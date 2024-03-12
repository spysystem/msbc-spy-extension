/// <summary>
/// Codeunit "SpyCreateJournalLine" (ID 73006).
/// </summary>
codeunit 73006 SpyCreateJournalLine
{
    trigger OnRun()
    begin

    end;

    [ServiceEnabled]
    procedure commitToJournalLine(): Text
    begin
        exit(Implementation.commitToJournalLine(''));
    end;

    [ServiceEnabled]
    procedure committoJournalLineWithBatch(BatchId: Code[20]): Text
    begin
        exit(Implementation.commitToJournalLine(BatchId));
    end;

    procedure CreateJournalLine(VAR JournalLineList: XmlPort SpyXmlCreateJournalLine) Return: Text[50]
    begin
        exit(Implementation.CreateJournalLine(JournalLineList));
    end;

    procedure ExportJournalLine(var spyXmlCreateJournalLine: xmlPort spyXmlCreateJournalLine) return: Text[50]
    var
        IsHandled: Boolean;
    begin
        OnBeforeExportJournalLine(SpyXmlCreateJournalLine, Return, IsHandled);
        if IsHandled then
            exit;

        exit(Implementation.ExportJournalLine(spyXmlCreateJournalLine));
    end;

    procedure uploadDocument(DocumentType: text; DocNo: Text; Data: Text): Text
    begin
        exit(Implementation.uploadDocument(DocumentType, DocNo, Data));
    end;

    procedure ping(): Text
    var
    begin
        exit(Implementation.ping());
    end;

    [ServiceEnabled]
    procedure deleteAllEntries(): Text
    begin
        exit(Implementation.deleteAllEntries());
    end;

    var
        Implementation: Codeunit "Spy Create Journal Line Imp";

    [IntegrationEvent(false, false)]
    local procedure OnBeforeExportJournalLine(var SpyXmlCreateJournalLine: XmlPort spyXmlCreateJournalLine; var Return: Text[50]; var IsHandled: Boolean)
    begin
    end;
}