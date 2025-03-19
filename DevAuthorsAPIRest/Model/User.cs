namespace DevAuthorsAPIRest.Model
{
    public class User
    {
        public int Id { get; init; }
        public string UserEmail { get; set; } = string.Empty;
        public string UserName { get; set; } = string.Empty;
        public string Token { get; set; } = string.Empty;
    }
}