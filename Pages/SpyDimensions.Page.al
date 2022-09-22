page 73006 "Spy Dimensions"
{
    ApplicationArea = All;
    Caption = 'Spy Dimensions';
    AdditionalSearchTerms = 'spy,spy dim';
    PageType = List;
    SourceTable = "Spy Dimensions";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Entry No.';
                }
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                    ToolTip = 'Code';
                }
                field("Dimension Name"; Rec."Dimension Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Dimension Name';

                }
                field("Dimension Value Code"; Rec."Dimension Value Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Dimension Value Code';

                }
            }
        }
    }
}
