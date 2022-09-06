xmlport 73091 SpyCustomerBalance
{
    UseDefaultNamespace = true;
    DefaultNamespace = 'urn:microsoft-dynamics-nav/xmlports/SpyCustomerBalance';
    FormatEvaluate = Xml;
    Direction = Export;

    schema
    {
        tableelement(customer; Customer)
        {
            MinOccurs = Zero;
            MaxOccurs = Unbounded;

            fieldelement(account; customer."No.")
            {
                MinOccurs = Once;
                MaxOccurs = Once;
            }
            fieldelement(balanceLcy; customer."Balance (LCY)")
            {
                MinOccurs = Zero;
                MaxOccurs = Once;
                trigger OnBeforePassField()
                var

                begin
                    customer.CalcFields("Balance (LCY)");
                end;
            }
            fieldelement(dueBalanceLcy; customer."Balance Due (LCY)")
            {
                MinOccurs = Zero;
                MaxOccurs = Once;
                trigger OnBeforePassField()
                var

                begin
                    customer.CalcFields("Balance Due (LCY)");
                end;
            }
        }

    }
}