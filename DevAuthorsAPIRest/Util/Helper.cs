using DevAuthorsAPIRest.DTO;
using DevAuthorsAPIRest.Model;
using System.Security.Cryptography.X509Certificates;

namespace DevAuthorsAPIRest.Util
{
    public static class Helper
    {
        public static UserDTO? ConvertUserToDTO(this User usr)
        {
            if (usr != null)
            {
                return new UserDTO
                {
                    UserName = usr.UserName,
                    UserEmail = usr.UserEmail,
                    Token = usr.Token
                };
            }

            return null;
        }
        public static BookDTO? ConvertBookToDTO(this Book book)
        {
            if (book != null)
            {
                return new BookDTO
                {
                    Title = book.Title,
                    PublishedYear = book.PublishedYear,
                    ISBN = book.ISBN,
                    Publisher = book.Publisher,
                    BookDescription = book.BookDescription
                };
            }

            return null;
        }
        public static AuthorDTO? ConvertAuthorToDTO(this Author author)
        {
            if (author != null)
            {
                return new AuthorDTO
                {
                    AuthorName = author.AuthorName,
                    Country = author.Country,
                    BirthDate = author.BirthDate,
                    Website = author.Website,
                    Bio = author.Bio
                };
            }

            return null;
        }
    }
}