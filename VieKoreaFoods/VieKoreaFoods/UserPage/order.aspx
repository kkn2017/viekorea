<%--author: Kwangeun Oh
date: 2019.03.05
file: order.aspx--%>

<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="order.aspx.cs" Inherits="VieKoreaFoods.UserPage.order" %>

<%@ Register Src="~/UserControls/ucLogin.ascx" TagPrefix="uc1" TagName="ucLogin" %>
<%@ Register Src="~/UserControls/ucNavigation.ascx" TagPrefix="uc1" TagName="ucNavigation" %>
<%@ Register Src="~/UserControls/ucCart.ascx" TagPrefix="uc1" TagName="ucCart" %>


<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <uc1:ucNavigation runat="server" ID="ucNavigation" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
    <uc1:ucCart runat="server" ID="ucCart" IsOrderPage="true" />
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder3" runat="server">
    <h2>Delivery and Payment Information</h2>
    <div id="Payment">
        <p>Advance Payment</p>
        <asp:RadioButtonList ID="rblPaymentMethod" AutoPostBack="True" runat="server">
            <asp:ListItem runat="server" Text="Yes" Value="Yes"></asp:ListItem>
            <asp:ListItem runat="server" Text="No" Value="No"></asp:ListItem>
        </asp:RadioButtonList>
        <asp:Label ID="lblSeeYou" Text="I see You" runat="server" Visible="false" Style=" color: black; " />
    </div>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolder4" runat="server">
    <uc1:ucLogin runat="server" ID="ucLogin" />
</asp:Content>
