using BankRazor.Models;
using BankRazor.Services;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;

namespace BankRazor.Pages.Reports;

public sealed class BetweenDatesModel : PageModel
{
    private readonly BankService _bank;
    public BetweenDatesModel(BankService bank) => _bank = bank;

    [BindProperty(SupportsGet = true)] public DateTime From { get; set; } = DateTime.Today.AddMonths(-1);
    [BindProperty(SupportsGet = true)] public DateTime To { get; set; } = DateTime.Today;
    public List<BankTransaction> Transactions { get; set; } = [];

    public IActionResult OnGet()
    {
        if (string.IsNullOrWhiteSpace(HttpContext.Session.GetString("BankUser"))) return RedirectToPage("/Login");
        if (From > To) (From, To) = (To, From);
        Transactions = _bank.GetTransactions(from: From, to: To);
        return Page();
    }
}
