page 73002 SpyCreateJournalLineAPI
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
                field(accountNo; Rec."Account No.")
                {
                    Caption = 'Account No.';
                }
                field(accountType; Rec."Account Type")
                {
                    Caption = 'Account Type';
                }
                field(amount; Rec.Amount)
                {
                    Caption = 'Amount';
                }
                field(amountLCY; Rec."Amount (LCY)")
                {
                    Caption = 'Amount (LCY)';
                }
                field(countryRegionCode; Rec."Country/Region Code")
                {
                    Caption = 'Country/Region Code';
                }
                field(countyUSTaxAccount; Rec."County US Tax Account")
                {
                    Caption = 'County US Tax Account';
                }
                field(currencyCode; Rec."Currency Code")
                {
                    Caption = 'Currency Code';
                }
                field(description; Rec.Description)
                {
                    Caption = 'Description';
                }
                field(documentNo; Rec."Document No.")
                {
                    Caption = 'Document No.';
                }
                field(documentType; gDocumentType)
                {
                    Caption = 'Document Type';
                }
                field(dueDate; Rec."Due Date")
                {
                    Caption = 'Due Date';
                }
                field(entryNo; Rec."Entry No.")
                {
                    Caption = 'Entry No.';
                }
                field(externalDocumentNo; Rec."External Document No.")
                {
                    Caption = 'External Document No.';
                }
                field(journalName; Rec."Journal Batch Name")
                {
                    Caption = 'Journal Batch Name';
                    trigger OnValidate()
                    begin
                    end;

                }
                field(journalTemplateName; Rec."Journal Template Name")
                {
                    Caption = 'Journal Template Name';
                    trigger OnValidate()
                    begin

                    end;
                }

                field(paymentTermsCode; Rec."Payment Terms Code")
                {
                    Caption = 'Payment Terms Code';
                }
                field(pmtDiscountDate; Rec."Pmt. Discount Date")
                {
                    Caption = 'Pmt. Discount Date';
                }
                field(postingDate; Rec."Posting Date")
                {
                    Caption = 'Posting Date';

                }
                part(spyDimensions; SpyJournalDimensionPart)
                {
                    EntityName = 'spyDimension';
                    EntitySetName = 'spyDimensions';
                    SubPageLink = "Spy Journal System Id" = field(SystemId);
                }

                field(stateUSTaxAccount; Rec."State US Tax Account")
                {
                    Caption = 'State US Tax Account';
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
                field(taxTitle; Rec."Tax Title")
                {
                    Caption = 'TaxTitle';

                }
                field(vatCode; Rec."VAT Code")
                {
                    Caption = 'VAT Code';
                }
                field(custGroup; Rec.custGroup)
                {
                    Caption = 'custGroup';
                }
                field(deliveryAccount; Rec.deliveryAccount)
                {
                    Caption = 'Delivery Acoount';
                }
                field(documentTypeAsText; Rec.documentTypeAsText)
                {
                    Caption = 'documentTypeAsText';
                }
                field(entryType; Rec.entryType)
                {
                    Caption = 'entryType';
                }
                field(postType; Rec.postType)
                {
                    Caption = 'postType';
                }
                field(taxPercentage; Rec."tax Percentage")
                {
                    Caption = 'Tax Percent';
                }
                field(vatArea; Rec.vatArea)
                {
                    Caption = 'vatArea';
                }
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
        Exit('Pong');
    end;

    var
        gDocumentType: Text;

}
