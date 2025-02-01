using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;

namespace WebApplication1.Util.sql
{
    public static class sqlistance
    {
        public static void ExecuteStoredProcedure(string connectionString, string procedureName, Dictionary<string, object> parameters)
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                try
                {
                    connection.Open();

                    // Create the SqlCommand to call the stored procedure
                    using (SqlCommand cmd = new SqlCommand(procedureName, connection))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;

                        // Add parameters dynamically using SqlParameter
                        foreach (var param in parameters)
                        {
                            // Create a SqlParameter for each parameter and add it to the command
                            SqlParameter sqlParam = new SqlParameter(param.Key, param.Value ?? DBNull.Value);

                            // You can optionally specify the type and size of parameters if needed:
                            // sqlParam.SqlDbType = SqlDbType.VarChar; // Example for string parameters
                            // sqlParam.Size = 255; // You can specify size if needed for VARCHAR parameters

                            cmd.Parameters.Add(sqlParam);
                        }

                        // Execute the stored procedure
                        cmd.ExecuteNonQuery();
                    }

                    System.Diagnostics.Trace.WriteLine($"Stored procedure '{procedureName}' executed successfully.");
                }
                catch (Exception ex)
                {
                    System.Diagnostics.Trace.WriteLine($"Error executing stored procedure: {ex.Message}");
                }
            }
        }

        public static DataTable ExecuteStoredProcedureList(string connectionString, string procedureName, Dictionary<string, object> parameters)
        {
            DataTable dataTable = new DataTable();

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                try
                {
                    connection.Open();

                    // Create the SqlCommand to call the stored procedure
                    using (SqlCommand cmd = new SqlCommand(procedureName, connection))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;

                        // Add parameters dynamically using SqlParameter
                        foreach (var param in parameters)
                        {
                            // Create a SqlParameter for each parameter and add it to the command
                            SqlParameter sqlParam = new SqlParameter(param.Key, param.Value ?? DBNull.Value);
                            cmd.Parameters.Add(sqlParam);
                        }

                        // Use SqlDataAdapter to fill the DataTable
                        using (SqlDataAdapter adapter = new SqlDataAdapter(cmd))
                        {
                            adapter.Fill(dataTable);
                        }
                    }

                    System.Diagnostics.Trace.WriteLine($"Stored procedure '{procedureName}' executed successfully.");
                }
                catch (Exception ex)
                {
                    System.Diagnostics.Trace.WriteLine($"Error executing stored procedure: {ex.Message}");
                }
            }

            return dataTable;
        }


    
    }
}