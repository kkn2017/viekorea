<%--author: Kwangeun Oh
date: 2019.03.05
file: order.aspx--%>

<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="order.aspx.cs" Inherits="VieKoreaFoods.UserPage.order" %>

<%@ Register Src="~/UserControls/ucLogin.ascx" TagPrefix="uc1" TagName="ucLogin" %>
<%@ Register Src="~/UserControls/ucNavigation.ascx" TagPrefix="uc1" TagName="ucNavigation" %>
<%@ Register Src="~/UserControls/ucCart.ascx" TagPrefix="uc1" TagName="ucCart" %>


<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <uc1:ucNavigation runat="server" ID="ucNavigation" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
    <%
        if (this.ConfirmedOrder == false)
        {
    %>
    <uc1:ucCart runat="server" ID="ucCart" IsOrderPage="true" />
    <%
        }
    %>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder3" runat="server">
    <%
        if (this.ConfirmedOrder == false)
        {
    %>
    <h2>Delivery and Payment Information</h2>
    <asp:Label ID="lblError" Text="" EnableViewState="false" runat="server" />
    <div style="padding-bottom: 10px; margin: auto; width: 50%;">
        <h3 style=" color: black; ">Payment Method</h3>
    </div>
    <div class="divRadioButton">
        <asp:RadioButtonList ID="rblPaymentMethod" CssClass="rdButton" AutoPostBack="True" runat="server" RepeatDirection="Horizontal" RepeatLayout="Flow" Style="width: auto;">
            <asp:ListItem runat="server" Text="Advance Payment" Value="Advance Payment"></asp:ListItem>
            <asp:ListItem runat="server" Text="Pay After Delivery" Value="Pay After Delivery"></asp:ListItem>
        </asp:RadioButtonList>
        <asp:RequiredFieldValidator ID="reqPaymentMethod" runat="server" CssClass="val"
                    ControlToValidate="rblPaymentMethod"
                    ErrorMessage="Payment method is required"
                    ToolTip="Payment method is required"
                    ForeColor="Red"
                    ValidationGroup="Group"></asp:RequiredFieldValidator>
    </div>
    <asp:Table ID="tblCreditCard" CssClass="tblCredit" runat="server" Visible="false" style=" border: 2px solid #b08101; border-radius: 12px; font-size: 17px; margin: auto; padding: 10px 20px; width: auto; ">
        <asp:TableRow runat="server">
            <asp:TableCell style=" text-align: right; padding-bottom: 8px;  ">Credit Card:</asp:TableCell>
            <asp:TableCell style=" text-align: left; padding-bottom: 8px;  ">
                <asp:DropDownList ID="ddlCreditCard" runat="server" CssClass="ddlCredit" >
                    <asp:ListItem Text="----- Choose Card ------" />
                    <asp:ListItem Text="VISA Card" Value="Visa" />
                    <asp:ListItem Text="Master Card" Value="Master" />
                </asp:DropDownList>
                <asp:RequiredFieldValidator ID="reqCreditCard" CssClass="val" runat="server"
                    ControlToValidate="ddlCreditCard"
                    InitialValue="----- Choose Card ------"
                    ErrorMessage="Credit Card is required"
                    ToolTip="Credit Card is required"
                    ForeColor="Red"
                    ValidationGroup="Group">*</asp:RequiredFieldValidator>
            </asp:TableCell>
        </asp:TableRow>
        <asp:TableRow runat="server">
            <asp:TableCell style=" text-align: right; padding-bottom: 5px; ">Card Number:</asp:TableCell>
            <asp:TableCell style=" text-align: left; padding-bottom: 5px; ">
                <asp:TextBox ID="txtCardNumber" runat="server" Placeholder="16-digit" 
                    Style=" background-color: white; border: 1px solid #b08101; color: black; margin: auto; " ></asp:TextBox>
                <asp:RequiredFieldValidator ID="reqCardNumber" CssClass="val" runat="server"
                    ControlToValidate="txtCardNumber"
                    IniticalValue="none"
                    ErrorMessage="Card Number is required"
                    ToolTip="Card Number is required"
                    ForeColor="Red"
                    ValidationGroup="Group">*</asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="regCardNumber" CssClass="val" runat="server"
                    ErrorMessage="Card number is not in valid format" 
                    ToolTip="Card number is not in valid format"
                    ControlToValidate="txtCardNumber"
                    ValidationExpression="^[0-9]{0,16}$"
                    ValidationGroup="Group"
                    Display="Dynamic"
                    ForeColor="red">*</asp:RegularExpressionValidator>
            </asp:TableCell>
        </asp:TableRow>
        <asp:TableRow runat="server">
            <asp:TableCell style=" text-align: right; padding-bottom: 5px; ">CVV:</asp:TableCell>
            <asp:TableCell style=" text-align: left; padding-bottom: 5px; ">
                <asp:TextBox ID="txtCVV" runat="server" Placeholder="123" 
                    Style=" background-color: white; border: 1px solid #b08101; color: black; margin: auto; " ></asp:TextBox>
                <asp:RequiredFieldValidator ID="reqCVV" CssClass="val" runat="server"
                    ControlToValidate="txtCVV"
                    IniticalValue="none"
                    ErrorMessage="Cvv is required"
                    ToolTip="Cvv is required"
                    ForeColor="Red"
                    ValidationGroup="Group">*</asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="regCVV" CssClass="val" runat="server"
                    ErrorMessage="CVV is not in valid format" 
                    ToolTip="CVV is not in valid format"
                    ControlToValidate="txtCVV"
                    ValidationExpression="^[0-9]{0,4}$"
                    ValidationGroup="Group"
                    Display="Dynamic"
                    ForeColor="red">*</asp:RegularExpressionValidator>
            </asp:TableCell>
        </asp:TableRow>
    </asp:Table>
    <div style=" color: black; padding-bottom: 10px; margin: 30px auto 0; width: 50%;">
        <h3>Delivery Information</h3>
    </div>
    <asp:DetailsView ID="detUser" runat="server" AutoGenerateRows="False" 
        Style=" border: 2px solid #b08101; margin: -10px auto 10px; width: auto; " CellPadding="10" >
        <Fields>
            <asp:TemplateField HeaderText="First Name">
                <ItemTemplate>
                    <asp:TextBox ID="txtFirstName" runat="server" Text='<%# Eval("firstName") %>' ReadOnly="true"
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
                    <asp:TextBox ID="txtLastName" runat="server" Text='<%# Eval("lastName") %>' ReadOnly="true"
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
            <asp:TemplateField HeaderText="Recipient Name">
                <ItemTemplate>
                    <asp:TextBox ID="txtRecipientName" runat="server" 
                        Style=" background-color: white; border: 1px solid #b08101; color: black; margin: auto; "></asp:TextBox>
                    <asp:RequiredFieldValidator ID="reqRecipientName" runat="server" CssClass="val"
                       ErrorMessage="Recipient name is required"
                       ToolTip="Recipient name is required"
                       ControlToValidate="txtRecipientName"
                       ValidationGroup="Group"
                       Display="Dynamic"
                       ForeColor="Red">*</asp:RequiredFieldValidator>
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
    <asp:Button ID="btnConfirmOrder" CssClass="button" Text="Confirm Order" runat="server" ValidationGroup="Group" 
        style=" margin-top: 15px; padding: 5px 10px; width: auto;" OnClick="btnConfirmOrder_Click" />
    <%
        }
        else
        {
    %>
    <h2>Order Confirmation</h2>
    <div style="color:black;">Your Order is sucessfuly confirmed now.</div>
    <div style="color:black;">Go to <a href="../UserPage/index.aspx" style="color: blue; font-weight: bold;">Home</a></div>
    <%
        }
    %>

</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolder4" runat="server">
    <uc1:ucLogin runat="server" ID="ucLogin" />
</asp:Content>
