page 73015 "SpyVATRegistrationNoFormat"
{
    APIGroup = 'integration';
    APIPublisher = 'spy';
    APIVersion = 'v1.0';
    Caption = 'VAT Registration No. Format API';
    DelayedInsert = true;
    EntityName = 'SpyVATRegistrationNoFormat';
    EntitySetName = 'SpyVATRegistrationNoFormats';
    PageType = API;
    SourceTable = "VAT Registration No. Format";
    ODataKeyFields = SystemId;

    layout
    {
        area(Content)
        {
            field("countryCode"; Rec."Country/Region Code")
            {
                Caption = 'Country Code';
            }

            field("lineNo"; Rec."Line No.")
            {
                Caption = 'Line No.';
            }

            field("format"; Rec.Format)
            {
                Caption = 'Format';
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
