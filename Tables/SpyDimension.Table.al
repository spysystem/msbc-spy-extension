/// <summary>
/// Table Spy Dimensions (ID 73002).
/// </summary>
table 73002 "Spy Dimension"
{
    Caption = 'Spy Dimension', comment = 'DAN="Spy Dimension"';
    DataClassification = ToBeClassified;
    fields
    {

        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            TableRelation = "Spy Journal Line"."Entry No.";
        }
        field(10; "Journal Template Name"; Code[10])
        {
            Caption = 'Journal Template Name';
            ValidateTableRelation = false;
            TableRelation = "Gen. Journal Template";
            DataClassification = CustomerContent;
        }

        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }

        field(37; "External Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = CustomerContent;
        }

        field(30; "Journal Batch Name"; Code[10])
        {
            Caption = 'Journal Batch Name';
            DataClassification = CustomerContent;
            ValidateTableRelation = false;
            TableRelation = "Gen. Journal Batch".Name WHERE("Journal Template Name" = FIELD("Journal Template Name"));
        }

        field(12; "Spy Journal System Id"; Guid)
        {
            TableRelation = "Spy Journal Line".SystemId;
        }

        field(14; "Dimension Value Code"; Code[20])
        {
            Caption = 'Dimension Value Code';
            Description = 'Dimension Value Code';

        }

        field(15; "Dimension Name"; Text[30])
        {
            Caption = 'Dimension Name';
        }
    }
    keys
    {
        key(Key1; "Entry No.", "Line No.")
        {
            Clustered = true;
        }
    }
    /// <summary>
    /// HandleDimensions.
    /// </summary>
    /// <param name="SpyJournalLine">VAR Record "Spy Create Journal Line".</param>
    /// <returns>Return variable DimensionsAdded of type Boolean.</returns>
    procedure HandleDimensions(var SpyJournalLine: Record "Spy Journal Line"): Boolean
    var
        SpyDimCreateErr: Label '[SypDimensionCreationErr] Failed to Insert SpyDimenison %1', comment = '%1 = postType';
        SpyDimValueCreateErr: Label '[SypDimensioValueCreationErr] Failed to Insert SpyDimenison %1', comment = '%1 = postType';
        SpyDimBufferCreateErr: Label '[SypDimensioBufferCreationErr] Failed to Insert SpyDimenison %1', comment = '%1 = postType';
    begin
        if ("Dimension Name" <> '') and ("Dimension Value Code" <> '') then begin
            DimensionRecord.SetFilter(Code, "Dimension Name");
            if not DimensionRecord.FindSet() then begin
                DimensionRecord.Init();
                DimensionRecord.Code := CopyStr(Rec."Dimension Name", 1, MaxStrLen(DimensionRecord.Code));
                DimensionRecord.Name := Rec."Dimension Name";
                if not DimensionRecord.Insert(true) THEN
                    ErrorList.Add(StrSubstNo(SpyDimCreateErr, Rec."External Document No." + ' ' + Format(Rec."Dimension Name")));
            end;

            DimensionValueRecord.SetFilter("Dimension Code", "Dimension Name");
            DimensionValueRecord.SetFilter(Code, "Dimension Value Code");
            if not DimensionValueRecord.FindSet() then begin
                DimensionValueRecord.Init();
                DimensionValueRecord."Dimension Code" := CopyStr("Dimension Name", 1, MaxStrLen(DimensionValueRecord."Dimension Code"));
                DimensionValueRecord.Code := "Dimension Value Code";
                if not DimensionValueRecord.Insert(true) then
                    ErrorList.Add(StrSubstNo(SpyDimValueCreateErr, Rec."External Document No." + ' ' + Format(Rec."Dimension Name")));

            end;
            DimensionBuffer.Reset();
            DimensionBuffer.SetFilter("Dimension Code", "Dimension Name");
            DimensionBuffer.SetFilter("Dimension Value Code", "Dimension Value Code");
            DimensionBuffer.SetFilter("Table ID", '81');
            if not DimensionBuffer.FindSet() then begin
                DimensionBuffer.Reset();
                DimensionBuffer.Init();
                DimensionBuffer."Entry No." := EntryNo;
                EntryNo := EntryNo + 1;
                DimensionBuffer."Table ID" := 81;
                DimensionBuffer."Dimension Code" := CopyStr("Dimension Name", 1, MaxStrLen(DimensionBuffer."Dimension Code"));
                DimensionBuffer."Dimension Value Code" := "Dimension Value Code";
                if not DimensionBuffer.Insert() then
                    ErrorList.Add(StrSubstNo(SpyDimBufferCreateErr, Rec."External Document No." + ' ' + Format(Rec."Dimension Name")));

            end;
        end;
        if ErrorList.Contains(SpyDimCreateErr) or ErrorList.Contains(SpyDimValueCreateErr) or ErrorList.Contains(SpyDimBufferCreateErr) then begin
            SpyError.AddError(SpyJournalLine, ErrorList);
            Exit(false);
        end else
            Exit(true);
    end;

    var
        DimensionValueRecord: Record "Dimension Value";
        DimensionRecord: Record Dimension;
        DimensionBuffer: Record "Dimension Buffer";
        SpyError: Record "Spy Error";
        ErrorList: List of [Text];
        EntryNo: Integer;

}