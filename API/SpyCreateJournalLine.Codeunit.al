/// <summary>
/// Codeunit SpyCreateJournalLine (ID 73006).
/// </summary>
codeunit 73006 SpyCreateJournalLine
{

    trigger OnRun()
    begin

    end;

    /// <summary>
    /// commitToJournalLine.
    /// </summary>
    /// <returns>Return value of type Text.</returns>
    [ServiceEnabled]
    procedure commitToJournalLine(): Text
    var
        SpyJournalLine: Record "Spy Journal Line";
        SpyErrors: Record "Spy Error";
        TotalCount: Integer;
        CurrentCount: Integer;
        Posted: Boolean;
        PostedCount: Integer;
        Errors: Text;
        ErrorFoundLbl: Label 'Erorrs found %1 - continue to delete lines', comment = '%1 = Errors';
    begin
        Clear(TotalCount);
        Clear(Errors);
        if SpyJournalLine.FindSet() then begin
            TotalCount := SpyJournalLine.Count();
            repeat
                CurrentCount += 1;
                SpyJournalLine.GetErrorsRec(SpyJournalLine, SpyErrors);
                if SpyErrors.IsEmpty then begin
                    Posted := SpyJournalLine.PostJournal(); //POST
                    if Posted then
                        PostedCount += 1;
                end;
                //IF NOT ALL POSTED
                if (CurrentCount = TotalCount) Then
                    if (PostedCount <> TotalCount) then
                        if not GuiAllowed then
                            //Delete current Spy Journal Lines and related GenJournalLines
                            Exit(CleanUp(SpyJournalLine, SpyErrors)) else
                            IF CONFIRM(StrSubstNo(ErrorFoundLbl, SpyJournalLine.GetErrorTextList()), false) then begin
                                Message(CleanUp(SpyJournalLine, SpyErrors));
                                Exit('');
                            end;
            until SpyJournalLine.Next() = 0;
            //IF ALL POSTED
            if (PostedCount = TotalCount) THEN
                if not GuiAllowed then
                    Exit(CleanUp(SpyJournalLine, SpyErrors))
                else
                    IF CONFIRM('Posting completed. do you want to delete all Spy lines?', false) then
                        SpyJournalLine.CleanUpAfterManualPosting(SpyJournalLine)
        end;
        if GuiAllowed then
            Message('Completed');
    end;
    /// <summary>
    /// ExportJournalLine.
    /// </summary>
    /// <param name="VAR spyXmlCreateJournalLine">XmlPort SpyXmlCreateJournalLine.</param>  
    /// <returns>Return variable Return of type Text[50].</returns>
    procedure ExportJournalLine(VAR spyXmlCreateJournalLine: XmlPort SpyXmlCreateJournalLine) Return: Text[50]
    var
        IsHandled: Boolean;
    begin
        OnBeforeExportJournalLine(SpyXmlCreateJournalLine, Return, IsHandled);
        if IsHandled then
            exit;

        SpyXmlCreateJournalLine.Export();
        EXIT(CopyStr(Database.CompanyName, 1, 50));
    end;

    /// <summary>
    /// ping. - For testing if service is alive.
    /// </summary>
    /// <returns>Return value of type Text.</returns>
    procedure ping(): Text
    var
    begin
        Exit('Pong');
    end;

    /// <summary>
    /// CleanUp.
    /// </summary>
    /// <param name="SpyJournalLine">VAR Record "Spy Create Journal Line".</param>
    /// <param name="SpyErrors">VAR Record "Spy Errors".</param>
    /// <returns>Return variable Errors of type Text.</returns>
    procedure CleanUp(var SpyJournalLine: Record "Spy Journal Line"; var SpyErrors: Record "Spy Error") Errors: Text
    var
        GenJournalLine: Record "Gen. Journal Line";
        SpyDimensions: Record "Spy Dimension";
        ErrorDescInStream: InStream;
    begin
        SpyJournalLine.SetRange("External Document No.", SpyJournalLine."External Document No.");
        if SpyJournalLine.FindSet() then
            repeat
                SpyJournalLine.Delete();
            until SpyJournalLine.Next() = 0;
        //Delete if any exists in GenJournalLine
        GenJournalLine.SetRange("Journal Template Name", SpyJournalLine."Journal Template Name");
        GenJournalLine.SetRange("Document No.", SpyJournalLine."External Document No.");
        if GenJournalLine.FindSet() then
            repeat
                GenJournalLine.Delete(true);
            until GenJournalLine.Next() = 0;

        //Delete Spy Dims
        SpyDimensions.SetRange("External Document No.", SpyJournalLine."External Document No.");
        if SpyDimensions.FindSet() then
            repeat
                SpyDimensions.Delete();
            until SpyDimensions.Next() = 0;

        //Return Error Text from Blob  
        SpyErrors.SetRange("External Document No.", SpyJournalLine."External Document No.");
        if SpyErrors.FindFirst() then begin
            SpyErrors.CalcFields("Error Description");
            IF SpyErrors."Error Description".HasValue() then begin
                SpyErrors."Error Description".CreateInStream(ErrorDescInStream);
                ErrorDescInStream.ReadText(Errors, SpyErrors."Error Description".Length());
                //Delete All Errors Alwyase
                SpyErrors.DeleteAll();
            end;
        end;
        Exit(Errors);
    end;

    /// <summary>
    /// deleteAllEntries.
    /// </summary>
    /// <returns>Return value of type Text.</returns>
    [ServiceEnabled]
    procedure deleteAllEntries(): Text
    var
        SpyJournalLine: Record "Spy Journal Line";
        LinesDeleted: Text;
        CountTotal: Integer;
        CountDel: Integer;
        DeleteStatusTxt: Label 'Deleted Lines Count: %1 of %2, Document No Deleted: %3', Comment = '%1 = CountTotal, %2 = CountDeleted, %3 = DocumentNos.';
    begin
        if SpyJournalLine.FindSet() then
            repeat
                if SpyJournalLine.Delete() then begin
                    LinesDeleted += SpyJournalLine."Document No." + ',';
                    CountDel += 1;
                end;
            until SpyJournalLine.Next() = 0;
        CountTotal := SpyJournalLine.Count();
        Exit(StrSubstNo(DeleteStatusTxt, CountTotal, CountDel, LinesDeleted));
    end;


    [IntegrationEvent(false, false)]
    local procedure OnBeforeExportJournalLine(var SpyXmlCreateJournalLine: XmlPort SpyXmlCreateJournalLine; var Return: Text[50];
    var
        IsHandled: Boolean)
    begin
    end;

}