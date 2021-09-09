using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Threading;
using System;

namespace sqlworker
{
    public class Worker : BackgroundService
    {
        private readonly ILogger<Worker> _logger;
        private readonly IConfiguration _configuration;
        private readonly List<string> _servers;

        public Worker(ILogger<Worker> logger, IConfiguration configRoot)
        {
            _logger = logger;
            _configuration = configRoot;
            _servers = new List<string> { "std", "proxy", "private" };
        }

        protected override async Task ExecuteAsync(CancellationToken stoppingToken)
        {
            while (!stoppingToken.IsCancellationRequested)
            {
                _logger.LogInformation("Worker running at: {time}", DateTimeOffset.Now);

                foreach (var server in _servers)
                {
                    try
                    {
                        SqlConnectionStringBuilder builder = new SqlConnectionStringBuilder();

                        builder.ConnectionString = _configuration.GetConnectionString("std");

                        using (SqlConnection connection = new SqlConnection(builder.ConnectionString))
                        {
                            Console.WriteLine("\nQuery data example:");
                            Console.WriteLine("=========================================\n");

                            connection.Open();

                            String sql = "SELECT name, collation_name FROM sys.databases";

                            using (SqlCommand command = new SqlCommand(sql, connection))
                            {
                                using (SqlDataReader reader = command.ExecuteReader())
                                {
                                    while (reader.Read())
                                    {
                                        Console.WriteLine("{0} {1}", reader.GetString(0), reader.GetString(1));
                                    }
                                }
                            }
                        }
                    }
                    catch (SqlException e)
                    {
                        Console.WriteLine(e.ToString());
                    }
                    await Task.Delay(1000, stoppingToken);
                }
            }
        }
    }
}
