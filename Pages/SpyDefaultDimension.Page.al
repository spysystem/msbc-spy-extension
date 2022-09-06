page 73091 "Spy Default Dimension"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Default Dimension";

    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                field("Table ID"; Rec."Table ID")
                {
                    ApplicationArea = All;
                    ToolTip = ' ';
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = ' ';
                }
                field("Dimension Code"; Rec."Dimension Code")
                {
                    ApplicationArea = All;
                    ToolTip = ' ';
                }
                field("Dimension Value Code"; Rec."Dimension Value Code")
                {
                    ApplicationArea = All;
                    ToolTip = ' ';
                }
                field("Value Posting"; Rec."Value Posting")
                {
                    ApplicationArea = All;
                    ToolTip = ' ';
                }

            }
        }
    }

}