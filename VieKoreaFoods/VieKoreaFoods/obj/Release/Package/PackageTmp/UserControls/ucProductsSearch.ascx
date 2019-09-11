<%--author: Kwangeun Oh
date: 2019.03.05
file: ucProducts.ascx--%>

<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ucProductsSearch.ascx.cs" Inherits="VieKoreaFoods.UserControls.ucProductsSearch" %>

<div class="search">
    <asp:TextBox id="txtSearch" class="search_text" maxlength="50" placeholder="Search Here" runat="server" />
    <div>
        <div style=" display: inline; width: auto; margin: 5px auto auto; ">
            <input ID="chkAllWords" type="checkbox" runat="server" style=" display: inline; margin: auto; width: auto; ">
            <div style=" display:inline; margin: auto; width: 40%; " runat="server" >All Words</div>
        </div>
        <asp:Button ID="btnSearch" CssClass="button" Text="search" runat="server" OnClick="btnSearch_Click"
            style=" display:inline; margin-left: 5px; width: auto; " />
    </div>
</div>	