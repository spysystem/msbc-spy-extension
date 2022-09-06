codeunit 73008 SpyCalcCustomerBalance
{

    trigger OnRun()
    begin

    end;

    /// <summary>
    /// calcCustomerBalance.
    /// </summary>
    [ServiceEnabled]
    procedure calcCustomerBalance()
    var
        Customer: record Customer;
    begin

        Customer.CalcFields("Balance (LCY)", "Balance Due (LCY)");
        Customer.FindSet();

    end;

    /// <summary>
    /// ping. - For testing if service is alive.
    /// </summary>
    /// <returns>Return value of type Text.</returns>
    procedure ping(): Text
    var
    begin
        Exit('Pong');
    end;

    var

}