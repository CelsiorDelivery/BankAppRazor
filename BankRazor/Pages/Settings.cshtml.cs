using BankRazor.Models;
using BankRazor.Services;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;

namespace BankRazor.Pages;

public sealed class SettingsModel : PageModel
{
    private readonly BankService _bank;
    public SettingsModel(BankService bank) => _bank = bank;

    [BindProperty] public AccountSettings Settings { get; set; } = new();

    public IActionResult OnGet()
    {
        if (!IsLoggedIn()) return RedirectToPage("/Login");
        Settings = _bank.GetSettings();
        return Page();
    }

    public IActionResult OnPost()
    {
        if (!IsLoggedIn()) return RedirectToPage("/Login");
        _bank.SaveSettings(Settings);
        TempData["Message"] = "Settings saved.";
        return RedirectToPage("/Settings");
    }

    private bool IsLoggedIn() => !string.IsNullOrWhiteSpace(HttpContext.Session.GetString("BankUser"));
}
