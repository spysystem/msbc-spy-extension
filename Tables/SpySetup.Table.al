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
            Caption = 'VAT Prod. Posting Group', comment = 'DAN="Moms. produktbogf. Gruppe"';
            TableRelation = "VAT Product Posting Group";
            ValidateTableRelation = true;
            DataClassification = ToBeClassified;
        }

        field(10; "Default Journal Template Name"; Code[10]) //Used when Gen Journal Batch does not exist.
        {
            Caption = 'Default Journal Temp Name', comment = 'DAN="Std. Kladde-skabelonnavn"';
            TableRelation = "Gen. Journal Template";
            ValidateTableRelation = true;
            DataClassification = ToBeClassified;
        }

        field(20; "Default Journal Description"; Text[100]) //Used when Gen Journal Description does not exist.
        {
            Caption = 'Default Journal Description', comment = 'DAN="Kaldde-beskrivelse"';
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
