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
                    ShowMandatory = true;
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
                    ShowMandatory = true;
                }

                field("Database Lock Filter"; Rec."Database Lock Filter")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifes which filter is used to look for databaselocks';
                    ShowMandatory = true;

                }
                field("Database Lock Sleep duration"; Rec."Database Lock Sleep duration")
                {
                    ApplicationArea = All;

                    ToolTip = 'Specfies how long time there should be between each databaselock lookup in ms. This is paired with the Fail Over Count.';
                    ShowMandatory = true;
                }
                field("Fail Over Count"; Rec."Fail Over Count")
                {
                    ApplicationArea = All;

                    ToolTip = 'Specifies how many times to look for the databaselock';
                    ShowMandatory = true;
                }

            }
        }
    }
}
