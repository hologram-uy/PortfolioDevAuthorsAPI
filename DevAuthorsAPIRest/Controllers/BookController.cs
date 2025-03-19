using DevAuthorsAPIRest.ServiceContracts;
using DevAuthorsAPIRest.DTO;
using Microsoft.AspNetCore.Mvc;
using DevAuthorsAPIRest.Util;

namespace DevAuthorsAPIRest.Controllers
{
    [Route("api/[Controller]")]
    [ApiController]
    public class BookController : Controller
    {
        private readonly IBookService _bookService;

        public BookController(IBookService bookService)
        {
            _bookService = bookService;
        }

        [HttpGet]
        public async Task<IActionResult> GetBookById(string isbn)
        {
            try
            {
                var book = await _bookService.GetBookByIdAsync(isbn);

                if (book == null)
                    return NotFound();
                    
                return Ok(book.ConvertBookToDTO());
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
                return StatusCode(500, "Error: GetBookById | BookController");
            }
        }
    }
}
