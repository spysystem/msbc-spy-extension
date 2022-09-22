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
                field("Default Journal Temp Name"; Rec."Default Journal Temp Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Default Journal Temp Name field.';
                    TableRelation = "Gen. Journal Template";
                }
                field("Default Journal Batch Name"; Rec."Default Journal Batch Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Default Journal Batch Name.';
                    TableRelation = "Gen. Journal Batch";

                }
                field("Gen. Bus. Posting Group"; Rec."Gen. Bus. Posting Group")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Gen. Bus. Posting Group field.';
                    TableRelation = "Gen. Business Posting Group";
                }
                field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Gen. Prod. Posting Group field.';
                    TableRelation = "Gen. Product Posting Group";
                }
                field("VAT Bus. Posting Group"; Rec."VAT Bus. Posting Group")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the VAT Bus. Posting Group field.';
                    TableRelation = "VAT Business Posting Group";
                }
                field("VAT Prod. Posting Group"; Rec."VAT Prod. Posting Group")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the VAT Prod. Posting Group field.';
                    TableRelation = "VAT Product Posting Group";
                }
                field("Template Type"; Rec."Default Template Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Template Type field.';
                }

            }
        }
    }
}
