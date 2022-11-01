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


        field(4; "VAT Prod. Posting Group"; Code[20]) //Used in GenJrnLine
        {
            Caption = 'VAT Prod. Posting Group';
            DataClassification = ToBeClassified;
            InitValue = 'SPY';
        }

        field(10; "Default Journal Template Name"; Code[10]) //Used when Gen Journal Batch does not exist.
        {
            Caption = 'Default Journal Temp Name';
            TableRelation = "Gen. Journal Template";
            ValidateTableRelation = false;
            DataClassification = ToBeClassified;
        }
        field(15; "Default Journal Batch Name"; Code[10]) //Used when Gen Journal Batch does not exist.
        {
            Caption = 'Default Journal Batch Name';
            DataClassification = ToBeClassified;
            ValidateTableRelation = false;
            TableRelation = "Gen. Journal Batch";
        }


        field(21; "Default Template Type"; Enum "Gen. Journal Template Type") ///Used when Gen Journal Batch does not exist
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
