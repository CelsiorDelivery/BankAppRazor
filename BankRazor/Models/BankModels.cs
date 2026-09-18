namespace BankRazor.Models;

public sealed class Customer
{
    public int CustomerID { get; set; }
    public string ContactTitle { get; set; } = "";
    public string FirstName { get; set; } = "";
    public string MiddleName { get; set; } = "";
    public string LastName { get; set; } = "";
    public int AccountNo { get; set; }
    public DateTime? DateOfOpen { get; set; }
    public string Nominee { get; set; } = "";
    public string AccountType { get; set; } = "SAVINGS";
    public string Sex { get; set; } = "";
    public string Cheque { get; set; } = "NO";
    public string Relationstatus { get; set; } = "MAJOR";
    public decimal Balance { get; set; }
    public string Relationship { get; set; } = "";
    public DateTime? DOB { get; set; }
    public string Address { get; set; } = "";
    public string Pincode { get; set; } = "";
    public string PhoneNO { get; set; } = "";
    public string MobileNO { get; set; } = "";
    public string EmailID { get; set; } = "";
    public string FullName => string.Join(" ", new[] { FirstName, MiddleName, LastName }.Where(x => !string.IsNullOrWhiteSpace(x)));
}

public sealed class AccountSettings
{
    public int AccountID { get; set; }
    public string AccountType { get; set; } = "SAVINGS";
    public decimal Cheque { get; set; }
    public decimal Nocheque { get; set; }
    public decimal InterestRate { get; set; }
}

public sealed class BankTransaction
{
    public int TransactionID { get; set; }
    public int CustomerID { get; set; }
    public int AccountNo { get; set; }
    public decimal Balance { get; set; }
    public string TransactionType { get; set; } = "";
    public decimal Amount { get; set; }
    public string Mode { get; set; } = "";
    public string ChequeNo { get; set; } = "";
    public DateTime? Date { get; set; }
    public string BankName { get; set; } = "";
    public string Month { get; set; } = "";
    public string CustomerName { get; set; } = "";
}
