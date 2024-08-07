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

        // Make sure that we are allowed to set the number series manually and that a number series is set

        if PurchaseSetup.Get() then begin
            if PurchaseSetup."Vendor Nos." <> '' then begin
                VendorNoSeries.Get(PurchaseSetup."Vendor Nos.");
                if not VendorNoSeries."Manual Nos." then begin
                    VendorNoSeries."Manual Nos." := true;
                    VendorNoSeries.Modify();
                end;
            end;
        end;

    end;

    [EventSubscriber(ObjectType::Table, Database::Customer, 'OnBeforeTestNoSeries', '', false, false)]
    local procedure CheckCustomerNumberSeriesConfiguration(var Customer: Record Customer; xCustomer: Record Customer; var IsHandled: Boolean)
    var
        SalesSetup: Record "Sales & Receivables Setup";
        CustomerNoSeries: Record "No. Series";
    begin

        if GuiAllowed then
            exit;

        // Make sure that we are allowed to set the number series manually and that a number series is set
        if SalesSetup.Get() then begin
            if SalesSetup."Customer Nos." <> '' then begin
                CustomerNoSeries.Get(SalesSetup."Customer Nos.");
                if not CustomerNoSeries."Manual Nos." then begin
                    CustomerNoSeries."Manual Nos." := true;
                    CustomerNoSeries.Modify();
                end;
            end;
        end;
    end;

}
