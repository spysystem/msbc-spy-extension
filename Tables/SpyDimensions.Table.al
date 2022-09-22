table 73002 "Spy Dimensions"
{
    DataClassification = ToBeClassified;
    fields
    {

        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            TableRelation = "Spy Create Journal Line"."Entry No.";
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

        field(30; "Journal Batch Name"; Code[10])
        {
            Caption = 'Journal Batch Name';
            DataClassification = CustomerContent;
            ValidateTableRelation = false;
            TableRelation = "Gen. Journal Batch".Name WHERE("Journal Template Name" = FIELD("Journal Template Name"));
        }

        field(12; "Spy Journal System Id"; Guid)
        {
            TableRelation = "Spy Create Journal Line".SystemId;
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
    procedure HandleDimensions()
    var
    begin
        if ("Dimension Name" <> '') and ("Dimension Value Code" <> '') then begin
            DimensionRecord.SetFilter(Code, "Dimension Name");
            if not DimensionRecord.FindSet() then begin
                DimensionRecord.Init();
                DimensionRecord.Code := CopyStr(Rec."Dimension Name", 1, MaxStrLen(DimensionRecord.Code));
                DimensionRecord.Name := Rec."Dimension Name";
                DimensionRecord.Insert(true);
            end;

            DimensionValueRecord.SetFilter("Dimension Code", "Dimension Name");
            DimensionValueRecord.SetFilter(Code, "Dimension Value Code");
            if not DimensionValueRecord.FindSet() then begin
                DimensionValueRecord.Init();
                DimensionValueRecord."Dimension Code" := CopyStr("Dimension Name", 1, MaxStrLen(DimensionValueRecord."Dimension Code"));
                DimensionValueRecord.Code := "Dimension Value Code";
                DimensionValueRecord.Insert(true);
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
                DimensionBuffer.Insert();
            end;
        end;
    end;

    var

        DimensionValueRecord: Record "Dimension Value";
        DimensionRecord: Record Dimension;
        DimensionBuffer: Record "Dimension Buffer";
        EntryNo: Integer;

}