page 73082 "SpyListJournalBatches"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Gen. Journal Batch";


    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                    ToolTip = ' ';
                    Caption = 'Name';

                }
                field("Journal Template Name"; Rec."Journal Template Name")
                {
                    ApplicationArea = All;
                    ToolTip = ' ';
                    Caption = 'Journal Template Name';
                }
                field("Template Type"; Rec."Template Type")
                {
                    ApplicationArea = All;
                    ToolTip = ' ';
                    Caption = 'Template Type';
                }
                Field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = ' ';
                    Caption = 'Description';
                }
                field("Allow VAT Difference"; Rec."Allow VAT Difference")
                {
                    ApplicationArea = All;
                    ToolTip = ' ';
                    Caption = 'Allow VAT Difference';
                }
                field("Copy VAT Setup to Jnl. Lines"; Rec."Copy VAT Setup to Jnl. Lines")
                {
                    ApplicationArea = All;
                    ToolTip = ' ';
                    Caption = 'Copy VAT Setup to Jnl. Lines';
                }

            }
        }
    }

}