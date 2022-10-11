/// <summary>
/// Page SpyCreateJournalDimensionsAPI (ID 73003).
/// </summary>
page 73003 SpyJournalDimensionPart
{

    Caption = 'spyDimensions';
    PageType = ListPart;
    SourceTable = "Spy Dimension";
    DelayedInsert = true;
    //AutoSplitKey = true;
    PopulateAllFields = true;
    ODataKeyFields = SystemId;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(id; Format(Rec.SystemId, 0, 4).ToLower())
                {
                    Caption = 'SystemID', Locked = true;
                    ApplicationArea = All;
                    ToolTip = ' ';
                }
                field(entryNo; Rec."Entry No.")
                {
                    Caption = 'EntryNo';
                    ApplicationArea = All;
                    ToolTip = ' ';
                }
                field(spyJournalSystemId; Rec."Spy Journal System Id")
                {
                    Caption = 'spyJournalSystemId';
                    ApplicationArea = All;
                    ToolTip = ' ';
                }

                field(dimensionName; Rec."Dimension Name")
                {
                    Caption = 'dimensionName';
                    ApplicationArea = All;
                    ToolTip = ' ';
                }
                field(dimensionValue; Rec."Dimension Value Code")
                {
                    Caption = 'dimensionValue';
                    ApplicationArea = All;
                    ToolTip = ' ';
                    trigger OnValidate()
                    begin
                        //ValidateDimension(CopyStr(Rec."Dimension Name", 1, 20), Rec."Dimension Value Code");
                    end;
                }
                field(SystemId; Rec.SystemId)
                {
                    Caption = 'sysid, msformat';
                    ToolTip = 'SystemID';
                    Visible = false;
                    ApplicationArea = All;
                }
            }
        }
    }

    var //Globals

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec.HandleDimensions(SpyJournalLine, GlobalErrorTextList);
        if GlobalErrorTextList.Count > 0 then
            AddDimensionsCreationError(SpyJournalLine, GlobalErrorTextList);
    end;


    trigger OnNewRecord(BelowxRec: Boolean)
    var
        SpyDimensionsRec: Record "Spy Dimension";
    begin
        SpyJournalLine.SetRange(SystemId, Rec."Spy Journal System Id");
        if SpyJournalLine.FindFirst() then begin
            Rec."Entry No." := SpyJournalLine."Entry No.";
            if SpyDimensionsRec.FindLast() then
                Rec."Line No." := SpyDimensionsRec."Line No." + 1
            else
                Rec."Line No." := 1;
            Rec."Journal Template Name" := SpyJournalLine."Journal Template Name";
            Rec."Journal Batch Name" := SpyJournalLine."Journal Batch Name";
            Rec."External Document No." := SpyJournalLine."External Document No.";
            Rec."Spy Jnl Line Description" := SpyJournalLine.Description;
        end;
    end;

    /// <summary>
    /// AddError.
    /// </summary>
    /// <param name="pSpyJournalLine">Record "Spy Journal Line".</param>
    /// <param name="ErrorList">List of [Text].</param>
    /// <returns>Return variable ErrorWasAdded of type Boolean.</returns>
    procedure AddDimensionsCreationError(pSpyJournalLine: Record "Spy Journal Line"; ErrorList: List of [Text]) ErrorWasAdded: Boolean
    var
        spyError: Record "Spy Error";
        ErrorText: Text;
        ErrorTotal: Text;
        ErrorNumber: Integer;
        BlobOutStream: OutStream;

    begin

        if ErrorList.Count > 0 then begin
            foreach ErrorText in ErrorList do begin
                ErrorNumber += 1;
                ErrorTotal += ErrorList.Get(ErrorNumber) + ' ';
            end;

            spyError.SetRange("Journal Template Name", pSpyJournalLine."Journal Template Name");
            spyError.SetRange("Entry No.", pSpyJournalLine."Entry No.");
            spyError.SetRange("Spy Jnl Line Description", pSpyJournalLine.Description);

            if spyError.FindFirst() then
                spyError."Line No." := spyError."Line No." + 1;

            spyError."Journal Template Name" := pSpyJournalLine."Journal Template Name";
            spyError."Entry No." := pSpyJournalLine."Entry No.";
            spyError."Spy Jnl Line Description" := pSpyJournalLine.Description;

            spyError."Error Description".CreateOutStream(BlobOutStream);
            BlobOutStream.WriteText(ErrorTotal);
            if not spyError.Insert() then
                spyError.Modify();
        end;

    end;


    var
        SpyJournalLine: Record "Spy Journal Line";
        GlobalErrorTextList: List of [Text];

}