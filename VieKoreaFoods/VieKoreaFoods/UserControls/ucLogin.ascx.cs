// author: Kwangeun Oh
// date: 2019.03.05
// file: ucLogin.ascx.cs

using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Web;
using System.Web.UI.WebControls;

namespace VieKoreaFoods.UserControls
{
    /// <summary>
    /// ucLogin Partial Class
    /// </summary>
    public partial class ucLogin : System.Web.UI.UserControl
    {
        public bool IsAdmin { get; set; }

        /// <summary>
        /// Login Page is loaded.
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void Page_Load(object sender, EventArgs e)
        {
            // If the admin login is activated, user account hyperlink is disabled 
            // because admin users don't need their own account page.
            if(this.IsAdmin == false)
            {
                if (Session["authenticated"] != null)
                {
                    this.divAccount.Visible = true;
                    this.divLoginStatus.Visible = true;
                    this.lblLoginName.Text = "Welcome, " + Session["authenticatedUser"].ToString();
                    this.Login.Visible = false;
                }
            }
            else
            {
                if (Session["authenticated"] != null)
                {
                    this.divAccount.Visible = false;
                    this.divAdmin_loginStatus.Visible = true;
                    this.lblAdmin_LoginName.Text = "Welcome, " + Session["authenticatedUser"].ToString();
                    this.Admin_Login.Visible = false;                
                }
            }           
        }

        /// <summary>
        /// User Login is successfuly executed if the user account and password are correct. 
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void Login_Authenticate(object sender, AuthenticateEventArgs e)
        {
            e.Authenticated = false;
            string loginUser = this.Login.UserName.ToString();
            string loginPassword = this.Login.Password.ToString();

            e.Authenticated = AuthenticateUser(loginUser, loginPassword);

            if (e.Authenticated)
            {
                if (Request.QueryString["returnurl"] != null)
                {
                    Response.Redirect($"~/{Request.QueryString["returnurl"]}");
                }
                else
                {
                    Response.Redirect($"{HttpContext.Current.Request.Url.ToString()}");
                }
            }            
        }

        /// <summary>
        /// Admin Login is successfuly executed if the user account and password are correct.
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void Admin_Login_Authenticate(object sender, AuthenticateEventArgs e)
        {
            e.Authenticated = false;
            string loginUser = this.Admin_Login.UserName.ToString();
            string loginPassword = this.Admin_Login.Password.ToString();

            e.Authenticated = AuthenticateAdmin(loginUser, loginPassword);

            if (e.Authenticated)
            {
                Response.Redirect("~/admin/admin_main.aspx");
            }
        }

        /// <summary>
        /// Checks whether or not admin user name and password are correct.
        /// </summary>
        /// <param name="userName"></param>
        /// <param name="password"></param>
        /// <returns></returns>
        private bool AuthenticateAdmin(string userName, string password)
        {
            bool isTrue = false;
            try
            {
                List<SqlParameter> prms = new List<SqlParameter>();

                prms.Add(Common.SetAdminUserNameParam(userName));
                prms.Add(Common.SetAdminPasswordParam(password));

                isTrue = !string.IsNullOrEmpty(DBHelper.GetScalarValue<string>("LoginAdmin", prms.ToArray()));

                if (isTrue)
                {
                    Session["authenticated"] = true;
                    Session["authenticatedUser"] = userName;
                    Session["admin"] = true;
                }
                else
                {
                    Session["authenticated"] = null;
                    Session["authenticatedUser"] = null;
                    Session["admin"] = null;
                }
            }
            catch (SqlException ex)
            {
                Login.FailureText = ex.Message;
            }

            return isTrue;
        }

        /// <summary>
        /// Checks whether or not user name and password are correct.
        /// </summary>
        /// <param name="userName"></param>
        /// <param name="password"></param>
        /// <returns></returns>
        private bool AuthenticateUser(string userName, string password)
        {
            bool isTrue = false;

            try
            {
                List<SqlParameter> prms = new List<SqlParameter>();

                prms.Add(Common.SetCustomerUserNameParam(userName));
                prms.Add(Common.SetCustomerPasswordParam(password));

                isTrue = !string.IsNullOrEmpty(DBHelper.GetScalarValue<string>("Login", prms.ToArray())) && !IsArchived(userName);

                if (isTrue)
                {
                    Session["authenticated"] = true;
                    Session["authenticatedUser"] = userName;

                    switch (IsValidated(userName))
                    {
                        case true:
                            Session["validatedUser"] = true;
                            break;
                        case false:
                            Session["validatedUser"] = null;
                            break;
                        default:
                            break;
                    }
                }
                else
                {
                    Session["authenticated"] = null;
                    Session["authenticatedUser"] = null;
                    Session["validatedUser"] = null;
                }
            }
            catch (SqlException ex)
            {
                Login.FailureText = ex.Message;
            }

            return isTrue;
        }

        /// <summary>
        /// Check whether or not the user account is validated.
        /// </summary>
        /// <param name="userName"></param>
        /// <returns></returns>
        private bool IsValidated(string userName)
        {
            bool isValidated = false;

            List<SqlParameter> prms = new List<SqlParameter>()
            {
                Common.SetCustomerUserNameParam(userName)
            };

            isValidated = DBHelper.GetScalarValue<bool>("Validation", prms.ToArray());

            return isValidated;
        }

        /// <summary>
        /// Check whether or not the user account is archived.
        /// </summary>
        /// <param name="userName"></param>
        /// <returns></returns>
        private bool IsArchived(string userName)
        {
            bool isArchived = false;

            List<SqlParameter> prms = new List<SqlParameter>()
            {
                Common.SetCustomerUserNameParam(userName)
            };

            isArchived = DBHelper.GetScalarValue<bool>("Archive", prms.ToArray());

            return isArchived;
        }

        /// <summary>
        /// As logout button event handler, logout is activated after clicking the button.
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void LogoutButton_Click(object sender, EventArgs e)
        {
            Session["authenticated"] = null;
            Session["authenticatedUser"] = null;
            Session["validatedUser"] = null;

            this.divLoginStatus.Visible = false;
            this.Login.Visible = true;

            Response.Redirect("~/default.aspx");
        }

        /// <summary>
        /// As logout button event handler, admin logout is activated after clicking the button.
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void Admin_LogoutButton_Click(object sender, EventArgs e)
        {
            Session["authenticated"] = null;
            Session["authenticatedUser"] = null;
            Session["admin"] = null;

            this.divAdmin_loginStatus.Visible = false;
            this.Admin_Login.Visible = true;

            Response.Redirect("~/default.aspx");
        }
    }
}