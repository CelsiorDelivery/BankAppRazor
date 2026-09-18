using BankRazor.Models;
using BankRazor.Services;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;

namespace BankRazor.Pages;

public sealed class CloseAccountModel : PageModel
{
    private readonly BankService _bank;
    public CloseAccountModel(BankService bank) => _bank = bank;

    [BindProperty(SupportsGet = true)] public int CustomerId { get; set; }
    public Customer? Customer { get; set; }

    public IActionResult OnGet()
    {
        if (!IsLoggedIn()) return RedirectToPage("/Login");
        Customer = CustomerId == 0 ? null : _bank.GetCustomerById(CustomerId);
        return Page();
    }

    public IActionResult OnPost()
    {
        if (!IsLoggedIn()) return RedirectToPage("/Login");
        _bank.DeleteCustomer(CustomerId);
        TempData["Message"] = "Account closed. Farewell message recorded as customer deletion, matching the VB6 behavior.";
        return RedirectToPage("/CloseAccount");
    }

    private bool IsLoggedIn() => !string.IsNullOrWhiteSpace(HttpContext.Session.GetString("BankUser"));
}
