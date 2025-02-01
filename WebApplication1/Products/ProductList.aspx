<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ProductList.aspx.cs" Inherits="WebApplication1.Products.ProductList" %>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
<asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CssClass="table table-bordered" EmptyDataText="No records found"
    OnRowCommand="GridView1_RowCommand"
    OnRowDeleting="GridView1_RowDeleting"
    OnRowEditing="GridView1_RowEditing"
    OnRowUpdating="GridView1_RowUpdating" 
    OnRowCancelingEdit="GridView1_RowCancelingEdit"
    OnRowDataBound="GridView1_RowDataBound"
    DataKeyNames="id">
    <Columns>
        <asp:BoundField DataField="name" HeaderText="Product Name" SortExpression="ProductName" />
        <asp:BoundField DataField="price" HeaderText="Price" SortExpression="Price" />
        <asp:BoundField DataField="quantity" HeaderText="Quantity" SortExpression="Quantity" />

        <asp:TemplateField HeaderText="Actions">
            <ItemTemplate>
                <asp:LinkButton ID="EditButton" runat="server" CommandName="Edit" CommandArgument='<%# Eval("id") %>'>
                    <i class="fas fa-edit"></i>
                </asp:LinkButton>

                <asp:LinkButton ID="DeleteButton" runat="server" CommandName="Delete" CommandArgument='<%# Eval("id") %>' OnClientClick="return confirm('Are you sure you want to delete this item?');">
                    <i class="fas fa-trash-alt" style="color:red"></i>
                </asp:LinkButton>
            </ItemTemplate>

            <EditItemTemplate>
                <asp:LinkButton ID="UpdateButton" runat="server" CommandName="Update" CausesValidation="false">
                    <i class="fa fa-check" aria-hidden="true"></i>
                </asp:LinkButton>

                <asp:LinkButton ID="CancelButton" runat="server" CommandName="Cancel" CausesValidation="false">
                    <i class="fa fa-times" aria-hidden="true" style="color:red"></i>
                </asp:LinkButton>
            </EditItemTemplate>
        </asp:TemplateField>
    </Columns>
</asp:GridView>


</asp:Content>
