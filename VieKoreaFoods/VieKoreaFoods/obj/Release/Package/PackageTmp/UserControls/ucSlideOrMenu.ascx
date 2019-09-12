﻿<%--author: Kwangeun Oh
date: 2019.03.05
file: ucSlideOrMenu.ascx--%>

<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ucSlideOrMenu.ascx.cs" Inherits="VieKoreaFoods.UserControl.ucSlideOrMenu" %>

<% 
    if (IsIndex == true && IsAdmin == false)
    {
%>
        <ul class="slides">
        	<li class="slide">
        		<div class="slide_image" style="background-image: url(../img/slides/slide-restaurant.jpeg);"></div>
        		<div class="overlay">
        			<strong>Family Restaurant</strong>
        			<span>Open 7 Days</span>
        		</div>
        	</li>
        	<li class="slide">
        		<div class="slide_image" style="background-image: url(../img/slides/slide-cheers.png);"></div>
        		<div class="overlay">
        			<strong>Make a Party</strong>
        			<span>Reservation recommended</span>
        		</div>
        	</li>
        	<li class="slide">
        		<div class="slide_image" style="background-image: url(../img/slides/slide-bar.jpg);"></div>
        		<div class="overlay">
        			<strong>Asian Cuisine</strong>
        			<span>Korean & vietnamese foods</span>
        		</div>
        	</li>
        	<li class="slide">
        		<div class="slide_image" style="background-image: url(../img/slides/slide-dragonfly.jpg);"></div>
        		<div class="overlay">
        			<strong>Delivery System</strong>
        			<span>12 am - 5 pm</span>
        		</div>
        	</li>
        </ul>
<% 
    }
    else if (IsIndex == false && IsAdmin == false)
    {
%>
        <h2 style=" margin: 0px; ">
            <asp:ListView ID="lstCategories" runat="server">
                <ItemTemplate>
                    <ul class="cuisines">
		    			<li class="cuisine">
                            <asp:HyperLink 
                                NavigateUrl='<%# Eval("id","~/UserPage/Products.aspx?categoryId={0}") %>'
                                Text='<%# Eval("name") %>'
                                runat="server" />
		    			</li>
		    		</ul>
                </ItemTemplate>
            </asp:ListView>
        </h2>
<%
    }
    else if (IsIndex == false && IsAdmin == true)
    {
%>
        <h2 style=" color: white; margin: 0px; ">
            <asp:HyperLink CssClass="admin_menu" NavigateUrl="~/Admin/admin_maintenance.aspx?returnCategory=foods" runat="server" Text="Foods" />&nbsp;&nbsp;|&nbsp;&nbsp;
            <asp:HyperLink CssClass="admin_menu" NavigateUrl="~/Admin/admin_maintenance.aspx?returnCategory=customers" runat="server" Text="Customers" />&nbsp;&nbsp;|&nbsp;&nbsp;
            <asp:HyperLink CssClass="admin_menu" NavigateUrl="~/Admin/admin_images.aspx" runat="server" Text="Images" />
        </h2>
<%
    }
%>
