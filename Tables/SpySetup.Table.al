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
            TableRelation = "VAT Business Posting Group";
            ValidateTableRelation = false;
            DataClassification = ToBeClassified;
        }
        field(3; "Gen. Bus. Posting Group"; Code[20])
        {
            Caption = 'Gen. Bus. Posting Group';
            DataClassification = ToBeClassified;
            TableRelation = "Gen. Business Posting Group";
            ValidateTableRelation = false;
        }
        field(4; "VAT Prod. Posting Group"; Code[20])
        {
            Caption = 'VAT Prod. Posting Group';
            TableRelation = "VAT Product Posting Group";
            ValidateTableRelation = false;
            DataClassification = ToBeClassified;

        }
        field(5; "Gen. Prod. Posting Group"; Code[20])
        {
            Caption = 'Gen. Prod. Posting Group';
            DataClassification = ToBeClassified;
            TableRelation = "Gen. Product Posting Group";
            ValidateTableRelation = false;


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

        }

        field(21; "Default Template Type"; enum "Gen. Journal Template Type")
        {
            Caption = 'Default Template Type';
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
