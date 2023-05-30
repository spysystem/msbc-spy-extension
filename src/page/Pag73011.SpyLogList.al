page 73011 "Spy Log List"
{
    ApplicationArea = All;
    Caption = 'Spy Log List';
    PageType = List;
    SourceTable = SpyLog;
    UsageCategory = Tasks;
    Editable = false;
    DeleteAllowed = true;
    
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Entry No."; Rec."Entry No.")
                {
                }
                field("Journal Template Name"; Rec."Journal Template Name")
                {
                }
                field("Journal Batch Name"; Rec."Journal Batch Name")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Action Description"; Rec."Action Description")
                {
                }
                field("Commited To Journal"; Rec."Commited To Journal")
                {
                }
                field("Currency Code"; Rec."Currency Code")
                {
                }
                field(Amount; Rec.Amount)
                {
                }
                field("Amount (LCY)"; Rec."Amount (LCY)")
                {
                }
                field("Account Type"; Rec."Account Type")
                {
                }
                field("Document No."; Rec."Document No.")
                {
                }
                field("Due Date"; Rec."Due Date")
                {
                }
                field("Cash Discount Date"; Rec."Cash Discount Date")
                {
                }
                field(documentTypeAsText; Rec.documentTypeAsText)
                {
                }
                field("Account No."; Rec."Account No.")
                {
                }
                field("Document Type"; Rec."Document Type")
                {
                }
                field("Payment Terms Code"; Rec."Payment Terms Code")
                {
                }
                field("Posting Date"; Rec."Posting Date")
                {
                }
                field("External Document No."; Rec."External Document No.")
                {
                }
                field("Country/Region Code"; Rec."Country/Region Code")
                {
                }
                field(postType; Rec.postType)
                {
                }
                field(deliveryAccount; Rec.deliveryAccount)
                {
                }
                field("County US Tax Account"; Rec."County US Tax Account")
                {
                }
                field("State US Tax Account"; Rec."State US Tax Account")
                {
                }
                field("VAT Code"; Rec."VAT Code")
                {
                }
                field(entryType; Rec.entryType)
                {
                }
                field(vatArea; Rec.vatArea)
                {
                }
                field("Tax Title"; Rec."Tax Title")
                {
                }
                field("tax Percentage"; Rec."tax Percentage")
                {
                }
                field(custGroup; Rec.custGroup)
                {
                }
                field("Ready To Post"; Rec."Ready To Post")
                {
                }
                field(PaymentId; Rec.PaymentId)
                {
                }
                field("Error Description Text"; Rec."Error Description Text")
                {
                }
                field("Document Entry No."; Rec."Document Entry No.")
                {
                }
                field(SystemCreatedAt; Rec.SystemCreatedAt)
                {
                }
                field(SystemCreatedBy; Rec.SystemCreatedBy)
                {
                }
                field(SystemId; Rec.SystemId)
                {
                }
                field(SystemModifiedAt; Rec.SystemModifiedAt)
                {
                }
                field(SystemModifiedBy; Rec.SystemModifiedBy)
                {
                }
            }
        }
    }
}
