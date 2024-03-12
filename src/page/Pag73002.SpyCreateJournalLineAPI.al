page 73002 "SpyCreateJournalLineAPI"
{
    APIGroup = 'integration';
    APIPublisher = 'spy';
    APIVersion = 'v1.0';
    Caption = 'spyCreateJournalLineAPI';
    DelayedInsert = true;
    EntityName = 'journalLine';
    EntitySetName = 'journalLines';
    PageType = API;
    SourceTable = "Spy Journal Line";
    ODataKeyFields = SystemId;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(id; Rec.SystemId) { Caption = 'Account No.'; }
                field(templateName; Rec."Journal Template Name") { Caption = 'Journal Template Name'; }
                field(journalName; Rec."Journal Batch Name") { Caption = 'Journal Batch Name'; }
                field(documentNumber; Rec."Document No.") { Caption = 'Document No.'; }
                field(documentType; Rec.documentTypeAsText) { Caption = 'Document Type'; }
                field(countryType; gcountryType) { Caption = 'countryType'; } //TODO: Thomas told me to change this since 10 was not long enough - yet you're not using this in the old XML.
                //Please confirm what to do here. 
                field(account; Rec."Account No.") { Caption = 'Account No.'; }
                field(description; Rec.Description) { Caption = 'Description'; }
                field(amount; Rec.Amount) { Caption = 'Amount'; }
                field(entryType; Rec.entryType) { Caption = 'entryType'; }
                field(postingDate; Rec."Posting Date") { Caption = 'Posting Date'; }
                field(deliveryAccount; Rec.deliveryAccount) { Caption = 'Delivery Acoount'; }
                field(postType; Rec.postType) { Caption = 'postType'; }
                field(invoiceNo; Rec."External Document No.") { Caption = 'External Document No.'; }
                field(currency; Rec."Currency Code") { Caption = 'Currency Code'; }
                field(amountBaseCurrency; Rec."Amount (LCY)") { Caption = 'Amount (LCY)'; }
                field(countyUSTaxAccount; Rec."County US Tax Account") { Caption = 'County US Tax Account'; }
                field(stateUSTaxAccount; Rec."State US Tax Account") { Caption = 'State US Tax Account'; }
                field(vatCode; Rec."VAT Code") { Caption = 'VAT Code'; }
                field(vatArea; Rec.vatArea) { Caption = 'vatArea'; }
                field(taxTitle; Rec."Tax Title") { Caption = 'TaxTitle'; }
                field(taxPercentage; Rec."tax Percentage") { Caption = 'Tax Percent'; }
                field(dueDate; Rec."Due Date") { Caption = 'Due Date'; }
                field(paymentTerm; Rec."Payment Terms Code") { Caption = 'Payment Terms Code'; }
                field(cashDiscountDate; Rec."Cash Discount Date") { Caption = 'Cash Discount Date'; }
                field(custGroup; Rec.custGroup) { Caption = 'custGroup'; }
                part(dimensions; SpyJournalDimensionPart)
                {
                    EntityName = 'spyDimension';
                    EntitySetName = 'spyDimensions';
                    SubPageLink = "Spy Journal System Id" = field(SystemId);
                }
                field(systemCreatedAt; Rec.SystemCreatedAt)
                {
                    Caption = 'SystemCreatedAt';
                }
                field(systemCreatedBy; Rec.SystemCreatedBy) { Caption = 'SystemCreatedBy'; }
                field(systemId; Rec.SystemId) { Caption = 'SystemId'; }
                field(systemModifiedAt; Rec.SystemModifiedAt) { Caption = 'SystemModifiedAt'; }
                field(systemModifiedBy; Rec.SystemModifiedBy) { Caption = 'SystemModifiedBy'; }
                field(BatchId; Rec."Spy Batch Id") { }
            }
        }
    }
    /// <summary>
    /// ping. - For testing if service is alive.
    /// </summary>
    /// <returns>Return value of type Text.</returns>
    procedure ping(): Text
    var
    begin
        exit('Pong');
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        APIValidateAccountTypeAndNo();
    end;

    /// <summary>
    /// ValidateAccountTypeAndNo.
    /// </summary>
    procedure APIValidateAccountTypeAndNo()
    var
    begin
        case Rec.postType of
            'tax':
                Rec."Account Type" := Rec."Account Type"::"G/L Account";
            'ledger':
                Rec."Account Type" := Rec."Account Type"::"G/L Account";
            'customer':
                Rec."Account Type" := Rec."Account Type"::Customer;
            'supplier':
                Rec."Account Type" := Rec."Account Type"::Vendor;
        end;
    end;

    var
        //gDocumentType: Text;
        gcountryType: Text;
}
