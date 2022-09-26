permissionset 73002 SpyPermissionsSet
{
    Assignable = true;
    Caption = 'Spy Permissions', MaxLength = 30;
    Permissions =
        table "Spy Customer Balance" = X,
        tabledata "Spy Customer Balance" = RMID,
        table "Spy Setup" = X,
        tabledata "Spy Setup" = RMID,
        table "Spy Dimension" = X,
        tabledata "Spy Dimension" = RMID,
        table "Spy Journal Line" = X,
        tabledata "Spy Journal Line" = RMID,
        codeunit SpyCreateJournalLine = X,
        codeunit SpyApplyCustomerTemplates = X,
        codeunit SpyCalcCustomerBalance = X,
        codeunit SpyUpgrade = X,
        codeunit SpyInsertPostCode = X,
        codeunit "Spy Install" = X,
        page "Spy Setup" = X,
        page SpyCreateJournalLineAPI = X,
        page "Spy Customer Ledger Entry" = X,
        page "Spy Customer List" = X,
        page "Spy Default Dimension" = X,
        page "Spy Fields" = X,
        page "Spy Journal" = X,
        page SpyListJournalBatches = X,
        page "Spy Post Code" = X,
        page SpyTempJournalLines = X,
        page "Spy Template Line" = X,
        page "Spy Vendor Ledger Entry" = X,
        xmlport SpyCustomerBalance = X,
        xmlport SpyXmlCreateJournalLine = X;

}
