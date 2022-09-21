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
    SourceTable = "Spy Create Journal Line";
    ODataKeyFields = SystemId;

    layout
    {
        area(content)
        {
            repeater(General)
            {

                field(journalName; gJournalBatchNameCode)
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
                    trigger OnValidate()
                    begin
                    end;
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

                field(lineNo; Rec."Line No.")
                {
                    Caption = 'Line No.';
                }
                field(paymentTermsCode; Rec."Payment Terms Code")
                {
                    Caption = 'Payment Terms Code';
                }
                field(pmtDiscountDate; Rec."Pmt. Discount Date")
                {
                    Caption = 'Pmt. Discount Date';
                }
                field(postingDate; gPostingDate)
                {
                    Caption = 'Posting Date';
                    trigger OnValidate()
                    var
                        day: integer;
                        month: Integer;
                        year: Integer;
                    begin
                        evaluate(day, CopyStr(gpostingDate, 9, 2));
                        evaluate(month, CopyStr(gpostingDate, 6, 2));
                        Rec."Posting Date" := DMY2Date(day, month, year);
                    end;
                }
                part(spyDimensions; SpyJournalDimensionPart)
                {
                    EntityName = 'spyDimension';
                    EntitySetName = 'spyDimensions';
                    SubPageLink = SystemId = field(SystemId);
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
                    trigger OnValidate()
                    begin

                    end;

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
                field(entryType; gPostingType)
                {
                    Caption = 'entryType';
                }
                field(postType; Rec.postType)
                {
                    Caption = 'postType';
                    trigger OnValidate()
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
                        Rec.Validate("Account No.");
                    end;
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
    var
        TempDimensionBuffer: Record "Dimension Buffer" temporary;

        gJournalBatchRec: Record "Gen. Journal Batch";

        gJournalBatchNameCode: code[20];

        gDocumentType: Text;
        gPostingType: Text;
        gPostingDate: Text;
        gJournaltemplate: Text;
        gStateTax: Text[20];
        gtemplateName: code[20];
        ErrorList: List of [Text];
        EntryNo: Integer;

    procedure ValidteAndPostJournal(): Text
    var
    begin
        IF not Rec.ValidateJournalBatchName() Then
            exit(Rec.GetErrors(ErrorList)) else
            if not ValidatePostingType(gPostingType) then
                exit(GetErrors(ErrorList)) else
                if not ValidateTaxTitle(Rec."Tax Title") then
                    exit(GetErrors(ErrorList)) else
                    if Rec.PostJournal() then
                        exit('Posted')
                    else
                        exit(Rec.GetErrors(ErrorList));
    end;

    /// <summary>
    /// GetErrors.
    /// </summary>
    /// <param name="pErrorList">list of Text[250].</param>
    /// <returns>Return value of type Text.</returns>

    /// <summary>
    /// ValidatePostingType.
    /// </summary>
    /// <param name="postingType">Text[20].</param>
    procedure ValidatePostingType(postingType: Text[20]): Boolean
    var
    begin
        gPostingType := '';
        case gDocumentType of
            'Sale':
                begin
                    Rec."Document Type" := Rec."Document Type"::Invoice;
                    gPostingType := 'Sale';
                end;
            'SaleCredit':
                begin
                    Rec."Document Type" := Rec."Document Type"::"Credit Memo";
                    gPostingType := 'Sale';
                end;
            'Purchase':
                begin
                    Rec."Document Type" := Rec."Document Type"::Invoice;
                    gPostingType := 'Purchase';
                end;
            'PurchaseCredit':
                begin
                    Rec."Document Type" := Rec."Document Type"::"Credit Memo";
                    gPostingType := 'Purchase';
                end;
        end;
    end;


    Procedure ValidateTaxTitle(pTaxTitle: Text[20])
    begin
        Rec."Tax Title" := DelChr(Rec."Tax Title", '=', '()');
        if Rec."Tax Title" <> '' then
            IF ((STRPOS(Rec."Tax Title", 'State Tax') <> 0) OR (STRPOS(Rec."Tax Title", 'County Tax') <> 0) OR (STRPOS(Rec."Tax Title", 'Municipal Tax') <> 0)) THEN
                if STRPOS(Rec."Tax Title", 'State Tax') <> 0 then begin
                    TempDimensionBuffer.Init();
                    TempDimensionBuffer."Table ID" := 81;
                    TempDimensionBuffer."Entry No." := EntryNo;
                    EntryNo := EntryNo + 1;
                    TempDimensionBuffer."Dimension Code" := 'STATETAX';
                    TempDimensionBuffer."Dimension Value Code" := Rec."Tax Title";
                    TempDimensionBuffer.Insert();
                    gStateTax := Rec."Tax Title";
                    Rec."Account No." := Rec."State US Tax Account";
                end else begin
                    if STRPOS(Rec."Tax Title", 'County Tax') <> 0 then
                        Rec."Tax Title" := DELSTR(Rec."Tax Title", STRPOS(Rec."Tax Title", 'County Tax'));
                    if STRPOS(Rec."Tax Title", 'Municipal Tax') <> 0 then
                        Rec."Tax Title" := DelStr(Rec."Tax Title", STRPOS(Rec."Tax Title", ' Tax'));
                    TempDimensionBuffer.Init();
                    TempDimensionBuffer."Table ID" := 81;
                    TempDimensionBuffer."Entry No." := EntryNo;
                    EntryNo := EntryNo + 1;
                    TempDimensionBuffer."Dimension Code" := 'STATETAX';
                    TempDimensionBuffer."Dimension Value Code" := gStateTax;
                    TempDimensionBuffer.Insert();
                    TempDimensionBuffer.Init();
                    TempDimensionBuffer."Table ID" := 81;
                    TempDimensionBuffer."Entry No." := EntryNo;
                    EntryNo := EntryNo + 1;
                    TempDimensionBuffer."Dimension Code" := 'COUNTYTAX';
                    TempDimensionBuffer."Dimension Value Code" := Rec."Tax Title";
                    TempDimensionBuffer.Insert();
                    Rec."Account No." := Rec."County US Tax Account";
                    gStateTax := '';
                END;
        Rec."Tax Title" := '';
    end;
}
