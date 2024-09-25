page 73084 "Spy Journal"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    Caption = 'Spy Journal Lines';
    AdditionalSearchTerms = 'spy,spy journal';
    SourceTable = "Gen. Journal Line";

    layout
    {
        area(Content)
        {
            Repeater("Spy Journal Lines")
            {
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                    ToolTip = ' ';
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                    ToolTip = ' ';
                }
                field("External Document No."; Rec."External Document No.")
                {
                    ApplicationArea = All;
                    ToolTip = ' ';
                }
                field("Account No."; Rec."Account No.")
                {
                    ApplicationArea = All;
                    ToolTip = ' ';
                }
                field("Account Type"; Rec."Account Type")
                {
                    ApplicationArea = All;
                    ToolTip = ' ';
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                    ToolTip = ' ';
                }
                field("Debit Amount"; Rec."Debit Amount")
                {
                    ApplicationArea = All;
                    ToolTip = ' ';
                }
                field("Credit Amount"; Rec."Credit Amount")
                {
                    ApplicationArea = All;
                    ToolTip = ' ';
                }
                field("VAT Amount"; Rec."VAT Amount")
                {
                    ApplicationArea = All;
                    ToolTip = ' ';
                }
                field("VAT Base Amount"; Rec."VAT Base Amount")
                {
                    ApplicationArea = All;
                    ToolTip = ' ';
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = All;
                    ToolTip = ' ';
                }
                field("Currency Factor"; Rec."Currency Factor")
                {
                    ApplicationArea = All;
                    ToolTip = ' ';
                }
                field("Amount (LCY)"; Rec."Amount (LCY)")
                {
                    ApplicationArea = All;
                    ToolTip = ' ';
                }
                field("VAT Amount (LCY)"; Rec."VAT Amount (LCY)")
                {
                    ApplicationArea = All;
                    ToolTip = ' ';
                }
                field("VAT Base Amount (LCY)"; Rec."VAT Base Amount (LCY)")
                {
                    ApplicationArea = All;
                    ToolTip = ' ';
                }
                field("Balance (LCY)"; Rec."Balance (LCY)")
                {
                    ApplicationArea = All;
                    ToolTip = ' ';
                }
                field("Sales/Purch. (LCY)"; Rec."Sales/Purch. (LCY)")
                {
                    ApplicationArea = All;
                    ToolTip = ' ';
                }
                field("Source Currency Code"; Rec."Source Currency Code")
                {
                    ApplicationArea = All;
                    ToolTip = ' ';
                }
                field("Source Currency Amount"; Rec."Source Currency Amount")
                {
                    ApplicationArea = All;
                    ToolTip = ' ';
                }
                field("Source Currency VAT Base Amount"; Rec."Source Curr. VAT Base Amount")
                {
                    ApplicationArea = All;
                    ToolTip = ' ';
                }
                field("Source Currency VAT Amount"; Rec."Source Curr. VAT Amount")
                {
                    ApplicationArea = All;
                    ToolTip = ' ';
                }
                field("VAT %"; Rec."VAT %")
                {
                    ApplicationArea = All;
                    ToolTip = ' ';
                }
                field("VAT Base Discount %"; Rec."VAT Base Discount %")
                {
                    ApplicationArea = All;
                    ToolTip = ' ';
                }

                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = All;
                    ToolTip = ' ';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = ' ';
                }
                field("Journal Template Name"; Rec."Journal Template Name")
                {
                    ApplicationArea = All;
                    ToolTip = ' ';
                }
                field("Journal Batch Name"; Rec."Journal Batch Name")
                {
                    ApplicationArea = All;
                    ToolTip = ' ';
                }
                field("Due Date"; Rec."Due Date")
                {
                    ApplicationArea = All;
                    ToolTip = ' ';
                }
                field("Payment Terms Code"; Rec."Payment Terms Code")
                {
                    ApplicationArea = All;
                    ToolTip = ' ';
                }
                field("Pmt. Discount Date"; Rec."Pmt. Discount Date")
                {
                    ApplicationArea = All;
                    ToolTip = ' ';
                }
                field("Payment Discount %"; Rec."Payment Discount %")
                {
                    ApplicationArea = All;
                    ToolTip = ' ';
                }
                field("Gen. Bus. Posting Group"; Rec."Gen. Bus. Posting Group")
                {
                    ApplicationArea = All;
                    ToolTip = ' ';
                }
                field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
                {
                    ApplicationArea = All;
                    ToolTip = ' ';
                }
                field("VAT Bus. Posting Group"; Rec."VAT Bus. Posting Group")
                {
                    ApplicationArea = All;
                    ToolTip = ' ';
                }
                field("VAT Prod. Posting Group"; Rec."VAT Prod. Posting Group")
                {
                    ApplicationArea = All;
                    ToolTip = ' ';
                }
                field("Gen. Posting Type"; Rec."Gen. Posting Type")
                {
                    ApplicationArea = All;
                    ToolTip = ' ';
                }


            }
        }
    }

}
