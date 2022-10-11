/// <summary>
/// Table Spy Create Journal Line (ID 73090).
/// </summary>
table 73090 "Spy Journal Line"
{
    Caption = 'Spy Journal Line', comment = 'DAN="Spy kladdelinje';
    fields
    {

        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
        }

        field(2; "Journal Template Name"; Code[10])
        {
            Caption = 'Journal Template Name';
            ValidateTableRelation = false;
            TableRelation = "Gen. Journal Template";
            DataClassification = CustomerContent;
        }

        field(4; "Journal Batch Name"; Code[10])
        {
            Caption = 'Journal Batch Name';
            DataClassification = CustomerContent;
            ValidateTableRelation = false;
            TableRelation = "Gen. Journal Batch".Name WHERE("Journal Template Name" = FIELD("Journal Template Name"));
        }
        field(8; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;

        }

        field(12; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            TableRelation = Currency;
            ValidateTableRelation = false;
            DataClassification = CustomerContent;

        }

        field(13; Amount; Decimal)
        {
            Caption = 'Amount';
            DataClassification = CustomerContent;

        }
        field(16; "Amount (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Amount (LCY)';
            DataClassification = CustomerContent;

        }
        field(33; "Account Type"; Enum "Gen. Journal Account Type")
        {
            Caption = 'Account Type';
            DataClassification = CustomerContent;
        }


        field(37; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = CustomerContent;
        }
        field(38; "Due Date"; Text[20]) //dueDate
        {
            Caption = 'Due Date';
        }

        field(39; "Cash Discount Date"; Text[20]) //cashDiscountDate
        {
            Caption = 'Pmt. Discount Date';
        }

        field(40; documentTypeAsText; Text[20])
        {
            Caption = 'documentTypeAsText';
            DataClassification = CustomerContent;
        }


        field(44; "Account No."; Code[20])
        {
            Caption = 'Account No.';
            DataClassification = CustomerContent;

        }

        field(46; "Document Type"; Enum "Gen. Journal Document Type")
        {
            Caption = 'Document Type';
            DataClassification = CustomerContent;
        }
        field(47; "Payment Terms Code"; Code[10])
        {
            Caption = 'Payment Terms Code';
            TableRelation = "Payment Terms";
            ValidateTableRelation = false;
        }

        field(55; "Posting Date"; Text[10])
        {
            Caption = 'Posting Date';
            DataClassification = CustomerContent;
        }
        field(77; "External Document No."; Code[20])
        {
            Caption = 'External Document No.';
            DataClassification = CustomerContent;

        }

        field(120; "Country/Region Code"; Code[10])
        {
            Caption = 'Country/Region Code';
            TableRelation = "Country/Region";
            ValidateTableRelation = false;
            DataClassification = CustomerContent;


        }
        field(510; postType; Text[20])
        {
            Caption = 'postType';
            DataClassification = CustomerContent;



        }

        field(515; deliveryAccount; Text[20])
        {
            Caption = 'Delivery Acoount';
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
        field(623; entryType; Text[30])
        {
            Caption = 'entryType';
        }
        field(654; vatArea; Code[20]) //NOT USED?
        {
            Caption = 'vatArea';
        }
        field(800; "Tax Title"; Text[20])
        {
            Caption = 'TaxTitle';
        }
        field(888; "tax Percentage"; Decimal)
        {
            Caption = 'Tax Percent', comment = 'DAN="Moms Percent"';
        }
        field(901; custGroup; Text[50])
        {
            Caption = 'custGroup';
        }

        // field(1000; "SPY Dimensions"; Integer)
        // {
        //     Caption = 'SPY Dimension';
        //     ValidateTableRelation = false;
        //     TableRelation = "Spy Dimensions" where("Entry No." = field("Entry No."));
        // }
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
    trigger OnInsert()
    var
        SpyJournalLine: Record "Spy Journal Line";
    begin
        if SpyJournalLine.FindLast() then
            Rec."Entry No." := SpyJournalLine."Entry No." + 1 else
            Rec."Entry No." := 1;
    end;

    /// <summary>
    /// CopyCustomerDimensions.
    /// </summary>
    procedure CopyCustomerDimensions()
    begin

        if (Rec."Account Type" = Rec."Account Type"::Customer) then begin
            gDefaultDimension.Setfilter("Table ID", '18');
            gCustomer.Reset();
            gCustomer.SetFilter("No.", deliveryAccount);

            if (deliveryAccount <> '') and gCustomer.FindFirst() then
                gDefaultDimension.SetFilter("No.", deliveryAccount)
            else
                gDefaultDimension.SetFilter("No.", "Account No.");

            if gDefaultDimension.FindSet() then begin
                gDimEntryNo := 1;
                repeat
                    if (gDefaultDimension."Dimension Code" <> '') and (gDefaultDimension."Dimension Value Code" <> '') then begin
                        TempDimensionBuffer3.Reset();
                        TempDimensionBuffer3.SetFilter("Dimension Code", gDefaultDimension."Dimension Code");
                        TempDimensionBuffer3.SetFilter("Dimension Value Code", gDefaultDimension."Dimension Value Code");
                        TempDimensionBuffer3.SetFilter("Table ID", '81');
                        if not TempDimensionBuffer3.FindSet() then begin
                            TempDimensionBuffer3.Reset();
                            TempDimensionBuffer3.Init();
                            TempDimensionBuffer3."Table ID" := 81;
                            TempDimensionBuffer3."Entry No." := gDimEntryNo;
                            gDimEntryNo := gDimEntryNo + 1;
                            TempDimensionBuffer3."Dimension Code" := gDefaultDimension."Dimension Code";
                            TempDimensionBuffer3."Dimension Value Code" := gDefaultDimension."Dimension Value Code";
                            TempDimensionBuffer3.Insert();
                        end;
                    end;
                until gDefaultDimension.Next() = 0;

                GlobalGenJournalLine.Reset();
                GlobalGenJournalLine.SETRANGE(GlobalGenJournalLine."Journal Template Name", Rec."Journal Template Name");
                GlobalGenJournalLine.SETRANGE("Journal Batch Name", Rec."Journal Batch Name");
                GlobalGenJournalLine.SETFILTER("Document No.", Rec."Document No.");
                if GlobalGenJournalLine.FindSet() then begin
                    gDimEntryNo := 1;
                    repeat
                        DimensionSetEntry.Reset();
                        DimensionSetEntry.SetFilter("Dimension Set ID", FORMAT(GlobalGenJournalLine."Dimension Set ID"));
                        if DimensionSetEntry.FindSet() then
                            repeat
                                TempDimensionBuffer.Reset();
                                TempDimensionBuffer.Init();
                                TempDimensionBuffer."Entry No." := gDimEntryNo;
                                gDimEntryNo := gDimEntryNo + 1;
                                TempDimensionBuffer."Table ID" := 81;
                                TempDimensionBuffer."Dimension Code" := DimensionSetEntry."Dimension Code";
                                TempDimensionBuffer."Dimension Value Code" := DimensionSetEntry."Dimension Value Code";
                                TempDimensionBuffer.Insert();
                            until DimensionSetEntry.Next() = 0;

                        if TempDimensionBuffer3.FindSet() then
                            repeat
                                TempDimensionBuffer2.SETFILTER("Dimension Code", TempDimensionBuffer3."Dimension Code");
                                if not TempDimensionBuffer2.FindSet() then begin
                                    TempDimensionBuffer.Reset();
                                    TempDimensionBuffer.Init();
                                    TempDimensionBuffer."Entry No." := gDimEntryNo;
                                    gDimEntryNo := gDimEntryNo + 1;
                                    TempDimensionBuffer."Table ID" := 81;
                                    TempDimensionBuffer."Dimension Code" := TempDimensionBuffer3."Dimension Code";
                                    TempDimensionBuffer."Dimension Value Code" := TempDimensionBuffer3."Dimension Value Code";
                                    TempDimensionBuffer.Insert();
                                end;
                            until TempDimensionBuffer3.Next() = 0;
                        GlobalGenJournalLine."Dimension Set ID" := DimensionManagement.CreateDimSetIDFromDimBuf(TempDimensionBuffer);
                        GlobalGenJournalLine.Modify();
                        TempDimensionBuffer.DeleteAll();
                    until GlobalGenJournalLine.Next() = 0;
                    TempDimensionBuffer3.DeleteAll();
                end;
            end;
        end;
    end;

    /// <summary>
    /// ErrorExists.
    /// </summary>
    /// <returns>Return variable ErrorFound of type Boolean.</returns>
    procedure ErrorExists() ErrorFound: Boolean
    var
        SpyErrors: Record "Spy Error";
        ErrorOutStream: OutStream;
        Errors: Text;
    begin
        Errors := Rec.GetErrorTextList();
        if Errors <> '' then begin
            SpyErrors.Init();
            SpyErrors."Entry No." := Rec."Entry No.";
            SpyErrors."Journal Template Name" := Rec."Journal Template Name";
            SpyErrors."Journal Batch Name" := Rec."Journal Batch Name";
            SpyErrors."Spy Jnl Line Description" := Rec.Description;
            SpyErrors."External Document No." := Rec."External Document No.";
            SpyErrors."Error Description".CreateOutStream(ErrorOutStream);
            ErrorOutStream.WriteText(Errors);
            SpyErrors.Insert();
            Rec."Ready To Post" := false;
            Rec.Modify();
            exit(true);
        end
        else
            exit(false);
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
            if RecordRefBank.FindSet() THEN begin
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
    /// GetErrorsRec.
    /// </summary>
    /// <param name="SpyJournalLine">VAR Record "Spy Create Journal Line".</param>
    /// <param name="SpyErrors">VAR Record "Spy Errors".</param>
    procedure GetErrorsRec(var SpyJournalLine: Record "Spy Journal Line"; var SpyErrors: Record "Spy Error")
    var
        lSpyErrors: Record "Spy Error";
    begin
        lSpyErrors.SetRange("Journal Template Name", SpyJournalLine."Journal Template Name");
        lSpyErrors.SetRange("Entry No.", SpyJournalLine."Entry No.");
        lSpyErrors.SetRange("External Document No.", SpyJournalLine."Document No.");
        if lSpyErrors.FindFirst() then
            SpyErrors := lSpyErrors;
    end;

    /// <summary>
    /// GetErrors.
    /// </summary>
    /// <returns>Return value of type Text.</returns>
    procedure GetErrorTextList(): Text
    var
        ErrorsLbl: label '{"code": 400, "message": "%1"}', Comment = '%1 = CollectedErrorMessages';
        ErrorText: Text;
        ErrorTotal: Text;
        i: Integer;
    begin
        if GlobalErrorTextList.Count > 0 Then
            foreach ErrorText in GlobalErrorTextList do begin
                i += 1;
                ErrorTotal += GlobalErrorTextList.Get(i) + ' ';
            end;
        if ErrorTotal <> '' then begin
            ErrorTotal := StrSubstNo(ErrorsLbl, ErrorTotal);
            exit(ErrorTotal);
        end;
    end;

    /// <summary>
    /// PostJournal.
    /// </summary>
    /// <returns>Return value of type Boolean.</returns>
    [ServiceEnabled]
    procedure PostTempSpyJournalLines(): Boolean
    var
        GeneralLedgerSetup: record "General Ledger Setup";
        SpyDimensions: Record "Spy Dimension";
        InsertGenJnlLineErr: label '[CreationErr] Failed to Insert Gen. Journal Line %1', comment = '%1 = Ext Doc No.';
    begin
        Clear(GlobalErrorTextList);
        Clear(BankAccount);
        Clear(TempDimensionBuffer);
        SPYSetup.Get();
        GeneralLedgerSetup.Get();
        SPYSetup.TestField("Default Journal Template Name");

        gDimEntryNo := 1;
        LockTable(true);

        GlobalGenJournalLine.Init();
        //GenJournalLine.SetCurrentKey(GenJournalLine."Journal Template Name", GenJournalLine."Journal Batch Name", GenJournalLine."Line No.");
        if Rec.ValidateJournalBatchName() then begin
            GlobalGenJournalLine.Validate("Journal Template Name", Rec."Journal Template Name");
            GlobalGenJournalLine.validate("Journal Batch Name", Rec."Journal Batch Name");
            GlobalGenJournalLine."Line No." := GlobalGenJournalLine.GetNewLineNo(Rec."Journal Template Name", Rec."Journal Batch Name"); //Validates Temp and Batch Name
            Rec.ValidateAccountTypeAndNo();
            Rec.ValidatePostingDate();
            Rec.ValidateDocumentType();

            GlobalGenJournalLine.Validate("Document No.", "Document No.");
            GlobalGenJournalLine.Validate("External Document No.", Rec."External Document No.");
            GlobalGenJournalLine.Validate(Description, Rec.Description);
            GlobalGenJournalLine.Validate("Amount (LCY)", Rec."Amount (LCY)");


            if GeneralLedgerSetup."LCY Code" = Rec."Currency Code" then
                GlobalGenJournalLine."Currency Code" := '' else
                GlobalGenJournalLine."Currency Code" := Rec."Currency Code";

            Rec.ValidateTaxTitle();
            Rec.SetPostingGroups();
            Rec.GetBankAccount();
            Rec.SetDueDate();
            Rec.SetCashDiscountDate();
            if Rec.ErrorExists() then
                exit(false);
        end;

        if not GlobalGenJournalLine.Insert(true) then
            GlobalErrorTextList.Add(StrSubstNo(InsertGenJnlLineErr, Rec."External Document No." + ' ' + Format(Rec."Entry No.")));

        //Set dimensionsId
        SpyDimensions.SetRange("External Document No.", Rec."External Document No.");
        SpyDimensions.SetRange("Entry No.", Rec."Entry No.");
        if SpyDimensions.FindSet() then
            repeat
                FillTempDimBuffer(SpyDimensions);
            until SpyDimensions.Next() = 0;
        GlobalGenJournalLine."Dimension Set ID" := DimensionManagement.CreateDimSetIDFromDimBuf(TempDimensionBuffer);
        TempDimensionBuffer.DeleteAll();

        gDimEntryNo := 1;
        GlobalGenJournalLine.Modify();
        Rec.SetSalesPurchExclVAT();    //Only run if "Account Type" = "Account Type"::Customer, Vendor
        Rec.CopyCustomerDimensions(); //Only run if "Account Type" = "Account Type"::Customer
        //Rec.UpdateGlobalDimensions();

        if ErrorFoundInErrorTextList('[CreationErr]') then
            exit(false) else
            exit(true);
    end;

    /// <summary>
    /// SetCashDiscountDate.
    /// </summary>
    procedure SetCashDiscountDate()
    begin
        if Rec."Cash Discount Date" <> '' then begin
            evaluate(day, CopyStr(Format(Rec."Cash Discount Date"), 9, 2));
            evaluate(month, CopyStr(Format(Rec."Cash Discount Date"), 6, 2));
            evaluate(year, CopyStr(Format(Rec."Cash Discount Date"), 1, 4));
            GlobalGenJournalLine."Pmt. Discount Date" := DMY2Date(day, month, year);
        end;
    end;

    /// <summary>
    /// SetDueDate.
    /// </summary>
    procedure SetDueDate()
    begin
        if Rec."Due Date" <> '' then begin
            evaluate(day, CopyStr(Format("Due Date"), 9, 2));
            evaluate(month, CopyStr(Format("Due Date"), 6, 2));
            evaluate(year, CopyStr(Format("Due Date"), 1, 4));
            GlobalGenJournalLine."Due Date" := DMY2Date(day, month, year);
        end;
    end;

    /// <summary>
    /// SetGlobalDimensions.
    /// </summary>
    /// <returns>Return value of type Boolean.</returns>
    procedure UpdateGlobalDimensions(): Boolean
    var
    begin
        //This i called from SpyDimensions table
        GlobalGenJournalLine.Reset();
        GlobalGenJournalLine.SETRANGE("Journal Template Name", Rec."Journal Template Name");
        GlobalGenJournalLine.SETRANGE("Journal Batch Name", Rec."Journal Batch Name");
        GlobalGenJournalLine.SETFILTER(Description, Rec.Description);
        if GlobalGenJournalLine.FindSet() then
            repeat
                DimensionManagement.UpdateGlobalDimFromDimSetID(
                    GlobalGenJournalLine."Dimension Set ID",
                    GlobalGenJournalLine."Shortcut Dimension 1 Code",
                    GlobalGenJournalLine."Shortcut Dimension 2 Code");
            until GlobalGenJournalLine.Next() = 0;
        GlobalGenJournalLine.Modify();
    end;

    /// <summary>
    /// SetPostingGroups.
    /// </summary>
    /// <returns>Return value of type Boolean.</returns>
    procedure SetPostingGroups(): Boolean
    var
        VATBusinessPostingGroup: Record "VAT Business Posting Group";
        GenBusinessPostingGroup: Record "Gen. Business Posting Group";
        InvalidVATCodeLbl: label '[VAT Code Err] %1 does not exist in BC', Comment = '%1 = VAT Code from SPY';
    begin
        GlobalGenJournalLine."Gen. Bus. Posting Group" := '';
        GlobalGenJournalLine."Gen. Prod. Posting Group" := '';
        GlobalGenJournalLine."Gen. Posting Type" := GlobalGenJournalLine."Gen. Posting Type"::" ";
        GlobalGenJournalLine."VAT Prod. Posting Group" := '';
        GlobalGenJournalLine."VAT Bus. Posting Group" := '';

        if Rec."VAT Code" <> '' then begin
            if not VATBusinessPostingGroup.Get(Rec."VAT Code") then
                GlobalErrorTextList.Add(StrSubstNo(InvalidVATCodeLbl, Rec."VAT Code")) else
                GlobalGenJournalLine.Validate("VAT Bus. Posting Group", "VAT Code");

            if not GenBusinessPostingGroup.Get(Rec."VAT Code") then
                GlobalErrorTextList.Add(StrSubstNo(InvalidVATCodeLbl, Rec."VAT Code")) else
                GlobalGenJournalLine.Validate("Gen. Bus. Posting Group", "VAT Code");

            GlobalGenJournalLine.Validate("VAT Prod. Posting Group", SPYSetup."VAT Prod. Posting Group");
            GlobalGenJournalLine.Validate("Gen. Prod. Posting Group", SPYSetup."Gen. Prod. Posting Group");

            if (PostingType = 'Sale') then
                GlobalGenJournalLine.Validate("Gen. Posting Type", GlobalGenJournalLine."Gen. Posting Type"::Sale);
            if PostingType = 'Purchase' then
                GlobalGenJournalLine.Validate("Gen. Posting Type", GlobalGenJournalLine."Gen. Posting Type"::Purchase);
        end;

        if ErrorFoundInErrorTextList('[VAT Code Err]') then
            exit(false) else
            exit(true);

    end;

    /// <summary>
    /// SetSalesPurchExclVAT.
    /// </summary>
    /// 
    /// <returns>Return value of type Boolean.</returns>
    procedure SetSalesPurchExclVAT(): Boolean
    var
        SetSalesPurchExclVATErr: Label '[SetSalesPurchExclVATErr] %1', Comment = '%1 = LineNo';
    begin
        if (Rec."Account Type" = "Account Type"::Customer) or
            (Rec."Account Type" = "Account Type"::Vendor) then begin
            GlobalGenJournalLine.Reset();
            GlobalGenJournalLine.SETRANGE(GlobalGenJournalLine."Journal Template Name", Rec."Journal Template Name");
            GlobalGenJournalLine.SETRANGE("Journal Batch Name", Rec."Journal Batch Name");
            GlobalGenJournalLine.SETFILTER("Document No.", Rec."External Document No.");
            if GlobalGenJournalLine.FindSet() then begin
                ExclVAT := "Amount (LCY)";
                repeat
                    ExclVAT := ExclVAT + GlobalGenJournalLine."VAT Amount (LCY)";
                until GlobalGenJournalLine.Next() = 0;
            end;
            GlobalGenJournalLine."Sales/Purch. (LCY)" := ExclVAT;
            if not GlobalGenJournalLine.Modify() then
                GlobalErrorTextList.Add(StrSubstNo(SetSalesPurchExclVATErr, Rec."Entry No."));

        end;
        if ErrorFoundInErrorTextList('[SetSalesPurchExclVATErr]') then
            exit(false) else
            exit(true);

    end;

    /// <summary>
    /// ValidateAccountType.
    /// </summary>
    /// <returns>Return value of type Boolean.</returns>
    procedure ValidateAccountTypeAndNo(): Boolean
    var
        GLAccount: Record "G/L Account";
        Customer: Record Customer;
        Vendor: Record Vendor;
        AccountNoGetErrorLbl: Label '[postTypeErr] Account No. does not exist %1', comment = '%1 = Account No';
        InvalidPostTypeLbl: Label '[postTypeErr] %1 is an invalid postyingType, posttypes avaible: tax,ledger,customer or supplier', comment = '%1,%2,%3,%5 = postType';
    begin
        if not (postType in ['tax', 'ledger', 'customer', 'supplier']) then
            GlobalErrorTextList.Add(StrSubstNo(InvalidPostTypeLbl, postType))
        else
            case postType of
                'tax', 'ledger':
                    begin
                        GlobalGenJournalLine."Account Type" := "Account Type"::"G/L Account";
                        if not GLAccount.Get("Account No.") then
                            GlobalErrorTextList.Add(StrSubstNo(AccountNoGetErrorLbl, "Account No."))
                    end;
                'customer':
                    begin
                        GlobalGenJournalLine."Account Type" := "Account Type"::Customer;
                        if not Customer.Get("Account No.") then
                            GlobalErrorTextList.Add(StrSubstNo(AccountNoGetErrorLbl, "Account No."))
                    end;
                'supplier':
                    begin
                        GlobalGenJournalLine."Account Type" := "Account Type"::Vendor;
                        if not Vendor.Get("Account No.") then
                            GlobalErrorTextList.Add(StrSubstNo(AccountNoGetErrorLbl, "Account No."))
                    end;
            end;

        if ErrorFoundInErrorTextList('[postTypeErr]') then
            exit(false) else begin
            GlobalGenJournalLine.Validate("Account No.", Rec."Account No.");
            exit(true)
        end;
    end;

    /// <summary>
    /// ValidateDocumentType, this will also set the postinType
    /// </summary>
    /// <returns>Return value of type Boolean.</returns>
    procedure ValidateDocumentType(): Boolean
    var
    //InvalidDocumentTypeLbl: label '[documentTypeErr] Document Type does not exist %1, document types avaliable: Sale,SaleCredit,Purchase,PurchaseCredit', comment = '%1,%2,%3,%4 = doc type';
    begin
        PostingType := '';
        case documentTypeAsText of
            'Sale':
                begin
                    GlobalGenJournalLine.Validate("Document Type", "Document Type"::Invoice);
                    PostingType := 'Sale';
                end;
            'SaleCredit':
                begin
                    GlobalGenJournalLine.Validate("Document Type", "Document Type"::"Credit Memo");
                    PostingType := 'Sale';
                end;
            'Purchase':
                begin
                    GlobalGenJournalLine.Validate("Document Type", "Document Type"::Invoice);
                    PostingType := 'Purchase';
                end;
            'PurchaseCredit':
                begin
                    GlobalGenJournalLine.Validate("Document Type", "Document Type"::"Credit Memo");
                    PostingType := 'Purchase';
                end;
        end;
        exit(true);
    end;

    /// <summary>
    /// ValidateJournalBatchName.
    /// </summary>
    /// <returns>Return value of type Boolean.</returns>
    procedure ValidateJournalBatchName(): Boolean
    var
        GenJournalTemplate: Record "Gen. Journal Template";
        JnlTemplateNotCreatedLbl: label '[CreateJnlTemplateErr] Failed to Create Journal Template Name %1', comment = 'DAN="Kladde blev ikke oprette %1"';
        BatchNotCreatedLbl: label '[CreateJnlBacthErr] Failed to Create Journal Template Name %1', comment = 'DAN="Kladde blev ikke oprette %1"';
    begin
        SPYSetup.TestField("Default Journal Template Name");
        SPYSetup.TestField("Default Journal Batch Name");
        if Rec."Journal Template Name" = '' then
            Rec."Journal Template Name" := SPYSetup."Default Journal Template Name";

        if Rec."Journal Batch Name" = '' then
            Rec."Journal Batch Name" := SPYSetup."Default Journal Batch Name";
        //IF missing, then create GenJnlTemplate
        if not GenJournalTemplate.Get(Rec."Journal Template Name") then begin
            GenJournalTemplate.Init();
            GenJournalTemplate.Name := Rec."Journal Template Name";
            if not GenJournalTemplate.Insert() then
                GlobalErrorTextList.Add(StrSubstNo(JnlTemplateNotCreatedLbl, Rec."Journal Template Name"));
        end;

        //IF missing, then create GenJnlBatch
        genJournalBatch.SetFilter("Journal Template Name", Rec."Journal Template Name");
        genJournalBatch.SetFilter("Template Type", '%1', SPYSetup."Default Template Type");
        genJournalBatch.SetFilter(Name, Rec."Journal Batch Name");
        if not genJournalBatch.FindSet() then begin
            genJournalBatch.Init();
            genJournalBatch.Description := SPYSetup."Default Journal Batch Name";
            genJournalBatch.Name := Rec."Journal Batch Name";
            genJournalBatch."Template Type" := SPYSetup."Default Template Type";
            genJournalBatch."Journal Template Name" := SPYSetup."Default Journal Template Name";
            if not genJournalBatch.Insert() then
                GlobalErrorTextList.Add(StrSubstNo(BatchNotCreatedLbl, SPYSetup."Default Template Type"));
        end;
        if (ErrorFoundInErrorTextList('[CreateJnlTemplateErr]')) or
             (ErrorFoundInErrorTextList('[CreateJnlBacthErr]')) then
            exit(false)
        else
            exit(true);
    end;


    /// <summary>
    /// ValidatePostingDate.
    /// </summary>
    /// <returns>Return value of type Boolean.</returns>
    procedure ValidatePostingDate(): Boolean
    var
        DayConvFailedLbl: Label '[DateConvErr] Day convertion failed: %1', Comment = '%1 = Day sent from SPY';
        MonthConvFailedLbl: Label '[DateConvErr] Month convertion failed: %1', Comment = '%1 = Month sent from SPY';
        YearConvFailedLbl: Label '[DateConvErr] Year convertion failed: %1', Comment = '%1 = Year sent from SPY';
    begin
        clear(gPostingDate);
        if not evaluate(day, CopyStr(Format(Rec."Posting Date"), 9, 2)) then
            GlobalErrorTextList.Add(StrSubstNo(DayConvFailedLbl, CopyStr(Format(Rec."Posting Date"), 9, 2)));
        if not evaluate(month, CopyStr(Format(Rec."Posting Date"), 6, 2)) then
            GlobalErrorTextList.Add(StrSubstNo(MonthConvFailedLbl, CopyStr(Format(Rec."Posting Date"), 6, 2)));
        if not evaluate(year, CopyStr(Format(Rec."Posting Date"), 1, 4)) then
            GlobalErrorTextList.Add(StrSubstNo(YearConvFailedLbl, CopyStr(Format(Rec."Posting Date"), 1, 4)));

        gPostingDate := DMY2Date(day, month, year);
        GlobalGenJournalLine."Posting Date" := gPostingDate;

        if ErrorFoundInErrorTextList('[DateConvErr]') then
            exit(false) else
            exit(true);
    end;


    /// <summary>
    /// ValidateTaxTitle.
    /// </summary>
    /// <returns>Return value of type Boolean.</returns>
    procedure ValidateTaxTitle(): Boolean
    var
        TaxErrorLbl: Label '[TAX Title Err] Failed to insert TAX Dimension %1', Comment = '%1 = Dimensions Code';
    begin
        Rec."Tax Title" := DelChr(Rec."Tax Title", '=', '()');
        if Rec."Tax Title" <> '' then
            if Rec."Tax Title".Contains('State Tax') then begin
                TempDimensionBuffer.Init();
                TempDimensionBuffer."Table ID" := 81;
                TempDimensionBuffer."Entry No." := gDimEntryNo;
                gDimEntryNo := gDimEntryNo + 1;
                TempDimensionBuffer."Dimension Code" := 'STATETAX';
                TempDimensionBuffer."Dimension Value Code" := Rec."Tax Title";
                if not TempDimensionBuffer.Insert() then
                    GlobalErrorTextList.Add(StrSubstNo(TaxErrorLbl, 'STATETAX'));
                StateTax := Rec."Tax Title";
                "Account No." := "State US Tax Account";
            end else begin
                if (Rec."Tax Title" = 'County Tax') then
                    Rec."Tax Title" := DELSTR(Rec."Tax Title", STRPOS(Rec."Tax Title", 'County Tax'));

                if (Rec."Tax Title" = 'Municipal Tax') then
                    Rec."Tax Title" := DelStr(Rec."Tax Title", STRPOS(Rec."Tax Title", ' Tax'));
                TempDimensionBuffer.Init();
                TempDimensionBuffer."Table ID" := 81;
                TempDimensionBuffer."Entry No." := gDimEntryNo;
                gDimEntryNo := gDimEntryNo + 1;
                TempDimensionBuffer."Dimension Code" := 'STATETAX';
                TempDimensionBuffer."Dimension Value Code" := StateTax;
                if not TempDimensionBuffer.Insert() then
                    GlobalErrorTextList.Add(StrSubstNo(TaxErrorLbl, 'STATETAX, Country or Municipal'));

                TempDimensionBuffer.Init();
                TempDimensionBuffer."Table ID" := 81;
                TempDimensionBuffer."Entry No." := gDimEntryNo;
                gDimEntryNo := gDimEntryNo + 1;
                TempDimensionBuffer."Dimension Code" := 'COUNTYTAX';
                TempDimensionBuffer."Dimension Value Code" := Rec."Tax Title";
                if not TempDimensionBuffer.Insert() then
                    GlobalErrorTextList.Add(StrSubstNo(TaxErrorLbl, 'COUNTYTAX'));
                "Account No." := "County US Tax Account";
                StateTax := '';
            end;
        Rec."Tax Title" := '';

        if ErrorFoundInErrorTextList('[TAX Title Err]') then
            exit(false) else
            exit(true);
    end;

    /// <summary>
    /// CleanUpAfterManualPosting - used for debugging BC Code.
    /// </summary>
    /// <param name="SpyJournalLine">VAR Record "Spy Journal Line".</param>
    procedure CleanUpAfterManualPosting(var SpyJournalLine: Record "Spy Journal Line")
    var
        SpyDimensions: Record "Spy Dimension";
        SpyErrors: Record "Spy Error";
    begin
        SpyJournalLine.SetRange(Description, SpyJournalLine.Description);
        if SpyJournalLine.FindSet() then
            repeat
                SpyJournalLine.Delete();
            until SpyJournalLine.Next() = 0;
        //Delete Spy Dims
        SpyDimensions.SetRange("Spy Jnl Line Description", SpyJournalLine.Description);
        if SpyDimensions.FindSet() then
            repeat
                SpyDimensions.Delete();
            until SpyDimensions.Next() = 0;

        //Return Error Text from Blob  
        SpyErrors.SetRange("Spy Jnl Line Description", SpyJournalLine.Description);
        if SpyErrors.FindFirst() then
            repeat
                SpyErrors.Delete();
            until SpyErrors.Next() = 0;
    end;

    /// <summary>
    /// FillTempDimBuffer.
    /// </summary>
    /// <param name="SpyDimensions">VAR Record "Spy Dimensions".</param>
    /// <returns>Return variable DimNo of type Integer.</returns>
    procedure FillTempDimBuffer(var SpyDimensions: Record "Spy Dimension") DimNo: Integer
    var
        EntryNo: Integer;
    begin
        EntryNo := 1;
        TempDimensionBuffer.Reset();
        TempDimensionBuffer.SetFilter("Dimension Code", SpyDimensions."Dimension Name");
        TempDimensionBuffer.SetFilter("Dimension Value Code", SpyDimensions."Dimension Value Code");
        TempDimensionBuffer.SetFilter("Table ID", '81');
        if not TempDimensionBuffer.FindSet() then begin
            TempDimensionBuffer.Reset();
            TempDimensionBuffer.Init();
            TempDimensionBuffer."Entry No." := EntryNo;
            EntryNo := EntryNo + 1;
            TempDimensionBuffer."Table ID" := 81;
            TempDimensionBuffer."Dimension Code" := CopyStr(SpyDimensions."Dimension Name", 1, MaxStrLen(TempDimensionBuffer."Dimension Code"));
            TempDimensionBuffer."Dimension Value Code" := SpyDimensions."Dimension Value Code";
            TempDimensionBuffer.Insert();
        end;
    end;

    /// <summary>
    /// GetBCDimGLNo.
    /// </summary>
    /// <param name="SpyDimensions">VAR Record "Spy Dimensions".</param>
    /// <returns>Return variable DimNo of type Integer.</returns>
    procedure GetBCDimGLNo(var SpyDimensions: Record "Spy Dimension") DimNo: Integer
    var
        DimArray: Array[8] of code[20];
        i: Integer;
    begin
        DimensionManagement.GetGLSetup(DimArray);
        FOR i := 1 to ArrayLen(DimArray) DO
            if DimArray[i] = SpyDimensions."Dimension Name" then
                DimNo := i;
    end;


    /// <summary>
    /// ErrorFoundInErrorTextList.
    /// </summary>
    /// <param name="ErrorTextToFind">Text.</param>
    /// <returns>Return value of type Boolean.</returns>
    procedure ErrorFoundInErrorTextList(ErrorTextToFind: Text): Boolean
    var
        ErrorText: Text;
        ErrorCurrent: Text;
        i: Integer;
    begin
        if GlobalErrorTextList.Count > 0 Then
            foreach ErrorText in GlobalErrorTextList do begin
                i += 1;
                ErrorCurrent += GlobalErrorTextList.Get(i);
                if StrPos(ErrorCurrent, ErrorTextToFind) > 0 then
                    exit(true);
            end;
    end;

    var
        BankAccount: record "Bank Account";
        GlobalGenJournalLine: Record "Gen. Journal Line";
        gCustomer: record Customer;
        genJournalBatch: Record "Gen. Journal Batch";
        DimensionSetEntry: Record "Dimension Set Entry";

        TempDimensionBuffer: Record "Dimension Buffer" temporary;
        TempDimensionBuffer2: Record "Dimension Buffer" temporary;
        TempDimensionBuffer3: Record "Dimension Buffer" temporary;
        gDefaultDimension: record "Default Dimension";
        SPYSetup: Record "Spy Setup";

        DimensionManagement: Codeunit DimensionManagement;
        RecordRefBank: RecordRef;

        FieldRefBank: FieldRef;

        StateTax: Text[20];
        PostingType: text;
        day: integer;
        month: Integer;
        year: Integer;
        gDimEntryNo: Integer;
        ExclVAT: Decimal;
        GlobalErrorTextList: List of [Text];
        gPostingDate: Date;

}