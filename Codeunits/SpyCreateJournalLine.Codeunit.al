codeunit 73006 SpyCreateJournalLine
{

    trigger OnRun()
    begin

    end;

    procedure CreateJournalLine(VAR JournalLines: Record "Spy Create Journal Line") Return: Text[50]

    begin
        if JournalLines.PostJournal() then
            EXIT(CopyStr(Database.CompanyName, 1, 50)) else begin
            JournalLines.DeleteAll();
            Exit('Error, SPY Journal is now blank');
        end;
    end;

    /// <summary>
    /// ExportJournalLine.
    /// </summary>
    /// <param name="VAR SpyXmlCreateJournalLine">XmlPort SpyXmlCreateJournalLine.</param>
    /// <returns>Return variable Return of type Text[50].</returns>
    procedure ExportJournalLine(VAR SpyXmlCreateJournalLine: XmlPort SpyXmlCreateJournalLine) Return: Text[50]
    var
        IsHandled: Boolean;
    begin
        OnBeforeExportJournalLine(SpyXmlCreateJournalLine, Return, IsHandled);
        if IsHandled then
            exit;

        SpyXmlCreateJournalLine.Export();
        EXIT(CopyStr(Database.CompanyName, 1, 50));
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeExportJournalLine(var SpyXmlCreateJournalLine: XmlPort SpyXmlCreateJournalLine; var Return: Text[50]; var IsHandled: Boolean)
    begin
    end;
}