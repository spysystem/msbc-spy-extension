table 73003 "SpyLog"
{
    Caption = 'SpyLog';
    DataClassification = ToBeClassified;

    fields
    {

        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
        }

        field(2; "Journal Template Name"; Code[10])
        {
            Caption = 'Journal Template Name';
            ValidateTableRelation = false;
            TableRelation = "Gen. Journal Template";
            DataClassification = CustomerContent;
        }

        field(4; "Journal Batch Name"; Code[10])
        {
            Caption = 'Journal Batch Name';
            DataClassification = CustomerContent;
            ValidateTableRelation = false;
            TableRelation = "Gen. Journal Batch".Name WHERE("Journal Template Name" = FIELD("Journal Template Name"));
        }
        field(8; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;

        }

        field(9; "Action Description"; Text[100])
        {
            Caption = 'Action Description';
            DataClassification = CustomerContent;
        }
        field(10; "Commited To Journal"; Boolean)
        {
            Caption = 'Commited To Journal';
            DataClassification = CustomerContent;
        }

        field(12; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            TableRelation = Currency;
            ValidateTableRelation = false;
            DataClassification = CustomerContent;

        }

        field(13; Amount; Decimal)
        {
            Caption = 'Amount';
            DataClassification = CustomerContent;

        }
        field(16; "Amount (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Amount (LCY)';
            DataClassification = CustomerContent;

        }
        field(33; "Account Type"; Enum "Gen. Journal Account Type")
        {
            Caption = 'Account Type';
            DataClassification = CustomerContent;
        }


        field(37; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = CustomerContent;
        }
        field(38; "Due Date"; Text[20]) //dueDate
        {
            Caption = 'Due Date';
        }

        field(39; "Cash Discount Date"; Text[20]) //cashDiscountDate
        {
            Caption = 'Pmt. Discount Date';
        }

        field(40; documentTypeAsText; Text[20])
        {
            Caption = 'documentTypeAsText';
            DataClassification = CustomerContent;
        }


        field(44; "Account No."; Code[20])
        {
            Caption = 'Account No.';
            DataClassification = CustomerContent;

        }

        field(46; "Document Type"; Enum "Gen. Journal Document Type")
        {
            Caption = 'Document Type';
            DataClassification = CustomerContent;
        }
        field(47; "Payment Terms Code"; Code[10])
        {
            Caption = 'Payment Terms Code';
            TableRelation = "Payment Terms";
            ValidateTableRelation = false;
        }

        field(55; "Posting Date"; Text[10])
        {
            Caption = 'Posting Date';
            DataClassification = CustomerContent;
        }
        field(77; "External Document No."; Code[35])
        {
            Caption = 'External Document No.';
            DataClassification = CustomerContent;

        }

        field(120; "Country/Region Code"; Code[10])
        {
            Caption = 'Country/Region Code';
            TableRelation = "Country/Region";
            ValidateTableRelation = false;
            DataClassification = CustomerContent;


        }
        field(510; postType; Text[20])
        {
            Caption = 'postType';
            DataClassification = CustomerContent;

        }

        field(515; deliveryAccount; Text[20])
        {
            Caption = 'Delivery Acoount';
            DataClassification = CustomerContent;


        }
        field(550; "County US Tax Account"; Code[20])
        {
            Caption = 'County US Tax Account';
            DataClassification = CustomerContent;

        }
        field(556; "State US Tax Account"; Code[20])
        {
            Caption = 'State US Tax Account';
            DataClassification = CustomerContent;

        }
        field(566; "VAT Code"; Code[20])
        {
            Caption = 'VAT Code';
            DataClassification = CustomerContent;
        }
        field(623; entryType; Text[30])
        {
            Caption = 'entryType';
        }
        field(654; vatArea; Code[20]) //NOT USED?
        {
            Caption = 'vatArea';
        }
        field(800; "Tax Title"; Text[20])
        {
            Caption = 'TaxTitle';
        }
        field(888; "tax Percentage"; Decimal)
        {
            Caption = 'Tax Percent', comment = 'DAN="Moms Percent"';
        }
        field(901; custGroup; Text[50])
        {
            Caption = 'custGroup';
        }

        field(1100; "Ready To Post"; Boolean)
        {
            Caption = 'Ready To Post', comment = 'DAN="Klar til bogf."';

        }

        field(1200; PaymentId; Text[100])
        {
            Caption = 'PaymentID', comment = 'DAN="Betalingsid"';
        }

        // field(1000; "SPY Dimensions"; Integer)
        // {
        //     Caption = 'SPY Dimension';
        //     ValidateTableRelation = false;
        //     TableRelation = "Spy Dimensions" where("Entry No." = field("Entry No."));
        // }
        field(1220; "Error Description Text"; Text[2000])
        {
            caption = 'Error Description', comment = 'DAN="Fejlbeskrivelse"';
        }
        field(50000; "Document Entry No."; Integer)
        {
            Caption = 'Entry No.';
        }
    }

    keys
    {
        key(Key1; "Document Entry No.")
        {
            Clustered = true;
        }

    }

    trigger OnInsert()
    var
        SpyLog: Record SpyLog;
    begin
        spylog.reset;
        If SpyLog.FindLast() then
            Rec."Document Entry No." := SpyLog."Document Entry No." + 1
        else
            Rec."Document Entry No." := 1;
    end;

    /// <summary>
    /// InitiateSpyLog.
    /// </summary>
    /// <param name="SpyJournalLine">Record "Spy Journal Line".</param>
    procedure Initiate(SpyJournalLine: Record "Spy Journal Line")
    begin
        Rec.Init();
        Rec.TransferFields(SpyJournalLine, true);
        Rec.Insert(true);
    end;


    /// <summary>
    /// WriteCompletedWithErrors.
    /// </summary>
    /// <param name="EntryNo">Integer.</param>
    procedure UpdatelogWithErrors(EntryNo: Integer; GlobalErrorTextList: List of [Text])
    var
        ErrorText: Text;
        ErrorTotal: Text;

    begin
        if GetRec(EntryNo) then
            if GlobalErrorTextList.Count > 0 then begin
                foreach ErrorText in GlobalErrorTextList do begin
                    if ErrorTotal = '' then
                        ErrorTotal := ErrorText
                    else
                        ErrorTotal += ' ' + ErrorText;
                end;
                Rec."Error Description Text" := CopyStr(ErrorTotal, 1, MaxStrLen(Rec."Error Description Text"));
                Rec.Modify();
            end
    end;

    /// <summary>
    /// WriteCompletedWithSucess.
    /// </summary>
    /// <param name="EntryNo">Integer.</param>
    procedure UpdateLogWithSucess(EntryNo: Integer)
    var
    begin
        if GetRec(EntryNo) then begin
            Rec."Ready To Post" := true;
            Rec.Modify();
        end;
    end;

    local procedure GetRec(EntryNo: integer): Boolean

    begin
        Rec.reset;
        Rec.setrange("Entry No.", EntryNo);
        exit(Rec.FindLast());
    end;

}
