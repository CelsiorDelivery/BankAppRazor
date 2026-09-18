using BankRazor.Models;
using BankRazor.Services;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;

namespace BankRazor.Pages.Reports;

public sealed class DailyModel : PageModel
{
    private readonly BankService _bank;
    public DailyModel(BankService bank) => _bank = bank;

    [BindProperty(SupportsGet = true)] public DateTime Date { get; set; } = DateTime.Today;
    public List<BankTransaction> Transactions { get; set; } = [];

    public IActionResult OnGet()
    {
        if (string.IsNullOrWhiteSpace(HttpContext.Session.GetString("BankUser"))) return RedirectToPage("/Login");
        Transactions = _bank.GetTransactions(exactDate: Date);
        return Page();
    }
}
