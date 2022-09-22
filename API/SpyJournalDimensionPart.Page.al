/// <summary>
/// Page SpyCreateJournalDimensionsAPI (ID 73003).
/// </summary>
page 73003 SpyJournalDimensionPart
{

    Caption = 'spyDimensions';
    PageType = ListPart;
    SourceTable = "Spy Dimensions";
    DelayedInsert = true;
    //AutoSplitKey = true;
    PopulateAllFields = true;
    ODataKeyFields = SystemId;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(id; Format(Rec.SystemId, 0, 4).ToLower())
                {
                    Caption = 'SystemID', Locked = true;
                    ToolTip = ' ';
                }
                field(entryNo; Rec."Entry No.")
                {
                    Caption = 'EntryNo';
                    ToolTip = ' ';
                }
                field(spyJournalSystemId; Rec."Spy Journal System Id")
                {
                    Caption = 'spyJournalSystemId';
                    ToolTip = ' ';
                }

                field(dimensionName; Rec."Dimension Name")
                {
                    Caption = 'dimensionName';
                    ToolTip = ' ';
                }
                field(dimensionValue; Rec."Dimension Value Code")
                {
                    Caption = 'dimensionValue';
                    ToolTip = ' ';
                    trigger OnValidate()
                    begin
                        //ValidateDimension(CopyStr(Rec."Dimension Name", 1, 20), Rec."Dimension Value Code");
                    end;
                }
            }
        }
    }

    var
        IsDeepInsert: Boolean;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    var
    //SpyJournalLine: Record "Spy Create Journal Line";
    //SpyDimensionLine: Record "Spy Dimensions";
    begin
        // if IsDeepInsert then begin
        //     SpyJournalLine.GetBySystemId(Rec."Spy Journal System Id");
        //     Rec."Spy Journal System Id" := SpyJournalLine.SystemId;
        //     Rec."Entry No." := SpyJournalLine."Entry No.";
        //     Rec."Journal Batch Name" := SpyJournalLine."Journal Batch Name";
        //     Rec."Journal Template Name" := SpyJournalLine."Journal Template Name";

        //     SpyDimensionLine.SetRange("Entry No.", Rec."Entry No.");
        //     if SpyDimensionLine.FindLast() then
        //         Rec."Line No." := SpyDimensionLine."Line No." + 1
        //     else
        //         Rec."Line No." := 1;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    var
        SpyCreateJournalLine: Record "Spy Create Journal Line";
        SpyDimensionsRec: Record "Spy Dimensions";
    begin
        SpyCreateJournalLine.SetRange(SystemId, Rec."Spy Journal System Id");
        if SpyCreateJournalLine.FindFirst() then begin
            Rec."Entry No." := SpyCreateJournalLine."Entry No.";
            if SpyDimensionsRec.FindLast() then
                Rec."Line No." := SpyDimensionsRec."Line No." + 1
            else
                Rec."Line No." := 1;
            Rec."Journal Template Name" := SpyCreateJournalLine."Journal Template Name";
            Rec."Journal Batch Name" := SpyCreateJournalLine."Journal Batch Name";
        end;
        //IsDeepInsert := IsNullGuid(Rec."Spy Journal System Id");
        //if not IsDeepInsert then begin
        //   SpyCreateJournalLine.GetBySystemId(Rec."Spy Journal System Id");
        //  Rec."Entry No." := Rec."Entry No.";
    end;



}