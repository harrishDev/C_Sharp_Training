using Microsoft.Data.SqlClient;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ProjectManagement.util
{
    public class DBConnUtil
    {
        public static SqlConnection GetConnection()
        {
            try
            {
                string connStr = DBPropertyUtil.GetConnectionString("db.properties");

                if (string.IsNullOrWhiteSpace(connStr))
                {
                    throw new InvalidOperationException("Connection string is null or empty.");
                }

                return new SqlConnection(connStr);
            }
            catch (Exception ex)
            {
                Console.WriteLine("Connection failed: " + ex.Message);
                return null;
            }
        }
    }

}