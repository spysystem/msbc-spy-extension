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
        SpyCreateJournalLine: Record "Spy Create Journal Line";
        SpyErrors: Record "Spy Errors";
        TotalCount: Integer;
        CurrentCount: Integer;
        Posted: Boolean;
        PostedCount: Integer;
        Errors: Text;
        ErrorFoundLbl: Label 'Erorrs found %1 - continue to delete lines', comment = '%1 = Errors';
    begin
        Clear(TotalCount);
        Clear(Errors);
        if SpyCreateJournalLine.FindSet() then begin
            TotalCount := SpyCreateJournalLine.Count();
            repeat
                CurrentCount += 1;
                SpyCreateJournalLine.GetErrorsRec(SpyCreateJournalLine, SpyErrors);
                if SpyErrors.IsEmpty then begin
                    Posted := SpyCreateJournalLine.PostJournal(); //POST
                    if Posted then
                        PostedCount += 1;
                end;
                //IF NOT ALL POSTED
                if (CurrentCount = TotalCount) Then
                    if (PostedCount <> TotalCount) then
                        if not GuiAllowed then
                            //Delete current Spy Journal Lines and related GenJournalLines
                            Exit(CleanUp(SpyCreateJournalLine, SpyErrors)) else
                            IF CONFIRM(StrSubstNo(ErrorFoundLbl, SpyCreateJournalLine.GetErrorTextList()), false) then
                                Exit(CleanUp(SpyCreateJournalLine, SpyErrors));
            until SpyCreateJournalLine.Next() = 0;
            //IF ALL POSTED
            if (PostedCount = TotalCount) THEN
                if not GuiAllowed then
                    Exit(CleanUp(SpyCreateJournalLine, SpyErrors))
                else
                    IF CONFIRM('Posting completed. do you want to delete all Spy lines?', false) then
                        SpyCreateJournalLine.CleanUpAfterManualPosting(SpyCreateJournalLine)
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
    /// <param name="SpyCreateJournalLine">VAR Record "Spy Create Journal Line".</param>
    /// <param name="SpyErrors">VAR Record "Spy Errors".</param>
    /// <returns>Return variable Errors of type Text.</returns>
    procedure CleanUp(var SpyCreateJournalLine: Record "Spy Create Journal Line"; var SpyErrors: Record "Spy Errors") Errors: Text
    var
        GenJournalLine: Record "Gen. Journal Line";
        SpyDim: Record "Spy Dimensions";
        ErrorInStream: InStream;
    begin
        SpyCreateJournalLine.SetRange("External Document No.", SpyCreateJournalLine."External Document No.");
        if SpyCreateJournalLine.FindSet() then
            repeat
                SpyCreateJournalLine.Delete();
            until SpyCreateJournalLine.Next() = 0;
        //Delete if any exists in GenJournalLine
        GenJournalLine.SetRange("Journal Template Name", SpyCreateJournalLine."Journal Template Name");
        GenJournalLine.SetRange("Document No.", SpyCreateJournalLine."External Document No.");
        if GenJournalLine.FindSet() then
            repeat
                GenJournalLine.Delete(true);
            until GenJournalLine.Next() = 0;

        //Delete Spy Dims
        SpyDim.SetRange("External Document No.", SpyCreateJournalLine."External Document No.");
        if SpyDim.FindSet() then
            repeat
                SpyDim.Delete();
            until SpyDim.Next() = 0;

        //Return Error Text from Blob  
        SpyErrors.SetRange("External Document No.", SpyCreateJournalLine."External Document No.");
        if SpyErrors.FindFirst() then begin
            SpyErrors.CalcFields("Error Description");
            IF SpyErrors."Error Description".HasValue() then begin
                SpyErrors."Error Description".CreateInStream(ErrorInStream);
                ErrorInStream.ReadText(Errors, SpyErrors."Error Description".Length());
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
        spyJournalLines: Record "Spy Create Journal Line";
    begin
        spyJournalLines.DeleteAll();
        Exit('Deleted All Entries');
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeExportJournalLine(var SpyXmlCreateJournalLine: XmlPort SpyXmlCreateJournalLine; var Return: Text[50]; var IsHandled: Boolean)
    begin
    end;

}