pageextension 73088 "Spy Customer Card" extends "Customer Card"
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

}