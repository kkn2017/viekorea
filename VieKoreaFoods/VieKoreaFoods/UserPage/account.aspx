<%--author: Kwangeun Oh
date: 2019.03.05
file: account.aspx--%>

<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="account.aspx.cs" Inherits="VieKoreaFoods.UserPage.MyAccount" %>
<%@ Register Src="~/UserControls/ucLogin.ascx" TagPrefix="uc1" TagName="ucLogin" %>
<%@ Register Src="~/UserControls/ucNavigation.ascx" TagPrefix="uc1" TagName="ucNavigation" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <uc1:ucNavigation runat="server" ID="ucNavigation" />
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder3" runat="server">
    <h2>My Account</h2>
    <div style="border-bottom: 1px solid #b08101; padding-bottom: 10px; text-align: center;">
        <asp:HyperLink ID="hypPrivacy" cssClass="accountLink" NavigateUrl="~/UserPage/account.aspx?returnSection=Privacy" runat="server" 
            Text="Personal Info" />
        <asp:HyperLink ID="hypOrderHistory" cssClass="accountLink" NavigateUrl="~/UserPage/account.aspx?returnSection=OrderHistory" runat="server" 
            Text="Order History" />
    </div>
    <%
        string section = Request.QueryString["returnSection"];

        if (section == "Privacy")
        {
    %>
    <h1>Hello Privacy</h1>
    <%
        }
        else if (section == "OrderHistory")
        { 
    %>
    <h1>Hello Order History</h1>
    <%
        }
    %>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolder4" runat="server">
    <uc1:ucLogin runat="server" ID="ucLogin" />
</asp:Content>
