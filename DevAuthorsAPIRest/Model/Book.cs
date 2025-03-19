using Microsoft.Extensions.Diagnostics.HealthChecks;

namespace DevAuthorsAPIRest.Model
{
    public class Book
    {
        public Guid BookId { get; init; }
        public string Title { get; set; } = string.Empty;
        public int PublishedYear { get; set; }
        public string ISBN { get; set; } = string.Empty;
        public string Publisher { get; set; } = string.Empty;
        public string BookDescription {  get; set; } = string.Empty;
    }
}