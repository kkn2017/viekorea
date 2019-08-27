<%--author: Kwangeun Oh
date: 2019.03.05
file: ucCart.ascx--%>

<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ucCart.ascx.cs" Inherits="VieKoreaFoods.UserControls.ucCart" %>

<h2>Shopping Cart</h2>
<asp:GridView ID="grdCart" runat="server" AutoGenerateColumns="False" DataKeyNames="ProductId" >
    <Columns>
        <asp:TemplateField HeaderText="Id">
            <ItemTemplate>
                <asp:HyperLink ID="hypProduct" runat="server" ForeColor="Blue" 
                    NavigateUrl='<%# Eval("ProductId","~/UserPage/products.aspx?id={0}") %>' Text='<%# Eval("ProductId") %>'></asp:HyperLink>
            </ItemTemplate>
        </asp:TemplateField>
        <asp:BoundField DataField="ProductName" HeaderText="Name" />
        <asp:BoundField DataField="CurrentDate" HeaderText="Date" />
        <asp:TemplateField HeaderText="Quantity">
            <ItemTemplate>
                <asp:HiddenField ID="hdnCurrentQty" runat="server" Value='<%# Eval("Qty") %>' />
                <asp:TextBox ID="txtQty" runat="server" Text='<%# Eval("Qty") %>'></asp:TextBox>
            </ItemTemplate>
        </asp:TemplateField>
        <asp:BoundField DataField="Price" DataFormatString="{0:c}" HeaderText="Price" />
        <asp:BoundField DataField="LineTotal" DataFormatString="{0:c}" HeaderText="SubTotal" />
        <asp:TemplateField HeaderText="Remove">
            <ItemTemplate>
                <asp:CheckBox ID="chkRemove" runat="server" />
            </ItemTemplate>
        </asp:TemplateField>
    </Columns>
</asp:GridView>
<div style="text-align:center">
    <asp:Label ID="lblTotal" runat="server" Text="" EnableViewState="false"></asp:Label> 
    <asp:Label ID="lblCartTotal" runat="server" Text="" Font-Bold="true" EnableViewState="false"></asp:Label>
</div>
<div style="text-align:center">
    <asp:Label ID="lblTaxShippingCost" runat="server" Text=""></asp:Label>
</div>
<asp:Button ID="btnUpdateCart" CssClass="button" runat="server" Text="Update Cart" OnClick="btnUpdateCart_Click" /> 
<asp:Button ID="btnContinueShopping" CssClass="button" runat="server" Text="Continue Shopping" OnClick="btnContinueShopping_Click" /> 
<asp:Button ID="btnCheckout" CssClass="button" runat="server" Text="Check Out" OnClick="btnCheckout_Click" />
