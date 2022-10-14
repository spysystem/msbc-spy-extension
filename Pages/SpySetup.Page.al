page 73001 "Spy Setup"
{
    Caption = 'SPY Setup';
    ApplicationArea = All;
    AdditionalSearchTerms = 'spy,spy set';
    PageType = Card;
    SourceTable = "Spy Setup";
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Default Journal Temp Name"; Rec."Default Journal Template Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Default Journal Temp Name field.';
                    TableRelation = "Gen. Journal Template";
                }
                field("Default Journal Batch Name"; Rec."Default Journal Batch Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Default Journal Batch Name.';
                    TableRelation = "Gen. Journal Batch";

                }

                field("Default Jnl Batch Description"; Rec."Default Jnl Batch Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Default Jnl Batch Description';


                }
                field("Gen. Bus. Posting Group"; Rec."Gen. Bus. Posting Group")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Gen. Bus. Posting Group field.';
                    TableRelation = "Gen. Business Posting Group";
                }
                field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Gen. Prod. Posting Group field.';
                    TableRelation = "Gen. Product Posting Group";
                }
                field("VAT Bus. Posting Group"; Rec."VAT Bus. Posting Group")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the VAT Bus. Posting Group field.';
                    TableRelation = "VAT Business Posting Group";
                }
                field("VAT Prod. Posting Group"; Rec."VAT Prod. Posting Group")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the VAT Prod. Posting Group field.';
                    TableRelation = "VAT Product Posting Group";
                }
                field("Template Type"; Rec."Default Template Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Template Type field.';
                }

            }
        }
    }

    actions
    {

        area(Creation)
        {
            action(DeleteVatSetup)
            {
                ApplicationArea = All;
                Caption = 'Delete VAT Registration No. Formats', comment = 'DAN="Slet CVR/SE format koder"';
                ToolTip = 'VAT Registration No. Formats will be deleted!', comment = 'DAN="CVR/SE format koder vil blive slettet!"';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = ClearLog;

                trigger OnAction()
                var
                    VatRegFormat: Record "VAT Registration No. Format";
                    VatRegDeleteWarningQst: label 'VAT Registration No. Formats will be deleted!', comment = 'DAN="CVR/SE format koder vil blive slettet!"';
                begin
                    if VatRegFormat.FindSet() then
                        if Confirm(VatRegDeleteWarningQst, false) then
                            VatRegFormat.DeleteAll();
                end;
            }

            action(CreateWS)
            {
                ApplicationArea = All;
                Caption = 'Create Web-Services', comment = 'DAN="Opret Webtjenester"';
                ToolTip = 'Create Web-Services', comment = 'DAN="Opret Webtjenester"';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Installments;

                trigger OnAction()
                var
                begin
                    InsertWebservice('SpyPaymentTerm', 4, 'page');
                    InsertWebservice('SpyCustomer', 73093, 'page');
                    InsertWebservice('SpySupplier', 26, 'page');
                    InsertWebservice('SpyLedgerAccount', 16, 'page');
                    InsertWebservice('SpyCustomerTemplate', 5157, 'page');
                    InsertWebservice('SpyCreateJournalLine', 73006, 'codeunit');
                    InsertWebservice('SpyCustomerTrans', 25, 'page');
                    InsertWebservice('SpySupplierTrans', 29, 'page');
                    InsertWebservice('SpyCalcCustomerBalance', 73008, 'codeunit');
                    InsertWebService('SpyGeneralJournalLine', 39, 'page');
                    InsertWebService('SpyJournalPage', 73084, 'page');
                    InsertWebService('SpyCustLedgerPage', 73085, 'page');
                    InsertWebService('SpyVendLedgerPage', 73086, 'page');
                    InsertWebService('SpyCountryPage', 10, 'page');
                    InsertWebservice('SpyExchangeRates', 483, 'page');
                    InsertWebservice('SpyLedgerTrans', 20, 'page');
                    InsertWebservice('SpyPostCode', 73089, 'page');
                    InsertWebservice('SpyTemplateLine', 73090, 'page');
                    InsertWebservice('SpyDefaultDimension', 73091, 'page');
                    InsertWebservice('SpyVatPostingSetup', 472, 'page');
                    InsertWebservice('SpyFieldsPage', 73092, 'page');
                    InsertWebservice('SpyApplyCustomerTemplates', 73009, 'codeunit');
                    InsertWebservice('SpyInsertPostCode', 73010, 'codeunit');
                end;
            }
        }
    }

    /// <summary>
    /// InsertWebservice.
    /// </summary>
    /// <param name="Name">text[100].</param>
    /// <param name="Id">Integer.</param>
    /// <param name="ObjType">text.</param>
    procedure InsertWebservice(Name: text[100]; Id: Integer; ObjType: text);
    var
        TenantWebService: record "Tenant Web Service";
    begin
        TenantWebService.setfilter("Service Name", Name);
        if TenantWebService.FindSet() then
            TenantWebService.Delete();

        TenantWebService.setfilter("Service Name", Name);
        if not TenantWebService.findset() then begin
            TenantWebService.Init();
            TenantWebService."Object ID" := Id;
            TenantWebService.Published := true;
            EVALUATE(TenantWebService."Object Type", ObjType);
            TenantWebService."Service Name" := Name;
            TenantWebService.Insert(true);
        end;
    end;
}
