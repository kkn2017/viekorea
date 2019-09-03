<%--author: Kwangeun Oh
date: 2019.03.05
file: ucLogin.ascx--%>

<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ucLogin.ascx.cs" Inherits="VieKoreaFoods.UserControls.ucLogin" %>

<%
    if (this.IsAdmin == false)
    {
%>
<asp:Login ID="Login" runat="server" CssClass="form" FailureText="Fail to Login." OnAuthenticate="Login_Authenticate">
    <LayoutTemplate>
        <div>
            <asp:TextBox ID="UserName" CssClass="your_name" placeholder="Your Account" runat="server"></asp:TextBox>
            <asp:RequiredFieldValidator CssClass="val" ID="UserNameRequired" runat="server" ControlToValidate="UserName" ErrorMessage="UserName" ToolTip="UserName" ValidationGroup="ctl00$Login1">*</asp:RequiredFieldValidator>
            <asp:TextBox ID="Password" CssClass="your_password" placeholder="Password" runat="server" TextMode="Password"></asp:TextBox>
            <asp:RequiredFieldValidator CssClass="val" ID="PasswordRequired" runat="server" ControlToValidate="Password" ErrorMessage="Password" ToolTip="Password" ValidationGroup="ctl00$Login1">*</asp:RequiredFieldValidator>
        </div>
        <div>
            <asp:HyperLink ID="Register" CssClass="your_register" NavigateUrl="~/UserPage/register.aspx" Text="Register" runat="server" />
            <asp:Button ID="LoginButton" CssClass="button" runat="server" CommandName="Login" Text="LogIn" ValidationGroup="ctl00$Login1" />
        </div>
        <br />
        <asp:Literal ID="FailureText" runat="server" EnableViewState="False"></asp:Literal>
    </LayoutTemplate>
</asp:Login>
<div ID="divLoginStatus" class="loginStatus" visible="false" runat="server">
    <asp:Label ID="lblLoginName" CssClass="loginName" Text="" runat="server" />
    <div ID="divAccount" runat="server" style=" text-align: center; margin: 10px auto; " visible="false">
        <a href="../UserPage/account.aspx" style=" color: white; ">My Account</a>
    </div>
    <asp:Button ID="btnLogout" CssClass="button" runat="server" CommandName="Logout" Text="Logout" OnClick="LogoutButton_Click" />
</div>
<%
    }
    else
    {
%>
<asp:Login ID="Admin_Login" runat="server" CssClass="form" FailureText="Fail to Login." OnAuthenticate="Admin_Login_Authenticate">
    <LayoutTemplate>
        <div>
            <asp:TextBox ID="UserName" CssClass="your_name" placeholder="Your Account" runat="server"></asp:TextBox>
            <asp:RequiredFieldValidator CssClass="val" ID="UserNameRequired" runat="server" ControlToValidate="UserName" ErrorMessage="UserName" ToolTip="UserName" ValidationGroup="ctl00$Login1">*</asp:RequiredFieldValidator>
            <asp:TextBox ID="Password" CssClass="your_password" placeholder="Password" runat="server" TextMode="Password"></asp:TextBox>
            <asp:RequiredFieldValidator CssClass="val" ID="PasswordRequired" runat="server" ControlToValidate="Password" ErrorMessage="Password" ToolTip="Password" ValidationGroup="ctl00$Login1">*</asp:RequiredFieldValidator>
        </div>
        <div>
            <asp:Button ID="LoginButton" CssClass="button" runat="server" CommandName="Login" Text="LogIn" ValidationGroup="ctl00$Login1" />
        </div>
        <br />
        <asp:Literal ID="FailureText" runat="server" EnableViewState="False"></asp:Literal>
    </LayoutTemplate>
</asp:Login>
<div ID="divAdmin_loginStatus" class="loginStatus" visible="false" runat="server">
    <asp:Label ID="lblAdmin_LoginName" CssClass="loginName" Text="" runat="server" />
    <asp:Button ID="btnAdmin_Logout" CssClass="button" runat="server" CommandName="Logout" Text="Logout" OnClick="Admin_LogoutButton_Click" />
</div>
<%
    }
%>

