namespace DevAuthorsAPIRest.Database
{
    public class Connection
    {
        public string ConnectionString { get; }

        public Connection(IConfiguration conf)
        {
            ConnectionString = conf.GetConnectionString("EcoRouteDB")
                ?? throw new Exception("Connection string not found.");
        }
    }
}