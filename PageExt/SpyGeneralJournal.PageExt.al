pageextension 73001 "SPY General Journal" extends "General Journal"
{
    actions
    {
        addafter("A&ccount")
        {
            action(AttemptDimUpdate)
            {
                ApplicationArea = All;
                Caption = 'Spy - Update Dimensions', comment = 'DAN="Spy - Update Dimensions"';
                Promoted = true;
                ToolTip = 'Spy - Update Dimensions', comment = 'DAN="Spy - Update Dimensions"';
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = UpdateDescription;

                trigger OnAction()
                var
                begin
                    Rec.SetFilter("Document No.", Rec."Document No.");
                    if Rec.FindSet() then
                        repeat
                            if newUpdateDimensionsSets() then
                                UpdateGlobalDimensions();
                        until Rec.Next() = 0;
                end;

            }
        }
    }

    /// <summary>
    /// CopyCustomerDimensions.
    /// </summary>
    /// <returns>Return value of type Boolean.</returns>
    procedure CopyCustomerDimensions(): Boolean
    begin
        if (Rec."Account Type" = Rec."Account Type"::Customer) then begin
            gDefaultDimension.Setfilter("Table ID", '18');
            gDefaultDimension.SetFilter("No.", Rec."Account No.");
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

                GenJournalLine.Reset();
                GenJournalLine.SETRANGE("Journal Template Name", Rec."Journal Template Name");
                GenJournalLine.SETRANGE("Journal Batch Name", Rec."Journal Batch Name");
                GenJournalLine.SETFILTER("Document No.", Rec."Document No.");
                if GenJournalLine.FindSet() then begin
                    gDimEntryNo := 1;
                    repeat
                        DimensionSetEntry.Reset();
                        DimensionSetEntry.SetFilter("Dimension Set ID", FORMAT(GenJournalLine."Dimension Set ID"));
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
                                //TempDimensionBuffer2.SetFilter("Table ID", '%1', 81);
                                //TempDimensionBuffer2.SetFilter("Entry No.", '%1', TempDimensionBuffer3."Entry No.");
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
                        GenJournalLine."Dimension Set ID" := DimensionManagement.CreateDimSetIDFromDimBuf(TempDimensionBuffer);
                        GenJournalLine.Modify();
                        TempDimensionBuffer.DeleteAll();
                    until GenJournalLine.Next() = 0;
                    TempDimensionBuffer3.DeleteAll();
                    exit(true);
                end;
            end;
        end;
    end;

    /// <summary>
    /// UpdateGlobalDimensions.
    /// </summary>
    /// <returns>Return value of type Boolean.</returns>
    procedure UpdateGlobalDimensions(): Boolean
    var
    begin
        //This i called from SpyDimensions table
        GenJournalLine.Reset();
        GenJournalLine.SETRANGE("Journal Template Name", Rec."Journal Template Name");
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

    procedure newUpdateDimensionsSets(): Boolean
    var
    begin

        if rec."Account Type" <> rec."Account Type"::Customer then exit;
        // Delete NewDimensionSetEntry (Temporary)
        CustomerDimensionSetEntry.DeleteAll();
        GenJournalLine := Rec;

        // Find Dimension from Existing GL Customer line
        DimensionSetEntry.Reset();
        DimensionSetEntry.SETRANGE("Dimension Set ID", GenJournalLine."Dimension Set ID");
        if DimensionSetEntry.FindSet() then
            repeat
                // Insert Existing Dimensions
                CustomerDimensionSetEntry.Init();
                CustomerDimensionSetEntry."Dimension Set ID" := 0;
                CustomerDimensionSetEntry.VALIDATE("Dimension Code", DimensionSetEntry."Dimension Code");
                CustomerDimensionSetEntry.VALIDATE("Dimension Value Code", DimensionSetEntry."Dimension Value Code");
                CustomerDimensionSetEntry.INSERT(TRUE);
            until DimensionSetEntry.Next() = 0;

        // Find GL Account Dimensions
        GenJournalLine2.Reset();
        GenJournalLine2.SETRANGE("Journal Template Name", GenJournalLine."Journal Template Name");
        GenJournalLine2.SETRANGE("Journal Batch Name", GenJournalLine."Journal Batch Name");
        GenJournalLine2.SETFILTER("Document No.", GenJournalLine."Document No.");
        if GenJournalLine2.FindSet() then
            repeat
                if GenJournalLine2."Line No." <> GenJournalLine."Line No." then begin
                    GLAccountDimensionSetEntry2.DeleteAll();
                    DimensionSetEntry.Reset();
                    DimensionSetEntry.SETRANGE("Dimension Set ID", GenJournalLine2."Dimension Set ID");
                    IF DimensionSetEntry.FindFirst() THEN
                        REPEAT
                            // Insert Existing Dimensions
                            GLAccountDimensionSetEntry2.Init();
                            GLAccountDimensionSetEntry2."Dimension Set ID" := 0;
                            GLAccountDimensionSetEntry2.VALIDATE("Dimension Code", DimensionSetEntry."Dimension Code");
                            GLAccountDimensionSetEntry2.VALIDATE("Dimension Value Code", DimensionSetEntry."Dimension Value Code");
                            GLAccountDimensionSetEntry2.Insert();
                        UNTIL DimensionSetEntry.Next() = 0;

                    if CustomerDimensionSetEntry.FindFirst() then
                        repeat
                            GLAccountDimensionSetEntry2 := CustomerDimensionSetEntry;
                            if not GLAccountDimensionSetEntry2.Insert() then;
                        until CustomerDimensionSetEntry.Next() = 0;

                    GenJournalLine2."Dimension Set ID" := GLAccountDimensionSetEntry2.GetDimensionSetID(GLAccountDimensionSetEntry2);
                    GenJournalLine2.Modify();
                end;
            until GenJournalLine2.Next() = 0;
        exit(true);
    end;

    var

        GenJournalLine: Record "Gen. Journal Line";
        GenJournalLine2: Record "Gen. Journal Line";
        gCustomer: record Customer;
        DimensionSetEntry: Record "Dimension Set Entry";
        CustomerDimensionSetEntry: Record "Dimension Set Entry" temporary;
        GLAccountDimensionSetEntry2: Record "Dimension Set Entry" temporary;

        TempDimensionBuffer: Record "Dimension Buffer" temporary;
        TempDimensionBuffer2: Record "Dimension Buffer" temporary;
        TempDimensionBuffer3: Record "Dimension Buffer" temporary;
        gDefaultDimension: record "Default Dimension";
        DimensionManagement: Codeunit DimensionManagement;
        gDimEntryNo: Integer;


}
