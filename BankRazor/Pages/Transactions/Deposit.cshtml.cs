using BankRazor.Models;
using BankRazor.Services;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;

namespace BankRazor.Pages.Transactions;

public sealed class DepositModel : PageModel
{
    private readonly BankService _bank;
    public DepositModel(BankService bank) => _bank = bank;

    [BindProperty(SupportsGet = true)] public int AccountNo { get; set; }
    [BindProperty] public decimal Amount { get; set; }
    [BindProperty] public string Mode { get; set; } = "Cash";
    [BindProperty] public string ChequeNo { get; set; } = "";
    [BindProperty] public string BankName { get; set; } = "";
    [BindProperty] public DateTime Date { get; set; } = DateTime.Today;
    public int NextTransactionId { get; set; }
    public Customer? Customer { get; set; }

    public IActionResult OnGet()
    {
        if (!IsLoggedIn()) return RedirectToPage("/Login");
        Load();
        return Page();
    }

    public IActionResult OnPost()
    {
        if (!IsLoggedIn()) return RedirectToPage("/Login");
        TempData["Message"] = _bank.Deposit(AccountNo, Amount, Mode, ChequeNo, BankName, Date);
        return RedirectToPage("/Transactions/Deposit", new { accountNo = AccountNo });
    }

    private void Load()
    {
        NextTransactionId = _bank.NextTransactionId();
        Customer = AccountNo == 0 ? null : _bank.GetCustomerByAccount(AccountNo);
    }

    private bool IsLoggedIn() => !string.IsNullOrWhiteSpace(HttpContext.Session.GetString("BankUser"));
}
