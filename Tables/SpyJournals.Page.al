page 73004 "Spy Journals"
{
    ApplicationArea = All;
    Caption = 'Spy Journals';
    PageType = List;
    SourceTable = "Spy Create Journal Line";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Account No."; Rec."Account No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Account No. field.';
                }
                field("Account Type"; Rec."Account Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Account Type field.';
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Amount field.';
                }
                field("Amount (LCY)"; Rec."Amount (LCY)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Amount (LCY) field.';
                }
                field("Country/Region Code"; Rec."Country/Region Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Country/Region Code field.';
                }
                field("County US Tax Account"; Rec."County US Tax Account")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the County US Tax Account field.';
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Currency Code field.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Document No. field.';
                }
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Document Type field.';
                }
                field("Due Date"; Rec."Due Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Due Date field.';
                }
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Entry No. field.';
                }
                field("External Document No."; Rec."External Document No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the External Document No. field.';
                }
                field("Journal Batch Name"; Rec."Journal Batch Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Journal Batch Name field.';
                }
                field("Journal Template Name"; Rec."Journal Template Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Journal Template Name field.';
                }
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Line No. field.';
                }
                field("Payment Terms Code"; Rec."Payment Terms Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Payment Terms Code field.';
                }
                field("Pmt. Discount Date"; Rec."Pmt. Discount Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Pmt. Discount Date field.';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Posting Date field.';
                }
                field("SPY Dimensions"; Rec."SPY Dimensions")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the SPY Dimensions field.';
                }
                field("State US Tax Account"; Rec."State US Tax Account")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the State US Tax Account field.';
                }
                field(SystemCreatedAt; Rec.SystemCreatedAt)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the SystemCreatedAt field.';
                }
                field(SystemCreatedBy; Rec.SystemCreatedBy)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the SystemCreatedBy field.';
                }
                field(SystemId; Rec.SystemId)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the SystemId field.';
                }
                field(SystemModifiedAt; Rec.SystemModifiedAt)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the SystemModifiedAt field.';
                }
                field(SystemModifiedBy; Rec.SystemModifiedBy)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the SystemModifiedBy field.';
                }
                field("Tax Title"; Rec."Tax Title")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the TaxTitle field.';
                }
                field("VAT Code"; Rec."VAT Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the VAT Code field.';
                }
                field(custGroup; Rec.custGroup)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the custGroup field.';
                }
                field(deliveryAccount; Rec.deliveryAccount)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Delivery Acoount field.';
                }
                field(documentTypeAsText; Rec.documentTypeAsText)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the documentTypeAsText field.';
                }
                field(entryType; Rec.entryType)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the entryType field.';
                }
                field(postType; Rec.postType)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the postType field.';
                }
                field("tax Percentage"; Rec."tax Percentage")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Tax Percent field.';
                }
                field(vatArea; Rec.vatArea)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the vatArea field.';
                }
            }
        }
    }


}
