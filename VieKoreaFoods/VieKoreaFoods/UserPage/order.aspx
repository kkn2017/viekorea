<%--author: Kwangeun Oh
date: 2019.03.05
file: order.aspx--%>

<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="order.aspx.cs" Inherits="VieKoreaFoods.UserPage.order" %>

<%@ Register Src="~/UserControls/ucLogin.ascx" TagPrefix="uc1" TagName="ucLogin" %>
<%@ Register Src="~/UserControls/ucNavigation.ascx" TagPrefix="uc1" TagName="ucNavigation" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <uc1:ucNavigation runat="server" ID="ucNavigation" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
    <h2>Order Information</h2>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder3" runat="server">
    <h2>Delivery and Payment Information</h2>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolder4" runat="server">
    <uc1:ucLogin runat="server" ID="ucLogin" />
</asp:Content>
