using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;

namespace BankRazor.Pages;

public sealed class IndexModel : PageModel
{
    public IActionResult OnGet()
    {
        return string.IsNullOrWhiteSpace(HttpContext.Session.GetString("BankUser"))
            ? RedirectToPage("/Login")
            : Page();
    }
}
