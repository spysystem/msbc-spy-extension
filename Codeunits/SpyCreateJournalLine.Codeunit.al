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
    [Scope('Cloud')]
    procedure commitToJournalLine(): Text
    var
        JournalLines: Record "Spy Create Journal Line";
    begin
        if JournalLines.FindSet() then
            repeat
                if JournalLines.PostJournal() then
                    EXIT(CopyStr(Database.CompanyName, 1, 50)) else begin
                    JournalLines.Delete();
                    Exit(JournalLines.GetErrors());
                end;
            until JournalLines.Next() = 0;
    end;
    /// <summary>
    /// ExportJournalLine.
    /// </summary>
    /// <param name="VAR SpyXmlCreateJournalLine">XmlPort SpyXmlCreateJournalLine.</param>
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

    [IntegrationEvent(false, false)]
    local procedure OnBeforeExportJournalLine(var SpyXmlCreateJournalLine: XmlPort SpyXmlCreateJournalLine; var Return: Text[50]; var IsHandled: Boolean)
    begin
    end;


}