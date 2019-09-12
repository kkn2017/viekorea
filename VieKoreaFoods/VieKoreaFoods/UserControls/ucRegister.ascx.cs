using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace VieKoreaFoods.UserControls
{
    public partial class ucRegister : System.Web.UI.UserControl
    {
        /// <summary>
        /// 
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void Page_Load(object sender, EventArgs e)
        {
            this.beforeRegister.Visible = true;
            this.afterRegister.Visible = false;
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void btnRegister_Click(object sender, EventArgs e)
        {
            try
            {
                if (Page.IsValid)
                {
                    string userName = this.txtUserName.Text.Trim();
                    string firstName = this.txtFirstName.Text.Trim();
                    string lastName = this.txtLastName.Text.Trim();
                    string emailAddress = this.txtEmailAddress.Text.Trim();
                    string street = this.txtStreet.Text.Trim();
                    string city = this.txtCity.Text.Trim();
                    string province = this.txtProvince.Text.Trim();
                    string postalCode = this.txtPostalCode.Text.Trim();
                    string phone = this.txtPhone.Text.Trim();
                    string password = this.txtPassword.Text.Trim();
                    DateTime birthday = Convert.ToDateTime(this.txtBirthday.Text);
                    bool archived = false;
                    bool validated = false;

                    if (!IsUnderNineteen(birthday))
                    {

                        int id = CreateAccount(
                                    userName,
                                    firstName,
                                    lastName,
                                    emailAddress,
                                    street,
                                    city,
                                    province,
                                    postalCode,
                                    phone,
                                    password,
                                    birthday,
                                    archived,
                                    validated);
                        if (id != 0)
                        {
                            Session["authenticated"] = true;
                            Session["authenticatedUser"] = userName;

                            this.afterRegister.Visible = true;
                            this.beforeRegister.Visible = false;

                            // send email and validation here
                            SendValidationEmail(id);

                            //if (Request.QueryString["returnurl"] != null)
                            //    Response.Redirect($"~/{Request.QueryString["returnurl"]}");
                            //else
                            //    Response.Redirect("~/MyAccount.aspx?created");
                        }
                        else
                        {
                            lblError.Text = "account is not created.";
                        }

                    }
                }
            }
            catch (SqlException ex)
            {
                this.lblError.Text = ex.Message;
            }
            catch (Exception ex)
            {
                this.lblError.Text = ex.Message;
            }
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="birthday"></param>
        /// <returns></returns>
        private bool IsUnderNineteen(DateTime birthday)
        {
            const int LEGAL_AGE = 19;
            return birthday.AddYears(LEGAL_AGE) > DateTime.Now;
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="userName"></param>
        /// <param name="firstName"></param>
        /// <param name="lastName"></param>
        /// <param name="emailAddress"></param>
        /// <param name="street"></param>
        /// <param name="city"></param>
        /// <param name="province"></param>
        /// <param name="postalCode"></param>
        /// <param name="phone"></param>
        /// <param name="password"></param>
        /// <param name="birthday"></param>
        /// <param name="archived"></param>
        /// <param name="validated"></param>
        /// <returns></returns>
        private int CreateAccount(string userName, string firstName, string lastName, string emailAddress, string street, string city, string province, string postalCode, string phone, string password, DateTime birthday, bool archived, bool validated)
        {
            int id = 0;
            try
            {
                List<SqlParameter> prms = new List<SqlParameter>();

                prms.Add(Common.SetCustomerUserNameParam(userName));
                prms.Add(Common.SetCustomerFirstNameParam(firstName));
                prms.Add(Common.SetCustomerLastNameParam(lastName));
                prms.Add(Common.SetCustomerEmailParam(emailAddress));
                prms.Add(Common.SetCustomerStreetParam(street));
                prms.Add(Common.SetCustomerCityParam(city));
                prms.Add(Common.SetCustomerProvinceParam(province));
                prms.Add(Common.SetCustomerPostalCodeParam(postalCode));
                prms.Add(Common.SetCustomerPhoneParam(phone));
                prms.Add(Common.SetCustomerPasswordParam(password));
                prms.Add(Common.SetCustomerBirthDayParam(birthday));
                prms.Add(Common.SetCustomerArchivedParam(archived));
                prms.Add(Common.SetCustomerValidatedParam(validated));

                prms.Add(new SqlParameter()
                {
                    ParameterName = "@Id",
                    SqlDbType = SqlDbType.Int,
                    Direction = ParameterDirection.Output
                });

                id = DBHelper.Insert<int>("InsertCustomer", "@Id", prms.ToArray());
            }
            catch (Exception ex)
            {

                lblError.Text = ex.Message;
            }

            return id;
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="id"></param>
        private void SendValidationEmail(int id)
        {
            using (MailMessage message = new MailMessage("noreply@viekor.com", this.txtEmailAddress.Text.Trim()))
            {
                message.Subject = "New Account Validation";
                string body = $"Hi {this.txtUserName.Text.Trim()}, <br /> This is VIEKOR Restaurant. Thank you for creating a new account"
                    + $"<br /><br />Please click the following link to validate your account."
                    + $"<br /><a href={Request.Url.AbsoluteUri.Replace("~/UserPage/register.aspx", $"~/UserPage/validation.aspx?id={id}")}"
                    + $"<br /><br /><h2>Thank you again.</ h2>";
                message.Body = body;
                message.IsBodyHtml = true;

                DirectoryInfo directInfo = new DirectoryInfo(@"c:\KE Oh\Email");

                if(!directInfo.Exists)
                {
                    Directory.CreateDirectory(@"c:\KE Oh\Email");
                }

                SmtpClient smtp = new SmtpClient();
                smtp.DeliveryMethod = SmtpDeliveryMethod.SpecifiedPickupDirectory;
                smtp.PickupDirectoryLocation = @"c:\KE Oh\Email";
                smtp.Send(message);
            }
        }
    }
}