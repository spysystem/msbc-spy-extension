page 73001 "Spy Setup"
{
    Caption = 'SPY Setup';
    ApplicationArea = All;
    AdditionalSearchTerms = 'spy,spy set';
    PageType = Card;
    SourceTable = "Spy Setup";
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Default Journal Temp Name"; Rec."Default Journal Template Name") //Used when Gen Journal Batch does not exist.
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Default Journal Temp Name field.';
                }

                field("Default Journal Description"; Rec."Default Journal Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Default Journal Description';
                }

                field("VAT Prod. Posting Group"; Rec."VAT Prod. Posting Group") //Used in GenJrnLine
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the VAT Prod. Posting Group field.';
                }

            }
        }
    }
}
