pageextension 73087 "Spy Customer Template" extends "Customer Templ. Card"
{
    layout
    {
        addafter(General)
        {
            field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
            {
                ApplicationArea = All;
                ToolTip = ' ';
            }
            field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
            {
                ApplicationArea = All;
                ToolTip = ' ';
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var

}