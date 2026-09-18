using BankRazor.Models;
using BankRazor.Services;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;

namespace BankRazor.Pages.Transactions;

public sealed class InterestModel : PageModel
{
    private readonly BankService _bank;
    public InterestModel(BankService bank) => _bank = bank;

    public string[] Months { get; } = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];
    [BindProperty(SupportsGet = true)] public int AccountNo { get; set; }
    [BindProperty] public string Month { get; set; } = DateTime.Today.ToString("MMMM");
    [BindProperty] public int Year { get; set; } = DateTime.Today.Year;
    [BindProperty] public DateTime Date { get; set; } = DateTime.Today;
    public Customer? Customer { get; set; }
    public int NextTransactionId { get; set; }
    public decimal InterestRate { get; set; }

    public IActionResult OnGet()
    {
        if (!IsLoggedIn()) return RedirectToPage("/Login");
        Load();
        return Page();
    }

    public IActionResult OnPost()
    {
        if (!IsLoggedIn()) return RedirectToPage("/Login");
        TempData["Message"] = _bank.AddInterest(AccountNo, Month, Year, Date);
        return RedirectToPage("/Transactions/Interest", new { accountNo = AccountNo });
    }

    private void Load()
    {
        Customer = AccountNo == 0 ? null : _bank.GetCustomerByAccount(AccountNo);
        NextTransactionId = _bank.NextTransactionId();
        InterestRate = _bank.GetSettings().InterestRate;
    }

    private bool IsLoggedIn() => !string.IsNullOrWhiteSpace(HttpContext.Session.GetString("BankUser"));
}
