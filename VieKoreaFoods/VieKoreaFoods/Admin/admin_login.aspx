<%--author: Kwangeun Oh
date: 2019.03.05
file: admin_login.ascx--%>

<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="admin_login.aspx.cs" Inherits="VieKoreaFoods.Admin.admin_login" %>

<%@ Register Src="~/UserControls/ucSlideOrMenu.ascx" TagPrefix="uc1" TagName="ucSlideOrMenu" %>
<%@ Register Src="~/UserControls/ucProducts.ascx" TagPrefix="uc1" TagName="ucProducts" %>
<%@ Register Src="~/UserControls/ucLogin.ascx" TagPrefix="uc1" TagName="ucLogin" %>
<%@ Register Src="~/UserControls/ucNavigation.ascx" TagPrefix="uc1" TagName="ucNavigation" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <uc1:ucNavigation runat="server" ID="ucNavigation" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
    <uc1:ucSlideOrMenu runat="server" ID="ucSlideOrMenu" IsIndex="true" IsAdmin="false" />
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder3" runat="server">
    <uc1:ucProducts runat="server" ID="ucProducts" Featured="true" />
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolder4" runat="server">
    <uc1:ucLogin runat="server" ID="ucLogin" IsAdmin="true" />
</asp:Content>


