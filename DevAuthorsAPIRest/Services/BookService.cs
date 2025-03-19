using System.Data;
using Dapper;
using DevAuthorsAPIRest.Model;
using DevAuthorsAPIRest.ServiceContracts;
using Microsoft.Data.SqlClient;

namespace DevAuthorsAPIRest.Services
{
    public class BookService:IBookService
    {
        private readonly string _connectionStr;

        public BookService(string connectionStr)
        {
            _connectionStr = connectionStr;
        }

        public async Task<Book?> GetBookByIdAsync(string isbn)
        {
            Book? book = null;

            try
            {
                if (string.IsNullOrEmpty(isbn))
                    throw new ArgumentNullException("Error: Book's ISBN must be specified.");

                using var connection = new SqlConnection(_connectionStr);
                await connection.OpenAsync();

                var param = new DynamicParameters();
                param.Add("@ISBN", isbn, DbType.String, ParameterDirection.Input, 20);

                book = await connection.QueryFirstOrDefaultAsync<Book>("GetBookById", param, commandType: CommandType.StoredProcedure);

                return book;

            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
                throw;
            }
        }

        public Task<List<Book>> GetBooksAsync(Author author)
        {
            throw new NotImplementedException();
        }

        public Task AddBookAsync(Book book)
        {
            throw new NotImplementedException();
        }

        public Task DeleteBookAsync(Book book)
        {
            throw new NotImplementedException();
        }

        public Task UpdateBookAsync(Book book)
        {
            throw new NotImplementedException();
        }
    }
}