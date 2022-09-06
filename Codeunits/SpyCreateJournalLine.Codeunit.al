codeunit 73006 SpyCreateJournalLine
{

    trigger OnRun()
    begin

    end;

    /// <summary>
    /// CreateJournalLine.
    /// </summary>
    /// <param name="VAR journalLineList">XmlPort SpyXmlCreateJournalLine.</param>
    /// <returns>Return variable Return of type Text[50].</returns>
#pragma warning disable AA0072
    procedure CreateJournalLine(VAR journalLineList: XmlPort SpyXmlCreateJournalLine) Return: Text[50]
#pragma warning restore AA0072
    begin
        journalLineList.Import();
        EXIT(CopyStr(Database.CompanyName, 1, 50));
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