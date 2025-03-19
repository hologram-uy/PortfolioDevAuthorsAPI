namespace DevAuthorsAPIRest.DTO
{
    public class BookDTO
    {
        public string Title { get; set; } = string.Empty;
        public int PublishedYear { get; set; }
        public string ISBN { get; set; } = string.Empty;
        public string Publisher { get; set; } = string.Empty;
        public string BookDescription { get; set; } = string.Empty;
    }
}
