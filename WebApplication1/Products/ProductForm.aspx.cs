using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Diagnostics;
using System.IO;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;
using WebApplication1.Models;
using WebApplication1.Util.sql;

namespace WebApplication1.Product
{
    public partial class ProductForm : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }


       

        protected void btnAddProduct_Click(object sender, EventArgs e)
        {
            
            ProductModel product = new ProductModel
            {
                Name = txtName.Text,
                Description = txtDescription.Text,
                Quantity = int.Parse(txtQuantity.Text),
                Price = decimal.Parse(txtPrice.Text)
            };
            string country = ddlCountry.SelectedValue;
            string fileName = "";
            if (fuProductPicture.HasFile)
            {
                fileName = Path.GetFileName(fuProductPicture.PostedFile.FileName);
                string filePath = Server.MapPath("~/img/") + fileName;
                fuProductPicture.SaveAs(filePath);
            }

                var a=ConfigurationManager.ConnectionStrings["connStr"].ConnectionString;

                
                var parameters = new Dictionary<string, object>();
                parameters.Add("name", product.Name);
                parameters.Add("description", product.Description);
                parameters.Add("quantity", product.Quantity);
                parameters.Add("price", product.Price);
                parameters.Add("filename", fileName);
                parameters.Add("country", country);

                sqlistance.ExecuteStoredProcedure(ConfigurationManager.ConnectionStrings["connStr"].ConnectionString, "Add_Product", parameters);
                lblSuccessMessage.Text = "Product added successfully!";
                lblSuccessMessage.ForeColor = System.Drawing.Color.Green;
            
        }
    }
}
