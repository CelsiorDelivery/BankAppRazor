using BankRazor.Models;
using BankRazor.Services;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;

namespace BankRazor.Pages.Transactions;

public sealed class WithdrawModel : PageModel
{
    private readonly BankService _bank;
    public WithdrawModel(BankService bank) => _bank = bank;

    [BindProperty(SupportsGet = true)] public int AccountNo { get; set; }
    [BindProperty] public decimal Amount { get; set; }
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
        TempData["Message"] = _bank.Withdraw(AccountNo, Amount, Date);
        return RedirectToPage("/Transactions/Withdraw", new { accountNo = AccountNo });
    }

    private void Load()
    {
        NextTransactionId = _bank.NextTransactionId();
        Customer = AccountNo == 0 ? null : _bank.GetCustomerByAccount(AccountNo);
    }

    private bool IsLoggedIn() => !string.IsNullOrWhiteSpace(HttpContext.Session.GetString("BankUser"));
}
