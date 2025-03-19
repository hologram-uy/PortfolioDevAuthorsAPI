namespace DevAuthorsAPIRest.Model
{
    public class Author
    {
        public Guid AuthorId { get; set; }
        public string AuthorName { get; set; } = string.Empty;
        public string Country { get; set; } = string.Empty;
        public DateOnly BirthDate { get; set; }
        public string Website { get; set; } = string.Empty;
        public string Bio {  get; set; } = string.Empty;
    }
}