using BankRazor.Services;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;

namespace BankRazor.Pages;

public sealed class LoginModel : PageModel
{
    private readonly BankService _bank;

    public LoginModel(BankService bank) => _bank = bank;

    [BindProperty]
    public string UserName { get; set; } = "";

    [BindProperty]
    public string Password { get; set; } = "";

    public string ErrorMessage { get; set; } = "";

    public IActionResult OnPost()
    {
        if (_bank.ValidateLogin(UserName, Password))
        {
            HttpContext.Session.SetString("BankUser", UserName);
            return RedirectToPage("/Index");
        }

        ErrorMessage = "Invalid Username or Password.";
        return Page();
    }
}
