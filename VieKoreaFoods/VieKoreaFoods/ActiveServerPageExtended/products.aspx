<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="products.aspx.cs" Inherits="VieKoreaFoods.ActiveServerPageExtended.products" %>

<%@ Register Src="~/UserControls/ucSlideOrMenu.ascx" TagPrefix="uc1" TagName="ucSlideOrMenu" %>
<%@ Register Src="~/UserControls/ucProducts.ascx" TagPrefix="uc1" TagName="ucProducts" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
    <uc1:ucSlideOrMenu runat="server" ID="ucSlideOrMenu" IsIndex="false" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder3" runat="server">
    <uc1:ucProducts runat="server" ID="ucProducts" Featured="false" />
</asp:Content>

