<%--author: Kwangeun Oh
date: 2019.03.05
file: ucRegister.ascx--%>

<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ucRegister.ascx.cs" Inherits="VieKoreaFoods.UserControls.ucRegister" %>

<h2>Create Your Account</h2>
<div id="beforeRegister" runat="server">
    <asp:Label ID="lblError" runat="server" EnableViewState="False" Text="" ForeColor="Red" />
    <table>
        <tr>
            <th>User Name:&nbsp;</th>
            <td>
                <asp:TextBox ID="txtUserName" CssClass="table_input" runat="server" ValidationGroup="Group" />
                <asp:RequiredFieldValidator ID="reqUserName" runat="server" ValidationGroup="Group" 
                    ErrorMessage="User Name is required."
                    ToolTip="User Name is required."
                    ControlToValidate="txtUserName"
                    Display="Dynamic"
                    ForeColor="Red"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <th>Fist Name:&nbsp;</th>
            <td>
                <asp:TextBox ID="txtFirstName" CssClass="table_input" runat="server" ValidationGroup="Group" />
                <asp:RequiredFieldValidator ID="reqFirstName" runat="server" ValidationGroup="Group" 
                    ErrorMessage="First Name is required."
                    ToolTip="First Name is required."
                    ControlToValidate="txtFirstName"
                    Display="Dynamic"
                    ForeColor="Red"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <th>Last Name:&nbsp;</th>
            <td>
                <asp:TextBox ID="txtLastName" CssClass="table_input" runat="server" ValidationGroup="Group" />
                <asp:RequiredFieldValidator ID="reqLastName" runat="server" ValidationGroup="Group" 
                    ErrorMessage="Last Name is required."
                    ToolTip="Last Name is required."
                    ControlToValidate="txtLastName"
                    Display="Dynamic"
                    ForeColor="Red"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <th>Email Address:&nbsp;</th>
            <td>
                <asp:TextBox ID="txtEmailAddress" CssClass="table_input" runat="server" ValidationGroup="Group" />
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
            </td>
        </tr>
        <tr>
            <th>Birthday:&nbsp;</th>
            <td>
                <asp:TextBox ID="txtBirthday" CssClass="table_input" runat="server" ValidationGroup="Group" placeholder="mm/dd/yyyy" />
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
            </td>
        </tr>
        <tr>
            <th>Street:&nbsp;</th>
            <td>
                <asp:TextBox ID="txtStreet" CssClass="table_input" runat="server" ValidationGroup="Group" />
                <asp:RequiredFieldValidator ID="reqStreet" runat="server" ValidationGroup="Group"
                    ErrorMessage="Street is required"
                    ToolTip="Street is required"
                    ControlToValidate="txtStreet"
                    Display="Dynamic"
                    ForeColor="Red"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <th>City:&nbsp;</th>
            <td>
                <asp:TextBox ID="txtCity" CssClass="table_input" runat="server" ValidationGroup="Group" />
                <asp:RequiredFieldValidator ID="reqCity" runat="server" ValidationGroup="Group"
                    ErrorMessage="City is required"
                    ToolTip="City is required"
                    ControlToValidate="txtCity"
                    Display="Dynamic"
                    ForeColor="Red"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <th>Province:&nbsp;</th>
            <td>
                <asp:TextBox ID="txtProvince" CssClass="table_input" runat="server" ValidationGroup="Group" placeholder="NB"/>
                <asp:RequiredFieldValidator ID="reqProvince" runat="server" ValidationGroup="Group"
                    ErrorMessage="Province is required"
                    ToolTip="Province is required"
                    ControlToValidate="txtProvince"
                    Display="Dynamic"
                    ForeColor="Red"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="regProvince" runat="server" ValidationGroup="Group"                                                             
                    ErrorMessage="Province must be two characters"
                    ToolTip="Province must be two characters"
                    ControlToValidate="txtProvince"
                    ValidationExpression="^[\s\S]{2,2}$" 
                    Display="Dynamic"
                    ForeColor="Red"></asp:RegularExpressionValidator>
            </td>
        </tr>
        <tr>
            <th>Postal Code:&nbsp;</th>
            <td>
                <asp:TextBox ID="txtPostalCode" CssClass="table_input" runat="server" ValidationGroup="Group" placeholder="H0H1H2" />
                <asp:RequiredFieldValidator ID="reqPostalCode" runat="server" ValidationGroup="Group"
                    ErrorMessage="Postal code is required"
                    ToolTip="Postal code is required"
                    ControlToValidate="txtPostalCode"
                    Display="Dynamic"
                    ForeColor="Red"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="regPostalCode" runat="server" ValidationGroup="Group"
                    ErrorMessage="Postal code is not in valid format"
                    ToolTip="Postal code is not in valid format"
                    ControlToValidate="txtPostalCode"
                    ValidationExpression="[ABCEGHJKLMNPRSTVXY][0-9][ABCEGHJKLMNPRSTVWXYZ][0-9][ABCEGHJKLMNPRSTVWXYZ][0-9]"
                    Display="Dynamic"
                    ForeColor="red"></asp:RegularExpressionValidator>
            </td>
        </tr>
        <tr>
            <th>Phone:&nbsp;</th>
            <td>
                <asp:TextBox ID="txtPhone" CssClass="table_input" runat="server" ValidationGroup="Group" />
                <asp:RequiredFieldValidator ID="reqPhone" runat="server" ValidationGroup="Group"
                    ErrorMessage="Phone number is required"
                    ToolTip="Phone number is required"
                    ControlToValidate="txtPhone"
                    Display="Dynamic"
                    ForeColor="Red"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="regPhone" runat="server" ValidationGroup="Group"
                    ErrorMessage="Phone number is not in valid format" 
                    ToolTip="Phone number is not in valid format"
                    ControlToValidate="txtPhone"
                    ValidationExpression="^([0-9\(\)\/\+ \-]*)$"
                    Display="Dynamic"
                    ForeColor="red"></asp:RegularExpressionValidator>
            </td>
        </tr>
        <tr>
            <th>Password:&nbsp;</th>
            <td>
                <asp:TextBox ID="txtPassword" CssClass="table_input" runat="server" ValidationGroup="Group" />
                <asp:RequiredFieldValidator ID="reqPassword" runat="server" ValidationGroup="Group"
                    ErrorMessage="Password is required"
                    ToolTip="Password is required"
                    data-toggle="tooltip"
                    data-placement="right"
                    ControlToValidate="txtPassword"
                    Display="Dynamic" 
                    ForeColor="Red"></asp:RequiredFieldValidator>
                <asp:CompareValidator ID="compPassword" runat="server" ValidationGroup="Group"
                    ErrorMessage="Password does not match"
                    ToolTip="Passwords do not match"
                    data-toggle="tooltip"
                    data-placement="right"
                    ControlToCompare="txtConfirmPassword"
                    ControlToValidate="txtPassword"
                    Display="Dynamic" 
                    ForeColor="Red"></asp:CompareValidator>
            </td>
        </tr>
        <tr>
            <th>Confirm Password:&nbsp;</th>
            <td>
                <asp:TextBox ID="txtConfirmPassword" CssClass="table_input" runat="server" ValidationGroup="Group" />
                <asp:RequiredFieldValidator ID="reqConfirmPassword" runat="server" ValidationGroup="Group"
                    ErrorMessage="Confirm password is required"
                    ToolTip="Confirm password is required"
                    data-toggle="tooltip"
                    data-placement="right"
                    ControlToValidate="txtConfirmPassword"
                    Display="Dynamic" 
                    ForeColor="Red"></asp:RequiredFieldValidator>
                <asp:CompareValidator ID="compConfirmPassword" runat="server" ValidationGroup="Group"
                    ErrorMessage="Password does not match"
                    ToolTip="Password does not match"
                    data-toggle="tooltip"
                    data-placement="right"
                    ControlToValidate="txtConfirmPassword"
                    ControlToCompare="txtPassword"
                    Display="Dynamic" 
                    ForeColor="Red"></asp:CompareValidator>
            </td>
        </tr>
        <tr>
            <th></th>
            <td>
                <asp:Button ID="btnRegister" CssClass="button" Text="Create Account" runat="server" ValidationGroup="Group"
                    OnClick="btnRegister_Click"/>
            </td>
        </tr>
    </table>
</div>
<div id="afterRegister" runat="server">
    <p>Thank you for creating an account. We sent a validation letter to your email address. Your account is going to be activated right 
        after checking the email. Now you can go to </p>
    <asp:HyperLink NavigateUrl="~/UserPage/index.aspx" runat="server">Home</asp:HyperLink>
</div>
