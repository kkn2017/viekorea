﻿<%--author: Kwangeun Oh
date: 2019.03.05
file: ucProducts.ascx--%>

<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ucProducts.ascx.cs" Inherits="VieKoreaFoods.UserControl.ucProducts" %>

<h2>
    <asp:Label ID="lblHeading" EnableViewState="false" runat="server" Text="" CssClass="content-heading large"></asp:Label>
</h2>

<asp:Repeater ID="rptProducts" runat="server" OnItemCommand="rptProducts_ItemCommand">
    <ItemTemplate>
        <ul>
            <li>
                <asp:Image
                    runat="server"
                    ImageUrl= '<%# Eval("ImageName") %>' />
                <div>
                    <asp:Label ID="lblName" runat="server" Text='<%# Eval("name") %>'></asp:Label>
                </div>
                <div>
                    <asp:Label ID="lblPrice" runat="server" Text='<%# Eval("price", "{0:c}") %>'></asp:Label>
                </div>
                <%
                    string productId = Request.QueryString["id"];
                    if (string.IsNullOrEmpty(productId))
                    {
                %>
                <div class="button">
                    <a href='Products.aspx?id=<%# Eval("id") %>'>details</a>
                </div>
                <%  
                    }
                %>
            </li>
        </ul>
        <%
            if (!string.IsNullOrEmpty(productId))
            {
        %>
        <div class="descriptions">
            <div class="brief_description">
                Brief Description:&nbsp;<asp:Label ID="lblBriefDescription" Text='<%# Eval("briefDescription") %>' runat="server" />
            </div>
            <div class="full_description">
                Full Description:&nbsp;<asp:Label ID="lblFullDescription" Text='<%# Eval("fullDescription") %>' runat="server" />
            </div>
            <asp:Button ID="btnAddToCart" cssClass="button" Text="Add To Cart" runat="server" CommandArgument='<%# Eval("Id") %>' CommandName="Add" />
        </div>
        <%
            }
        %>   
    </ItemTemplate>
</asp:Repeater>

<%--<asp:Label ID="lblError" runat="server" Text="" ForeColor="Red" EnableViewState="false"></asp:Label>--%>
