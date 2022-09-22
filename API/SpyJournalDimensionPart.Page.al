/// <summary>
/// Page SpyCreateJournalDimensionsAPI (ID 73003).
/// </summary>
page 73003 SpyJournalDimensionPart
{

    Caption = 'spyDimensions';
    PageType = ListPart;
    SourceTable = "Spy Dimensions";
    DelayedInsert = true;
    AutoSplitKey = true;
    ODataKeyFields = SystemId;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(systemId; Rec.SystemId) { Caption = 'systemId'; ToolTip = ' '; }
                field(dimensionName; Rec."Dimension Name") { Caption = 'dimensionName'; ToolTip = ' '; }
                field(dimensionValue; Rec."Dimension Value Code")
                {
                    Caption = 'dimensionValue';
                    ToolTip = ' ';
                    trigger OnValidate()
                    begin
                        ValidateDimension(CopyStr(Rec."Dimension Name", 1, 20), Rec."Dimension Value Code");
                    end;
                }
            }
        }
    }
    var
        DimensionSetEntry: Record "Dimension Set Entry";
        TempDimensionBuffer: Record "Dimension Buffer" temporary;

        gDimensionValue: Record "Dimension Value";
        gDimension: Record Dimension;
        gCustomer: record Customer;
        gDefaultDimension: record "Default Dimension";
        EntryNo: Integer;


    procedure ValidateDimension(pDimensionName: Code[20]; pdimensionValueCode: Code[20])
    var
    begin
        if (pDimensionName <> '') and (pdimensionValueCode <> '') then begin
            gDimension.SetFilter(Code, pDimensionName);
            if not gDimension.FindSet() then begin
                gDimension.Init();
                gDimension.Code := pDimensionName;
                gDimension.Name := pDimensionName;
                gDimension.Insert(true);
            end;
            gDimensionValue.SetFilter("Dimension Code", pDimensionName);
            gDimensionValue.SetFilter(Code, pdimensionValueCode);
            if not gDimensionValue.FindSet() then begin
                gDimensionValue.Init();
                gDimensionValue."Dimension Code" := pDimensionName;
                gDimensionValue.Code := pdimensionValueCode;
                gDimensionValue.Insert(true);
            end;
            TempDimensionBuffer.Reset();
            TempDimensionBuffer.SetFilter("Dimension Code", pDimensionName);
            TempDimensionBuffer.SetFilter("Dimension Value Code", pdimensionValueCode);
            TempDimensionBuffer.SetFilter("Table ID", '81');
            if not TempDimensionBuffer.FindSet() then begin
                TempDimensionBuffer.Reset();
                TempDimensionBuffer.Init();
                TempDimensionBuffer."Entry No." := EntryNo;
                EntryNo := EntryNo + 1;
                TempDimensionBuffer."Table ID" := 81;
                TempDimensionBuffer."Dimension Code" := pDimensionName;
                TempDimensionBuffer."Dimension Value Code" := pdimensionValueCode;
                TempDimensionBuffer.Insert();
            end;
        end;
    end;


}