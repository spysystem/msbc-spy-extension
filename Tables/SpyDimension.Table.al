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

        field(8; "Spy Jnl Line Description"; Text[100])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;

        }

        field(37; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = CustomerContent;
        }

        field(38; "External Document No."; Code[35])
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
    /// <param name="pSpyJournalLine">VAR Record "Spy Create Journal Line".</param>
    /// <returns>Return variable DimensionsAdded of type Boolean.</returns>
    procedure HandleDimensions(var pSpyJournalLine: Record "Spy Journal Line"): Boolean
    var
    //SpyDimCreateErr: label '[SypDimensionCreationErr] Failed to Insert SpyDimenison %1', comment = '%1 = create dimension';
    //SpyDimValueCreateErr: label '[SypDimensioValueCreationErr] Failed to Insert SpyDimenison %1', comment = '%1 =  create dimension';
    //SpyDimBufferCreateErr: label '[SypDimensioBufferCreationErr] Failed to Insert SpyDimenison %1', comment = '%1 =  create dimension';
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
            TempDimensionBuffer.Reset();
            TempDimensionBuffer.SetFilter("Dimension Code", "Dimension Name");
            TempDimensionBuffer.SetFilter("Dimension Value Code", "Dimension Value Code");
            TempDimensionBuffer.SetFilter("Table ID", '81');
            if not TempDimensionBuffer.FindSet() then begin
                TempDimensionBuffer.Reset();
                TempDimensionBuffer.Init();
                TempDimensionBuffer."Entry No." := EntryNo;
                EntryNo := EntryNo + 1;
                TempDimensionBuffer."Table ID" := 81;
                TempDimensionBuffer."Dimension Code" := CopyStr("Dimension Name", 1, MaxStrLen(TempDimensionBuffer."Dimension Code"));
                TempDimensionBuffer."Dimension Value Code" := "Dimension Value Code";
                TempDimensionBuffer.Insert();

            end;
        end;
        exit(true);
    end;

    /// <summary>
    /// ErrorFoundInErrorTextList.
    /// </summary>
    /// <param name="ErrorTextToFind">Text.</param>
    /// <param name="GlobalErrorTextList">VAR List of [Text].</param>
    /// <returns>Return value of type Boolean.</returns>
    procedure ErrorFoundInErrorTextList(ErrorTextToFind: Text; var GlobalErrorTextList: List of [Text]): Boolean
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
        DimensionValueRecord: Record "Dimension Value";
        DimensionRecord: Record Dimension;
        TempDimensionBuffer: Record "Dimension Buffer" temporary;
        EntryNo: Integer;

}