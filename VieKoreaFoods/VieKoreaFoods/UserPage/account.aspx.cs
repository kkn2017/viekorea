using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace VieKoreaFoods.UserPage
{
    public partial class MyAccount : System.Web.UI.Page
    {
        /// <summary>
        /// 
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void Page_Load(object sender, EventArgs e)
        {
            string section = Request.QueryString["returnSection"];

            if (!IsPostBack)
            {
                string user = Common.GetAuthenticatedUser(Session);

                if ( section == "OrderHistory")
                {                    
                    int customerId = DBHelper.GetQueryValue<int>("SelectCustomers", "id", new SqlParameter[] 
                    {
                        new SqlParameter()
                        {
                            ParameterName = "@UserName",
                            SqlDbType = SqlDbType.NVarChar,
                            Size = 50,
                            Value = user
                        }
                    });

                    DBHelper.DataBinding(this.grdOrderHistory, "SelectOrders", new SqlParameter[]
                    {
                        new SqlParameter()
                        {
                            ParameterName = "@CustomerId",
                            SqlDbType = SqlDbType.Int,
                            Value = customerId
                        }
                    });
                }
                else if (section == "Privacy")
                {
                    DBHelper.DataBinding(this.detPrivacy, "SelectCustomers", new SqlParameter[] 
                    {
                        new SqlParameter()
                        {
                            ParameterName = "@UserName",
                            SqlDbType = SqlDbType.NVarChar,
                            Size = 50,
                            Value = user
                        }
                    });
                }
            }
        }

        /// <summary>
        /// Update the personal Information
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void btnUpdatePersonalInfo_Click(object sender, EventArgs e)
        {
            TextBox txtUserName = (TextBox)this.detPrivacy.Rows[0].Cells[1].FindControl("txtUserName");
            TextBox txtFirstName = (TextBox)this.detPrivacy.Rows[1].Cells[1].FindControl("txtFirstName");
            TextBox txtLastName = (TextBox)this.detPrivacy.Rows[2].Cells[1].FindControl("txtLastName");
            TextBox txtEmailAddress = (TextBox)this.detPrivacy.Rows[3].Cells[1].FindControl("txtEmailAddress");
            TextBox txtBirthday = (TextBox)this.detPrivacy.Rows[4].Cells[1].FindControl("txtBirthday");
            TextBox txtStreet = (TextBox)this.detPrivacy.Rows[5].Cells[1].FindControl("txtStreet");
            TextBox txtCity = (TextBox)this.detPrivacy.Rows[6].Cells[1].FindControl("txtCity");
            TextBox txtProvince = (TextBox)this.detPrivacy.Rows[7].Cells[1].FindControl("txtProvince");
            TextBox txtPostalCode = (TextBox)this.detPrivacy.Rows[8].Cells[1].FindControl("txtPostalCode");
            TextBox txtPhone = (TextBox)this.detPrivacy.Rows[9].Cells[1].FindControl("txtPhone");

            string userName = txtUserName.Text.Trim();
            string firstName = txtFirstName.Text.Trim();
            string lastName = txtLastName.Text.Trim();
            string emailAddress = txtEmailAddress.Text.Trim();
            DateTime birthday = Convert.ToDateTime(txtBirthday.Text.Trim());
            string street = txtStreet.Text.Trim();
            string city = txtCity.Text.Trim();
            string province = txtProvince.Text.Trim();
            string postalCode = txtPostalCode.Text.Trim();
            string phone = txtPhone.Text.Trim();

            try
            {
                int customerId = DBHelper.GetQueryValue<int>("SelectCustomers", "id", new SqlParameter[] {
                new SqlParameter()
                {
                    ParameterName = "@UserName",
                    SqlDbType = SqlDbType.NVarChar,
                    Size = 50,
                    Value = userName
                }
                });

                List<SqlParameter> prms = new List<SqlParameter>();

                prms.Add(new SqlParameter() { ParameterName = "@Id", SqlDbType = SqlDbType.Int, Value = customerId });
                prms.Add(new SqlParameter() { ParameterName = "@UserName", SqlDbType = SqlDbType.NVarChar, Size = 50, Value = userName });
                prms.Add(new SqlParameter() { ParameterName = "@FirstName", SqlDbType = SqlDbType.NVarChar, Size = 50, Value = firstName });
                prms.Add(new SqlParameter() { ParameterName = "@LastName", SqlDbType = SqlDbType.NVarChar, Size = 50, Value = lastName });
                prms.Add(new SqlParameter() { ParameterName = "@Email", SqlDbType = SqlDbType.NVarChar, Size = 50, Value = emailAddress });
                prms.Add(new SqlParameter() { ParameterName = "@Birth", SqlDbType = SqlDbType.Date, Value = birthday });
                prms.Add(new SqlParameter() { ParameterName = "@Street", SqlDbType = SqlDbType.NVarChar, Size = 50, Value = street });
                prms.Add(new SqlParameter() { ParameterName = "@City", SqlDbType = SqlDbType.NVarChar, Size = 20, Value = city });
                prms.Add(new SqlParameter() { ParameterName = "@Province", SqlDbType = SqlDbType.NVarChar, Size = 2, Value = province });
                prms.Add(new SqlParameter() { ParameterName = "@PostalCode", SqlDbType = SqlDbType.NVarChar, Size = 6, Value = postalCode });
                prms.Add(new SqlParameter() { ParameterName = "@Phone", SqlDbType = SqlDbType.NVarChar, Size = 10, Value = phone });

                DBHelper.NonQuery("UpdateCustomer", prms.ToArray());

                this.detPrivacy.Visible = false;
                this.btnUpdatePersonalInfo.Visible = false;
                this.divUpdatedPersonalInfo.Visible = true;
                this.btnBackToPrivacy.Visible = true;
            }
            catch (SqlException ex)
            {
                this.lblError.Text = ex.Message;
            }          
        }

        /// <summary>
        /// Go back to the personal information
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void btnBackToPrivacy_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/UserPage/account.aspx?returnSection=Privacy");
        }

        /// <summary>
        /// Delete the order history
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void btnDeleteOrdHistory_Click(object sender, EventArgs e)
        {
            try
            {
                List<SqlParameter> prms = new List<SqlParameter>();

                foreach (GridViewRow row in this.grdOrderHistory.Rows)
                {
                    if (row.RowType == DataControlRowType.DataRow)
                    {
                        CheckBox chkRemove = (CheckBox)row.FindControl("chkRemove");

                        if (chkRemove.Checked == true)
                        {
                            int orderNumber = Convert.ToInt32(this.grdOrderHistory.DataKeys[row.RowIndex].Value);
                            prms.Add(new SqlParameter()
                            {
                                ParameterName = "@OrderNumber",
                                SqlDbType = SqlDbType.Int,
                                Value = orderNumber
                            });
                        }
                    }
                }

                DBHelper.NonQuery("DeleteOrders", prms.ToArray());
            }
            catch (SqlException ex)
            {
                this.lblError.Text = ex.Message;
            }
            catch (Exception ex)
            {
                this.lblError.Text = ex.Message;
            }

            Response.Redirect($"{HttpContext.Current.Request.Url.ToString()}");
        }

        /// <summary>
        /// See the details of the order you clicked the button in the grid view.
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void grdOrderHistory_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            try
            {
                int index = Convert.ToInt32(e.CommandArgument);
                int orderNumber = Convert.ToInt32(this.grdOrderHistory.DataKeys[index].Value);

                DBHelper.DataBinding(this.grdOrderDetails, "SelectOrderDetails", new SqlParameter[]
                    {
                        new SqlParameter()
                        {
                            ParameterName = "@OrderId",
                           SqlDbType = SqlDbType.NVarChar,
                            Value = orderNumber
                         }
                    });

                this.grdOrderHistory.Visible = false;
                this.btnDeleteOrdHistory.Visible = false;
                this.grdOrderDetails.Visible = true;
                this.btnBackToHistory.Visible = true;
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
        /// Go Back to the order history from the order details
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void btnBackToHistory_Click(object sender, EventArgs e)
        {
            this.grdOrderHistory.Visible = true;
            this.btnDeleteOrdHistory.Visible = true;
            this.grdOrderDetails.Visible = false;
            this.btnBackToHistory.Visible = false;
        }
    }
}