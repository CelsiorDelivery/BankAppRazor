using System.Data;
using System.Data.OleDb;
using System.Globalization;
using BankRazor.Models;

namespace BankRazor.Services;

public sealed class BankService
{
    private readonly BankDb _db;

    public BankService(BankDb db) => _db = db;

    public bool ValidateLogin(string userName, string password)
    {
        var table = _db.Query("SELECT * FROM [LOGIN]");
        return table.Rows.Cast<DataRow>().Any(row =>
            string.Equals(Convert.ToString(row[0]), userName, StringComparison.OrdinalIgnoreCase) &&
            Convert.ToString(row[1]) == password);
    }

    public List<Customer> GetCustomers()
    {
        return _db.Query("SELECT * FROM tblCustomers ORDER BY CustomerID").Rows.Cast<DataRow>().Select(ToCustomer).ToList();
    }

    public Customer? GetCustomerByAccount(int accountNo)
    {
        var table = _db.Query("SELECT * FROM tblCustomers WHERE AccountNo=?", accountNo);
        return table.Rows.Count == 0 ? null : ToCustomer(table.Rows[0]);
    }

    public Customer? GetCustomerById(int customerId)
    {
        var table = _db.Query("SELECT * FROM tblCustomers WHERE CustomerID=?", customerId);
        return table.Rows.Count == 0 ? null : ToCustomer(table.Rows[0]);
    }

    public (int CustomerId, int AccountNo) NextCustomerNumbers()
    {
        var table = _db.Query("SELECT MAX(CustomerID) AS MaxCustomerID, MAX(AccountNo) AS MaxAccountNo FROM tblCustomers");
        var row = table.Rows[0];
        return (ToInt(row["MaxCustomerID"], 2000) + 1, ToInt(row["MaxAccountNo"], 100) + 1);
    }

    public string SaveCustomer(Customer customer, bool isNew)
    {
        var settings = GetSettings();
        var minimum = string.Equals(customer.Cheque, "YES", StringComparison.OrdinalIgnoreCase) ? settings.Cheque : settings.Nocheque;
        if (customer.Balance < minimum)
        {
            return $"Minimum balance is {minimum:0.##} for this account.";
        }

        if (isNew)
        {
            _db.Execute("""
                INSERT INTO tblCustomers
                (CustomerID, FirstName, MiddleName, LastName, AccountNo, DateOfOpen, Nominee, AccountType, Sex, Cheque, Relationstatus, Balance, Relationship, DOB, Address, Pincode, PhoneNO, MobileNO)
                VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
                """,
                customer.CustomerID, customer.FirstName, customer.MiddleName, customer.LastName,
                customer.AccountNo, customer.DateOfOpen, customer.Nominee, customer.AccountType, customer.Sex,
                customer.Cheque, customer.Relationstatus, customer.Balance, customer.Relationship, customer.DOB,
                customer.Address, customer.Pincode, customer.PhoneNO, customer.MobileNO);
        }
        else
        {
            _db.Execute("""
                UPDATE tblCustomers SET FirstName=?, MiddleName=?, LastName=?, DateOfOpen=?, Nominee=?, AccountType=?, Sex=?, Cheque=?, Relationstatus=?, Balance=?, Relationship=?, DOB=?, Address=?, Pincode=?, PhoneNO=?, MobileNO=?
                WHERE CustomerID=?
                """,
                customer.FirstName, customer.MiddleName, customer.LastName, customer.DateOfOpen,
                customer.Nominee, customer.AccountType, customer.Sex, customer.Cheque, customer.Relationstatus,
                customer.Balance, customer.Relationship, customer.DOB, customer.Address, customer.Pincode,
                customer.PhoneNO, customer.MobileNO, customer.CustomerID);
        }

        return "Customer details saved.";
    }

    public void DeleteCustomer(int customerId) => _db.Execute("DELETE FROM tblCustomers WHERE CustomerID=?", customerId);

    public AccountSettings GetSettings()
    {
        var table = _db.Query("SELECT * FROM tblAccount");
        return table.Rows.Count == 0 ? new AccountSettings { AccountID = 1, AccountType = "SAVINGS", Cheque = 1500, Nocheque = 1000, InterestRate = 0 } : ToSettings(table.Rows[0]);
    }

    public void SaveSettings(AccountSettings settings)
    {
        _db.Execute("UPDATE tblAccount SET AccountType=?, Cheque=?, Nocheque=?, InterestRate=? WHERE AccountID=?",
            settings.AccountType, settings.Cheque, settings.Nocheque, settings.InterestRate, settings.AccountID);
    }

    public int NextTransactionId()
    {
        var table = _db.Query("SELECT MAX(TransactionID) AS MaxTransactionID FROM tblTransaction");
        return ToInt(table.Rows[0]["MaxTransactionID"], 0) + 1;
    }

    public string Deposit(int accountNo, decimal amount, string mode, string chequeNo, string bankName, DateTime date)
    {
        if (amount <= 0) return "Please enter an amount greater than zero.";
        var customer = GetCustomerByAccount(accountNo);
        if (customer is null) return "Invalid account number.";
        if (string.Equals(mode, "Cheque", StringComparison.OrdinalIgnoreCase) && (string.IsNullOrWhiteSpace(chequeNo) || chequeNo.Length > 6 || string.IsNullOrWhiteSpace(bankName)))
        {
            return "Cheque deposits require a bank name and a cheque number up to 6 digits.";
        }

        var newBalance = customer.Balance + amount;
        InsertTransaction(customer, "Deposit", amount, newBalance, mode, chequeNo, bankName, date, "");
        return "Deposit transaction saved and balance updated.";
    }

    public string Withdraw(int accountNo, decimal amount, DateTime date)
    {
        if (amount <= 0) return "Please enter an amount greater than zero.";
        var customer = GetCustomerByAccount(accountNo);
        if (customer is null) return "Invalid account number.";
        if (customer.Balance <= amount) return "You do not have enough balance.";
        var settings = GetSettings();
        var minimum = string.Equals(customer.Cheque, "YES", StringComparison.OrdinalIgnoreCase) ? settings.Cheque : settings.Nocheque;
        var newBalance = customer.Balance - amount;
        if (newBalance < minimum) return $"Balance should remain at least {minimum:0.##} for this account.";

        InsertTransaction(customer, "Withdraw", amount, newBalance, "N/A", "", "", date, "");
        return "Withdrawal transaction saved and balance updated.";
    }

    public string AddInterest(int accountNo, string month, int year, DateTime date)
    {
        var customer = GetCustomerByAccount(accountNo);
        if (customer is null) return "Invalid account number.";
        var period = $"{month}/{year}";
        var duplicate = _db.Query("SELECT * FROM tblTransaction WHERE AccountNo=? AND [Month]=?", accountNo, period);
        if (duplicate.Rows.Count > 0) return "Interest has already been given for this month.";

        var settings = GetSettings();
        var interest = customer.Balance * settings.InterestRate / 100m;
        var newBalance = customer.Balance + interest;
        InsertTransaction(customer, "Interest", interest, newBalance, "N/A", "", "", date, period);
        return $"Interest of {interest:0.##} saved and balance updated.";
    }

    public List<BankTransaction> GetTransactions(DateTime? from = null, DateTime? to = null, int? customerId = null, DateTime? exactDate = null)
    {
        var filters = new List<string>();
        var parameters = new List<object?>();
        if (exactDate.HasValue)
        {
            filters.Add("t.[Date]=?");
            parameters.Add(exactDate.Value.Date);
        }
        if (from.HasValue)
        {
            filters.Add("t.[Date]>=?");
            parameters.Add(from.Value.Date);
        }
        if (to.HasValue)
        {
            filters.Add("t.[Date]<=?");
            parameters.Add(to.Value.Date);
        }
        if (customerId.HasValue)
        {
            filters.Add("t.CustomerID=?");
            parameters.Add(customerId.Value);
        }

        var where = filters.Count == 0 ? "" : " WHERE " + string.Join(" AND ", filters);
        var sql = $"""
            SELECT t.*, c.FirstName, c.MiddleName, c.LastName
            FROM tblTransaction AS t LEFT JOIN tblCustomers AS c ON t.CustomerID = c.CustomerID
            {where}
            ORDER BY t.[Date] DESC, t.TransactionID DESC
            """;
        return _db.Query(sql, parameters.ToArray()).Rows.Cast<DataRow>().Select(ToTransaction).ToList();
    }

    private void InsertTransaction(Customer customer, string type, decimal amount, decimal newBalance, string mode, string chequeNo, string bankName, DateTime date, string month)
    {
        _db.Transaction((connection, transaction) =>
        {
            var transactionId = NextTransactionId(connection, transaction);
            using var insert = BankDb.Command(connection, transaction, """
                INSERT INTO tblTransaction (TransactionID, CustomerID, AccountNo, Balance, TransactionType, Amount, Mode, ChequeNo, [Date], BankName, [Month])
                VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
                """,
                transactionId, customer.CustomerID, customer.AccountNo, newBalance, type, amount, mode, chequeNo, date.Date, bankName, month);
            insert.ExecuteNonQuery();
            using var update = BankDb.Command(connection, transaction, "UPDATE tblCustomers SET Balance=? WHERE CustomerID=?", newBalance, customer.CustomerID);
            update.ExecuteNonQuery();
            return transactionId;
        });
    }

    private static int NextTransactionId(OleDbConnection connection, OleDbTransaction transaction)
    {
        using var command = BankDb.Command(connection, transaction, "SELECT MAX(TransactionID) FROM tblTransaction");
        return ToInt(command.ExecuteScalar(), 0) + 1;
    }

    private static Customer ToCustomer(DataRow row) => new()
    {
        CustomerID = ToInt(row["CustomerID"]),
        ContactTitle = ToString(row, "ContactTitle"),
        FirstName = ToString(row, "FirstName"),
        MiddleName = ToString(row, "MiddleName"),
        LastName = ToString(row, "LastName"),
        AccountNo = ToInt(row["AccountNo"]),
        DateOfOpen = ToDate(row, "DateOfOpen"),
        Nominee = ToString(row, "Nominee"),
        AccountType = ToString(row, "AccountType"),
        Sex = ToString(row, "Sex"),
        Cheque = ToString(row, "Cheque"),
        Relationstatus = ToString(row, "Relationstatus"),
        Balance = ToDecimal(row["Balance"]),
        Relationship = ToString(row, "Relationship"),
        DOB = ToDate(row, "DOB"),
        Address = ToString(row, "Address"),
        Pincode = ToString(row, "Pincode"),
        PhoneNO = ToString(row, "PhoneNO"),
        MobileNO = ToString(row, "MobileNO"),
        EmailID = ToString(row, "EmailID")
    };

    private static AccountSettings ToSettings(DataRow row) => new()
    {
        AccountID = ToInt(row["AccountID"]),
        AccountType = ToString(row, "AccountType"),
        Cheque = ToDecimal(row["Cheque"]),
        Nocheque = ToDecimal(row["Nocheque"]),
        InterestRate = ToDecimal(row["InterestRate"])
    };

    private static BankTransaction ToTransaction(DataRow row) => new()
    {
        TransactionID = ToInt(row["TransactionID"]),
        CustomerID = ToInt(row["CustomerID"]),
        AccountNo = ToInt(row["AccountNo"]),
        Balance = ToDecimal(row["Balance"]),
        TransactionType = ToString(row, "TransactionType"),
        Amount = ToDecimal(row["Amount"]),
        Mode = ToString(row, "Mode"),
        ChequeNo = ToString(row, "ChequeNo"),
        Date = ToDate(row, "Date"),
        BankName = ToString(row, "BankName"),
        Month = ToString(row, "Month"),
        CustomerName = string.Join(" ", new[] { ToString(row, "FirstName"), ToString(row, "MiddleName"), ToString(row, "LastName") }.Where(x => !string.IsNullOrWhiteSpace(x)))
    };

    private static string ToString(DataRow row, string name) => row.Table.Columns.Contains(name) && row[name] != DBNull.Value ? Convert.ToString(row[name]) ?? "" : "";
    private static int ToInt(object? value, int fallback = 0) => value is null || value == DBNull.Value || string.IsNullOrWhiteSpace(Convert.ToString(value)) ? fallback : Convert.ToInt32(value);
    private static decimal ToDecimal(object? value) => value is null || value == DBNull.Value || string.IsNullOrWhiteSpace(Convert.ToString(value)) ? 0 : Convert.ToDecimal(value);
    private static DateTime? ToDate(DataRow row, string name)
    {
        if (!row.Table.Columns.Contains(name) || row[name] == DBNull.Value)
        {
            return null;
        }

        if (row[name] is DateTime date)
        {
            return date;
        }

        var value = Convert.ToString(row[name]);
        if (string.IsNullOrWhiteSpace(value))
        {
            return null;
        }

        string[] formats = ["d/M/yyyy", "dd/MM/yyyy", "M/d/yyyy", "MM/dd/yyyy", "d-M-yyyy", "dd-MM-yyyy"];
        return DateTime.TryParseExact(value, formats, CultureInfo.InvariantCulture, DateTimeStyles.None, out var parsed) ||
               DateTime.TryParse(value, CultureInfo.CurrentCulture, DateTimeStyles.None, out parsed)
            ? parsed
            : null;
    }
}
