page 73006 "Spy Dimensions"
{
    ApplicationArea = All;
    Caption = 'Spy Dimensions';
    AdditionalSearchTerms = 'spy,sypd,spy dim';
    PageType = List;
    SourceTable = "Spy Dimension";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {

                field(id; Format(Rec.SystemId, 0, 4).ToLower())
                {
                    caption = 'id';
                    ApplicationArea = All;
                    ToolTip = 'SystemId';
                    Visible = false;

                }
                field("Spy Journal System Id"; Rec."Spy Journal System Id")
                {
                    caption = 'Spy Journal System Id';
                    ApplicationArea = All;
                    ToolTip = 'SystemId';
                    Visible = false;
                }

                field("Journal Template Name"; Rec."Journal Template Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Dimension Name';
                }
                field(lineNo; Rec."Line No.")
                {
                    ApplicationArea = All;
                    Caption = 'Line No.';
                    ToolTip = 'Line No.';

                }

                field("Spy Jnl Line Description"; Rec."Spy Jnl Line Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Spy Jnl Line Description.';
                }

                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Document No.';
                }
                field("external Document No."; Rec."External Document No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'External Document No.';
                }

                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Entry No.';
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
