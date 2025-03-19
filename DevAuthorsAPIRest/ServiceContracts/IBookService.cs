using DevAuthorsAPIRest.Model;

namespace DevAuthorsAPIRest.ServiceContracts
{
    public interface IBookService
    {
        Task<Book?> GetBookByIdAsync(string isbn);
        Task<List<Book>> GetBooksAsync(Author author);
        Task AddBookAsync(Book book);
        Task DeleteBookAsync(Book book);
        Task UpdateBookAsync(Book book);
    }
}
