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
                if( section == "OrderHistory")
                {
                    string user = Common.GetAuthenticatedUser(Session);
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
            }
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