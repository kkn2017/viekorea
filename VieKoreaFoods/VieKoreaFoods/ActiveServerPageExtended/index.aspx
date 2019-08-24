<%--author: Kwangeun Oh
date: 2019.03.05
file: index.aspx--%>

<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="index.aspx.cs" Inherits="VieKoreaFoods.ActiveServerPageExtended.index" %>

<%@ Register Src="~/UserControls/ucSlideOrMenu.ascx" TagPrefix="uc1" TagName="ucSlideOrMenu" %>
<%@ Register Src="~/UserControls/ucProducts.ascx" TagPrefix="uc1" TagName="ucProducts" %>



<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
    <uc1:ucSlideOrMenu runat="server" ID="ucSlideOrMenu" IsIndex="true" />
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder3" runat="server">
    <uc1:ucProducts runat="server" ID="ucProducts" Featured="true" />
</asp:Content>
