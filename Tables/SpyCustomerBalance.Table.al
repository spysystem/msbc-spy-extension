table 73091 "Spy Customer Balance"
{
    Caption = 'Spy Customer Balance';
    fields
    {

        field(10; account; Code[20])//customer."No.")
        {
            caption = 'account';

        }
        field(20; balanceLcy; Decimal)// customer."Balance (LCY)")
        {

            //customer.CalcFields("Balance (LCY)");

        }
        field(30; dueBalanceLcy; Decimal)//customer."Balance Due (LCY)")
        {

            //customer.CalcFields("Balance Due (LCY)");

        }
    }

    keys
    {
        key(Key1; account)
        {
            Clustered = true;
        }

    }

}