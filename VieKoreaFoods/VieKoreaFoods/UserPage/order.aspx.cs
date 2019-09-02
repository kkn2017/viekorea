using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Net.Mail;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace VieKoreaFoods.UserPage
{
    public partial class order : System.Web.UI.Page
    {
        public bool ConfirmedOrder { get; set; }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack)
            {
                if (this.rblPaymentMethod.SelectedItem != null)
                {
                    if (this.rblPaymentMethod.SelectedItem.ToString() == "Advance Payment")
                    {
                        this.tblCreditCard.Visible = true;
                    }
                    else
                    {
                        this.tblCreditCard.Visible = false;
                    }                        
                }
            }
            else
            {
                this.ConfirmedOrder = false;
                LoadUserDetails();
            }
        }

        /// <summary>
        /// Load the user details.
        /// </summary>
        private void LoadUserDetails()
        {
            string user = Common.GetAuthenticatedUser(Session);
            SqlParameter userPrm = new SqlParameter()
            {
                ParameterName = "@UserName",
                SqlDbType = SqlDbType.NVarChar,
                Size = 50,
                Value = user
            };
            DBHelper.DataBinding(this.detUser, "SelectCustomerInfo", new SqlParameter[] { userPrm });
        }

        /// <summary>
        /// Order is confirmed right after click this button.
        /// Order Confirmation Mail is sent to the user, and every order data is stored in SQL server.
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void btnConfirmOrder_Click(object sender, EventArgs e)
        {
            try
            {
                string userName = Common.GetAuthenticatedUser(Session).Trim();

                int orderNumber = SubmitOrder(userName);
                SendEmail(userName, orderNumber);
                this.ConfirmedOrder = true;
                Response.Cookies["CartUId"].Expires = DateTime.Now.AddDays(-1);
            }
            catch (Exception ex)
            {
                this.lblError.Text = ex.Message;
            }
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="name"></param>
        /// <returns></returns>
        private int SubmitOrder(string name)
        {
            int orderNo = 0;

            try
            {
                List<SqlParameter> prms = new List<SqlParameter>();
                int customerID = DBHelper.GetQueryValue<int>("SelectCustomers", "id", new SqlParameter[]
                {
                    new SqlParameter()
                    {
                        ParameterName = "@UserName",
                        SqlDbType = SqlDbType.NVarChar,
                        Size = 50,
                        Value = name
                    }
                });
                prms.Add(new SqlParameter() { ParameterName = "@CustomerId", SqlDbType = SqlDbType.Int, Value = customerID });

                string nowTime = DateTime.Now.ToShortDateString();
                DateTime orderDate = DateTime.Parse(nowTime);
                prms.Add(new SqlParameter() { ParameterName = "@OrderDate", SqlDbType = SqlDbType.Date, Value = orderDate });

                string cartUId = Common.GetCartId(Request, Response).Trim();
                double tax = UserControls.ucCart.tax;
                double shippingCost = UserControls.ucCart.shippingCost;
                double totalCost = UserControls.ucCart.totalCost;

                prms.Add(new SqlParameter() { ParameterName = "@CartUId", SqlDbType = SqlDbType.NVarChar, Size = 50, Value = cartUId });
                prms.Add(new SqlParameter() { ParameterName = "@Tax", SqlDbType = SqlDbType.Money, Value = Convert.ToDecimal(tax) });
                prms.Add(new SqlParameter() { ParameterName = "@ShippingCost", SqlDbType = SqlDbType.Money, Value = Convert.ToDecimal(shippingCost) });
                prms.Add(new SqlParameter() { ParameterName = "@TotalCost", SqlDbType = SqlDbType.Money, Value = Convert.ToDecimal(totalCost) });

                TextBox txtRecipientName = (TextBox)this.detUser.Rows[2].Cells[1].FindControl("txtRecipientName");
                TextBox txtStreet = (TextBox)this.detUser.Rows[3].Cells[1].FindControl("txtStreet");
                TextBox txtCity = (TextBox)this.detUser.Rows[4].Cells[1].FindControl("txtCity");
                TextBox txtProvince = (TextBox)this.detUser.Rows[5].Cells[1].FindControl("txtProvince");
                TextBox txtPostalCode = (TextBox)this.detUser.Rows[6].Cells[1].FindControl("txtPostalCode");
                TextBox txtPhone = (TextBox)this.detUser.Rows[7].Cells[1].FindControl("txtPhone");

                string recipientName = txtRecipientName.Text.Trim();
                string street = txtStreet.Text.Trim();
                string city = txtCity.Text.Trim();
                string province = txtProvince.Text.Trim();
                string postalCode = txtPostalCode.Text.Trim();
                string phone = txtPhone.Text.Trim();

                prms.Add(new SqlParameter() { ParameterName = "@RecipientName", SqlDbType = SqlDbType.NVarChar, Size = 50, Value = recipientName });
                prms.Add(new SqlParameter() { ParameterName = "@Street", SqlDbType = SqlDbType.NVarChar, Size = 50, Value = street });
                prms.Add(new SqlParameter() { ParameterName = "@City", SqlDbType = SqlDbType.NVarChar, Size = 20, Value = city });
                prms.Add(new SqlParameter() { ParameterName = "@Province", SqlDbType = SqlDbType.NVarChar, Size = 2, Value = province });
                prms.Add(new SqlParameter() { ParameterName = "@PostalCode", SqlDbType = SqlDbType.NVarChar, Size = 6, Value = postalCode });
                prms.Add(new SqlParameter() { ParameterName = "@Phone", SqlDbType = SqlDbType.NVarChar, Size = 10, Value = phone });

                string paymentMethod = this.rblPaymentMethod.SelectedItem.ToString().Trim();
                prms.Add(new SqlParameter() { ParameterName = "@Payment", SqlDbType = SqlDbType.NVarChar, Size = 50, Value = paymentMethod });


                if (this.rblPaymentMethod.SelectedItem != null && this.rblPaymentMethod.SelectedItem.ToString().Trim() != "Pay After Delivery")
                {
                    DropDownList ddlCreditCard = (DropDownList)this.tblCreditCard.Rows[0].Cells[1].FindControl("ddlCreditCard");
                    TextBox txtCardNumber = (TextBox)this.tblCreditCard.Rows[1].Cells[1].FindControl("txtCardNumber");
                    TextBox txtCVV = (TextBox)this.tblCreditCard.Rows[2].Cells[1].FindControl("txtCVV");

                    string creditCard = ddlCreditCard.SelectedItem.ToString().Trim();
                    string cardNumber = txtCardNumber.Text.Trim();
                    string cvv = txtCVV.Text.Trim();

                    prms.Add(new SqlParameter() { ParameterName = "@CreditCardName", SqlDbType = SqlDbType.NVarChar, Size = 50, Value = creditCard });
                    prms.Add(new SqlParameter() { ParameterName = "@CreditNumber", SqlDbType = SqlDbType.NVarChar, Size = 50, Value = cardNumber });
                    prms.Add(new SqlParameter() { ParameterName = "@Cvv", SqlDbType = SqlDbType.NVarChar, Size = 50, Value = cvv });
                }

                prms.Add(new SqlParameter() { ParameterName = "@OrderNo", SqlDbType = SqlDbType.Int, Direction = ParameterDirection.Output });
                orderNo = DBHelper.Insert<int>("InsertOrder", "@OrderNo", prms.ToArray());

            }
            catch (Exception e)
            {
                this.lblError.Text = e.Message;
            }

            return orderNo;
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="name"></param>
        /// <param name="number"></param>
        private void SendEmail(string name, int number)
        {
            try
            {
                string emailAddress = DBHelper.GetQueryValue<string>("SelectCustomers", "email", new SqlParameter[] 
                {
                    new SqlParameter()
                    {
                        ParameterName= "@UserName",
                        SqlDbType = SqlDbType.NVarChar,
                        Size = 50,
                        Value = name
                    }
                });

                using (MailMessage mail = new MailMessage("noreply@viekor.com", emailAddress))
                {
                    string htmlHead = "<html><head><style>body{font-family:Arial; color:#000;} table, tr, td{color:blue; border:1px solid #000; font-family:Arial;} </style></head>";

                    mail.Subject = $"Order Confirmation Number: { number.ToString() }";
                    mail.Body = $"{htmlHead}<body>Your order now has been confirmed.<br /> <br /><h2>Order Number: {number.ToString()}</h2><br /><br />"
                       + $"<h3>Order Details</h3><br />{BuildEmailOrderTable(number)}<br /></body></html>";
                    mail.IsBodyHtml = true;

                    DirectoryInfo dirInfo = new DirectoryInfo(@"c:\KE Oh\Email");
                    if(!dirInfo.Exists)
                    {
                        Directory.CreateDirectory(@"c:\KE Oh\Email");
                    }

                    SmtpClient smtp = new SmtpClient();
                    smtp.DeliveryMethod = SmtpDeliveryMethod.SpecifiedPickupDirectory;
                    smtp.PickupDirectoryLocation = dirInfo.ToString();
                    smtp.Send(mail);
                }
            }
            catch (SqlException e)
            {
                this.lblError.Text = e.Message;
            }
            catch (Exception e)
            {
                this.lblError.Text = e.Message;
            }
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="number"></param>
        /// <returns></returns>
        private object BuildEmailOrderTable(int number)
        {
            StringBuilder sb = new StringBuilder();
            DataTable orderDetails = DBHelper.GetQuery("SelectOrderDetails", new SqlParameter[]
            {
                new SqlParameter()
                {
                    ParameterName= "@OrderId",
                    SqlDbType = SqlDbType.Int,
                    Value = number
                }
            });

            sb.Append("<table>");
            sb.Append("<tr><td>Food Name</td><td>Price</td><td>Qty</td><td>SubTotal</td></tr>");

            foreach(DataRow r in orderDetails.Rows)
            {
                sb.Append("<tr>");
                sb.Append($"<td>{r["ProductName"].ToString()}</td>");
                sb.Append($"<td>{double.Parse(r["price"].ToString()).ToString("c2")}</td>");
                sb.Append($"<td>{r["quantity"].ToString()}</td>");
                sb.Append($"<td>{double.Parse(r["linetotal"].ToString()).ToString("c2")}</td>");
                sb.Append("</tr>");               
            }
            sb.Append($"<tr><td>Tax:</td><td>{UserControls.ucCart.tax.ToString("c2")}</td></tr>");
            sb.Append($"<tr><td>Delivery Cost:</td><td>{UserControls.ucCart.shippingCost.ToString("c2")}</td></tr>");
            sb.Append($"<tr><td>Total Cost:</td><td>{UserControls.ucCart.totalCost.ToString("c2")}</td></tr>");
            sb.Append("</table>");

            return sb.ToString();
        }
    }
}