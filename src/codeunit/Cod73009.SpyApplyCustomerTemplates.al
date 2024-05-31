codeunit 73009 "SpyApplyCustomerTemplates"
{
    Procedure ApplyTemplates(Customer: Code[20]; CountryType: Text[3])
    var
        DimensionsTemplate: Record "Dimensions Template";
        lCustomer: Record Customer;
        ConfigTemplateHeader: Record "Config. Template Header";
        ConfigTemplateManagement: Codeunit "Config. Template Management";
        CustomerRecordRef: RecordRef;
        Country: Text;
    begin
        if lCustomer.GET(Customer) then begin
            CustomerRecordRef.GETTABLE(lCustomer);
            Country := lCustomer."Country/Region Code";

            IF ConfigTemplateHeader.GET('SPYCUS') THEN BEGIN
                ConfigTemplateManagement.UpdateRecord(ConfigTemplateHeader, CustomerRecordRef);
                DimensionsTemplate.InsertDimensionsFromTemplates(ConfigTemplateHeader, lCustomer."No.", DATABASE::Customer);

            END;
            IF ConfigTemplateHeader.GET('SPYCUS-' + UpperCase(CountryType)) THEN BEGIN
                ConfigTemplateManagement.UpdateRecord(ConfigTemplateHeader, CustomerRecordRef);
                DimensionsTemplate.InsertDimensionsFromTemplates(ConfigTemplateHeader, lCustomer."No.", DATABASE::Customer);

            END;

            IF ConfigTemplateHeader.GET('SPYCUS-' + UpperCase(Country)) THEN BEGIN
                ConfigTemplateManagement.UpdateRecord(ConfigTemplateHeader, CustomerRecordRef);
                DimensionsTemplate.InsertDimensionsFromTemplates(ConfigTemplateHeader, lCustomer."No.", DATABASE::Customer);

            END;
        end;
    end;

}