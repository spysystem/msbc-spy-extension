pageextension 73081 "Spy Led Jour Batch" extends "General Journal Batches"
{
    layout
    {
        addlast(Content)
        {
            field("Journal Template Name"; Rec."Journal Template Name")
            {
                Caption = 'Journal Template Name';
                ToolTip = 'Journal Template Name ';
                ApplicationArea = All;

            }
            field("Template Type"; Rec."Template Type")
            {
                Caption = 'Template Type';
                ToolTip = 'Template Type ';
                ApplicationArea = All;
            }
        }

    }
}