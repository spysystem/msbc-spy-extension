table 73090 "Spy Create Journal Line"
{
    Caption = 'Spy Create Journal Line', comment = 'DAN="Spy Opret Kladde"';
    fields
    {

        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
        }

        field(10; "Journal Template Name"; Code[10])
        {
            Caption = 'Journal Template Name';
            ValidateTableRelation = false;
            TableRelation = "Gen. Journal Template";
            DataClassification = CustomerContent;
        }
        field(20; "Journal Batch Name"; Code[10])
        {
            Caption = 'Journal Batch Name';
            DataClassification = CustomerContent;
            ValidateTableRelation = false;
            TableRelation = "Gen. Journal Batch".Name WHERE("Journal Template Name" = FIELD("Journal Template Name"));
        }

        field(30; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }

        field(37; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = CustomerContent;
        }

        field(40; documentTypeAsText; Text[20])
        {
            Caption = 'documentTypeAsText';
            DataClassification = CustomerContent;
        }

        field(46; "Document Type"; Enum "Gen. Journal Document Type")
        {
            Caption = 'Document Type';
            DataClassification = CustomerContent;
        }

        field(120; "Country/Region Code"; Code[10])
        {
            Caption = 'Country/Region Code';
            TableRelation = "Country/Region";
            ValidateTableRelation = false;
            DataClassification = CustomerContent;


        }
        field(4; "Account No."; Code[20])
        {
            Caption = 'Account No.';
            DataClassification = CustomerContent;

        }
        field(8; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;

        }

        field(13; Amount; Decimal)
        {
            Caption = 'Amount';
            DataClassification = CustomerContent;

        }
        field(623; entryType; Text[30])
        {
            Caption = 'entryType';
        }
        field(3; "Account Type"; Enum "Gen. Journal Account Type")
        {
            Caption = 'Account Type';
            DataClassification = CustomerContent;


            trigger OnValidate()
            begin

            end;
        }

        field(5; "Posting Date"; Text[10])
        {
            Caption = 'Posting Date';
            DataClassification = CustomerContent;
        }

        field(515; deliveryAccount; Text[20])
        {
            Caption = 'Delivery Acoount';
            DataClassification = CustomerContent;


        }
        field(510; postType; Text[20])
        {
            Caption = 'postType';
            DataClassification = CustomerContent;



        }
        field(77; "External Document No."; Code[35])
        {
            Caption = 'External Document No.';
            DataClassification = CustomerContent;

        }

        field(12; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            TableRelation = Currency;
            ValidateTableRelation = false;
            DataClassification = CustomerContent;

        }
        field(16; "Amount (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Amount (LCY)';
            DataClassification = CustomerContent;

        }
        field(550; "County US Tax Account"; Code[20])
        {
            Caption = 'County US Tax Account';
            DataClassification = CustomerContent;

        }
        field(556; "State US Tax Account"; Code[20])
        {
            Caption = 'State US Tax Account';
            DataClassification = CustomerContent;

        }
        field(566; "VAT Code"; Code[20])
        {
            Caption = 'VAT Code';
            DataClassification = CustomerContent;
        }
        field(654; vatArea; Code[20]) //NOT USED?
        {
            Caption = 'vatArea';
        }
        field(800; "Tax Title"; Text[20])
        {
            Caption = 'TaxTitle';
            trigger OnValidate()
            begin
                //ValidateTaxTitle(Rec."Tax Title");
            END;
        }
        field(888; "tax Percentage"; Decimal)
        {
            Caption = 'Tax Percent', comment = 'DAN="Moms Percent"';
        }
        field(38; "Due Date"; Date) //dueDate
        {
            Caption = 'Due Date';
        }
        field(47; "Payment Terms Code"; Code[10])
        {
            Caption = 'Payment Terms Code';
            TableRelation = "Payment Terms";
            ValidateTableRelation = false;
        }

        field(39; "Pmt. Discount Date"; Date) //cashDiscountDate
        {
            Caption = 'Pmt. Discount Date';
        }
        field(901; custGroup; Text[50])
        {
        }

        field(1000; "SPY Dimensions"; Integer)
        {
            Caption = 'SPY Dimension';
            ValidateTableRelation = false;
            TableRelation = "Spy Dimensions" where("Entry No." = field("Entry No."));
        }
        field(1100; "Ready To Post"; Boolean)
        {
            Caption = 'Ready To Post', comment = 'DAN="Klar til bogf."';

        }

    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }

    }

    /// <summary>
    /// PostJournal.
    /// </summary>
    /// <returns>Return value of type Boolean.</returns>
    [ServiceEnabled]
    procedure PostJournal(): Boolean
    begin
        Clear(ErrorList);
        Clear(BankAccount);
        Clear(TempDimensionBuffer);
        SPYSetup.Get();
        // SPYSetup.TestField("VAT Prod. Posting Group");
        // SPYSetup.TestField("VAT Bus. Posting Group");
        // SPYSetup.TestField("Gen. Bus. Posting Group");
        // SPYSetup.TestField("Gen. Prod. Posting Group");
        SPYSetup.TestField("Default Journal Temp Name");

        EntryNo := 1;
        LockTable(true);

        GenJournalLine.Init();
        //GenJournalLine.SetCurrentKey(GenJournalLine."Journal Template Name", GenJournalLine."Journal Batch Name", GenJournalLine."Line No.");
        if Rec.ValidateJournalBatchName() then begin
            GenJournalLine.Validate("Journal Batch Name", Rec."Journal Batch Name");
            GenJournalLine.Validate("Journal Template Name", Rec."Journal Template Name");
            GenJournalLine."Line No." := GenJournalLine.GetNewLineNo("Journal Template Name", Rec."Journal Batch Name");
            Rec.ValidateAccountType();
            Rec.ValidatePostingDate(Rec."Posting Date");
            Rec.ValidateDocumentType();
            Rec.ValidateTaxTitle(Rec."Tax Title");
            Rec.SetPostingGroups(SPYSetup);
            Rec.GetBankAccount();
            Rec.SetDueDate();
            Rec.SetCashDiscountDate();
            if Rec.ErrorExists() then
                exit(false);
        end;

        if not GenJournalLine.Insert(true) then
            ErrorList.Add(StrSubstNo('Failed to insert Gen. Journal Line', Rec."Document No." + ' ' + Format(Rec."Line No.")));


        //Set dimensionsId
        GenJournalLine."Dimension Set ID" := DimensionManagement.CreateDimSetIDFromDimBuf(TempDimensionBuffer);
        TempDimensionBuffer.DeleteAll();
        EntryNo := 1;
        GenJournalLine.Modify();
        Rec.SetSalesPurchExclVAT();
        Rec.CopyCustomerDimensions();
        Rec.SetGlobalDimensions();
        if Rec.ErrorExists() then
            exit(false) else
            exit(true);
    end;


    /// <summary>
    /// ValidateTaxTitle.
    /// </summary>
    /// <param name="pTaxTitle">VAR Text[20].</param>
    procedure ValidateTaxTitle(var pTaxTitle: Text[20])
    var
        TaxErrorLbl: Label 'TAXError: Failed to insert Dimension for %1', Comment = '%1 = Dimensions Code';
    begin
        pTaxTitle := DelChr(pTaxTitle, '=', '()');
        if pTaxTitle <> '' then
            if pTaxTitle.Contains('State Tax') then begin
                TempDimensionBuffer.Init();
                TempDimensionBuffer."Table ID" := 81;
                TempDimensionBuffer."Entry No." := EntryNo;
                EntryNo := EntryNo + 1;
                TempDimensionBuffer."Dimension Code" := 'STATETAX';
                TempDimensionBuffer."Dimension Value Code" := pTaxTitle;
                if not TempDimensionBuffer.Insert() then
                    ErrorList.Add(StrSubstNo(TaxErrorLbl, 'STATETAX'));
                StateTax := pTaxTitle;
                "Account No." := "State US Tax Account";
            end else begin
                if (pTaxTitle = 'County Tax') then
                    pTaxTitle := DELSTR(pTaxTitle, STRPOS(pTaxTitle, 'County Tax'));

                if (pTaxTitle = 'Municipal Tax') then
                    pTaxTitle := DelStr(pTaxTitle, STRPOS(pTaxTitle, ' Tax'));
                TempDimensionBuffer.Init();
                TempDimensionBuffer."Table ID" := 81;
                TempDimensionBuffer."Entry No." := EntryNo;
                EntryNo := EntryNo + 1;
                TempDimensionBuffer."Dimension Code" := 'STATETAX';
                TempDimensionBuffer."Dimension Value Code" := StateTax;
                if not TempDimensionBuffer.Insert() then
                    ErrorList.Add(StrSubstNo(TaxErrorLbl, 'STATETAX, Country or Municipal'));

                TempDimensionBuffer.Init();
                TempDimensionBuffer."Table ID" := 81;
                TempDimensionBuffer."Entry No." := EntryNo;
                EntryNo := EntryNo + 1;
                TempDimensionBuffer."Dimension Code" := 'COUNTYTAX';
                TempDimensionBuffer."Dimension Value Code" := pTaxTitle;
                if not TempDimensionBuffer.Insert() then
                    ErrorList.Add(StrSubstNo(TaxErrorLbl, 'COUNTYTAX'));
                "Account No." := "County US Tax Account";
                StateTax := '';
            END;
        pTaxTitle := '';
    end;

    /// <summary>
    /// ValidateJournalBatchName.
    /// </summary>
    /// <returns>Return value of type Boolean.</returns>
    procedure ValidateJournalBatchName(): Boolean
    var
        GenJournalTemplate: Record "Gen. Journal Template";
        BatchNotCreatedLbl: label 'Failed to insert Journal Template Name %1', comment = 'DAN="Kladde blev ikke oprette %1"';
    begin
        SPYSetup.TestField("Default Journal Temp Name");
        SPYSetup.TestField("Default Journal Batch Name");
        if "Journal Template Name" = '' then
            "Journal Template Name" := SPYSetup."Default Journal Temp Name";

        if not GenJournalTemplate.Get(Rec."Journal Template Name") then begin
            GenJournalTemplate.Init();
            GenJournalTemplate.Name := Rec."Journal Template Name";
            if not GenJournalTemplate.Insert() then
                ErrorList.Add(StrSubstNo(BatchNotCreatedLbl, Rec."Journal Template Name"));
        end;

        genJournalBatch.SetFilter("Journal Template Name", Rec."Journal Template Name");
        genJournalBatch.SetFilter("Template Type", '%1', SPYSetup."Default Template Type");
        genJournalBatch.SetFilter(Name, "Journal Batch Name");
        if not genJournalBatch.FindSet() then begin
            genJournalBatch.Init();
            genJournalBatch.Description := SPYSetup."Default Journal Batch Name";
            genJournalBatch.Name := "Journal Batch Name";
            genJournalBatch."Template Type" := SPYSetup."Default Template Type";
            genJournalBatch."Journal Template Name" := "Journal Template Name";
            if not genJournalBatch.Insert() then
                ErrorList.Add(StrSubstNo(BatchNotCreatedLbl, SPYSetup."Default Template Type")) else
                exit(true);
        end;
    end;

    /// <summary>
    /// ValidateDocumentType.
    /// </summary>
    procedure ValidateDocumentType(): Boolean
    begin
        PostingType := '';
        case documentTypeAsText of
            'Sale':
                begin
                    "Document Type" := "Document Type"::Invoice;
                    PostingType := 'Sale';
                end;
            'SaleCredit':
                begin
                    "Document Type" := "Document Type"::"Credit Memo";
                    PostingType := 'Sale';
                end;
            'Purchase':
                begin
                    "Document Type" := "Document Type"::Invoice;
                    PostingType := 'Purchase';
                end;
            'PurchaseCredit':
                begin
                    "Document Type" := "Document Type"::"Credit Memo";
                    PostingType := 'Purchase';
                end;
        end;
    end;

    /// <summary>
    /// ValidatePostingDate.
    /// </summary>
    procedure ValidatePostingDate(DateAsText: Text[10]): Boolean
    var
        DayConvFailedLbl: Label 'DateConvErr: Day convertion failed: %1', Comment = '%1 = Day sent from SPY';
        MonthConvFailedLbl: Label 'DateConvErr:Month convertion failed: %1', Comment = '%1 = Month sent from SPY';
        YearConvFailedLbl: Label 'DateConvErr:Year convertion failed: %1', Comment = '%1 = Year sent from SPY';
        Error: Text;

    begin
        clear(gPostingDate);
        if not evaluate(day, CopyStr(Format(Rec."Posting Date"), 9, 2)) then
            ErrorList.Add(StrSubstNo(DayConvFailedLbl, CopyStr(Format(Rec."Posting Date"), 9, 2)));
        if not evaluate(month, CopyStr(Format(Rec."Posting Date"), 6, 2)) then
            ErrorList.Add(StrSubstNo(MonthConvFailedLbl, CopyStr(Format(Rec."Posting Date"), 6, 2)));
        if not evaluate(year, CopyStr(Format(Rec."Posting Date"), 1, 4)) then
            ErrorList.Add(StrSubstNo(YearConvFailedLbl, CopyStr(Format(Rec."Posting Date"), 1, 4)));
        gPostingDate := DMY2Date(day, month, year);
        Error := Rec.GetErrorTextList();
        If Error.Contains('DateConvErr:') then
            exit(false) else
            exit(true);
    end;

    /// <summary>
    /// GetErrors.
    /// </summary>
    /// <returns>Return value of type Text.</returns>
    procedure GetErrorTextList(): Text
    var
        ErrorsLbl: label '{"code": 400, \n "message": "%1"}', Comment = '%1 CollectedErrorMessages';
        ErrorText: Text;
        ErrorTotal: Text;
        i: Integer;
    begin
        if ErrorList.Count > 0 Then
            foreach ErrorText in ErrorList do begin
                i += 1;
                ErrorTotal += ErrorList.Get(i);
                ErrorTotal += '\n';
            end;
        if ErrorTotal <> '' then begin
            ErrorTotal := StrSubstNo(ErrorsLbl, ErrorTotal);
            exit(ErrorTotal);
        end;
    end;

    /// <summary>
    /// ValidateAccountType.
    /// </summary>
    procedure ValidateAccountType()
    var
        GLAccount: Record "G/L Account";
        Customer: Record Customer;
        Vendor: Record Vendor;
        AccountNoGetErrorLbl: Label '[Account No Err] does not exist %1', comment = '%1 = Account No';
        Error: Text;
    begin
        case postType of
            'tax', 'ledger':
                begin
                    GenJournalLine."Account Type" := "Account Type"::"G/L Account";
                    if not GLAccount.Get("Account No.") then
                        ErrorList.Add(StrSubstNo(AccountNoGetErrorLbl, "Account No."))
                end;
            'customer':
                begin
                    GenJournalLine."Account Type" := "Account Type"::Customer;
                    if not Customer.Get("Account No.") then
                        ErrorList.Add(StrSubstNo(AccountNoGetErrorLbl, "Account No."))
                end;
            'supplier':
                begin
                    GenJournalLine."Account Type" := "Account Type"::Vendor;
                    if not Vendor.Get("Account No.") then
                        ErrorList.Add(StrSubstNo(AccountNoGetErrorLbl, "Account No."))
                end;
        end;

        Error := Rec.GetErrorTextList();
        if not Error.Contains('[Account No Err]') then
            GenJournalLine.Validate("Account No.");
    end;

    /// <summary>
    /// GetBankAccount.
    /// </summary>
    procedure GetBankAccount()
    begin
        if (Rec.entryType = 'payment_offset') and (Rec.postType = 'ledger') then begin
            RecordRefBank.Open(Database::"Bank Account Posting Group");
            if RecordRefBank.FieldExist(3) then
                FieldRefBank := RecordRefBank.Field(3)
            else
                FieldRefBank := RecordRefBank.Field(2);

            FieldRefBank.SetFilter("Account No.");
            If RecordRefBank.FindSet() THEN begin
                BankAccount.SetFilter("Bank Acc. Posting Group", RecordRefBank.field(1).Value);
                BankAccount.SetFilter("Currency Code", "Currency Code");
                if BankAccount.FindFirst() then begin
                    Rec."Account Type" := "Account Type"::"Bank Account";
                    Rec."Account No." := BankAccount."No.";
                    Rec.validate("Account No.");
                end;
            end;
        end;
    end;

    /// <summary>
    /// SetPostingGroups.
    /// </summary>
    /// <param name="SPYSetup">VAR Record "Spy Setup".</param>
    procedure SetPostingGroups(var SPYSetup: Record "Spy Setup")
    var
        VATBusinessPostingGroup: Record "VAT Business Posting Group";
    begin
        GenJournalLine."Gen. Bus. Posting Group" := '';
        GenJournalLine."Gen. Prod. Posting Group" := '';
        GenJournalLine."Gen. Posting Type" := GenJournalLine."Gen. Posting Type"::" ";
        GenJournalLine."VAT Prod. Posting Group" := '';
        GenJournalLine."VAT Bus. Posting Group" := '';
        if "VAT Code" <> '' then begin
            If not VATBusinessPostingGroup.Get("VAT Code") then
                ErrorList.Add('Invalid VAT Code') else
                GenJournalLine.Validate("VAT Bus. Posting Group", "VAT Code");
            GenJournalLine.Validate("VAT Prod. Posting Group", SPYSetup."VAT Prod. Posting Group");
            GenJournalLine.Validate("Gen. Bus. Posting Group", "VAT Code");
            GenJournalLine.Validate("Gen. Prod. Posting Group", SPYSetup."Gen. Prod. Posting Group");

            if (PostingType = 'Sale') then
                GenJournalLine.Validate("Gen. Posting Type", GenJournalLine."Gen. Posting Type"::Sale);
            if PostingType = 'Purchase' then
                GenJournalLine.Validate("Gen. Posting Type", GenJournalLine."Gen. Posting Type"::Purchase);
        end;
    end;

    /// <summary>
    /// SetDueDate.
    /// </summary>
    procedure SetDueDate()
    begin
        if Rec."Due Date" <> 0D then begin
            evaluate(day, CopyStr(Format("Due Date"), 9, 2));
            evaluate(month, CopyStr(Format("Due Date"), 6, 2));
            evaluate(year, CopyStr(Format("Due Date"), 1, 4));
            Rec."Due Date" := DMY2Date(day, month, year);
        end;
    end;

    /// <summary>
    /// SetCashDiscountDate.
    /// </summary>
    procedure SetCashDiscountDate()
    begin
        if Rec."Pmt. Discount Date" <> 0D then begin
            evaluate(day, CopyStr(Format("Pmt. Discount Date"), 9, 2));
            evaluate(month, CopyStr(Format("Pmt. Discount Date"), 6, 2));
            evaluate(year, CopyStr(Format("Pmt. Discount Date"), 1, 4));
            Rec."Pmt. Discount Date" := DMY2Date(day, month, year);
        end;
    end;

    /// <summary>
    /// SetSalesPurchExclVAT.
    /// </summary>
    procedure SetSalesPurchExclVAT()
    var
        SetSalesPurchExclVATErr: Label '[SetSalesPurchExclVATErr] %1', Comment = '%1 = LineNo';
    begin
        if (Rec."Account Type" = "Account Type"::Customer) or
            (Rec."Account Type" = "Account Type"::Vendor) then begin
            GenJournalLine.Reset();
            GenJournalLine.SETRANGE(GenJournalLine."Journal Template Name", Rec."Journal Template Name");
            GenJournalLine.SETRANGE("Journal Batch Name", Rec."Journal Batch Name");
            GenJournalLine.SETFILTER("Document No.", Rec."Document No.");
            if GenJournalLine.FindSet() then begin
                ExclVAT := "Amount (LCY)";
                repeat
                    ExclVAT := ExclVAT + GenJournalLine."VAT Amount (LCY)";
                until GenJournalLine.Next() = 0;
            end;
            GenJournalLine."Sales/Purch. (LCY)" := ExclVAT;
            if not GenJournalLine.Modify() then
                ErrorList.Add(StrSubstNo(SetSalesPurchExclVATErr, Rec."Line No."))
        end;
    end;

    /// <summary>
    /// CopyCustomerDimensions.
    /// </summary>
    procedure CopyCustomerDimensions()
    begin
        if (Rec."Account Type" = "Account Type"::Customer) then begin
            gDefaultDimension.Setfilter("Table ID", '18');
            gCustomer.Reset();
            gCustomer.SetFilter("No.", deliveryAccount);

            if (deliveryAccount <> '') AND gCustomer.FindFirst() then
                gDefaultDimension.SetFilter("No.", deliveryAccount)
            else
                gDefaultDimension.SetFilter("No.", "Account No.");

            if gDefaultDimension.FindSet() then begin
                EntryNo := 1;
                repeat
                    IF (gDefaultDimension."Dimension Code" <> '') AND (gDefaultDimension."Dimension Value Code" <> '') then begin
                        TempDimensionBuffer3.Reset();
                        TempDimensionBuffer3.SetFilter("Dimension Code", gDefaultDimension."Dimension Code");
                        TempDimensionBuffer3.SetFilter("Dimension Value Code", gDefaultDimension."Dimension Value Code");
                        TempDimensionBuffer3.SetFilter("Table ID", '81');
                        if not TempDimensionBuffer3.FindSet() then begin
                            TempDimensionBuffer3.Reset();
                            TempDimensionBuffer3.Init();
                            TempDimensionBuffer3."Table ID" := 81;
                            TempDimensionBuffer3."Entry No." := EntryNo;
                            EntryNo := EntryNo + 1;
                            TempDimensionBuffer3."Dimension Code" := gDefaultDimension."Dimension Code";
                            TempDimensionBuffer3."Dimension Value Code" := gDefaultDimension."Dimension Value Code";
                            TempDimensionBuffer3.Insert();
                        end;
                    end;
                until gDefaultDimension.Next() = 0;

                GenJournalLine.Reset();
                GenJournalLine.SETRANGE(GenJournalLine."Journal Template Name", "Journal Template Name");
                GenJournalLine.SETRANGE("Journal Batch Name", "Journal Batch Name");
                GenJournalLine.SETFILTER("Document No.", "Document No.");
                if GenJournalLine.FindSet() then begin
                    EntryNo := 1;
                    repeat
                        DimensionSetEntry.Reset();
                        DimensionSetEntry.SetFilter("Dimension Set ID", FORMAT(GenJournalLine."Dimension Set ID"));
                        if DimensionSetEntry.FindSet() then
                            repeat
                                TempDimensionBuffer.Reset();
                                TempDimensionBuffer.Init();
                                TempDimensionBuffer."Entry No." := EntryNo;
                                EntryNo := EntryNo + 1;
                                TempDimensionBuffer."Table ID" := 81;
                                TempDimensionBuffer."Dimension Code" := DimensionSetEntry."Dimension Code";
                                TempDimensionBuffer."Dimension Value Code" := DimensionSetEntry."Dimension Value Code";
                                TempDimensionBuffer.Insert();
                            until DimensionSetEntry.Next() = 0;

                        IF TempDimensionBuffer3.FindSet() then
                            repeat
                                TempDimensionBuffer2.SETFILTER("Dimension Code", TempDimensionBuffer3."Dimension Code");
                                IF not TempDimensionBuffer2.FindSet() then begin
                                    TempDimensionBuffer.Reset();
                                    TempDimensionBuffer.Init();
                                    TempDimensionBuffer."Entry No." := EntryNo;
                                    EntryNo := EntryNo + 1;
                                    TempDimensionBuffer."Table ID" := 81;
                                    TempDimensionBuffer."Dimension Code" := TempDimensionBuffer3."Dimension Code";
                                    TempDimensionBuffer."Dimension Value Code" := TempDimensionBuffer3."Dimension Value Code";
                                    TempDimensionBuffer.Insert();
                                end;
                            until TempDimensionBuffer3.Next() = 0;
                        GenJournalLine."Dimension Set ID" := DimensionManagement.CreateDimSetIDFromDimBuf(TempDimensionBuffer);
                        GenJournalLine.Modify();
                        TempDimensionBuffer.DeleteAll();
                    until GenJournalLine.Next() = 0;
                    TempDimensionBuffer3.DeleteAll();
                end;
            end;
        end;
    end;

    /// <summary>
    /// SetGlobalDimensions.
    /// </summary>
    procedure SetGlobalDimensions()
    begin
        GenJournalLine.Reset();
        GenJournalLine.SETRANGE(GenJournalLine."Journal Template Name", Rec."Journal Template Name");
        GenJournalLine.SETRANGE("Journal Batch Name", Rec."Journal Batch Name");
        GenJournalLine.SETFILTER("Document No.", Rec."Document No.");
        if GenJournalLine.FindSet() then
            repeat
                DimensionManagement.UpdateGlobalDimFromDimSetID(
                    GenJournalLine."Dimension Set ID",
                    GenJournalLine."Shortcut Dimension 1 Code",
                    GenJournalLine."Shortcut Dimension 2 Code");
                GenJournalLine.Modify();
            until GenJournalLine.Next() = 0;
    end;

    /// <summary>
    /// SetErrors.
    /// </summary>
    /// <param name="SpyJournalLine">VAR Record "Spy Create Journal Line".</param>
    /// <param name="SpyErrors">VAR Record "Spy Errors".</param>
    procedure ErrorExists() ErrorFound: Boolean
    var
        SpyErrors: Record "Spy Errors";
        ErrorOutStream: OutStream;
        Errors: Text;
    begin
        Errors := Rec.GetErrorTextList();
        If Errors <> '' then begin
            SpyErrors.Init();
            SpyErrors."Entry No." := Rec."Entry No.";
            SpyErrors."Journal Template Name" := Rec."Journal Template Name";
            SpyErrors."Journal Batch Name" := Rec."Journal Batch Name";
            SpyErrors."Document No." := Rec."Document No.";
            SpyErrors."Line No." := Rec."Line No.";
            SpyErrors."Error Description".CreateOutStream(ErrorOutStream);
            ErrorOutStream.WriteText(Errors);
            SpyErrors.Insert();
            Rec."Ready To Post" := false;
            Rec.Modify();
            exit(true);
        end
        else
            Exit(false);
    end;

    procedure GetErrorsRec(var SpyJournalLine: Record "Spy Create Journal Line"; var SpyErrors: Record "Spy Errors")
    var
        lSpyErrors: Record "Spy Errors";
    begin
        lSpyErrors.SetRange("Entry No.", SpyJournalLine."Entry No.");
        lSpyErrors.SetRange("Journal Template Name", SpyJournalLine."Journal Template Name");
        lSpyErrors.SetRange("Journal Batch Name", SpyJournalLine."Journal Batch Name");
        lSpyErrors.SetRange("Document No.", SpyJournalLine."Document No.");
        lSpyErrors.SetRange("Line No.", SpyJournalLine."Line No.");
        if lSpyErrors.Get() then
            SpyErrors := lSpyErrors;
    end;

    var
        BankAccount: record "Bank Account";
        GenJournalLine: Record "Gen. Journal Line";
        gCustomer: record Customer;
        genJournalBatch: Record "Gen. Journal Batch";
        DimensionSetEntry: Record "Dimension Set Entry";

        TempDimensionBuffer: Record "Dimension Buffer" temporary;
        TempDimensionBuffer2: Record "Dimension Buffer" temporary;
        TempDimensionBuffer3: Record "Dimension Buffer" temporary;
        gDefaultDimension: record "Default Dimension";
        DimensionManagement: Codeunit DimensionManagement;
        RecordRefBank: RecordRef;
        SPYSetup: Record "Spy Setup";
        FieldRefBank: FieldRef;
        StateTax: Text[20];
        PostingType: text;
        day: integer;
        month: Integer;
        year: Integer;
        EntryNo: Integer;
        ExclVAT: Decimal;
        ErrorList: List of [Text];
        gPostingDate: Date;

}