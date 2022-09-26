table 73000 "Spy Error"
{
    DataClassification = ToBeClassified;
    Caption = 'Spy Error', comment = 'DAN="Spy Fejl"';

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

        field(37; "External Document No."; Code[20])
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
        key(Key1; "Entry No.", "Journal Template Name", "Journal Batch Name", "External Document No.", "Line No.")
        {
            Clustered = true;
        }
    }

    /// <summary>
    /// AddError.
    /// </summary>
    /// <param name="SpyJournalLine">Record "Spy Create Journal Line".</param>
    /// <param name="ErrorList">List of [Text].</param>
    /// <returns>Return variable ErrorWasAdded of type Boolean.</returns>
    procedure AddError(SpyJournalLine: Record "Spy Journal Line"; ErrorList: List of [Text]) ErrorWasAdded: Boolean
    var
        ErrorText: Text;
        ErrorTotal: Text;
        ErrorNumber: Integer;
        BlobOutStream: OutStream;
    begin
        //TODO: This may not be good, ErrorList may be > 0 due to ealier errors.
        if ErrorList.Count > 0 then begin
            foreach ErrorText in ErrorList do begin
                ErrorNumber += 1;
                ErrorTotal += ErrorList.Get(ErrorNumber) + ' ';
            end;
            Rec."Journal Template Name" := SpyJournalLine."Journal Template Name";
            Rec."Entry No." := SpyJournalLine."Entry No.";
            Rec."External Document No." := SpyJournalLine."External Document No.";
            Rec."Error Description".CreateOutStream(BlobOutStream);
            BlobOutStream.WriteText(ErrorTotal);
            if not Rec.Insert() then
                Rec.Modify();
        end;
    end;

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