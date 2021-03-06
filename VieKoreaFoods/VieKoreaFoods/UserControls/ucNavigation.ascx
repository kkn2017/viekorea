﻿<%--author: Kwangeun Oh
date: 2019.03.05
file: ucMenu.ascx--%>

<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ucNavigation.ascx.cs" Inherits="VieKoreaFoods.UserControl.ucNavigation" %>

<ul>
	<li class="nav-home">
        <asp:HyperLink cssClass="active" NavigateUrl="~/ActiveServerPageExtended/index.aspx" runat="server">
            <div class="icon"></div>Home
        </asp:HyperLink>
	</li>
	<li class="nav-menu">
        <asp:HyperLink NavigateUrl="~/ActiveServerPageExtended/products.aspx" runat="server">
            <div class="icon"></div>Menu
        </asp:HyperLink>
	</li>
	<li class="nav-about">
		<asp:HyperLink NavigateUrl="~/about.html" runat="server">
            <div class="icon"></div>About
        </asp:HyperLink>
	</li>
	<li class="nav-contact">
		<asp:HyperLink NavigateUrl="~/contact.html" runat="server">
            <div class="icon"></div>Contact
        </asp:HyperLink>
	</li>
</ul>
