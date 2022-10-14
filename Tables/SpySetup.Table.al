table 73001 "Spy Setup"
{
    Caption = 'SPY Setup';
    DataClassification = ToBeClassified;


    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            DataClassification = ToBeClassified;
        }
        field(2; "VAT Bus. Posting Group"; Code[20])
        {
            Caption = 'VAT Bus. Posting Group';
            DataClassification = ToBeClassified;
        }
        field(3; "Gen. Bus. Posting Group"; Code[20])
        {
            Caption = 'Gen. Bus. Posting Group';
            DataClassification = ToBeClassified;
        }
        field(4; "VAT Prod. Posting Group"; Code[20])
        {
            Caption = 'VAT Prod. Posting Group';
            DataClassification = ToBeClassified;
            InitValue = 'SPY';
        }
        field(5; "Gen. Prod. Posting Group"; Code[20])
        {
            Caption = 'Gen. Prod. Posting Group';
            DataClassification = ToBeClassified;
            InitValue = 'SPY';

        }
        field(10; "Default Journal Template Name"; Code[10])
        {
            Caption = 'Default Journal Temp Name';
            TableRelation = "Gen. Journal Template";
            DataClassification = ToBeClassified;
        }
        field(15; "Default Journal Batch Name"; Code[10])
        {
            Caption = 'Default Journal Batch Name';
            DataClassification = ToBeClassified;
            TableRelation = "Gen. Journal Batch";
        }
        field(20; "Default Jnl Batch Description"; Text[100])
        {
            Caption = 'Default Jnl Batch Description';
            DataClassification = ToBeClassified;
            InitValue = 'Spy Journal';
        }

        field(21; "Default Template Type"; Enum "Gen. Journal Template Type")
        {
            Caption = 'Default Template Type';
            TableRelation = "Gen. Journal Template".Type;
            DataClassification = ToBeClassified;
        }

        field(30; "Auto Extract PaymentId"; Boolean)
        {
            Caption = 'Auto Extract PaymentId', comment = 'DAN="Auto, ovf. betalingsid"';
            InitValue = true;
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }
}
