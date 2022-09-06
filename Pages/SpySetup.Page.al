page 73001 "Spy Setup"
{
    Caption = 'SPY Setup';
    PageType = Card;
    SourceTable = "Spy Setup";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Default Journal Temp Name"; Rec."Default Journal Temp Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Default Journal Temp Name field.';
                }
                field("Gen. Bus. Posting Group"; Rec."Gen. Bus. Posting Group")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Gen. Bus. Posting Group field.';
                }
                field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Gen. Prod. Posting Group field.';
                }
                field("VAT Bus. Posting Group"; Rec."VAT Bus. Posting Group")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the VAT Bus. Posting Group field.';
                }
                field("VAT Prod. Posting Group"; Rec."VAT Prod. Posting Group")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the VAT Prod. Posting Group field.';
                }
                field("Template Type"; Rec."Template Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Template Type field.';
                }
            }
        }
    }
}
