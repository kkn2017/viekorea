using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace VieKoreaFoods.UserControls
{
    public partial class ucLogin : System.Web.UI.UserControl
    {
        public bool IsAdmin { get; set; }

        protected void Page_Load(object sender, EventArgs e)
        {
            
            if (Session["authenticated"] == null)
            {
                this.btnLogout.Visible = false;
                this.lblLoginName.Visible = false;
                this.divAccount.Visible = false;
                this.Login.Visible = true;
            }
            else
            {
                this.btnLogout.Visible = true;
                this.lblLoginName.Text = "Welcome, " + Session["authenticatedUser"].ToString();
                this.lblLoginName.Visible = true;
                this.divAccount.Visible = true;
                this.Login.Visible = false;
            }
        }

        protected void Login_Authenticate(object sender, AuthenticateEventArgs e)
        {
            e.Authenticated = false;
            string loginUser = Login.UserName;
            string loginPassword = Login.Password;

            if (IsAdmin == false)
            {
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
            else
            {
                e.Authenticated = AuthenticateAdmin(loginUser, loginPassword);

                if (e.Authenticated)
                {
                    Response.Redirect("~/admin/AdminDashboard.aspx");
                }
            }
            
        }

        private bool AuthenticateAdmin(string userName, string password)
        {
            bool isTrue = false;
            try
            {
                List<SqlParameter> prms = new List<SqlParameter>();

                prms.Add(DBHelper.SetAdminUserNameParam(userName));
                prms.Add(DBHelper.SetAdminPasswordParam(password));

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

        private bool AuthenticateUser(string userName, string password)
        {
            bool isTrue = false;

            try
            {
                List<SqlParameter> prms = new List<SqlParameter>();

                prms.Add(DBHelper.SetCustomerUserNameParam(userName));
                prms.Add(DBHelper.SetCustomerPasswordParam(password));

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

        private bool IsValidated(string userName)
        {
            bool isValidated = false;

            List<SqlParameter> prms = new List<SqlParameter>()
            {
                DBHelper.SetCustomerUserNameParam(userName)
            };

            isValidated = DBHelper.GetScalarValue<bool>("Validation", prms.ToArray());

            return isValidated;
        }

        private bool IsArchived(string userName)
        {
            bool isArchived = false;

            List<SqlParameter> prms = new List<SqlParameter>()
            {
                DBHelper.SetCustomerUserNameParam(userName)
            };

            isArchived = DBHelper.GetScalarValue<bool>("Archive", prms.ToArray());

            return isArchived;
        }

        protected void LogoutButton_Click(object sender, EventArgs e)
        {
            Session["authenticated"] = null;
            Session["authenticatedUser"] = null;
            Session["validatedUser"] = null;
            Session["admin"] = null;

            this.btnLogout.Visible = false;
            this.lblLoginName.Visible = false;
            this.Login.Visible = true;

            Response.Redirect("~/UserPage/index.aspx");
        }
    }
}