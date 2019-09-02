<%--author: Kwangeun Oh
date: 2019.03.05
file: account.aspx--%>

<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="account.aspx.cs" Inherits="VieKoreaFoods.UserPage.MyAccount" %>
<%@ Register Src="~/UserControls/ucLogin.ascx" TagPrefix="uc1" TagName="ucLogin" %>
<%@ Register Src="~/UserControls/ucNavigation.ascx" TagPrefix="uc1" TagName="ucNavigation" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <uc1:ucNavigation runat="server" ID="ucNavigation" />
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder3" runat="server">
    <h2>My Account</h2>
    <div style="border-bottom: 1px solid #b08101; padding-bottom: 10px; text-align: center;">
        <asp:HyperLink ID="hypPrivacy" cssClass="accountLink" NavigateUrl="~/UserPage/account.aspx?returnSection=Privacy" runat="server" 
            Text="Personal Info" />
        <asp:HyperLink ID="hypOrderHistory" cssClass="accountLink" NavigateUrl="~/UserPage/account.aspx?returnSection=OrderHistory" runat="server" 
            Text="Order History" />
    </div>
    <asp:Label ID="lblError" EnableViewState="false" Text="" runat="server" Style=" margin: 10px auto; " />
    <%
        string section = Request.QueryString["returnSection"];

        if (section == "Privacy")
        {
    %>
    <asp:DetailsView ID="detPrivacy" runat="server" AutoGenerateRows="False" Visible="true"
        Style=" border: 2px solid #b08101; margin: 20px auto 10px; width: auto; " CellPadding="10" >
        <Fields>
            <asp:TemplateField HeaderText="User Name">
                <ItemTemplate>
                    <asp:TextBox ID="txtUserName" runat="server" Text='<%# Eval("userName") %>'
                        Style=" background-color: white; border: 1px solid #b08101; color: black; margin: auto; " ></asp:TextBox>
                    <asp:RequiredFieldValidator ID="reqUserName" runat="server" CssClass="val"
                       ErrorMessage="User name is required"
                       ToolTip="User name is required"
                       ControlToValidate="txtUserName"
                       ValidationGroup="Group"
                       Display="Dynamic"
                       ForeColor="Red">*</asp:RequiredFieldValidator>
                </ItemTemplate>
                <HeaderStyle CssClass="view" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="First Name">
                <ItemTemplate>
                    <asp:TextBox ID="txtFirstName" runat="server" Text='<%# Eval("firstName") %>'
                        Style=" background-color: white; border: 1px solid #b08101; color: black; margin: auto; "></asp:TextBox>
                    <asp:RequiredFieldValidator ID="reqFirstName" runat="server" CssClass="val"
                      ErrorMessage="First name is required"
                      ToolTip="First name is required"
                      ControlToValidate="txtFirstName"
                      ValidationGroup="Group"
                      Display="Dynamic"
                      ForeColor="Red">*</asp:RequiredFieldValidator>
                </ItemTemplate>
                <HeaderStyle CssClass="view" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Last Name">
                <ItemTemplate>
                    <asp:TextBox ID="txtLastName" runat="server" Text='<%# Eval("lastName") %>'
                        Style=" background-color: white; border: 1px solid #b08101; color: black; margin: auto; "></asp:TextBox>
                    <asp:RequiredFieldValidator ID="reqLastName" runat="server" CssClass="val"
                       ErrorMessage="Last name is required"
                       ToolTip="Last name is required"
                       ControlToValidate="txtLastName"
                       ValidationGroup="Group"
                       Display="Dynamic"
                       ForeColor="Red">*</asp:RequiredFieldValidator>
                </ItemTemplate>
                <HeaderStyle CssClass="view" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Email Address">
                <ItemTemplate>
                <asp:TextBox ID="txtEmailAddress" runat="server" Text='<%# Eval("email") %>'
                        Style=" background-color: white; border: 1px solid #b08101; color: black; margin: auto; " />
                <asp:RequiredFieldValidator ID="reqEmailAdress" runat="server" ValidationGroup="Group"
                    ErrorMessage="Email address required"
                    ToolTip="Email address is required"
                    data-toggle="tooltip"
                    data-placement="right"
                    ControlToValidate="txtEmailAddress"
                    Display="Dynamic" 
                    ForeColor="Red"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="regEmailAddress" runat="server" ValidationGroup="Group"
                    ErrorMessage="Email is not in valid format" 
                    ToolTip="Email is not in valid format"
                    ControlToValidate="txtEmailAddress"
                    ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
                    Display="Dynamic" 
                    ForeColor="Red"></asp:RegularExpressionValidator>
                </ItemTemplate>
                <HeaderStyle CssClass="view" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Birthday">
                <ItemTemplate>
                    <asp:TextBox ID="txtBirthday" runat="server" Text='<%# Eval("birthday", "{0:MM-dd-yyyy}") %>'
                         Style=" background-color: white; border: 1px solid #b08101; color: black; margin: auto; "/>
                    <asp:RequiredFieldValidator ID="reqBirthday" runat="server" ValidationGroup="Group"
                        ErrorMessage="Birthday required"
                        ToolTip="Birthday is required"
                        data-toggle="tooltip"
                        data-placement="right"
                        ControlToValidate="txtBirthday"
                        Display="Dynamic" 
                        ForeColor="Red"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="regBirthday" runat="server" ValidationGroup="Group"
                        ErrorMessage="Birthday is not in valid format" 
                        ToolTip="Birthday is not in valid format"
                        ControlToValidate="txtBirthday"
                        ValidationExpression="((0[1-9]|1[0-2])\/((0|1)[0-9]|2[0-9]|3[0-1])\/((19|20)\d\d))$"
                        Display="Dynamic"
                        ForeColor="red"></asp:RegularExpressionValidator>
                </ItemTemplate>
                <HeaderStyle CssClass="view" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Street">
                <ItemTemplate>
                    <asp:TextBox ID="txtStreet" runat="server" Text='<%# Eval("street") %>' 
                        Style=" background-color: white; border: 1px solid #b08101; color: black; margin: auto; "></asp:TextBox>
                    <asp:RequiredFieldValidator ID="reqStreet" runat="server" CssClass="val"
                        ErrorMessage="Street is required"
                        ToolTip="Street is required"
                        ControlToValidate="txtStreet"
                        ValidationGroup="Group"
                        Display="Dynamic"
                        ForeColor="Red">*</asp:RequiredFieldValidator>
                </ItemTemplate>
                <HeaderStyle CssClass="view" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="City">
                <ItemTemplate>
                    <asp:TextBox ID="txtCity" runat="server" Text='<%# Eval("city") %>' 
                        Style=" background-color: white; border: 1px solid #b08101; color: black; margin: auto; "></asp:TextBox>
                    <asp:RequiredFieldValidator ID="reqCity" runat="server" CssClass="val"
                        ErrorMessage="City is required"
                        ToolTip="City is required"
                        ControlToValidate="txtCity"
                        ValidationGroup="Group"
                        Display="Dynamic"
                        ForeColor="Red">*</asp:RequiredFieldValidator>
                </ItemTemplate>
                <HeaderStyle CssClass="view" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Province">
                <ItemTemplate>
                    <asp:TextBox ID="txtProvince" runat="server" Text='<%# Eval("province") %>' 
                        Style=" background-color: white; border: 1px solid #b08101; color: black; margin: auto; "></asp:TextBox>
                    <asp:RequiredFieldValidator ID="reqProvince" runat="server" CssClass="val"
                        ErrorMessage="Province is required"
                        ToolTip="Province is required"
                        ControlToValidate="txtProvince"
                        ValidationGroup="Group"
                        Display="Dynamic"
                        ForeColor="Red">*</asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="regProvince" runat="server" CssClass="val"
                        Display="Dynamic"                                                                 
                        ValidationExpression="^[\s\S]{2,2}$"                                                 
                        ErrorMessage="Province must be two characters"
                        ToolTip="Province must be two characters"
                        ControlToValidate="txtProvince"
                        ValidationGroup="Group"
                        ForeColor="Red"
                        >*</asp:RegularExpressionValidator>
                </ItemTemplate>
                <HeaderStyle CssClass="view" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Postal Code">
                <ItemTemplate>
                    <asp:TextBox ID="txtPostalCode" runat="server" Text='<%# Eval("postalCode") %>' 
                        Style=" background-color: white; border: 1px solid #b08101; color: black; margin: auto; "></asp:TextBox>
                    <asp:RequiredFieldValidator ID="reqPostalCode" runat="server" CssClass="val"
                        ErrorMessage="Postal code is required"
                        ToolTip="Postal code is required"
                        ControlToValidate="txtPostalCode"
                        ValidationGroup="Group"
                        Display="Dynamic"
                        ForeColor="Red">*</asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="regPostalCode" runat="server" CssClass="val"
                        ErrorMessage="Postal code is not in valid format" ForeColor="red"
                        ToolTip="Postal code is not in valid format"
                        ControlToValidate="txtPostalCode"
                        ValidationExpression="[ABCEGHJKLMNPRSTVXY][0-9][ABCEGHJKLMNPRSTVWXYZ][0-9][ABCEGHJKLMNPRSTVWXYZ][0-9]"
                        ValidationGroup="Group"
                        Display="Dynamic">*</asp:RegularExpressionValidator>
                </ItemTemplate>
                <HeaderStyle CssClass="view" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Phone">
                <ItemTemplate>
                    <asp:TextBox ID="txtPhone" runat="server" Text='<%# Eval("phone") %>' 
                        Style=" background-color: white; border: 1px solid #b08101; color: black; margin: auto; "></asp:TextBox>
                    <asp:RequiredFieldValidator ID="reqPhone" runat="server" CssClass="val"
                         ErrorMessage="Phone number is required"
                         ToolTip="Phone number is required"
                         ControlToValidate="txtPhone"
                         ValidationGroup="Group"
                         Display="Dynamic"
                         ForeColor="Red">*</asp:RequiredFieldValidator>
                     <asp:RegularExpressionValidator ID="regPhone" runat="server" CssClass="val"
                         ErrorMessage="Phone number is not in valid format" ForeColor="red"
                         ToolTip="Phone number is not in valid format"
                         ControlToValidate="txtPhone"
                         ValidationExpression="^([0-9\(\)\/\+ \-]*)$"
                         ValidationGroup="Group"
                         Display="Dynamic">*</asp:RegularExpressionValidator>
                </ItemTemplate>
                <HeaderStyle CssClass="view" />
            </asp:TemplateField>
        </Fields> 
    </asp:DetailsView>
    <asp:Button ID="btnUpdatePersonalInfo" CssClass="button" runat="server" Text="Update" Visible="true" OnClick="btnUpdatePersonalInfo_Click"
        Style=" margin: 3px; width: auto; " />
    <div ID="divUpdatedPersonalInfo" runat="server" visible="false" style=" color: black; font-weight: bold; margin-top: 20px; ">
        Successfully Updated Your Information.
    </div>
    <asp:Button ID="btnBackToPrivacy" CssClass="button" runat="server" Text="Back" Visible="false" OnClick="btnBackToPrivacy_Click"
        Style=" margin: 5px; width: auto; " />
    <%
        }
        else if (section == "OrderHistory")
        {
    %>
    <div style=" overflow-x: auto; margin: 20px auto 10px; ">
        <asp:GridView ID="grdOrderHistory" AutoGenerateColumns="False" DataKeyNames="orderNumber" OnRowCommand="grdOrderHistory_RowCommand" runat="server" CellPadding="4" 
            Style="border: 1.5px solid #b08101; margin: auto; padding: 0; width:80%; " >
            <Columns>
                <asp:BoundField DataField="orderNumber" HeaderText="Ord No" ReadOnly="True" HeaderStyle-CssClass="view" ItemStyle-CssClass="view" />
                <asp:BoundField DataField="orderDate" HeaderText="Ord Date" ReadOnly="True" HeaderStyle-CssClass="view" ItemStyle-CssClass="view" />
                <asp:BoundField DataField="recipientName" HeaderText="Recipient" ReadOnly="True" HeaderStyle-CssClass="view" ItemStyle-CssClass="view"/>
                <asp:BoundField DataField="street" HeaderText="Street" ReadOnly="True" HeaderStyle-CssClass="view" ItemStyle-CssClass="view" />
                <asp:BoundField DataField="city" HeaderText="City" ReadOnly="True" HeaderStyle-CssClass="view" ItemStyle-CssClass="view"/>
                <asp:BoundField DataField="province" HeaderText="Province" ReadOnly="True" HeaderStyle-CssClass="view" ItemStyle-CssClass="view" />
                <asp:BoundField DataField="postalCode" HeaderText="PC" ReadOnly="True" HeaderStyle-CssClass="view" ItemStyle-CssClass="view" />
                <asp:BoundField DataField="phone" HeaderText="Phone" ReadOnly="True" HeaderStyle-CssClass="view" ItemStyle-CssClass="view" />
                <asp:BoundField DataField="payment" HeaderText="Pay Method" ReadOnly="True" HeaderStyle-CssClass="view" ItemStyle-CssClass="view" />
                <asp:BoundField DataField="totalCost" DataFormatString="{0:c}" HeaderText="Total Cost" ReadOnly="True" HeaderStyle-CssClass="view" 
                    ItemStyle-CssClass="view"/>
                <asp:ButtonField HeaderText="Details" Text="Details" HeaderStyle-CssClass="view" ItemStyle-CssClass="button_detail" />
                <asp:TemplateField HeaderText="Remove">
                    <ItemTemplate>
                        <div style=" width: 20px; margin: auto;">
                            <asp:CheckBox ID="chkRemove" runat="server"/>
                       </div>
                    </ItemTemplate>
                    <HeaderStyle CssClass="view" />
                </asp:TemplateField>
            </Columns>
            <HeaderStyle BackColor="#e39401" Font-Bold="True" ForeColor="White" BorderStyle="Solid" />
            <RowStyle BackColor="White" BorderStyle="Solid" BorderColor="#b08101" ForeColor="Black" />
        </asp:GridView>
    </div>
    <asp:Button ID="btnDeleteOrdHistory" CssClass="button" runat="server" Text="Delete" OnClick="btnDeleteOrdHistory_Click" 
        Style=" margin: 3px; width: auto; " />
    <asp:GridView ID="grdOrderDetails" AutoGenerateColumns="False"  runat="server" Visible="False" 
        Style="border: 1.5px solid #b08101; margin: auto; padding: 0; width:80%; ">
        <Columns>
            <asp:BoundField DataField="ProductName" HeaderText="Food" ReadOnly="True" HeaderStyle-CssClass="view" ItemStyle-CssClass="view" />
            <asp:BoundField DataField="price" DataFormatString="{0:c}" HeaderText="Price" ReadOnly="True" HeaderStyle-CssClass="view" ItemStyle-CssClass="view" />
            <asp:BoundField DataField="quantity" HeaderText="Qty" ReadOnly="True" HeaderStyle-CssClass="view" ItemStyle-CssClass="view" />
            <asp:BoundField DataField="linetotal" DataFormatString="{0:c}" HeaderText="Sub Total" HeaderStyle-CssClass="view" ItemStyle-CssClass="view" />
        </Columns>
        <HeaderStyle BackColor="#e39401" Font-Bold="True" ForeColor="White" BorderStyle="Solid" />
        <RowStyle BackColor="White" BorderStyle="Solid" BorderColor="#b08101" ForeColor="Black" />
    </asp:GridView>
    <asp:Button ID="btnBackToHistory" CssClass="button" runat="server" Text="Back" OnClick="btnBackToHistory_Click" 
        Style=" margin: 13px 3px 3px; width: auto; " Visible="false" />
    <%
        }
    %>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolder4" runat="server">
    <uc1:ucLogin runat="server" ID="ucLogin" />
</asp:Content>
