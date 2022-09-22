codeunit 73006 SpyCreateJournalLine
{

    trigger OnRun()
    begin

    end;

    /// <summary>
    /// CommitToJournalLine.
    /// </summary>
    /// <param name="VAR JournalLines">Record "Spy Create Journal Line".</param>
    /// <returns>Return variable Return of type Text[50].</returns>    
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
    begin
        Clear(TotalCount);
        Clear(Errors);
        if SpyCreateJournalLine.FindSet() then begin
            TotalCount := SpyCreateJournalLine.Count();
            repeat
                CurrentCount += 1;
                SpyCreateJournalLine.GetErrorsRec(SpyCreateJournalLine, SpyErrors);
                if SpyErrors.IsEmpty then begin
                    Posted := SpyCreateJournalLine.PostJournal();
                    if Posted then
                        PostedCount += 1;
                end;

                if (CurrentCount <> TotalCount) Then
                    if (PostedCount <> TotalCount) then
                        Exit(CleanUp(SpyCreateJournalLine, SpyErrors)); //Delete current Spy Journal Lines and related GenJournalLines
            until SpyCreateJournalLine.Next() = 0;
        end;
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
    /// <param name="Errors">VAR Text.</param>
    procedure CleanUp(var SpyCreateJournalLine: Record "Spy Create Journal Line"; SpyError: Record "Spy Errors") Errors: Text
    var
        GenJournalLine: Record "Gen. Journal Line";
        ErrorOutStream: OutStream;
    begin
        SpyCreateJournalLine.SetRange("Document No.");
        if SpyCreateJournalLine.FindSet() then
            repeat
                SpyCreateJournalLine.Delete();
            until SpyCreateJournalLine.Next() = 0;
        //Delete if any exists in GenJournalLine
        GenJournalLine.SetRange("Journal Template Name", SpyCreateJournalLine."Journal Template Name");
        GenJournalLine.SetRange("Document No.", SpyCreateJournalLine."Document No.");
        if GenJournalLine.FindSet() then
            repeat
                GenJournalLine.Delete(true);
            until GenJournalLine.Next() = 0;
        //Return Error Text from Blob    
        SpyError.CalcFields("Error Description");
        IF SpyError."Error Description".HasValue() then begin
            SpyError."Error Description".CreateOutStream(ErrorOutStream);
            ErrorOutStream.WriteText(Errors);
            //Delete All Errors Alwyase
            SpyError.DeleteAll();
        end;
        Exit(Errors);
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeExportJournalLine(var SpyXmlCreateJournalLine: XmlPort SpyXmlCreateJournalLine; var Return: Text[50]; var IsHandled: Boolean)
    begin
    end;

}