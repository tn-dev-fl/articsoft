using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;
using System.Web;
using System.Web.Mvc;
using Newtonsoft.Json;
using WebApplication1.Models;
using WebApplication1.Util.sql;

namespace WebApplication1.Controllers
{
    public class AdminController : Controller
    {
        [HttpGet]
        public JsonResult Dashboard()
        {
            try
            {
                string connectionString = ConfigurationManager.ConnectionStrings["connStr"].ConnectionString;

                string query = @"
                SELECT 
                c.CountryName,
                SUM(o.Quantity) AS ProductsSold
            FROM 
                Orders o
            LEFT JOIN 
                Product p ON o.ProductID = p.id
            LEFT JOIN 
                Countries c ON p.country = c.CountryID
            GROUP BY 
                c.CountryName;
            ";

                List<object> result = new List<object>();

                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            while (reader.Read())
                            {
                                var countryData = new
                                {
                                    CountryName = reader["CountryName"].ToString(),
                                    ProductsSold = Convert.ToInt32(reader["ProductsSold"])
                                };
                                result.Add(countryData);
                            }
                        }
                    }
                }

                return Json(result, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                return Json(new { success = false, message = "Error: " + ex.Message }, JsonRequestBehavior.AllowGet);
            }
        }

        [HttpPost]
        public JsonResult SubmitOrder(String id, String Quantity)
        {
            try
            {
                var sqlparam = new Dictionary<string, object>
                {
                    { "id", id },
                    { "Quantity", Quantity }
                };

                var res = sqlistance.ExecuteStoredProcedureList(
                    ConfigurationManager.ConnectionStrings["connStr"].ConnectionString,
                    "SubmitOrder", 
                    sqlparam
                );

                if (res.Rows.Count > 0)
                {
                    return Json(new { success = false, message = "Quantity Exceded" });
                }
                else
                {
                    return Json(new { success = true, message = "Order processed successfully" });
                }
            }
            catch (SqlException sqlEx)
            {
                var errorMessage = sqlEx.Message; 

                return Json(new { success = false, message = errorMessage });
            }
            catch (Exception ex)
            {
                // Catch any other errors (general exceptions)
                return Json(new { success = false, message = "An unexpected error occurred: " + ex.Message });
            }
        }

        [HttpGet]
        public JsonResult GetItems()
        {
            var sqlparam = new Dictionary<string, object>();

            var res = sqlistance.ExecuteStoredProcedureList(
                ConfigurationManager.ConnectionStrings["connStr"].ConnectionString,
                "GetProducts",
                sqlparam
            );

            if (res.Rows.Count > 0)
            {
                var itemList = new List<productitem>();
                foreach (DataRow row in res.Rows)
                {
                    itemList.Add(new productitem
                    {
                        Id = Convert.ToInt32(row["Id"]),
                        Name = Convert.ToString(row["Name"])
                    });
                }
                return Json(itemList, JsonRequestBehavior.AllowGet);
            }
            else
            {
                return Json(new { success = false, message = "No items found" }, JsonRequestBehavior.AllowGet);
            }
        }
        [HttpGet]
        public JsonResult GetItemsBySearch(string search)
        {
            var sqlparam = new Dictionary<string, object>();
            sqlparam.Add("searchTerm", search);

            var res = sqlistance.ExecuteStoredProcedureList(
                ConfigurationManager.ConnectionStrings["connStr"].ConnectionString,
                "SearchProducts", // Example stored procedure name
                sqlparam
            );

            if (res.Rows.Count > 0)
            {
                var itemList = new List<productitem>();
                foreach (DataRow row in res.Rows)
                {
                    itemList.Add(new productitem
                    {
                        Id = Convert.ToInt32(row["Id"]),
                        Name = Convert.ToString(row["Name"])
                    });
                }

                return Json(itemList, JsonRequestBehavior.AllowGet);
            }
            else
            {
                return Json(new { success = false, message = "No items found" }, JsonRequestBehavior.AllowGet);
            }
        }

        [HttpPost]
        public ActionResult Index()
        {
            string requestBody;
            using (var reader = new StreamReader(Request.InputStream))
            {
                requestBody = reader.ReadToEnd();
            }

            var loginData = JsonConvert.DeserializeObject<User>(requestBody);

            System.Diagnostics.Trace.WriteLine("user name is " + loginData.Username);
            var sqlparam = new Dictionary<string, object>();
            sqlparam.Add("username", loginData.Username);
            sqlparam.Add("password", loginData.Password);

           var res= sqlistance.ExecuteStoredProcedureList(ConfigurationManager.ConnectionStrings["connStr"].ConnectionString, "Login_admin", sqlparam);

       
        
            if (res.Rows.Count > 0)
            {
                var token = GenerateJwtToken(loginData.Username);

                // Return a successful login response
                return Json(new { success = true, message = "Login successful", token = token });

            }
            else
            {
                return Json(new { success = false, message = "Invalid username or password" });
            }
        }


        private string GenerateJwtToken(string username)
        {
            var header = new
            {
                alg = "HS256",
                typ = "JWT"
            };

            var payload = new
            {
                sub = username,
                exp = DateTimeOffset.UtcNow.AddHours(1).ToUnixTimeSeconds()
            };

            var headerJson = JsonConvert.SerializeObject(header);
            var payloadJson = JsonConvert.SerializeObject(payload);

            var base64UrlHeader = Base64UrlEncode(Encoding.UTF8.GetBytes(headerJson));
            var base64UrlPayload = Base64UrlEncode(Encoding.UTF8.GetBytes(payloadJson));

            var stringToSign = $"{base64UrlHeader}.{base64UrlPayload}";

            var secretKey = "test123";

            var signature = SignWithHmacSha256(stringToSign, secretKey);

            return $"{stringToSign}.{signature}";
        }

        private string Base64UrlEncode(byte[] input)
        {
            var base64 = Convert.ToBase64String(input);
            return base64
                .Replace('+', '-')
                .Replace('/', '_')
                .TrimEnd('=');
        }

        private string SignWithHmacSha256(string data, string key)
        {
            using (var hmac = new HMACSHA256(Encoding.UTF8.GetBytes(key)))
            {
                var hash = hmac.ComputeHash(Encoding.UTF8.GetBytes(data));
                return Base64UrlEncode(hash);
            }
        }

       
    }

}

