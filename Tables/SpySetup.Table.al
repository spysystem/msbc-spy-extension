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
            ValidateTableRelation = false;
            DataClassification = ToBeClassified;
        }
        field(15; "Default Journal Batch Name"; Code[10])
        {
            Caption = 'Default Journal Batch Name';
            DataClassification = ToBeClassified;
            ValidateTableRelation = false;
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
            ValidateTableRelation = false;
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
