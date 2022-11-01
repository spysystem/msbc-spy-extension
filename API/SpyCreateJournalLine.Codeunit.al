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
        CurrentCount: Integer;
        PostedCount: Integer;
        ErrorsCollectedTxt: Text;
        ErrorFoundLbl: label 'Erorrs found %1. Continue and delete SPY data?', comment = '%1 = Errors';
    begin
        Clear(CurrentCount);
        Clear(PostedCount);
        Clear(ErrorsCollectedTxt);
        SpyErrors.DeleteAll();

        if SpyJournalLine.FindSet() then
            repeat
                CurrentCount += 1;
                if SpyJournalLine.PostTempSpyJournalLines() then //THIS IS MOVING sypJournalLines to General Journal.
                    PostedCount += 1;
                if (CurrentCount = SpyJournalLine.Count()) and (PostedCount <> SpyJournalLine.Count()) then
                    ErrorsCollectedTxt := GetErrorBlobMessage(SpyJournalLine);
            until SpyJournalLine.Next() = 0;

        if PostedCount = SpyJournalLine.Count() then begin
            //Return SUCESS
            if GuiAllowed then
                Message(CleanSpyData(SpyJournalLine, true));
            if not GuiAllowed then
                exit(CleanSpyData(SpyJournalLine, true));
        end
        else begin
            //Return Errors
            if GuiAllowed then
                if CONFIRM(StrSubstNo(ErrorFoundLbl, ErrorsCollectedTxt), false) then
                    Message(CleanUpWithGUIAllowed(SpyJournalLine) + ' ' + ErrorsCollectedTxt);

            if not GuiAllowed then begin
                CleanSpyData(SpyJournalLine, false);
                Error(ErrorsCollectedTxt);
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
        exit('Pong');
    end;

    /// <summary>
    /// CleanUp.
    /// </summary>
    /// <param name="SpyJournalLine">VAR Record "Spy Journal Line".</param>
    /// <returns>Return variable Errors of type Text.</returns>
    procedure CleanUpWithGUIAllowed(var SpyJournalLine: Record "Spy Journal Line") Result: Text
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
        //For Manual Debugging
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

 
    procedure CleanSpyData(var SpyJournalLine: Record "Spy Journal Line"; ReadyToPost: Boolean) PostMessage: Text
    var
        GenJournalLine: Record "Gen. Journal Line";
        SpyDimensions: Record "Spy Dimension";
        SpyError: Record "Spy Error";
        PostedMessageLbl: label 'Posted %1 lines to Journal: %2 with Description: %3', comment = '%1, %2, %3';
    begin

        if ReadyToPost then begin
            GenJournalLine.SetRange(Description, SpyJournalLine.Description);
            if GenJournalLine.FindSet() then
                PostMessage := StrSubstNo(PostedMessageLbl, GenJournalLine.Count(), GenJournalLine."Journal Template Name", GenJournalLine.Description);
        end
        else begin
            GenJournalLine.SetFilter(Description, '%1', SpyJournalLine.Description);
            if GenJournalLine.FindSet() then
                repeat
                    GenJournalLine.Delete(true);
                until GenJournalLine.Next() = 0;

        end;
        //Delete Temp Spy Journal Lines
        if SpyJournalLine.FindSet() then begin
            SpyJournalLine.DeleteAll();
            Commit();
        end;

        //Delete Spy Dims
        if SpyDimensions.FindSet() then begin
            SpyDimensions.Delete();
            Commit();
        end;

        //Delete SpyErrors 
        if SpyError.FindSet() then begin
            SpyError.DeleteAll();
            Commit();
        end;

        exit(PostMessage);
    end;

    /// <summary>
    /// GetErrorBlobMessage.
    /// </summary>
    /// <param name="SpyJournalLine">VAR Record "Spy Journal Line".</param>
    /// <param name="SpyErrors">VAR Record "Spy Error".</param>
    /// <returns>Return variable Errors of type Text.</returns>

    procedure GetErrorBlobMessage(var SpyJournalLine: Record "Spy Journal Line") Errors: Text
    var
        SpyErrors: Record "Spy Error";
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
        SpyDimensions: record "Spy Dimension";
        SpyError: Record "Spy Error";
    begin
        if SpyJournalLine.FindSet() then
            SpyJournalLine.DeleteAll();
        if SpyDimensions.FindSet() then
            SpyDimensions.DeleteAll();
        if SpyError.FindSet() then
            spyError.DeleteAll();
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