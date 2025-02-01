using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebApplication1.Util.sql;

namespace WebApplication1.Products
{
    public partial class ProductList : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindGrid();
            }
        }
        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            System.Diagnostics.Trace.WriteLine("111 "+ e.Row.RowType);

            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                LinkButton EditButton = (LinkButton)e.Row.FindControl("EditButton");
                LinkButton DeleteButton = (LinkButton)e.Row.FindControl("DeleteButton");
                LinkButton UpdateButton = (LinkButton)e.Row.FindControl("UpdateButton");
                LinkButton CancelButton = (LinkButton)e.Row.FindControl("CancelButton");
                if (GridView1.EditIndex == e.Row.RowIndex)
                {

                    if (EditButton != null) EditButton.Visible = false;
                    if (DeleteButton != null) DeleteButton.Visible = false;

                    if (UpdateButton != null) UpdateButton.Visible = true;
                    if (CancelButton != null) CancelButton.Visible = true;
                }
                else
                {
                    if (EditButton != null) EditButton.Visible = true;
                    if (DeleteButton != null) DeleteButton.Visible = true;

                    if (UpdateButton != null) UpdateButton.Visible = false;
                    if (CancelButton != null) CancelButton.Visible = false;
                }
            }
        }



        protected void GridView1_RowEditing(object sender, GridViewEditEventArgs e) {
            GridView1.EditIndex = e.NewEditIndex;
            BindGrid();
        }
        protected void GridView1_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int id = Convert.ToInt32(GridView1.DataKeys[e.RowIndex].Value);

            var newName = e.NewValues["name"];
            var newPrice = e.NewValues["price"];
            var newQuantity = e.NewValues["quantity"];

            var sqlparam = new Dictionary<string, object>();
            sqlparam.Add("id", id);
            sqlparam.Add("name", newName);
            sqlparam.Add("price", newPrice);
            sqlparam.Add("quantity", newQuantity);
            System.Diagnostics.Trace.WriteLine("ID: " + id);
            System.Diagnostics.Trace.WriteLine("Updated Name: " + newName);
            System.Diagnostics.Trace.WriteLine("Updated Price: " + newPrice);
            System.Diagnostics.Trace.WriteLine("Updated Quantity: " + newQuantity);
            sqlistance.ExecuteStoredProcedure(ConfigurationManager.ConnectionStrings["connStr"].ConnectionString, "Update_Product", sqlparam);
            GridView1.EditIndex = -1;
            BindGrid();

        }

        protected void GridView1_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            GridView1.EditIndex = -1;
            BindGrid();
        }
        protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e) {
        }
        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Edit")
            {
               
            }
            else if (e.CommandName == "Delete")
            {
                DeleteProduct(e.CommandArgument.ToString());

                BindGrid();

            }
        }

        private void DeleteProduct(string productId)
        {
            var parameters = new Dictionary<string, object>();
            parameters.Add("id", productId);

            sqlistance.ExecuteStoredProcedure(ConfigurationManager.ConnectionStrings["connStr"].ConnectionString, "Delete_Product", parameters);
        }

        private void BindGrid()
        {
            var parameters = new Dictionary<string, object>();
            DataTable dt = sqlistance.ExecuteStoredProcedureList(ConfigurationManager.ConnectionStrings["connStr"].ConnectionString, "Show_Products", parameters);

            GridView1.DataSource = dt;
            GridView1.DataBind();
        }

    }
}