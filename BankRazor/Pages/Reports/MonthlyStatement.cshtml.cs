using BankRazor.Models;
using BankRazor.Services;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;

namespace BankRazor.Pages.Reports;

public sealed class MonthlyStatementModel : PageModel
{
    private readonly BankService _bank;
    public MonthlyStatementModel(BankService bank) => _bank = bank;

    [BindProperty(SupportsGet = true)] public int CustomerId { get; set; }
    [BindProperty(SupportsGet = true)] public DateTime From { get; set; } = new(DateTime.Today.Year, DateTime.Today.Month, 1);
    [BindProperty(SupportsGet = true)] public DateTime To { get; set; } = DateTime.Today;
    public List<Customer> Customers { get; set; } = [];
    public List<BankTransaction> Transactions { get; set; } = [];

    public IActionResult OnGet()
    {
        if (string.IsNullOrWhiteSpace(HttpContext.Session.GetString("BankUser"))) return RedirectToPage("/Login");
        Customers = _bank.GetCustomers();
        var selected = CustomerId == 0 ? Customers.FirstOrDefault()?.CustomerID : CustomerId;
        CustomerId = selected ?? 0;
        Transactions = CustomerId == 0 ? [] : _bank.GetTransactions(from: From, to: To, customerId: CustomerId);
        return Page();
    }
}
