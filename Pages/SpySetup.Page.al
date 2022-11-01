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
                    TableRelation = "Gen. Journal Template";
                }
                field("Default Journal Batch Name"; Rec."Default Journal Batch Name") //Used when Gen Journal Batch does not exist.
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Default Journal Batch Name.';
                    TableRelation = "Gen. Journal Batch";

                }

                field("VAT Prod. Posting Group"; Rec."VAT Prod. Posting Group") //Used in GenJrnLine
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the VAT Prod. Posting Group field.';
                    TableRelation = "VAT Product Posting Group";
                }
                field("Template Type"; Rec."Default Template Type") ///Used when Gen Journal Batch does not exist
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Template Type field.';
                }

            }
        }
    }
}
