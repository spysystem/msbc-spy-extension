page 73016 "SpyGeneralLedgerSetup"
{
    APIGroup = 'integration';
    APIPublisher = 'spy';
    APIVersion = 'v1.0';
    Caption = 'General Ledger Setup API';
    DelayedInsert = true;
    EntityName = 'SpyGeneralLedgerSetup';
    EntitySetName = 'SpyGeneralLedgerSetup';
    PageType = API;
    SourceTable = "General Ledger Setup";
    ODataKeyFields = SystemId;

    layout
    {
        area(Content)
        {
            field("allowPostingFromDate"; AllowPostingFromDate)
            {
                /** 
                * We cannot expose Date fields directly in API pages, because when you expose a Date field through an API page and that field is uninitialized (i.e., blank in BC).
                * It will default to returning the minimum .NET date, which is 0001-01-01.
                * This we fix by using Text variables and the OnAfterGetRecord() below to format the date correctly.
                */
                Caption = 'Allow Posting From Date';
            }

            field("allowPostingToDate"; AllowPostingToDate)
            {
                // Same comment as for the Allow Posting From Date field.
                Caption = 'Allow Posting To Date';
            }

            field("systemId"; Rec.SystemId)
            {
                Caption = 'System Id';
            }

            field("systemCreatedAt"; Rec.SystemCreatedAt)
            {
                Caption = 'System Created At';
            }

            field("systemCreatedBy"; Rec.SystemCreatedBy)
            {
                Caption = 'System Created By';
            }

            field("systemModifiedAt"; Rec.systemModifiedAt)
            {
                Caption = 'System Modified At';
            }

            field("systemModifiedBy"; Rec.systemModifiedBy)
            {
                Caption = 'System Modified By';
            }
        }
    }

    var
        AllowPostingFromDate: Text[10];
        AllowPostingToDate: Text[10];

    trigger OnAfterGetRecord()
    begin
        if Rec."Allow Posting From" = 0D then
            AllowPostingFromDate := ''
        else
            AllowPostingFromDate := Format(Rec."Allow Posting From", 0, '<Year4>-<Month,2>-<Day,2>');

        if Rec."Allow Posting To" = 0D then
            AllowPostingToDate := ''
        else
            AllowPostingToDate := Format(Rec."Allow Posting To", 0, '<Year4>-<Month,2>-<Day,2>');
    end;


}
