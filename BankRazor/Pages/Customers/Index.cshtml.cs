using BankRazor.Models;
using BankRazor.Services;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;

namespace BankRazor.Pages.Customers;

public sealed class IndexModel : PageModel
{
    private readonly BankService _bank;

    public IndexModel(BankService bank) => _bank = bank;

    public List<Customer> Customers { get; set; } = [];

    [BindProperty]
    public Customer Customer { get; set; } = new();

    [BindProperty]
    public bool IsNew { get; set; }

    [BindProperty(SupportsGet = true)]
    public int? AccountNo { get; set; }

    [BindProperty(SupportsGet = true)]
    public int? SearchAccountNo { get; set; }

    [BindProperty(SupportsGet = true)]
    public bool NewCustomer { get; set; }

    public IActionResult OnGet()
    {
        if (!IsLoggedIn()) return RedirectToPage("/Login");
        Load(AccountNo ?? SearchAccountNo, NewCustomer);
        return Page();
    }

    public IActionResult OnPostSave()
    {
        if (!IsLoggedIn()) return RedirectToPage("/Login");
        var validation = ValidateCustomer(Customer);
        if (validation is not null)
        {
            TempData["Message"] = validation;
            Load(Customer.AccountNo, IsNew);
            return Page();
        }

        TempData["Message"] = _bank.SaveCustomer(Customer, IsNew);
        return RedirectToPage("/Customers/Index", new { accountNo = Customer.AccountNo });
    }

    public IActionResult OnPostDelete()
    {
        if (!IsLoggedIn()) return RedirectToPage("/Login");
        _bank.DeleteCustomer(Customer.CustomerID);
        TempData["Message"] = "Customer deleted.";
        return RedirectToPage("/Customers/Index");
    }

    private void Load(int? accountNo, bool isNew)
    {
        Customers = _bank.GetCustomers();
        if (isNew)
        {
            var next = _bank.NextCustomerNumbers();
            Customer = new Customer
            {
                CustomerID = next.CustomerId,
                AccountNo = next.AccountNo,
                AccountType = "SAVINGS",
                DateOfOpen = DateTime.Today,
                Cheque = "NO",
                Relationstatus = "MAJOR"
            };
            IsNew = true;
            return;
        }

        Customer = accountNo.HasValue ? _bank.GetCustomerByAccount(accountNo.Value) ?? Customers.FirstOrDefault() ?? new Customer() : Customers.FirstOrDefault() ?? new Customer();
        IsNew = false;
    }

    private static string? ValidateCustomer(Customer customer)
    {
        if (string.IsNullOrWhiteSpace(customer.FirstName) || string.IsNullOrWhiteSpace(customer.LastName) ||
            string.IsNullOrWhiteSpace(customer.Nominee) || string.IsNullOrWhiteSpace(customer.Address))
        {
            return "Please ensure that all mandatory fields are complete.";
        }
        if (!string.IsNullOrWhiteSpace(customer.Pincode) && customer.Pincode.Length != 6) return "Pincode must be 6 digits.";
        if (!string.IsNullOrWhiteSpace(customer.PhoneNO) && customer.PhoneNO.Length != 8) return "Phone number must be 8 digits.";
        if (!string.IsNullOrWhiteSpace(customer.MobileNO) && customer.MobileNO.Length != 10) return "Mobile number must be 10 digits.";
        return null;
    }

    private bool IsLoggedIn() => !string.IsNullOrWhiteSpace(HttpContext.Session.GetString("BankUser"));
}
