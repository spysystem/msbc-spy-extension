table 73000 "Spy Errors"
{
    DataClassification = ToBeClassified;
    Caption = 'Spy Errors';

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
        }

        field(10; "Journal Template Name"; Code[10])
        {
            Caption = 'Journal Template Name';
            DataClassification = CustomerContent;
        }
        field(20; "Journal Batch Name"; Code[10])
        {
            Caption = 'Journal Batch Name';
            DataClassification = CustomerContent;

        }

        field(30; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }

        field(37; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = CustomerContent;
        }

        Field(100; "Error Description"; Blob)
        {
            Caption = 'Error Description';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Entry No.", "Journal Template Name", "Journal Batch Name", "Document No.", "Line No.")
        {
            Clustered = true;
        }
    }
    var

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}