page 73013 "Spy Accounting Periods"
{
    APIGroup = 'integration';
    APIPublisher = 'spy';
    APIVersion = 'v1.0';
    Caption = 'SpyAccountingPeriodAPI';
    DelayedInsert = true;
    EntityName = 'SpyAccountingPeriod';
    EntitySetName = 'SpyAccountingPeriods';
    PageType = API;
    SourceTable = "Accounting Period";
    ODataKeyFields = SystemId;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(systemId; Rec.SystemId)
                {
                    Caption = 'SystemId';
                }

                field(startDate; Rec."Starting Date")
                {
                    Caption = 'Starting Date';
                }

                field(periodName; Rec."Name")
                {
                    Caption = 'Period Name';
                }

                field(closed; Rec."Closed")
                {
                    Caption = 'closed';
                }

                field(newFiscalYear; Rec."New Fiscal Year")
                {
                    Caption = 'New Fiscal Year';
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
    }
}
