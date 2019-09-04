<%--author: Kwangeun Oh
date: 2019.03.05
file: admin_maintenance.ascx--%>

<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="admin_maintenance.aspx.cs" Inherits="VieKoreaFoods.Admin.maintenance" %>

<%@ Register Src="~/UserControls/ucSlideOrMenu.ascx" TagPrefix="uc1" TagName="ucSlideOrMenu" %>
<%@ Register Src="~/UserControls/ucProducts.ascx" TagPrefix="uc1" TagName="ucProducts" %>
<%@ Register Src="~/UserControls/ucLogin.ascx" TagPrefix="uc1" TagName="ucLogin" %>
<%@ Register Src="~/UserControls/ucNavigation.ascx" TagPrefix="uc1" TagName="ucNavigation" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <uc1:ucNavigation runat="server" ID="ucNavigation" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
    <uc1:ucSlideOrMenu runat="server" ID="ucSlideOrMenu" IsIndex="false" IsAdmin="true" />
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder3" runat="server">
    <%
        string queryString = Request.QueryString["returnCategory"];

        if (queryString == "foods")
        {
    %>
    <h2 style=" color: #fff; "> Foods Maintenance</h2>
    <div style=" overflow-x: auto; margin: 20px auto 10px; ">
        <asp:GridView ID="grdFoods" runat="server" AllowPaging="true" AllowSorting="true" AutoGenerateColumns="false" DataKeyNames="id"
            OnRowCommand="grdFoods_RowCommand" OnRowDeleting="grdFoods_RowDeleting" OnRowUpdating="grdFoods_RowUpdating"
            OnRowEditing="grdFoods_RowEditing" OnRowCancelingEdit="grdFoods_RowCancelingEdit"
            OnPageIndexChanging="grdFoods_PageIndexChanging" PageSize="4" ShowFooter="true"
            Style="border: 1.5px solid #b08101; margin: auto; padding: 0; width: 100%; " PagerStyle-Font-Underline="true" >
            <Columns>
                <asp:TemplateField HeaderText="Id">
                    <ItemTemplate>
                        <asp:Label ID="lblProductId" runat="server" Text='<%# Eval("id") %>' style=" margin: 1px; "></asp:Label>
                    </ItemTemplate>
                    <HeaderStyle CssClass="view" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Name">
                    <EditItemTemplate>
                        <asp:TextBox ID="txtProductName" runat="server" Text='<%# Eval("name") %>'
                            Style=" background-color: white; border: 1px solid #b08101; color: black; margin: auto; width: 90px; "></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="lblProductName" runat="server" Text='<%# Eval("name") %>'></asp:Label>
                    </ItemTemplate>
                    <FooterTemplate>
                        <asp:TextBox ID="txtProductNameNew" runat="server"
                            Style=" background-color: white; border: 1px solid #b08101; color: black; margin: auto; width: 90px; "></asp:TextBox>
                    </FooterTemplate>
                    <HeaderStyle CssClass="view" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Brief Description">
                    <EditItemTemplate>
                        <asp:TextBox ID="txtBriefDesc" runat="server" Text='<%# Eval("briefDescription") %>'
                            Style=" background-color: white; border: 1px solid #b08101; color: black; margin: auto; width: 90px; "></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="lblBriefDesc" runat="server" Text='<%# Eval("briefDescription") %>'></asp:Label>
                    </ItemTemplate>
                    <FooterTemplate>
                        <asp:TextBox ID="txtBriefDescNew" runat="server"
                            Style=" background-color: white; border: 1px solid #b08101; color: black; margin: auto; width: 90px; "></asp:TextBox>
                    </FooterTemplate>
                    <HeaderStyle CssClass="view" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Full Description">
                    <EditItemTemplate>
                        <asp:TextBox ID="txtFullDesc" runat="server" Text='<%# Eval("fullDescription") %>'
                            Style=" background-color: white; border: 1px solid #b08101; color: black; margin: auto; width: 180px; "></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="lblFullDesc" runat="server" Text='<%# Eval("fullDescription") %>'></asp:Label>
                    </ItemTemplate>
                    <FooterTemplate>
                        <asp:TextBox ID="txtFullDescNew" runat="server"
                            Style=" background-color: white; border: 1px solid #b08101; color: black; margin: auto; width: 180px; "></asp:TextBox>
                    </FooterTemplate>
                    <HeaderStyle CssClass="view" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Status">
                    <EditItemTemplate>
                         <asp:DropDownList ID="ddlStatus" runat="server" 
                             style=" background-color: white; border: 1px solid #b08101; margin: auto; height: 25px; width: 70px; "></asp:DropDownList>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="lblStatusName" runat="server" Text='<%# Eval("StatusName") %>'></asp:Label>
                    </ItemTemplate>
                    <FooterTemplate>
                       <asp:DropDownList ID="ddlStatusNew" runat="server" 
                           style=" background-color: white; border: 1px solid #b08101; margin: auto; height: 25px; width: 70px; "></asp:DropDownList>
                    </FooterTemplate>
                    <HeaderStyle CssClass="view" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Price">
                    <EditItemTemplate>
                        <asp:TextBox ID="txtPrice" runat="server" Text='<%# Eval("price", "{0:0.00}") %>'
                            Style=" background-color: white; border: 1px solid #b08101; color: black; margin: auto; width: 50px; "></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="lblPrice" runat="server" Text='<%# Eval("price", "{0:c}") %>' ></asp:Label>
                    </ItemTemplate>
                    <FooterTemplate>
                        <asp:TextBox ID="txtPriceNew" runat="server"
                            Style=" background-color: white; border: 1px solid #b08101; color: black; margin: auto; width: 90px; "></asp:TextBox>
                    </FooterTemplate>
                    <HeaderStyle CssClass="view" />
                    <ItemStyle CssClass="view" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Featured">
                    <EditItemTemplate>
                        <div style=" width: 20px; margin: auto;">
                            <asp:CheckBox ID="chkFeatured" runat="server" Checked='<%# Bind("featured") %>' />
                        </div>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <div style=" width: 20px; margin: auto;">
                            <asp:CheckBox ID="chkFeaturedDisplay" runat="server" Checked='<%# Bind("featured") %>' Enabled="false" />
                        </div>
                    </ItemTemplate>
                    <FooterTemplate>
                        <div style=" width: 20px; margin: auto;">
                            <asp:CheckBox ID="chkFeaturedNew" runat="server" />
                        </div>
                    </FooterTemplate>
                    <HeaderStyle CssClass="view" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Category">
                    <EditItemTemplate>
                        <asp:DropDownList ID="ddlCategories" runat="server" 
                            style=" background-color: white; border: 1px solid #b08101; margin: auto; height: 25px; width: 70px; "></asp:DropDownList>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="lblCategory" runat="server" Text='<%# Eval("CategoryName") %>'></asp:Label>
                    </ItemTemplate>
                    <FooterTemplate>
                        <asp:DropDownList ID="ddlCategoriesNew" runat="server" 
                            style=" background-color: white; border: 1px solid #b08101; margin: auto; height: 25px; width: 70px; "></asp:DropDownList>
                    </FooterTemplate>
                    <HeaderStyle CssClass="view" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Image">
                    <EditItemTemplate>
                        <asp:FileUpload ID="uplUpdateImage" runat="server" 
                            Style=" background-color: white; border:none; color: black; margin: auto; width: 80px; "/>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Image ID="imgProduct" runat="server" ImageUrl='<%# Eval("ImageName") %>' />
                    </ItemTemplate>
                    <FooterTemplate>
                        <asp:FileUpload ID="uplNewImage" runat="server"
                            Style=" background-color: white; border:none; color: black; margin: auto; width: 80px; "/>
                    </FooterTemplate>
                    <HeaderStyle CssClass="view" />
                </asp:TemplateField>
                <asp:TemplateField>
                    <EditItemTemplate>
                        <asp:Button ID="btnUpdate" CssClass="button" runat="server" CausesValidation="True" CommandName="Update"
                            Text="Update" Style=" display: inline-block; margin: 5px auto auto; padding: 5px; width: auto; " />
                        <asp:Button ID="btnCancel" CssClass="button" runat="server" CausesValidation="False" CommandName="Cancel" 
                            Text="Cancel" Style=" display: inline-block; margin: 5px 1px 5px; padding: 5px; width: auto; " />
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Button ID="btnEdit" CssClass="button" runat="server" Text="Edit" CommandName="Edit" 
                            Style=" display: inline-block; margin: auto; width: auto; " CausesValidation="false" />
                        <asp:Button ID="btnDelete" CssClass="button" runat="server" Text="Delete" CommandName="Delete" 
                            Style=" display: inline-block; margin: 5px 1px auto; padding: 5px; width: auto; " CausesValidation="false" />
                    </ItemTemplate>
                    <FooterTemplate>
                        <asp:Button ID="btnNew" CssClass="button" runat="server" CommandName="btnNew" Text="Insert"
                            Style=" display: inline-block; margin: 2px 1px 2px; padding: 5px; width: auto; "/>
                    </FooterTemplate>
                </asp:TemplateField>
            </Columns>
            <HeaderStyle BackColor="#e39401" Font-Bold="True" ForeColor="White" BorderStyle="Solid" />
            <RowStyle BackColor="White" BorderStyle="Solid" BorderColor="#b08101" ForeColor="Black" />
            <PagerStyle BackColor="#e39401" BorderStyle="Solid" BorderColor="#b08101" ForeColor="White" Height="25px" />
        </asp:GridView>
    </div>
    <%
        }
        else if (queryString == "customers")
        {
    %>
    <h2 style=" color: #fff; "> Customers Maintenance</h2>
    <div style=" overflow-x: auto; margin: 20px auto 10px; ">
        <asp:GridView ID="grdCustomers" runat="server" AutoGenerateColumns="false" AllowPaging="true" AllowSorting="true" DataKeyNames="id"
            OnRowDeleting="grdCustomers_RowDeleting" OnRowCommand="grdCustomers_RowCommand" OnRowUpdating="grdCustomers_RowUpdating"
            OnRowEditing="grdCustomers_RowEditing" OnRowCancelingEdit="grdCustomers_RowCancelingEdit" OnPageIndexChanging="grdCustomers_PageIndexChanging"
            PageSize="4" ShowFooter="true" PagerStyle-Font-Underline="true"
            Style="border: 1.5px solid #b08101; margin: auto; padding: 0; width: 100%; " >
            <Columns>
                <asp:TemplateField HeaderText="Id">
                    <ItemTemplate>
                        <asp:Label ID="lblCustomerId" runat="server" Text='<%# Eval("id") %>'></asp:Label>
                    </ItemTemplate>
                    <HeaderStyle CssClass="view" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="User Name">
                    <EditItemTemplate>
                        <asp:TextBox ID="txtUserName" runat="server" Text='<%# Eval("userName") %>'
                            Style=" background-color: white; border: 1px solid #b08101; color: black; margin: auto; width: 70px; "></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="lblUserName" runat="server" Text='<%# Eval("userName") %>'></asp:Label>
                    </ItemTemplate>
                    <FooterTemplate>
                        <asp:TextBox ID="txtUserNameNew" runat="server" 
                            Style=" background-color: white; border: 1px solid #b08101; color: black; margin: auto; width: 70px; "></asp:TextBox>
                    </FooterTemplate>
                    <HeaderStyle CssClass="view" />
                    <ItemStyle CssClass="view" />
                    <FooterStyle CssClass="view" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="First Name">
                    <EditItemTemplate>
                        <asp:TextBox ID="txtFirstName" runat="server" Text='<%# Eval("firstname") %>'
                            Style=" background-color: white; border: 1px solid #b08101; color: black; margin: auto; width: 70px; "></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="lblFirstName" runat="server" Text='<%# Eval("firstname") %>'></asp:Label>
                    </ItemTemplate>
                    <FooterTemplate>
                        <asp:TextBox ID="txtFirstNameNew" runat="server"
                            Style=" background-color: white; border: 1px solid #b08101; color: black; margin: auto; width: 70px; "></asp:TextBox>
                    </FooterTemplate>
                    <HeaderStyle CssClass="view" />
                    <ItemStyle CssClass="view" />
                    <FooterStyle CssClass="view" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Last Name">
                    <EditItemTemplate>
                        <asp:TextBox ID="txtLastName" runat="server" Text='<%# Eval("lastName") %>'
                            Style=" background-color: white; border: 1px solid #b08101; color: black; margin: auto; width: 70px; "></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="lblLastName" runat="server" Text='<%# Eval("lastName") %>'></asp:Label>
                    </ItemTemplate>
                    <FooterTemplate>
                        <asp:TextBox ID="txtLastNameNew" runat="server"
                            Style=" background-color: white; border: 1px solid #b08101; color: black; margin: auto; width: 70px; "></asp:TextBox>
                    </FooterTemplate>
                    <HeaderStyle CssClass="view" />
                    <ItemStyle CssClass="view" />
                    <FooterStyle CssClass="view" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Email">
                    <EditItemTemplate>
                        <asp:TextBox ID="txtEmail" runat="server" Text='<%# Eval("email") %>'
                            Style=" background-color: white; border: 1px solid #b08101; color: black; margin: auto; width: 120px; "></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="lblEmail" runat="server" Text='<%# Eval("email") %>'></asp:Label>
                    </ItemTemplate>
                    <FooterTemplate>
                        <asp:TextBox ID="txtEmailNew" runat="server"
                            Style=" background-color: white; border: 1px solid #b08101; color: black; margin: auto; width: 120px; "></asp:TextBox>
                    </FooterTemplate>
                    <HeaderStyle CssClass="view" />
                    <ItemStyle CssClass="view" />
                    <FooterStyle CssClass="view" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Street">
                    <EditItemTemplate>
                        <asp:TextBox ID="txtStreet" runat="server" Text='<%# Eval("street") %>'
                            Style=" background-color: white; border: 1px solid #b08101; color: black; margin: auto; width: 90px; "></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="lblStreet" runat="server" Text='<%# Eval("street") %>'></asp:Label>
                    </ItemTemplate>
                    <FooterTemplate>
                        <asp:TextBox ID="txtStreetNew" runat="server"
                            Style=" background-color: white; border: 1px solid #b08101; color: black; margin: auto; width: 90px; "></asp:TextBox>
                    </FooterTemplate>
                    <HeaderStyle CssClass="view" />
                    <ItemStyle CssClass="view" />
                    <FooterStyle CssClass="view" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="City">
                    <EditItemTemplate>
                        <asp:TextBox ID="txtCity" runat="server" Text='<%# Eval("City") %>'
                            Style=" background-color: white; border: 1px solid #b08101; color: black; margin: auto; width: 90px; "></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="lblCity" runat="server" Text='<%# Eval("City") %>'></asp:Label>
                    </ItemTemplate>
                    <FooterTemplate>
                        <asp:TextBox ID="txtCityNew" runat="server"
                            Style=" background-color: white; border: 1px solid #b08101; color: black; margin: auto; width: 90px; "></asp:TextBox>
                    </FooterTemplate>
                    <HeaderStyle CssClass="view" />
                    <ItemStyle CssClass="view" />
                    <FooterStyle CssClass="view" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="PR">
                    <EditItemTemplate>
                        <asp:TextBox ID="txtProvince" runat="server" Text='<%# Eval("province") %>'
                            Style=" background-color: white; border: 1px solid #b08101; color: black; margin: auto; width: 30px; "></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="lblProvince" runat="server" Text='<%# Eval("province") %>'></asp:Label>
                    </ItemTemplate>
                    <FooterTemplate>
                        <asp:TextBox ID="txtProvinceNew" runat="server"
                            Style=" background-color: white; border: 1px solid #b08101; color: black; margin: auto; width: 30px; "></asp:TextBox>
                    </FooterTemplate>
                    <HeaderStyle CssClass="view" />
                    <ItemStyle CssClass="view" />
                    <FooterStyle CssClass="view" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="PC">
                    <EditItemTemplate>
                        <asp:TextBox ID="txtPostalCode" runat="server" Text='<%# Eval("postalCode") %>'
                            Style=" background-color: white; border: 1px solid #b08101; color: black; margin: auto; width: 90px; "></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="lblPostalCode" runat="server" Text='<%# Eval("postalCode") %>'></asp:Label>
                    </ItemTemplate>
                    <FooterTemplate>
                        <asp:TextBox ID="txtPostalCodeNew" runat="server"
                            Style=" background-color: white; border: 1px solid #b08101; color: black; margin: auto; width: 90px; "></asp:TextBox>
                    </FooterTemplate>
                    <HeaderStyle CssClass="view" />
                    <ItemStyle CssClass="view" />
                    <FooterStyle CssClass="view" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Phone Number">
                    <EditItemTemplate>
                        <asp:TextBox ID="txtPhone" runat="server" Text='<%# Eval("phone") %>'
                            Style=" background-color: white; border: 1px solid #b08101; color: black; margin: auto; width: 90px; "></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="lblPhone" runat="server" Text='<%# Eval("phone") %>'></asp:Label>
                    </ItemTemplate>
                    <FooterTemplate>
                        <asp:TextBox ID="txtPhoneNew" runat="server"
                            Style=" background-color: white; border: 1px solid #b08101; color: black; margin: auto; width: 90px; "></asp:TextBox>
                    </FooterTemplate>
                    <HeaderStyle CssClass="view" />
                    <ItemStyle CssClass="view" />
                    <FooterStyle CssClass="view" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Password">
                    <EditItemTemplate>
                        <asp:TextBox ID="txtPassword" runat="server" Text='<%# Eval("password") %>'
                            Style=" background-color: white; border: 1px solid #b08101; color: black; margin: auto; width: 90px; "></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="lblPassword" runat="server" Text='<%# Eval("password") %>'></asp:Label>
                    </ItemTemplate>
                    <FooterTemplate>
                        <asp:TextBox ID="txtPasswordNew" runat="server"
                            Style=" background-color: white; border: 1px solid #b08101; color: black; margin: auto; width: 90px; "></asp:TextBox>
                    </FooterTemplate>
                    <HeaderStyle CssClass="view" />
                    <ItemStyle CssClass="view" />
                    <FooterStyle CssClass="view" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Birthday">
                    <EditItemTemplate>
                        <asp:TextBox ID="txtBirthday" runat="server" Text='<%# Eval("birthday", "{0:d}") %>'
                            Style=" background-color: white; border: 1px solid #b08101; color: black; margin: auto; width: 90px; "></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="lblBirthday" runat="server" Text='<%# Eval("birthday", "{0:d}") %>'></asp:Label>
                    </ItemTemplate>
                    <FooterTemplate>
                        <asp:TextBox ID="txtBirthdayNew" runat="server"
                            Style=" background-color: white; border: 1px solid #b08101; color: black; margin: auto; width: 90px; "></asp:TextBox>
                    </FooterTemplate>
                    <HeaderStyle CssClass="view" />
                    <ItemStyle CssClass="view" />
                    <FooterStyle CssClass="view" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Archived">
                    <EditItemTemplate>
                        <div style=" width: 20px; margin: auto;">
                            <asp:CheckBox ID="chkArchived" runat="server" Checked='<%# Bind("archived") %>' Enabled="true" />
                        </div>
                    </EditItemTemplate>
                    <FooterTemplate>
                        <div style=" width: 20px; margin: auto;">
                            <asp:CheckBox ID="chkArchivedNew" runat="server" Enabled="true" />
                        </div>
                    </FooterTemplate>
                    <ItemTemplate>
                        <div style=" width: 20px; margin: auto;">
                            <asp:CheckBox ID="chkArchivedDisplay" runat="server" Checked='<%# Bind("archived") %>' Enabled="false" />
                        </div>
                    </ItemTemplate>
                    <HeaderStyle CssClass="view" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Validated">
                    <EditItemTemplate>
                        <div style=" width: 20px; margin: auto;">
                            <asp:CheckBox ID="chkValidated" runat="server" Checked='<%# Bind("validated") %>' Enabled="true" />
                        </div>
                    </EditItemTemplate>
                    <FooterTemplate>
                        <div style=" width: 20px; margin: auto;">
                            <asp:CheckBox ID="chkValidatedNew" runat="server" Enabled="true" />
                        </div>
                    </FooterTemplate>
                    <ItemTemplate>
                        <div style=" width: 20px; margin: auto;">
                            <asp:CheckBox ID="chkValidatedDisplay" runat="server" Checked='<%# Bind("validated") %>' Enabled="false" />
                        </div>
                    </ItemTemplate>
                    <HeaderStyle CssClass="view" />
                </asp:TemplateField>
                <asp:TemplateField ShowHeader="False">
                    <EditItemTemplate>
                        <asp:Button ID="btnUpdate" CssClass="button" runat="server" CausesValidation="True" CommandName="Update" Text="Update"
                            Style=" display: inline-block; margin: 5px auto auto; padding: 5px; width: auto; "/>
                        <asp:Button ID="btnCancel" CssClass="button" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel"
                            Style=" display: inline-block; margin: 5px 1px 5px; padding: 5px; width: auto; " />
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Button ID="btnEdit" CssClass="button" runat="server" CausesValidation="False" CommandName="Edit" Text="Edit"
                            Style=" display: inline-block; margin: auto; width: auto; "/>
                        <asp:Button ID="btnDelete" CssClass="button" runat="server" CausesValidation="False" CommandName="Delete" Text="Delete"
                            Style=" display: inline-block; margin: 5px 1px auto; padding: 5px; width: auto; "/>
                    </ItemTemplate>
                    <FooterTemplate>
                        <asp:Button ID="btnNew" CssClass="button" runat="server" CommandName="btnNew" Text="Insert"
                            Style=" display: inline-block; margin: 2px 1px 2px; padding: 5px; width: auto; "/>
                    </FooterTemplate>
                </asp:TemplateField>
            </Columns>
            <HeaderStyle BackColor="#e39401" Font-Bold="True" ForeColor="White" BorderStyle="Solid" />
            <RowStyle BackColor="White" BorderStyle="Solid" BorderColor="#b08101" ForeColor="Black" />
            <PagerStyle BackColor="#e39401" BorderStyle="Solid" BorderColor="#b08101" ForeColor="White" Height="25px" />
        </asp:GridView>
    </div>
    <%
        }
    %>
    <asp:Label ID="lblMessage" EnableViewState="false" Text="" runat="server" style="color: red; " />
    <asp:Label ID="lblError" EnableViewState="false" Text="" runat="server" style="color: red; " />
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolder4" runat="server">
    <uc1:ucLogin runat="server" ID="ucLogin" />
</asp:Content>