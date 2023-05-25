xmlport 73090 "SpyXmlCreateJournalLine"
{
    UseDefaultNamespace = true;
    DefaultNamespace = 'urn:microsoft-dynamics-nav/xmlports/SpyXmlCreateJournalLine';
    FormatEvaluate = Xml;

    schema
    {
        textelement(accountingLines)
        {
            MinOccurs = Zero;
            MaxOccurs = Unbounded;
            tableelement(journalLine; "Gen. Journal Line")
            {
                UseTemporary = false;

                fieldelement(templateName; journalLine."Journal Template Name")
                {
                    FieldValidate = No;
                    MinOccurs = Zero;
                    MaxOccurs = Once;

                    trigger OnAfterAssignField()
                    var

                    begin
                        templateName := journalLine."Journal Template Name";
                    end;
                }
                fieldelement(journalName; journalLine."Journal Batch Name")
                {
                    FieldValidate = No;
                    MinOccurs = Once;
                    MaxOccurs = Once;

                    trigger OnAfterAssignField()

                    begin
                        batchName := journalLine."Journal Batch Name";
                        if templateName = '' then
                            templateName := 'KASSE';
                        genJournalBatch.SetFilter("Journal Template Name", templateName);
                        genJournalBatch.SetFilter("Template Type", FORMAT(genJournalBatch."Template Type"::General));
                        genJournalBatch.SetFilter(Name, journalLine."Journal Batch Name");
                        if not genJournalBatch.FindSet() then begin
                            genJournalBatch.Init();
                            genJournalBatch.Description := 'Spy Journal';
                            genJournalBatch.Name := journalLine."Journal Batch Name";
                            genJournalBatch."Template Type" := genJournalBatch."Template Type"::General;
                            genJournalBatch."Journal Template Name" := CopyStr(templateName, 1, MaxStrLen(genJournalBatch."Journal Template Name"));
                            genJournalBatch.Insert();
                        end;
                        journalLine."Journal Template Name" := CopyStr(templateName, 1, MaxStrLen(journalLine."Journal Template Name"));
                    end;
                }
                fieldelement(documentNumber; journalLine."Document No.")
                {
                    MinOccurs = Once;
                    MaxOccurs = Once;

                    trigger OnAfterAssignField()
                    // var
                    //     myInt: Integer;
                    begin
                        //Voucher := journalLine."Document No.";
                    end;
                }
                textelement(documentType)
                {
                    MinOccurs = Zero;
                    MaxOccurs = Once;
                    trigger OnAfterAssignVariable()
                    var

                    begin
                        PostingType := '';
                        case documentType of
                            'Sale':
                                begin
                                    journalLine."Document Type" := journalLine."Document Type"::Invoice;
                                    PostingType := 'Sale';
                                end;
                            'SaleCredit':
                                begin
                                    journalLine."Document Type" := journalLine."Document Type"::"Credit Memo";
                                    PostingType := 'Sale';
                                end;
                            'Purchase':
                                begin
                                    journalLine."Document Type" := journalLine."Document Type"::Invoice;
                                    PostingType := 'Purchase';
                                end;
                            'PurchaseCredit':
                                begin
                                    journalLine."Document Type" := journalLine."Document Type"::"Credit Memo";
                                    PostingType := 'Purchase';
                                end;
                        end;
                    end;
                }
                textelement(countryType)
                {
                    MinOccurs = Zero; //Please confirm if this indeed is not used for anything. KW.
                    MaxOccurs = Once;
                }
                fieldelement(account; journalLine."Account No.")
                {
                    FieldValidate = No;
                    MinOccurs = Once;
                    MaxOccurs = Once;
                }
                fieldelement(description; journalLine.Description)
                {
                    MinOccurs = Once;
                    MaxOccurs = Once;

                }
                fieldelement(amount; journalLine.Amount)
                {
                    MinOccurs = Once;
                    MaxOccurs = Once;

                }
                textelement(entryType)
                {
                    MinOccurs = Zero;
                    MaxOccurs = Once;
                }
                textelement(postingDate)
                {
                    MinOccurs = Zero;
                    MaxOccurs = Once;
                    trigger OnAfterAssignVariable()
                    var
                        day: integer;
                        month: Integer;
                        year: Integer;
                    begin
                        evaluate(day, CopyStr(postingDate, 9, 2));
                        evaluate(month, CopyStr(postingDate, 6, 2));
                        evaluate(year, CopyStr(postingDate, 1, 4));
                        journalLine."Posting Date" := DMY2Date(day, month, year);
                    end;
                }
                textelement(deliveryAccount)
                {
                    MinOccurs = Zero;
                    MaxOccurs = Once;
                }
                textelement(postType)
                {
                    MinOccurs = Once;
                    MaxOccurs = Once;
                    trigger OnAfterAssignVariable()
                    var

                    begin
                        case postType of
                            'tax':
                                journalLine."Account Type" := journalLine."Account Type"::"G/L Account";
                            'ledger':
                                journalLine."Account Type" := journalLine."Account Type"::"G/L Account";
                            'customer':
                                journalLine."Account Type" := journalLine."Account Type"::Customer;
                            'supplier':
                                journalLine."Account Type" := journalLine."Account Type"::Vendor;
                        end;

                        journalLine.Validate("Account No.");


                    end;

                }
                fieldelement(invoiceNo; journalLine."External Document No.")
                {
                    MinOccurs = Zero;
                    MaxOccurs = Once;
                }
                textelement(currency)
                {
                    MinOccurs = Zero;
                    MaxOccurs = Once;
                    trigger OnAfterAssignVariable()
                    var

                    begin
                        journalLine."Currency Code" := currency;
                    end;
                }
                fieldelement(amountBaseCurrency; journalLine."Amount (LCY)")
                {
                    MinOccurs = Once;
                    MaxOccurs = Once;
                }
                textelement(countyUSTaxAccount)
                {
                    MinOccurs = Zero;
                    MaxOccurs = Once;
                }
                textelement(stateUSTaxAccount)
                {
                    MinOccurs = Zero;
                    MaxOccurs = Once;
                }
                textelement(vatCode)
                {
                    MinOccurs = Zero;
                    MaxOccurs = Once;


                    trigger OnBeforePassVariable()
                    begin
                        vatcode := '';
                    end;


                }
                textelement(vatArea)
                {
                    MinOccurs = Zero;
                    MaxOccurs = Once;
                }
                textelement(taxTitle)
                {
                    MinOccurs = Zero;
                    MaxOccurs = Once;
                    trigger OnAfterAssignVariable()
                    begin
                        taxTitle := DelChr(taxTitle, '=', '()');
                        if TaxTitle <> '' then
                            IF ((STRPOS(TaxTitle, 'State Tax') <> 0) OR (STRPOS(TaxTitle, 'County Tax') <> 0) OR (STRPOS(TaxTitle, 'Municipal Tax') <> 0)) THEN
                                if STRPOS(TaxTitle, 'State Tax') <> 0 then begin
                                    TempDimensionBuffer.Init();
                                    TempDimensionBuffer."Table ID" := 81;
                                    TempDimensionBuffer."Entry No." := EntryNo;
                                    EntryNo := EntryNo + 1;
                                    TempDimensionBuffer."Dimension Code" := 'STATETAX';
                                    TempDimensionBuffer."Dimension Value Code" := TaxTitle;
                                    TempDimensionBuffer.Insert();
                                    StateTax := TaxTitle;
                                    journalLine."Account No." := stateUSTaxAccount;
                                end else begin
                                    if STRPOS(TaxTitle, 'County Tax') <> 0 then
                                        TaxTitle := DELSTR(TaxTitle, STRPOS(TaxTitle, 'County Tax'));
                                    if STRPOS(taxTitle, 'Municipal Tax') <> 0 then
                                        TaxTitle := DelStr(taxTitle, STRPOS(TaxTitle, ' Tax'));
                                    TempDimensionBuffer.Init();
                                    TempDimensionBuffer."Table ID" := 81;
                                    TempDimensionBuffer."Entry No." := EntryNo;
                                    EntryNo := EntryNo + 1;
                                    TempDimensionBuffer."Dimension Code" := 'STATETAX';
                                    TempDimensionBuffer."Dimension Value Code" := StateTax;
                                    TempDimensionBuffer.Insert();
                                    TempDimensionBuffer.Init();
                                    TempDimensionBuffer."Table ID" := 81;
                                    TempDimensionBuffer."Entry No." := EntryNo;
                                    EntryNo := EntryNo + 1;
                                    TempDimensionBuffer."Dimension Code" := 'COUNTYTAX';
                                    TempDimensionBuffer."Dimension Value Code" := TaxTitle;
                                    TempDimensionBuffer.Insert();
                                    journalLine."Account No." := countyUSTaxAccount;
                                    StateTax := '';
                                END;
                        taxTitle := '';
                    end;

                }
                textelement(taxPercentage)
                {
                    MinOccurs = Zero;
                    MaxOccurs = Once;
                }
                textelement(dueDate)
                {
                    MinOccurs = Zero;
                    MaxOccurs = Once;

                    // trigger OnAfterAssignVariable()
                    // var
                    //     day: integer;
                    //     month: Integer;
                    //     year: Integer;
                    // begin
                    //     evaluate(day, CopyStr(dueDate, 9, 2));
                    //     evaluate(month, CopyStr(dueDate, 6, 2));
                    //     evaluate(year, CopyStr(dueDate, 1, 4));
                    //     journalLine."Due Date" := DMY2Date(day, month, year);
                    // end;
                }
                fieldelement(paymentTerm; journalLine."Payment Terms Code")
                {
                    MinOccurs = Zero;
                    MaxOccurs = Once;

                }
                textelement(cashDiscountDate)
                {
                    MinOccurs = Zero;
                    MaxOccurs = Once;

                    // trigger OnAfterAssignVariable()
                    // var
                    //     day: integer;
                    //     month: Integer;
                    //     year: Integer;
                    // begin
                    //     evaluate(day, CopyStr(cashDiscountDate, 9, 2));
                    //     evaluate(month, CopyStr(cashDiscountDate, 6, 2));
                    //     evaluate(year, CopyStr(cashDiscountDate, 1, 4));
                    //     journalLine."Pmt. Discount Date" := DMY2Date(day, month, year);
                    // end;
                }
                textelement(cashDiscountAmount)
                {
                    MinOccurs = Zero;
                    MaxOccurs = Once;
                    trigger OnAfterAssignVariable()
                    begin
                        //Evaluate(gAmount, cashDiscountAmount);
                    end;
                }
                textelement(custGroup)
                {
                    MinOccurs = Zero;
                    MaxOccurs = Once;
                }

                textelement(dimensions)
                {
                    MinOccurs = Zero;
                    MaxOccurs = Once;


                    textelement(dimension)
                    {
                        MinOccurs = Zero;
                        MaxOccurs = Unbounded;

                        textelement(dimensionName)
                        {
                            MinOccurs = Zero;
                            MaxOccurs = Once;
                        }
                        textelement(dimensionValue)
                        {
                            MinOccurs = Zero;
                            MaxOccurs = Once;
                        }
                        trigger OnAfterAssignVariable()
                        begin
                            if (dimensionName <> '') and (dimensionValue <> '') then begin
                                gDimension.SetFilter(Code, dimensionName);
                                if not gDimension.FindSet() then begin
                                    gDimension.Init();
                                    gDimension.Code := dimensionName;
                                    gDimension.Name := dimensionName;
                                    gDimension.Insert(true);
                                end;
                                gDimensionValue.SetFilter("Dimension Code", dimensionName);
                                gDimensionValue.SetFilter(Code, dimensionValue);
                                if not gDimensionValue.FindSet() then begin
                                    gDimensionValue.Init();
                                    gDimensionValue."Dimension Code" := dimensionName;
                                    gDimensionValue.Code := dimensionValue;
                                    gDimensionValue.Insert(true);
                                end;
                                TempDimensionBuffer.Reset();
                                TempDimensionBuffer.SetFilter("Dimension Code", dimensionName);
                                TempDimensionBuffer.SetFilter("Dimension Value Code", dimensionValue);
                                TempDimensionBuffer.SetFilter("Table ID", '81');
                                if not TempDimensionBuffer.FindSet() then begin
                                    TempDimensionBuffer.Reset();
                                    TempDimensionBuffer.Init();
                                    TempDimensionBuffer."Entry No." := EntryNo;
                                    EntryNo := EntryNo + 1;
                                    TempDimensionBuffer."Table ID" := 81;
                                    TempDimensionBuffer."Dimension Code" := dimensionName;
                                    TempDimensionBuffer."Dimension Value Code" := dimensionValue;
                                    TempDimensionBuffer.Insert();
                                end;
                            end;
                        end;

                    }


                }
                trigger OnBeforeInsertRecord()
                begin

                    journalLine.Validate("Posting Date");

                    if journalLine."Currency Code" <> currency then begin
                        journalLine."Currency Code" := currency;
                        journalLine.Validate("Currency Code");
                    end;
                    // Findes der en bankkonto
                    if (entryType = 'payment_offset') and (postType = 'ledger') then begiN
                        // Rettet så version 14 og 15 er det samme vha. FieldRef
                        MyRecordRef.Open(Database::"Bank Account Posting Group");
                        if MyRecordRef.FieldExist(3) then
                            MyFieldRef := MyRecordRef.Field(3)
                        else
                            MyFieldRef := MyRecordRef.Field(2);

                        MyFieldRef.SetFilter(journalLine."Account No.");
                        If MyRecordRef.FindSet() THEN begin
                            BankAccount.SetFilter("Bank Acc. Posting Group", MyRecordRef.field(1).Value);
                            BankAccount.SetFilter("Currency Code", journalLine."Currency Code");
                            if BankAccount.FindFirst() then begin
                                journalLine."Account Type" := journalLine."Account Type"::"Bank Account";
                                journalLine."Account No." := BankAccount."No.";
                                journalLine.validate("Account No.");
                            end;
                        end;
                        // PostingGroup.SetFilter("G/L Account No.", journalLine."Account No.");
                        // if PostingGroup.FindFirst() then begin
                        //     BankAccount.SetFilter("Bank Acc. Posting Group", PostingGroup.Code);
                        //     BankAccount.SetFilter("Currency Code", journalLine."Currency Code");
                        //     if BankAccount.FindFirst() then begin
                        //         journalLine."Account Type" := journalLine."Account Type"::"Bank Account";
                        //         journalLine."Account No." := BankAccount."No.";
                        //         journalLine.validate("Account No.");
                        //     end;

                        // end;
                    end;

                    genJournalLine.Reset();
                    genJournalLine.SetCurrentKey(genJournalLine."Journal Template Name", genJournalLine."Journal Batch Name", genJournalLine."Line No.");
                    genJournalLine.SetFilter("Journal Batch Name", batchName);
                    genJournalLine.SetFilter("Journal Template Name", templateName);
                    if genJournalLine.FindLast() then
                        JournalLine."Line No." := genJournalLine."Line No." + 102
                    else
                        JournalLine."Line No." := 20000;
                end;

                trigger OnAfterInsertRecord()
                var

                begin
                    // Set postingsgrupper
                    journalLine."Gen. Bus. Posting Group" := '';
                    journalLine."Gen. Prod. Posting Group" := '';
                    journalLine."Gen. Posting Type" := journalLine."Gen. Posting Type"::" ";
                    journalLine."VAT Prod. Posting Group" := '';
                    journalLine."VAT Bus. Posting Group" := '';
                    if vatCode <> '' then begin
                        journalLine."VAT Bus. Posting Group" := vatCode;
                        journalLine."VAT Prod. Posting Group" := 'SPY';
                        journalLine."Gen. Bus. Posting Group" := vatCode;
                        journalLine."Gen. Prod. Posting Group" := 'SPY';
                        if (PostingType = 'Sale') then
                            journalLine."Gen. Posting Type" := journalLine."Gen. Posting Type"::Sale;
                        if PostingType = 'Purchase' then
                            journalLine."Gen. Posting Type" := journalLine."Gen. Posting Type"::Purchase;
                    end;
                    journalLine.Validate("VAT Prod. Posting Group");
                    //Set DueDate
                    if dueDate <> '' then begin
                        evaluate(day, CopyStr(dueDate, 9, 2));
                        evaluate(month, CopyStr(dueDate, 6, 2));
                        evaluate(year, CopyStr(dueDate, 1, 4));
                        journalLine."Due Date" := DMY2Date(day, month, year);
                    end;
                    //Set Cash Discount Date
                    if cashDiscountDate <> '' then begin
                        evaluate(day, CopyStr(cashDiscountDate, 9, 2));
                        evaluate(month, CopyStr(cashDiscountDate, 6, 2));
                        evaluate(year, CopyStr(cashDiscountDate, 1, 4));
                        journalLine."Pmt. Discount Date" := DMY2Date(day, month, year);
                    end;
                    // Set dimensionsId
                    JournalLine."Dimension Set ID" := DimensionManagement.CreateDimSetIDFromDimBuf(TempDimensionBuffer);
                    TempDimensionBuffer.DeleteAll();
                    EntryNo := 1;
                    journalLine.Modify();
                    // Set Sales/Purch without VAT
                    if (journalLine."Account Type" = journalLine."Account Type"::Customer) or
                        (journalLine."Account Type" = journalLine."Account Type"::Vendor) then begin
                        genJournalLine.Reset();
                        genJournalLine.SETRANGE(genJournalLine."Journal Template Name", templateName);
                        genJournalLine.SETRANGE("Journal Batch Name", batchName);
                        genJournalLine.SETFILTER("Document No.", journalLine."Document No.");
                        if genJournalLine.FindSet() then begin
                            UdenMoms := journalLine."Amount (LCY)";
                            repeat
                                UdenMoms := UdenMoms + genJournalLine."VAT Amount (LCY)";
                            until genJournalLine.Next() = 0;
                        end;
                        journalLine."Sales/Purch. (LCY)" := UdenMoms;
                        journalLine.Modify();
                    end;
                    // Kopier debitor dimensioner ud på alle poster i transaktion
                    if (journalLine."Account Type" = journalLine."Account Type"::Customer) then begin
                        gDefaultDimension.Setfilter("Table ID", '18');
                        gCustomer.Reset();
                        gCustomer.SetFilter("No.", deliveryAccount);

                        if (deliveryAccount <> '') AND gCustomer.FindFirst() then
                            gDefaultDimension.SetFilter("No.", deliveryAccount)
                        else
                            gDefaultDimension.SetFilter("No.", journalLine."Account No.");
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

                            genJournalLine.Reset();
                            genJournalLine.SETRANGE(genJournalLine."Journal Template Name", templateName);
                            genJournalLine.SETRANGE("Journal Batch Name", batchName);
                            genJournalLine.SETFILTER("Document No.", journalLine."Document No.");
                            if genJournalLine.FindSet() then begin
                                EntryNo := 1;
                                repeat
                                    DimensionSetEntry.Reset();
                                    DimensionSetEntry.SetFilter("Dimension Set ID", FORMAT(genJournalLine."Dimension Set ID"));
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
                                    genJournalLine."Dimension Set ID" := DimensionManagement.CreateDimSetIDFromDimBuf(TempDimensionBuffer);
                                    genJournalLine.Modify();
                                    TempDimensionBuffer.DeleteAll();
                                until genJournalLine.Next() = 0;
                                TempDimensionBuffer3.DeleteAll();
                            end;
                        end;
                    end;
                    // Set global dimensioner
                    genJournalLine.Reset();
                    genJournalLine.SETRANGE(genJournalLine."Journal Template Name", templateName);
                    genJournalLine.SETRANGE("Journal Batch Name", batchName);
                    genJournalLine.SETFILTER("Document No.", journalLine."Document No.");
                    if genJournalLine.FindSet() then
                        repeat
                            DimensionManagement.UpdateGlobalDimFromDimSetID(genJournalLine."Dimension Set ID", genJournalLine."Shortcut Dimension 1 Code", genJournalLine."Shortcut Dimension 2 Code");
                            genJournalLine.Modify();
                        until genJournalLine.Next() = 0;

                end;
            }
        }
    }

    trigger OnPostXmlPort()
    var

    begin
    end;

    trigger OnPreXmlPort()
    var

    begin
        EntryNo := 1;
        journalLine.LockTable(true);
        // if GL.FindSet() then begin
        //     GlobalDim1 := GL."Global Dimension 1 Code";
        //     GlobalDim2 := GL."Global Dimension 2 Code";
        // end;
    end;


    var
        TempDimensionBuffer: Record "Dimension Buffer" temporary;
        TempDimensionBuffer2: Record "Dimension Buffer" temporary;
        TempDimensionBuffer3: Record "Dimension Buffer" temporary;
        DimensionSetEntry: Record "Dimension Set Entry";
        gDimensionValue: Record "Dimension Value";
        gDimension: Record Dimension;
        gCustomer: record Customer;
        gDefaultDimension: record "Default Dimension";
        BankAccount: record "Bank Account";
        genJournalLine: Record "Gen. Journal Line";
        genJournalBatch: Record "Gen. Journal Batch";
        DimensionManagement: Codeunit DimensionManagement;
        MyRecordRef: RecordRef;
        MyFieldRef: FieldRef;
        //gAmount: Decimal;
        templateName: code[20];
        batchName: code[20];
        UdenMoms: Decimal;
        StateTax: Text[20];
        PostingType: text;
        day: integer;
        month: Integer;
        year: Integer;
        EntryNo: Integer;

}