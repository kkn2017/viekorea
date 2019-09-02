<%--author: Kwangeun Oh
date: 2019.03.05
file: contact.aspx--%>

<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="contact.aspx.cs" Inherits="VieKoreaFoods.UserPage.contact" %>

<%@ Register Src="~/UserControls/ucProducts.ascx" TagPrefix="uc1" TagName="ucProducts" %>
<%@ Register Src="~/UserControls/ucLogin.ascx" TagPrefix="uc1" TagName="ucLogin" %>
<%@ Register Src="~/UserControls/ucNavigation.ascx" TagPrefix="uc1" TagName="ucNavigation" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <uc1:ucNavigation runat="server" ID="ucNavigation" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
    <h2 style=" margin: 0;">Contact</h2>
    <div id="map_canvas" class="embed-container" style=" width: 100%; height: 400px; margin: 0px;"></div>
    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCAE0B0xF-tPdEPGVJwfSNL8XDnx2DOPD4&sensor=false&language=en"></script> 
    <script> 
        function initialize() {
            var myLatlng = new google.maps.LatLng(40.779615, -73.963255);
            var mapOptions = {
                zoom: 14,
                center: myLatlng,
                mapTypeId: google.maps.MapTypeId.ROADMAP
            }
            var map = new google.maps.Map(document.getElementById('map_canvas'), mapOptions);
            var marker = new google.maps.Marker({
                position: myLatlng,
                map: map,
                title: "VieKorea Restaurant"
            });
        }
        window.onload = initialize;
    </script>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder3" runat="server">
    <table style=" border-collapse: collapse; font-size: 17px; ">
        <tr>
            <td style=" border: 2px solid #b08101; color: black; padding: 0px 15px;">Address</td>
            <td style=" border: 2px solid #b08101; padding: 0px 15px;"><p style="margin-bottom: -10px;">VieKorea Restaurant</p> 
                <p>1111 Central Park New York, NY US 1A0 2B5</p></td>
        </tr>
        <tr>
            <td style=" border: 2px solid #b08101; color: black; padding: 0px 15px;">Parking Lot</td>
            <td style=" border: 2px solid #b08101; padding: 0px 15px;"><p style="margin-bottom: -10px;">Lorem ipsum dolor sit amet, consectetur adipiscing elit</p> 
                <p>Lorem ipsum dolor sit amet</p></td>
        </tr>
                <tr>
            <td style=" border: 2px solid #b08101; color: black; padding: 0px 15px;">Contact Us</td>
            <td style=" border: 2px solid #b08101; padding: 0px 15px;"><p style="margin-bottom: -10px;">Phone: (111)222-3333</p> 
                <p>Email: contact@viekorea.com</p></td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolder4" runat="server">
    <uc1:ucLogin runat="server" ID="ucLogin" />
</asp:Content>