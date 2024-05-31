page 73012 "EDK Gen. Journal Line"
{
    APIGroup = 'integration';
    APIPublisher = 'spy';
    APIVersion = 'v1.0';
    Caption = 'edkGenJournalLine';
    DelayedInsert = true;
    EntityName = 'genJournalLine';
    EntitySetName = 'genJournalLines';
    PageType = API;
    SourceTable = "Gen. Journal Line";
    ODataKeyFields = SystemId;


    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(journalBatchName; Rec."Journal Batch Name")
                {
                    Caption = 'Journal Batch Name';
                }
                field(journalTemplateName; Rec."Journal Template Name")
                {
                    Caption = 'Journal Template Name';
                }
                field(documentNo; Rec."Document No.")
                {
                    Caption = 'Document No.';
                }
                field(documentType; Rec."Document Type")
                {
                    Caption = 'Document Type';
                }
                field(accountNo; Rec."Account No.")
                {
                    Caption = 'Account No.';
                }
                field(description; Rec.Description)
                {
                    Caption = 'Description';
                }
                field(amount; Rec.Amount)
                {
                    Caption = 'Amount';
                }
                field(postingDate; Rec."Posting Date")
                {
                    Caption = 'Posting Date';
                }
                field(currencyCode; Rec."Currency Code")
                {
                    Caption = 'Currency Code';
                }
                field(amountLCY; Rec."Amount (LCY)")
                {
                    Caption = 'Amount (LCY)';
                }
                field(vat; Rec."VAT %")
                {
                    Caption = 'VAT %';
                }
                field(systemCreatedEntry; Rec."System-Created Entry")
                {
                    Caption = 'System-Created Entry';
                }
                field(systemCreatedAt; Rec.SystemCreatedAt)
                {
                    Caption = 'SystemCreatedAt';
                }
                field(systemCreatedBy; Rec.SystemCreatedBy)
                {
                    Caption = 'SystemCreatedBy';
                }
                field(systemId; Rec.SystemId)
                {
                    Caption = 'SystemId';
                }
                field(systemModifiedAt; Rec.SystemModifiedAt)
                {
                    Caption = 'SystemModifiedAt';
                }
                field(systemModifiedBy; Rec.SystemModifiedBy)
                {
                    Caption = 'SystemModifiedBy';
                }
            }
        }
    }
}
