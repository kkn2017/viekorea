<%--author: Kwangeun Oh
date: 2019.03.05
file: admin_images.ascx--%>

<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="admin_images.aspx.cs" Inherits="VieKoreaFoods.Admin.admin_images" %>

<%@ Register Src="~/UserControls/ucSlideOrMenu.ascx" TagPrefix="uc1" TagName="ucSlideOrMenu" %>
<%@ Register Src="~/UserControls/ucLogin.ascx" TagPrefix="uc1" TagName="ucLogin" %>
<%@ Register Src="~/UserControls/ucNavigation.ascx" TagPrefix="uc1" TagName="ucNavigation" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <uc1:ucNavigation runat="server" ID="ucNavigation" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
    <uc1:ucSlideOrMenu runat="server" ID="ucSlideOrMenu" IsIndex="false" IsAdmin="true" />
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder3" runat="server">
    <h2 style=" color: white; ">Temporary Images</h2>
    <div>
        <asp:Label ID="lblMessage" EnableViewState="false" Style=" color: blue; " Text="" runat="server" />
        <asp:Label ID="lblError" EnableViewState="false" Style=" color: red; " Text="" runat="server" />
    </div>    
    <asp:Repeater ID="rptTmpImages" runat="server" OnItemCommand="rptTmpImages_ItemCommand">
        <ItemTemplate>
            <ul>
                <li>
                    <asp:Image ImageUrl='<%# Eval("Name", "~/tmp_img/{0}") %>' runat="server" style=" margin: 5px auto auto;" />
                    <div>
                        <asp:Label ID="lblImageName" Text='<%# Eval("Name") %>' runat="server" />
                    </div>
                    <div>
                        <asp:Button ID="btnUpload" CssClass="button" runat="server" CommandArgument='<%# Eval("Name") %>' CommandName="Upload"
                            style=" margin: 10px auto 10px; width: auto; " Text="Upload"/>
                    </div>
                </li>
            </ul>
        </ItemTemplate>
    </asp:Repeater>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolder4" runat="server">
    <uc1:ucLogin runat="server" ID="ucLogin" />
</asp:Content>
