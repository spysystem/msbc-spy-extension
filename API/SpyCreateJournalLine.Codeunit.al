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
        ErrorsWritten: Text;
        ErrorFoundLbl: label 'Erorrs found %1 - continue to delete lines', comment = '%1 = Errors';
    begin
        Clear(TotalCount);
        Clear(ErrorsWritten);
        clear(SpyErrors);
        SpyErrors.DeleteAll();

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

                if (CurrentCount = TotalCount) then //when all Lines is processed
                    if (PostedCount <> TotalCount) then begin //if errors occured
                        ErrorsWritten := GetErrorBlobMessage(SpyJournalLine, SpyErrors);
                        if not GuiAllowed then
                            CleanUp(SpyJournalLine, SpyErrors)//Delete current Spy Journal Lines and related GenJournalLines    
                        else
                            if CONFIRM(StrSubstNo(ErrorFoundLbl, SpyJournalLine.GetErrorTextList()), false) then begin
                                Message(CleanUp(SpyJournalLine, SpyErrors));
                                exit('');
                            end;
                    end;
            until SpyJournalLine.Next() = 0;
            //IF ALL POSTED
            if (PostedCount = TotalCount) then
                if not GuiAllowed then begin
                    CleanUp(SpyJournalLine, SpyErrors);
                    exit('OK!');
                end
                else
                    if CONFIRM('Posting completed. do you want to delete all Spy lines?', false) then
                        SpyJournalLine.CleanUpAfterManualPosting(SpyJournalLine)
        end;

        if (PostedCount = TotalCount) and GuiAllowed then
            Message('Completed');

        if (PostedCount <> TotalCount) then
            Error(ErrorsWritten);
    end;


    /// <summary>
    /// CreateJournalLine.
    /// </summary>
    /// <param name="VAR JournalLineList">XmlPort SpyXmlCreateJournalLine.</param>
    /// <returns>Return variable Return of type Text[50].</returns>
    procedure CreateJournalLine(VAR JournalLineList: XmlPort SpyXmlCreateJournalLine) Return: Text[50]
    begin
        JournalLineList.Import();
        EXIT(CopyStr(Database.CompanyName, 1, 50));
    end;


    /// <summary>
    /// ExportJournalLine.
    /// </summary>
    /// <param name="spyXmlCreateJournalLine">VAR xmlPort spyXmlCreateJournalLine.</param>
    /// <returns>Return variable return of type Text[50].</returns>
    procedure ExportJournalLine(var spyXmlCreateJournalLine: xmlPort spyXmlCreateJournalLine) return: Text[50]
    var
        IsHandled: Boolean;
    begin
        OnBeforeExportJournalLine(SpyXmlCreateJournalLine, Return, IsHandled);
        if IsHandled then
            exit;

        spyXmlCreateJournalLine.Export();
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
    /// <param name="SpyJournalLine">VAR Record "Spy Journal Line".</param>
    /// <param name="SpyErrors">VAR Record "Spy Error".</param>
    /// <returns>Return variable Errors of type Text.</returns>
    procedure CleanUp(var SpyJournalLine: Record "Spy Journal Line"; var SpyErrors: Record "Spy Error") Errors: Text
    var
        GenJournalLine: Record "Gen. Journal Line";
        SpyDimensions: Record "Spy Dimension";
        ErrorDescInStream: InStream;
    begin
        //Delete Temp Spy Journal Lines
        SpyJournalLine.SetRange(Description, SpyJournalLine.Description);
        if SpyJournalLine.FindSet() then
            repeat
                SpyJournalLine.Delete();
                Commit();
            until SpyJournalLine.Next() = 0;

        //Delete if any exists in GenJournalLine
        GenJournalLine.SetRange("Journal Template Name", SpyJournalLine."Journal Template Name");
        GenJournalLine.SetRange(Description, SpyJournalLine.Description);
        if GenJournalLine.FindSet() then
            repeat
                GenJournalLine.Delete(true);
                Commit();
            until GenJournalLine.Next() = 0;

        //Delete Spy Dims
        SpyDimensions.SetRange(Description, SpyJournalLine.Description);
        if SpyDimensions.FindSet() then
            repeat
                SpyDimensions.Delete();
                Commit();
            until SpyDimensions.Next() = 0;

        //Return Error Text from Blob  
        SpyErrors.SetRange("Spy Jnl Line Description", SpyJournalLine.Description);
        if SpyErrors.FindFirst() then begin
            SpyErrors.CalcFields("Error Description");
            if SpyErrors."Error Description".HasValue() then begin
                SpyErrors."Error Description".CreateInStream(ErrorDescInStream);
                ErrorDescInStream.ReadText(Errors, SpyErrors."Error Description".Length());
                //Delete All Errors Alwyase
                SpyErrors.DeleteAll();
                Commit();
            end;
        end;
        exit(Errors);
    end;

    /// <summary>
    /// GetErrorBlobMessage.
    /// </summary>
    /// <param name="SpyJournalLine">VAR Record "Spy Journal Line".</param>
    /// <param name="SpyErrors">VAR Record "Spy Error".</param>
    /// <returns>Return variable Errors of type Text.</returns>

    procedure GetErrorBlobMessage(var SpyJournalLine: Record "Spy Journal Line"; var SpyErrors: Record "Spy Error") Errors: Text
    var
        ErrorDescInStream: InStream;
    begin
        //Return Error Text from Blob  
        SpyErrors.SetRange("Spy Jnl Line Description", SpyJournalLine.Description);
        if SpyErrors.FindFirst() then begin
            SpyErrors.CalcFields("Error Description");
            if SpyErrors."Error Description".HasValue() then begin
                SpyErrors."Error Description".CreateInStream(ErrorDescInStream);
                ErrorDescInStream.ReadText(Errors, SpyErrors."Error Description".Length());
                //Delete All Errors Alwyase
                SpyErrors.DeleteAll();
            end;
        end;
        exit(Errors);
    end;

    /// <summary>
    /// TryGetHttpFriendlyErrors.
    /// </summary>
    /// <param name="SpyJournalLine">VAR Record "Spy Journal Line".</param>
    /// <param name="SpyErrors">VAR Record "Spy Error".</param>
    [TryFunction]
    procedure TryGetHttpFriendlyErrors(var SpyJournalLine: Record "Spy Journal Line"; var SpyErrors: Record "Spy Error")
    var
        ErrorDescInStream: InStream;
        Errors: Text;
    begin
        //Return Error Text from Blob  
        SpyErrors.SetRange("Spy Jnl Line Description", SpyJournalLine.Description);
        if SpyErrors.FindFirst() then begin
            SpyErrors.CalcFields("Error Description");
            if SpyErrors."Error Description".HasValue() then begin
                SpyErrors."Error Description".CreateInStream(ErrorDescInStream);
                ErrorDescInStream.ReadText(Errors, SpyErrors."Error Description".Length());
                //Delete All Errors Alwyase
                SpyErrors.DeleteAll();
            end;
        end;
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
    local procedure OnBeforeExportJournalLine(var SpyXmlCreateJournalLine: XmlPort spyXmlCreateJournalLine; var Return: Text[50];
    var
        IsHandled: Boolean)
    begin
    end;

}