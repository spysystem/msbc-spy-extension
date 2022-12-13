page 73010 SpyPostedGenJnlLines
{
    ApplicationArea = All;
    Caption = 'SpyPostedGenJnlLines';
    PageType = List;
    SourceTable = "Posted Gen. Journal Line";
    UsageCategory = Lists;
    //Added to be used via. ODATA Web-service. 
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Account Id"; Rec."Account Id")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Account Id field.';
                }
                field("Account No."; Rec."Account No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the account number that the entry on the journal line will be posted to.';
                }
                field("Account Type"; Rec."Account Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the type of account that the entry on the journal line will be posted to.';
                }
                field("Additional-Currency Posting"; Rec."Additional-Currency Posting")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Additional-Currency Posting field.';
                }
                field("Allow Application"; Rec."Allow Application")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Allow Application field.';
                }
                field("Allow Zero-Amount Posting"; Rec."Allow Zero-Amount Posting")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Allow Zero-Amount Posting field.';
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the total amount (including VAT) that the journal line consists of.';
                }
                field("Amount (LCY)"; Rec."Amount (LCY)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the total amount in local currency (including VAT) that the journal line consists of.';
                }
                field("Applied Automatically"; Rec."Applied Automatically")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Applied Automatically field.';
                }
                field("Applies-to Doc. No."; Rec."Applies-to Doc. No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Applies-to Doc. No. field.';
                }
                field("Applies-to Doc. Type"; Rec."Applies-to Doc. Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Applies-to Doc. Type field.';
                }
                field("Applies-to Ext. Doc. No."; Rec."Applies-to Ext. Doc. No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Applies-to Ext. Doc. No. field.';
                }
                field("Applies-to ID"; Rec."Applies-to ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Applies-to ID field.';
                }
                field("Applies-to Invoice Id"; Rec."Applies-to Invoice Id")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Applies-to Invoice Id field.';
                }
                field("Bal. Account No."; Rec."Bal. Account No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number of the general ledger, customer, vendor, or bank account to which a balancing entry for the journal line will posted (for example, a cash account for cash purchases).';
                }
                field("Bal. Account Type"; Rec."Bal. Account Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the code for the balancing account type that should be used in this journal line.';
                }
                field("Bal. Gen. Bus. Posting Group"; Rec."Bal. Gen. Bus. Posting Group")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the general business posting group code associated with the balancing account that will be used when you post the entry.';
                }
                field("Bal. Gen. Posting Type"; Rec."Bal. Gen. Posting Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the general posting type associated with the balancing account that will be used when you post the entry on the journal line.';
                }
                field("Bal. Gen. Prod. Posting Group"; Rec."Bal. Gen. Prod. Posting Group")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the general product posting group code associated with the balancing account that will be used when you post the entry.';
                }
                field("Bal. Tax Area Code"; Rec."Bal. Tax Area Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Bal. Tax Area Code field.';
                }
                field("Bal. Tax Group Code"; Rec."Bal. Tax Group Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Bal. Tax Group Code field.';
                }
                field("Bal. Tax Liable"; Rec."Bal. Tax Liable")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Bal. Tax Liable field.';
                }
                field("Bal. Use Tax"; Rec."Bal. Use Tax")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Bal. Use Tax field.';
                }
                field("Bal. VAT %"; Rec."Bal. VAT %")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Bal. VAT % field.';
                }
                field("Bal. VAT Amount"; Rec."Bal. VAT Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Bal. VAT Amount field.';
                }
                field("Bal. VAT Amount (LCY)"; Rec."Bal. VAT Amount (LCY)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Bal. VAT Amount (LCY) field.';
                }
                field("Bal. VAT Base Amount"; Rec."Bal. VAT Base Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Bal. VAT Base Amount field.';
                }
                field("Bal. VAT Base Amount (LCY)"; Rec."Bal. VAT Base Amount (LCY)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Bal. VAT Base Amount (LCY) field.';
                }
                field("Bal. VAT Bus. Posting Group"; Rec."Bal. VAT Bus. Posting Group")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Bal. VAT Bus. Posting Group field.';
                }
                field("Bal. VAT Calculation Type"; Rec."Bal. VAT Calculation Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Bal. VAT Calculation Type field.';
                }
                field("Bal. VAT Difference"; Rec."Bal. VAT Difference")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Bal. VAT Difference field.';
                }
                field("Bal. VAT Prod. Posting Group"; Rec."Bal. VAT Prod. Posting Group")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Bal. VAT Prod. Posting Group field.';
                }
                field("Balance (LCY)"; Rec."Balance (LCY)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Balance (LCY) field.';
                }
                field("Bank Payment Type"; Rec."Bank Payment Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Bank Payment Type field.';
                }
                field("Bill-to/Pay-to No."; Rec."Bill-to/Pay-to No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Bill-to/Pay-to No. field.';
                }
                field("Budgeted FA No."; Rec."Budgeted FA No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Budgeted FA No. field.';
                }
                field("Business Unit Code"; Rec."Business Unit Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Business Unit Code field.';
                }
                field("Campaign No."; Rec."Campaign No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Campaign No. field.';
                }
                field("Check Exported"; Rec."Check Exported")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Check Exported field.';
                }
                field("Check Printed"; Rec."Check Printed")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Check Printed field.';
                }
                field("Check Transmitted"; Rec."Check Transmitted")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Check Transmitted field.';
                }
                field(Comment; Rec.Comment)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Comment field.';
                }
                field("Contact Graph Id"; Rec."Contact Graph Id")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Contact Graph Id field.';
                }
                field("Copy VAT Setup to Jnl. Lines"; Rec."Copy VAT Setup to Jnl. Lines")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Copy VAT Setup to Jnl. Lines field.';
                }
                field(Correction; Rec.Correction)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Correction field.';
                }
                field("Country/Region Code"; Rec."Country/Region Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Country/Region Code field.';
                }
                field("Credit Amount"; Rec."Credit Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the total amount (including VAT) that the journal line consists of, if it is a credit amount.';
                }
                field("Creditor No."; Rec."Creditor No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Creditor No. field.';
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the code of the currency for the amounts on the journal line.';
                }
                field("Currency Factor"; Rec."Currency Factor")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Currency Factor field.';
                }
                field("Customer Id"; Rec."Customer Id")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Customer Id field.';
                }
                field("Data Exch. Entry No."; Rec."Data Exch. Entry No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Data Exch. Entry No. field.';
                }
                field("Data Exch. Line No."; Rec."Data Exch. Line No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Data Exch. Line No. field.';
                }
                field("Debit Amount"; Rec."Debit Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the total amount (including VAT) that the journal line consists of, if it is a debit amount.';
                }
                field("Deferral Code"; Rec."Deferral Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the deferral template that governs how expenses or revenue are deferred to the different accounting periods when the expenses or revenue were incurred.';
                }
                field("Deferral Line No."; Rec."Deferral Line No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Deferral Line No. field.';
                }
                field("Depr. Acquisition Cost"; Rec."Depr. Acquisition Cost")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Depr. Acquisition Cost field.';
                }
                field("Depr. until FA Posting Date"; Rec."Depr. until FA Posting Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Depr. until FA Posting Date field.';
                }
                field("Depreciation Book Code"; Rec."Depreciation Book Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Depreciation Book Code field.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies a description of the entry.';
                }
                field("Dimension Set ID"; Rec."Dimension Set ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Dimension Set ID field.';
                }
                field("Direct Debit Mandate ID"; Rec."Direct Debit Mandate ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Direct Debit Mandate ID field.';
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Document Date field.';
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies a document number for the journal line.';
                }
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the type of document that the entry on the journal line is.';
                }
                field("Due Date"; Rec."Due Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Due Date field.';
                }
                field("Duplicate in Depreciation Book"; Rec."Duplicate in Depreciation Book")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Duplicate in Depreciation Book field.';
                }
                field("EU 3-Party Trade"; Rec."EU 3-Party Trade")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the EU 3-Party Trade field.';
                }
                field("Expiration Date"; Rec."Expiration Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Expiration Date field.';
                }
                field("Exported to Payment File"; Rec."Exported to Payment File")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Exported to Payment File field.';
                }
                field("External Document No."; Rec."External Document No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the External Document No. field.';
                }
                field("FA Add.-Currency Factor"; Rec."FA Add.-Currency Factor")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the FA Add.-Currency Factor field.';
                }
                field("FA Error Entry No."; Rec."FA Error Entry No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the FA Error Entry No. field.';
                }
                field("FA Posting Date"; Rec."FA Posting Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the FA Posting Date field.';
                }
                field("FA Posting Type"; Rec."FA Posting Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the FA Posting Type field.';
                }
                field("FA Reclassification Entry"; Rec."FA Reclassification Entry")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the FA Reclassification Entry field.';
                }
                field("Financial Void"; Rec."Financial Void")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Financial Void field.';
                }
                field("G/L Register No."; Rec."G/L Register No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number of the general ledger register.';
                }
                field("Gen. Bus. Posting Group"; Rec."Gen. Bus. Posting Group")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the vendor''s or customer''s trade type to link transactions made for this business partner with the appropriate general ledger account according to the general posting setup.';
                }
                field("Gen. Posting Type"; Rec."Gen. Posting Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the general posting type that will be used when you post the entry on this journal line.';
                }
                field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the item''s product type to link transactions made for this item with the appropriate general ledger account according to the general posting setup.';
                }
                field("IC Direction"; Rec."IC Direction")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the IC Direction field.';
                }
                field("IC Partner Code"; Rec."IC Partner Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the IC Partner Code field.';
                }
                field("IC Partner G/L Acc. No."; Rec."IC Partner G/L Acc. No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the IC Partner G/L Acc. No. field.';
                }
                field("IC Partner Transaction No."; Rec."IC Partner Transaction No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the IC Partner Transaction No. field.';
                }
                field("Incoming Document Entry No."; Rec."Incoming Document Entry No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Incoming Document Entry No. field.';
                }
                field(Indentation; Rec.Indentation)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Indentation field.';
                }
                field("Index Entry"; Rec."Index Entry")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Index Entry field.';
                }
                field("Insurance No."; Rec."Insurance No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Insurance No. field.';
                }
                field("Inv. Discount (LCY)"; Rec."Inv. Discount (LCY)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Inv. Discount (LCY) field.';
                }
                field("Job Currency Code"; Rec."Job Currency Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Job Currency Code field.';
                }
                field("Job Currency Factor"; Rec."Job Currency Factor")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Job Currency Factor field.';
                }
                field("Job Line Amount"; Rec."Job Line Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Job Line Amount field.';
                }
                field("Job Line Amount (LCY)"; Rec."Job Line Amount (LCY)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Job Line Amount (LCY) field.';
                }
                field("Job Line Disc. Amount (LCY)"; Rec."Job Line Disc. Amount (LCY)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Job Line Disc. Amount (LCY) field.';
                }
                field("Job Line Discount %"; Rec."Job Line Discount %")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Job Line Discount % field.';
                }
                field("Job Line Discount Amount"; Rec."Job Line Discount Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Job Line Discount Amount field.';
                }
                field("Job Line Type"; Rec."Job Line Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Job Line Type field.';
                }
                field("Job No."; Rec."Job No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Job No. field.';
                }
                field("Job Planning Line No."; Rec."Job Planning Line No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Job Planning Line No. field.';
                }
                field("Job Quantity"; Rec."Job Quantity")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Job Quantity field.';
                }
                field("Job Queue Entry ID"; Rec."Job Queue Entry ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Job Queue Entry ID field.';
                }
                field("Job Queue Status"; Rec."Job Queue Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Job Queue Status field.';
                }
                field("Job Remaining Qty."; Rec."Job Remaining Qty.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Job Remaining Qty. field.';
                }
                field("Job Task No."; Rec."Job Task No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Job Task No. field.';
                }
                field("Job Total Cost"; Rec."Job Total Cost")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Job Total Cost field.';
                }
                field("Job Total Cost (LCY)"; Rec."Job Total Cost (LCY)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Job Total Cost (LCY) field.';
                }
                field("Job Total Price"; Rec."Job Total Price")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Job Total Price field.';
                }
                field("Job Total Price (LCY)"; Rec."Job Total Price (LCY)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Job Total Price (LCY) field.';
                }
                field("Job Unit Cost"; Rec."Job Unit Cost")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Job Unit Cost field.';
                }
                field("Job Unit Cost (LCY)"; Rec."Job Unit Cost (LCY)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Job Unit Cost (LCY) field.';
                }
                field("Job Unit Of Measure Code"; Rec."Job Unit Of Measure Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Job Unit Of Measure Code field.';
                }
                field("Job Unit Price"; Rec."Job Unit Price")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Job Unit Price field.';
                }
                field("Job Unit Price (LCY)"; Rec."Job Unit Price (LCY)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Job Unit Price (LCY) field.';
                }
                field("Journal Batch Id"; Rec."Journal Batch Id")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Journal Batch Id field.';
                }
                field("Journal Batch Name"; Rec."Journal Batch Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the name of the journal batch.';
                }
                field("Journal Template Name"; Rec."Journal Template Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the name of the journal template.';
                }
                field("Last Modified DateTime"; Rec."Last Modified DateTime")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Last Modified DateTime field.';
                }
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Line No. field.';
                }
                field("Maintenance Code"; Rec."Maintenance Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Maintenance Code field.';
                }
                field("Message to Recipient"; Rec."Message to Recipient")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Message to Recipient field.';
                }
                field("No. of Depreciation Days"; Rec."No. of Depreciation Days")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. of Depreciation Days field.';
                }
                field("On Hold"; Rec."On Hold")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the On Hold field.';
                }
                field("Orig. Pmt. Disc. Possible"; Rec."Orig. Pmt. Disc. Possible")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Original Pmt. Disc. Possible field.';
                }
                field("Orig. Pmt. Disc. Possible(LCY)"; Rec."Orig. Pmt. Disc. Possible(LCY)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Orig. Pmt. Disc. Possible (LCY) field.';
                }
                field("Payer Information"; Rec."Payer Information")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Payer Information field.';
                }
                field("Payment Discount %"; Rec."Payment Discount %")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Payment Discount % field.';
                }
                field("Payment Method Code"; Rec."Payment Method Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Payment Method Code field.';
                }
                field("Payment Method Id"; Rec."Payment Method Id")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Payment Method Id field.';
                }
                field("Payment Reference"; Rec."Payment Reference")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Payment Reference field.';
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
                    ToolTip = 'Specifies the entry''s posting date.';
                }
                field("Posting Group"; Rec."Posting Group")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Posting Group field.';
                }
                field("Posting No. Series"; Rec."Posting No. Series")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Posting No. Series field.';
                }
                field(Prepayment; Rec.Prepayment)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Prepayment field.';
                }
                field("Print Posted Documents"; Rec."Print Posted Documents")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Print Posted Documents field.';
                }
                field("Prod. Order No."; Rec."Prod. Order No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Prod. Order No. field.';
                }
                field("Profit (LCY)"; Rec."Profit (LCY)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Profit (LCY) field.';
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the quantity of items to be included on the journal line.';
                }
                field("Reason Code"; Rec."Reason Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Reason Code field.';
                }
                field("Recipient Bank Account"; Rec."Recipient Bank Account")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Recipient Bank Account field.';
                }
                field("Recurring Frequency"; Rec."Recurring Frequency")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Recurring Frequency field.';
                }
                field("Recurring Method"; Rec."Recurring Method")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Recurring Method field.';
                }
                field("Reversing Entry"; Rec."Reversing Entry")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Reversing Entry field.';
                }
                field("Sales/Purch. (LCY)"; Rec."Sales/Purch. (LCY)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Sales/Purch. (LCY) field.';
                }
                field("Salespers./Purch. Code"; Rec."Salespers./Purch. Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Salespers./Purch. Code field.';
                }
                field("Salvage Value"; Rec."Salvage Value")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Salvage Value field.';
                }
                field("Sell-to/Buy-from No."; Rec."Sell-to/Buy-from No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Sell-to/Buy-from No. field.';
                }
                field("Ship-to/Order Address Code"; Rec."Ship-to/Order Address Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Ship-to/Order Address Code field.';
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the code for Shortcut Dimension 1, which is one of two global dimension codes that you set up in the General Ledger Setup window.';
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the code for Shortcut Dimension 2, which is one of two global dimension codes that you set up in the General Ledger Setup window.';
                }
                field("Source Code"; Rec."Source Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Source Code field.';
                }
                field("Source Curr. VAT Amount"; Rec."Source Curr. VAT Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Source Curr. VAT Amount field.';
                }
                field("Source Curr. VAT Base Amount"; Rec."Source Curr. VAT Base Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Source Curr. VAT Base Amount field.';
                }
                field("Source Currency Amount"; Rec."Source Currency Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Source Currency Amount field.';
                }
                field("Source Currency Code"; Rec."Source Currency Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Source Currency Code field.';
                }
                field("Source Line No."; Rec."Source Line No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Source Line No. field.';
                }
                field("Source No."; Rec."Source No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Source No. field.';
                }
                field("Source Type"; Rec."Source Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Source Type field.';
                }
                field("System-Created Entry"; Rec."System-Created Entry")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the System-Created Entry field.';
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
                field("Tax Area Code"; Rec."Tax Area Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Tax Area Code field.';
                }
                field("Tax Group Code"; Rec."Tax Group Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Tax Group Code field.';
                }
                field("Tax Liable"; Rec."Tax Liable")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Tax Liable field.';
                }
                field("Transaction Information"; Rec."Transaction Information")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Transaction Information field.';
                }
                field("Use Duplication List"; Rec."Use Duplication List")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Use Duplication List field.';
                }
                field("Use Tax"; Rec."Use Tax")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Use Tax field.';
                }
                field("VAT %"; Rec."VAT %")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the VAT % field.';
                }
                field("VAT Amount"; Rec."VAT Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the amount of VAT included in the total amount.';
                }
                field("VAT Amount (LCY)"; Rec."VAT Amount (LCY)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the VAT Amount (LCY) field.';
                }
                field("VAT Base Amount"; Rec."VAT Base Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the VAT Base Amount field.';
                }
                field("VAT Base Amount (LCY)"; Rec."VAT Base Amount (LCY)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the VAT Base Amount (LCY) field.';
                }
                field("VAT Base Before Pmt. Disc."; Rec."VAT Base Before Pmt. Disc.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the VAT Base Before Pmt. Disc. field.';
                }
                field("VAT Base Discount %"; Rec."VAT Base Discount %")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the VAT Base Discount % field.';
                }
                field("VAT Bus. Posting Group"; Rec."VAT Bus. Posting Group")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the VAT business posting group code that will be used when you post the entry on the journal line.';
                }
                field("VAT Calculation Type"; Rec."VAT Calculation Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the VAT Calculation Type field.';
                }
                field("VAT Difference"; Rec."VAT Difference")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the VAT Difference field.';
                }
                field("VAT Posting"; Rec."VAT Posting")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the VAT Posting field.';
                }
                field("VAT Prod. Posting Group"; Rec."VAT Prod. Posting Group")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the VAT product posting group. Links business transactions made for the item, resource, or G/L account with the general ledger, to account for VAT amounts resulting from trade with that record.';
                }
                field("VAT Registration No."; Rec."VAT Registration No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the VAT Registration No. field.';
                }
            }
        }
    }
}
