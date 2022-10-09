codeunit 73005 "Spy Install"
{
    Subtype = Install;

    trigger OnInstallAppPerCompany()
    var
    //VatRegFormat: Record "VAT Registration No. Format";
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

        // Slet eventuelle CVR format records TODO: Perhaps move to Guided Setup, so the customer will know they're deleting this data?
        //if VatRegFormat.FindSet() then
        //    VatRegFormat.DeleteAll();
    end;

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

    procedure CreateDefaultSetup()
    var
    SpySetup: Record "Spy Setup";
    begin
        SpySetup.Init();
        SpySetup."Default Jnl Batch Description" := 'Spy Description';
        SpySetup."Default Journal Batch Name" := ''
    end;
}