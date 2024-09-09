page 73014 "SpyPaymentTermV2"
{
    APIGroup = 'integration';
    APIPublisher = 'spy';
    APIVersion = 'v1.0';
    Caption = 'Payment Terms API';
    DelayedInsert = true;
    EntityName = 'SpyPaymentTermV2';
    EntitySetName = 'SpyPaymentTermsV2';
    PageType = API;
    SourceTable = "Payment Terms";
    ODataKeyFields = SystemId;

    layout
    {
        area(Content)
        {
            field("code"; Rec.Code)
            {
                Caption = 'Code';
            }

            field("dueDateCalculation"; Rec."Due Date Calculation")
            {
                Caption = 'Due Date Calculation';
            }

            field("discountDateCalculation"; Rec."Discount Date Calculation")
            {
                Caption = 'Discount Date Calculation';
            }

            field("discountPercentage"; Rec."Discount %")
            {
                Caption = 'Discount %';
            }

            field("calculateDiscountOnCreditNotes"; Rec."Calc. Pmt. Disc. on Cr. Memos")
            {
                Caption = 'Calculate Discount On Credit Notes';
            }

            field(description; Rec.Description)
            {
                Caption = 'Description';
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
}
