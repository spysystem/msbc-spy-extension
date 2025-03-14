codeunit 73040 "SpyHooks"
{
    [EventSubscriber(ObjectType::Table, Database::Vendor, 'OnBeforeValidateEvent', 'No.', false, false)]
    local procedure CheckVendorNumberSeriesConfiguration(var Rec: Record Vendor; var xRec: Record Vendor; CurrFieldNo: Integer)
    var
        PurchaseSetup: Record "Purchases & Payables Setup";
        VendorNoSeries: Record "No. Series";
    begin
        if GuiAllowed then
            exit;

        // Make sure that if we have a number series configured for Suppliers, that it exists and is allowing manual numbers
        if not PurchaseSetup.Get() then
            exit;

        if PurchaseSetup."Vendor Nos." = '' then
            exit;

        if VendorNoSeries.Get(PurchaseSetup."Vendor Nos.") then begin
            if not VendorNoSeries."Manual Nos." then begin
                VendorNoSeries."Manual Nos." := true;
                VendorNoSeries.Modify();
            end;

            exit;
        end;

        // If we reach this point, then the No. series does not exist and we clear it from the setup
        PurchaseSetup."Vendor Nos." := '';
        PurchaseSetup.Modify();

    end;

    [EventSubscriber(ObjectType::Table, Database::Customer, 'OnBeforeTestNoSeries', '', false, false)]
    local procedure CheckCustomerNumberSeriesConfiguration(var Customer: Record Customer; xCustomer: Record Customer; var IsHandled: Boolean)
    var
        SalesSetup: Record "Sales & Receivables Setup";
        CustomerNoSeries: Record "No. Series";
    begin

        if GuiAllowed then
            exit;

        #region validate number series for customers
        // Make sure that if we have a number series configured for Customers, that it exists and is allowing manual numbers
        if not SalesSetup.Get() then
            exit;

        if SalesSetup."Customer Nos." = '' then
            exit;

        if CustomerNoSeries.Get(SalesSetup."Customer Nos.") then begin
            if not CustomerNoSeries."Manual Nos." then begin
                CustomerNoSeries."Manual Nos." := true;
                CustomerNoSeries.Modify();
            end;

            exit;
        end;

        // If we reach this point, then the No. series does not exist and we clear it from the setup
        SalesSetup."Customer Nos." := '';
        SalesSetup.Modify();
        #endregion
    end;

}
