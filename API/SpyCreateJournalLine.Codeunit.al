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
        PostedSuccessTxt: label 'Posting completed. do you want to delete all Spy-related records?', comment = 'DAN="Bogføring udført, venligst slet de relaterede spy-data ved at trykke Ja, eller tryk nej"';
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
                    Posted := SpyJournalLine.PostTempSpyJournalLines(); //POST
                    if Posted then
                        PostedCount += 1;
                end;
                if (CurrentCount = TotalCount) and (PostedCount <> TotalCount) then
                    ErrorsWritten := GetErrorBlobMessage(SpyJournalLine, SpyErrors);
            until SpyJournalLine.Next() = 0;
        end;

        //IF ALL POSTED
        if (PostedCount = TotalCount) then
            if not GuiAllowed then
                exit(CleanUpWhenPosted(SpyJournalLine)) else
                if CONFIRM(PostedSuccessTxt, false) then
                    SpyJournalLine.CleanUpAfterManualPosting(SpyJournalLine);

        //IF NOT ALL POSTED
        if (PostedCount <> TotalCount) then begin
            if GuiAllowed then
                if CONFIRM(StrSubstNo(ErrorFoundLbl, ErrorsWritten), false) then begin
                    CleanUpWhenError(SpyJournalLine);
                    Message('Completed');
                end;

            if not GuiAllowed then begin
                CleanUpWhenError(SpyJournalLine);
                Error(ErrorsWritten);
            end;

        end;
    end;


    /// <summary>
    /// CreateJournalLine.
    /// </summary>
    /// <param name="VAR JournalLineList">XmlPort SpyXmlCreateJournalLine.</param>
    /// <returns>Return variable Return of type Text[50].</returns>
    procedure CreateJournalLine(VAR JournalLineList: XmlPort SpyXmlCreateJournalLine) Return: Text[50]
    begin
        JournalLineList.Import();
        exit(CopyStr(Database.CompanyName, 1, 50));
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
        exit(CopyStr(Database.CompanyName, 1, 50));
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
    procedure CleanUpWhenError(var SpyJournalLine: Record "Spy Journal Line") Result: Text
    var
        GenJournalLine: Record "Gen. Journal Line";
        SpyDimensions: Record "Spy Dimension";
        SpyErrors: Record "Spy Error";
        GJLCount: Integer;
        SpyJournalLinesCount: Integer;
        SpyErrorsCount: Integer;
        SpyDimensionsCount: Integer;
        ResultSummazionTxt: label 'Cleaned, %1: %2, %3: %4, %5: %6, %7: %8', comment = '%1: %2, %3: %4, %5: %6, %7: %8';//tableCaptions and Counters or rows in that table
    begin

        //Delete if any exists in GenJournalLine
        GenJournalLine.SetRange("Journal Template Name", SpyJournalLine."Journal Template Name");
        GenJournalLine.SetRange(Description, SpyJournalLine.Description);

        if GenJournalLine.FindSet() then
            repeat
                GenJournalLine.Delete(true);
                Commit();
                GJLCount += 1;
            until GenJournalLine.Next() = 0;

        //Delete Temp Spy Journal Lines
        SpyJournalLine.SetRange(Description, SpyJournalLine.Description);
        if SpyJournalLine.FindSet() then
            repeat
                SpyJournalLine.Delete();
                Commit();
                SpyJournalLinesCount += 1;
            until SpyJournalLine.Next() = 0;

        //Delete All Errors Alwyase
        if SpyErrors.FindSet() then begin
            SpyErrors.DeleteAll();
            Commit();
            SpyErrorsCount += 1;
        end;


        //Delete Spy Dims
        SpyDimensions.SetRange("Spy Jnl Line Description", SpyJournalLine.Description);
        if SpyDimensions.FindSet() then
            repeat
                SpyDimensions.Delete();
                Commit();
                SpyDimensionsCount += 1;
            until SpyDimensions.Next() = 0;

        exit(StrSubstNo(ResultSummazionTxt,
                            GenJournalLine.TableCaption, GJLCount,
                            SpyJournalLine.TableCaption, SpyJournalLinesCount,
                                 SpyErrors.TableCaption, SpyErrorsCount,
                                 SpyDimensions.TableCaption, SpyDimensionsCount));
    end;

    /// <summary>
    /// CleanUpWhenPosted.
    /// </summary>
    /// <param name="SpyJournalLine">VAR Record "Spy Journal Line".</param>
    /// <returns>Return value of type Boolean.</returns>
    procedure CleanUpWhenPosted(var SpyJournalLine: Record "Spy Journal Line") PostMessage: Text
    var
        GenJnlLine: Record "Gen. Journal Line";
        SpyDimensions: Record "Spy Dimension";
        SpyErrors: Record "Spy Error";
        PostedMessageLbl: label 'Posted %1 lines to Journal: %2 with Description: %3', comment = '%1, %2, %3';

    begin
        GenJnlLine.SetRange(Description, SpyJournalLine.Description);
        if GenJnlLine.FindSet() then
            PostMessage := StrSubstNo(PostedMessageLbl, GenJnlLine.Count(), GenJnlLine."Journal Template Name", GenJnlLine.Description);

        //Delete Temp Spy Journal Lines
        SpyJournalLine.SetRange(Description, SpyJournalLine.Description);
        if SpyJournalLine.FindSet() then
            repeat
                SpyJournalLine.Delete();
                Commit();
            until SpyJournalLine.Next() = 0;

        //Delete Spy Dims
        SpyDimensions.SetRange("Spy Jnl Line Description", SpyJournalLine.Description);
        if SpyDimensions.FindSet() then
            repeat
                SpyDimensions.Delete();
                Commit();
            until SpyDimensions.Next() = 0;

        //Return Error Text from Blob  
        SpyErrors.DeleteAll();
        Commit();
        exit(PostMessage);

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
        CollectedErrors: Text;
    begin
        //Return Error Text from Blob  
        SpyErrors.SetRange("Spy Jnl Line Description", SpyJournalLine.Description);
        if SpyErrors.FindFirst() then
            repeat
                SpyErrors.CalcFields("Error Description");
                if SpyErrors."Error Description".HasValue() then begin
                    clear(CollectedErrors);
                    SpyErrors."Error Description".CreateInStream(ErrorDescInStream);
                    ErrorDescInStream.ReadText(CollectedErrors, SpyErrors."Error Description".Length());
                    Errors += CollectedErrors;
                end;
            until SpyErrors.Next() = 0;
        exit(Errors);
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
    local procedure OnBeforeExportJournalLine(var SpyXmlCreateJournalLine: XmlPort spyXmlCreateJournalLine;

    var
        Return: Text[50];

    var
        IsHandled: Boolean)
    begin
    end;

}