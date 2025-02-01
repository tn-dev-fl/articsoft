<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ProductForm.aspx.cs" Inherits="WebApplication1.Product.ProductForm" %>


<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
     <style>
         .center {
             display:flex;
             justify-content:center;

         }
     </style>
   
     <h2 class="center">Add Product</h2>
     <div class="center">

        <div class="form-container">
            <div class="form-group">
                <label for="txtName">Product Name *</label>
                <asp:TextBox ID="txtName" runat="server" CssClass="form-control" />
                <asp:RequiredFieldValidator ID="rfvName" runat="server" ControlToValidate="txtName"
                    ErrorMessage="Product name is required" ForeColor="Red" />
            </div>

            <div class="form-group">
                <label for="txtDescription">Description</label>
                <asp:TextBox ID="txtDescription" runat="server" CssClass="form-control" />
                 
            </div>

            <div class="form-group">
                <label for="txtQuantity">Quantity *</label>
                <asp:TextBox ID="txtQuantity" runat="server" CssClass="form-control" />
                <asp:RequiredFieldValidator 
                    ID="rfvQuantity" 
                    runat="server" 
                    ControlToValidate="txtQuantity"
                    ErrorMessage="Quantity is required." 
                    ForeColor="Red" />
                <asp:RangeValidator ID="rvQuantity" runat="server" ControlToValidate="txtQuantity"
                    MinimumValue="1" MaximumValue="10000" Type="Integer" ErrorMessage="Please enter a valid quantity."
                    ForeColor="Red" />
            </div>

            <div class="form-group">
                <label for="txtPrice">Price *</label>
                <asp:TextBox ID="txtPrice" runat="server" CssClass="form-control" />
                <asp:RequiredFieldValidator 
                    ID="rfvPrice" 
                    runat="server" 
                    ControlToValidate="txtPrice"
                    ErrorMessage="Price is required." 
                    ForeColor="Red" />
                <asp:RangeValidator ID="rvPrice" runat="server" ControlToValidate="txtPrice"
                    MinimumValue="0.01" MaximumValue="99999" Type="Double" ErrorMessage="Please enter a valid price."
                    ForeColor="Red" />
            </div>
             <div class="form-group">
                <label for="fuProductPicture">Product Picture *</label>
                <asp:FileUpload ID="fuProductPicture" runat="server" CssClass="form-control" />
                <asp:RequiredFieldValidator ID="rfvProductPicture" runat="server" ControlToValidate="fuProductPicture"
                    ErrorMessage="Product picture is required." ForeColor="Red" />
            </div>

            <div class="form-group">
                <label for="ddlCountry">Country *</label>
                <asp:DropDownList ID="ddlCountry" runat="server" CssClass="form-control">
                    <asp:ListItem Value="" Text="Select a country" />
                    <asp:ListItem Value="1" Text="United States" />
                    <asp:ListItem Value="2" Text="Canada" />
                    <asp:ListItem Value="3" Text="United Kingdom" />
                    <asp:ListItem Value="4" Text="Australia" />
                    <asp:ListItem Value="5" Text="India" />
                    <asp:ListItem Value="6" Text="Germany" />
                    <asp:ListItem Value="7" Text="France" />
                    <asp:ListItem Value="8" Text="Italy" />
                    <asp:ListItem Value="9" Text="Japan" />
                    <asp:ListItem Value="10" Text="Brazil" />
                </asp:DropDownList>
                <asp:RequiredFieldValidator ID="rfvCountry" runat="server" ControlToValidate="ddlCountry"
                    InitialValue="" ErrorMessage="Country is required" ForeColor="Red" />
                </div>

            <div class="form-group">
                <asp:Button ID="btnAddProduct" runat="server" Text="Add Product" CssClass="btn btn-primary" OnClick="btnAddProduct_Click" />
            </div>

            <asp:Label ID="lblSuccessMessage" runat="server" ForeColor="Green" />
            <asp:Label ID="lblErrorMessage" runat="server" ForeColor="Red" />
        </div>
    </div>
</asp:Content>
