<%--author: Kwangeun Oh
date: 2019.03.05
file: ucCart.ascx--%>

<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ucCart.ascx.cs" Inherits="VieKoreaFoods.UserControls.ucCart" %>

<h2>Shopping Cart</h2>
<div style=" overflow-x: auto; ">
    <asp:GridView ID="grdCart" runat="server" AutoGenerateColumns="False" DataKeyNames="ProductId" style=" border: 1.5px solid #b08101; margin: auto; padding: 0; width:80%; " CellPadding="4" >
        <Columns>
            <asp:TemplateField HeaderText="Id">
                <ItemTemplate>
                    <asp:HyperLink ID="hypProduct" runat="server" ForeColor="Blue"
                        NavigateUrl='<%# Eval("ProductId","~/UserPage/products.aspx?id={0}") %>' Text='<%# Eval("ProductId") %>'></asp:HyperLink>
                </ItemTemplate>
                <HeaderStyle CssClass="view" />
                <ItemStyle CssClass="view" />
            </asp:TemplateField>
            <asp:BoundField DataField="ProductName" HeaderText="Name" HeaderStyle-CssClass="view" ItemStyle-CssClass="view" />
            <asp:BoundField DataField="CurrentDate" HeaderText="Date" HeaderStyle-CssClass="view" ItemStyle-CssClass="view" />
            <asp:TemplateField HeaderText="Quantity">
                <ItemTemplate>
                    <asp:HiddenField ID="hdnCurrentQty" runat="server" Value='<%# Eval("Qty") %>' />
                    <div style="text-align: center;">
                        <asp:TextBox ID="txtQty" runat="server" Text='<%# Eval("Qty") %>' Height="21px" Width="21px" 
                            Style=" background-color: aliceblue; color: black; margin: auto;" ></asp:TextBox>
                    </div>
                </ItemTemplate>
                <HeaderStyle CssClass="view" />
            </asp:TemplateField>
            <asp:BoundField DataField="Price" DataFormatString="{0:c}" HeaderText="Price" HeaderStyle-CssClass="view" ItemStyle-CssClass="view" />
            <asp:BoundField DataField="LineTotal" DataFormatString="{0:c}" HeaderText="SubTotal" HeaderStyle-CssClass="view" ItemStyle-CssClass="view" />
            <asp:TemplateField HeaderText="Remove">
                <ItemTemplate>
                    <div style=" width: 20px; margin: auto;">
                        <asp:CheckBox ID="chkRemove" runat="server"/>
                   </div>
                </ItemTemplate>
                <HeaderStyle CssClass="view" />
            </asp:TemplateField>
        </Columns>
        <HeaderStyle BackColor="#e39401" Font-Bold="True" ForeColor="White" BorderStyle="Solid"/>
        <RowStyle BackColor="White" BorderStyle="Solid" BorderColor="#b08101" ForeColor="Black" />
    </asp:GridView>
</div>
<div style="text-align: center; margin-top: 10px;">
    <asp:Label ID="lblTaxShippingCost" runat="server" Text=""></asp:Label>
</div>
<div style="text-align:center; margin-bottom: 10px;">
    <asp:Label ID="lblTotal" runat="server" Text="" EnableViewState="false"></asp:Label> 
    <asp:Label ID="lblCartTotal" runat="server" Text="" Font-Bold="true" EnableViewState="false"></asp:Label>
</div>
<asp:Button ID="btnUpdateCart" CssClass="button" runat="server" Text="Update Cart" OnClick="btnUpdateCart_Click" Style=" margin: 3px; width: auto; " /> 
<asp:Button ID="btnContinueShopping" CssClass="button" runat="server" Text="Continue Shopping" OnClick="btnContinueShopping_Click" Style=" margin: 3px; width: auto; " /> 
<asp:Button ID="btnCheckout" CssClass="button" runat="server" Text="Check Out" OnClick="btnCheckout_Click" Style=" margin: 3px; width: auto; " />
 <div id="CheckLogin" runat="server" visible="false" style=" color: red; ">
     <p>Sorry, you should log in your account that must be validated. If not, please email the company.</p>
     <p>If you don't have an account, please create your own account. Click <a href="../UserPage/register.aspx" style=" color: blue; font-weight: bold; ">this</a>.</p>
 </div>
