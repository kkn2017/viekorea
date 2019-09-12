using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace VieKoreaFoods.Admin
{
    public partial class maintenance : System.Web.UI.Page
    {
        /// <summary>
        /// 
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void Page_Load(object sender, EventArgs e)
        {
            string queryString = Request.QueryString["returnCategory"]; 

            if (!IsPostBack)
            {
                if (queryString == "foods")
                {
                    LoadFoodsGridView();
                }
                else if (queryString == "customers")
                {
                    DBHelper.DataBindingWithPaging(this.grdCustomers, "SelectCustomers");
                }
            }
        }

        /// <summary>
        /// Bind category and 
        /// </summary>
        private void BindDropDownList()
        {
            try
            {
                //Load the dropdown list in the create row
                DropDownList ddlCategoriesInFooter = (DropDownList)(this.grdFoods.FooterRow.FindControl("ddlCategoriesNew"));
                BindCategoryDropdownList(ddlCategoriesInFooter);

                //Load the dropdown list in the create row
                DropDownList ddlStatusInFooter = (DropDownList)(this.grdFoods.FooterRow.FindControl("ddlStatusNew"));
                BindStatusDropdownList(ddlStatusInFooter);
            }
            catch (Exception e)
            {
                this.lblError.Text = e.Message;
            }
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="ddlStatusInFooter"></param>
        private void BindStatusDropdownList(DropDownList ddlStatus)
        {
            ddlStatus.DataValueField = "id";
            ddlStatus.DataTextField = "status";
            DBHelper.DataBinding(ddlStatus, "SelectStatus");
            ddlStatus.Items.Insert(0, new ListItem("--Select Status--"));
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="ddlCategoriesInFooter"></param>
        private void BindCategoryDropdownList(DropDownList ddlCategories)
        {
            ddlCategories.DataValueField = "id";
            ddlCategories.DataTextField = "name";
            DBHelper.DataBinding(ddlCategories, "SelectCategories");
            ddlCategories.Items.Insert(0, new ListItem("--Select Category--"));
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void grdFoods_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int productId = Convert.ToInt32(this.grdFoods.DataKeys[e.RowIndex].Values[0]);
            SqlParameter prmProductId = new SqlParameter() { ParameterName = "@ProductId", SqlDbType = SqlDbType.Int, Value = productId };

            DBHelper.NonQuery("DeleteProduct", new SqlParameter[] { prmProductId });

            LoadFoodsGridView();
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void grdFoods_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "btnNew")
            {
                AddNewFood();
                LoadFoodsGridView();
            }
        }

        /// <summary>
        /// 
        /// </summary>
        private void LoadFoodsGridView()
        {
            DBHelper.DataBindingWithPaging(this.grdFoods, "SelectProductMaintenance");
            BindDropDownList();
        }

        private void AddNewFood()
        {
            TextBox txtProductName = (TextBox)this.grdFoods.FooterRow.FindControl("txtProductNameNew");
            TextBox txtBriefDesc = (TextBox)this.grdFoods.FooterRow.FindControl("txtBriefDescNew");
            TextBox txtFullDesc = (TextBox)this.grdFoods.FooterRow.FindControl("txtFullDescNew");
            DropDownList ddlStatus = (DropDownList)this.grdFoods.FooterRow.FindControl("ddlStatusNew");
            TextBox txtPrice = (TextBox)this.grdFoods.FooterRow.FindControl("txtPriceNew");
            CheckBox chkFeatured = (CheckBox)this.grdFoods.FooterRow.FindControl("chkFeaturedNew");
            FileUpload uplImage = (FileUpload)this.grdFoods.FooterRow.FindControl("uplNewImage");
            DropDownList ddlCategories = (DropDownList)this.grdFoods.FooterRow.FindControl("ddlCategoriesNew");

            try
            {
                List<SqlParameter> prms = new List<SqlParameter>();
                string productName = txtProductName.Text.Trim();
                string productBriefDesc = txtBriefDesc.Text.Trim();
                string productFullDesc = txtFullDesc.Text.Trim();
                decimal price = Convert.ToDecimal(txtPrice.Text.Trim());
                bool featured = chkFeatured.Checked;
                int statusId = ddlStatus.SelectedIndex > 0 ? Convert.ToInt32(ddlStatus.SelectedValue) : 0;
                string fileName = $"{ Server.MapPath("~/img/")}{ uplImage.FileName}";
                string imageName = $"~/img/{ uplImage.FileName }";
                string altText = uplImage.FileName;
                int categoryId = ddlCategories.SelectedIndex > 0 ? Convert.ToInt32(ddlCategories.SelectedValue) : 0;
                bool status = false;              

                switch (statusId)
                {
                    case 1:
                        status = true;
                        break;
                    case 2:
                        status = false;
                        break;
                    case 3:
                        status = true;
                        break;
                    case 4:
                        status = true;
                        break;
                    case 5:
                        status = false;
                        break;
                    default:
                        break;
                }

                uplImage.SaveAs(fileName);

                prms.Add(Common.SetProductNameParam(productName));
                prms.Add(Common.SetProductBriefDescParam(productBriefDesc));
                prms.Add(Common.SetProductFullDescParam(productFullDesc));
                prms.Add(Common.SetProductStatusCodeParam(status));
                prms.Add(Common.SetProductStatusIdParam(statusId));
                prms.Add(Common.SetProductPriceParam(price));
                prms.Add(Common.SetProductFeaturedParam(featured));
                prms.Add(Common.SetCategoryIdParam(categoryId));
                prms.Add(Common.SetProductImageName(imageName));
                prms.Add(Common.SetProductImageDate(DateTime.Now));
                prms.Add(Common.SetProductImageAlt(altText));

                prms.Add(new SqlParameter()
                {
                    ParameterName = "@Id",
                    SqlDbType = SqlDbType.Int,
                    Direction = ParameterDirection.Output
                });

                int id = DBHelper.Insert<int>("InsertProduct", "@Id", prms.ToArray());
                this.lblMessage.Text = $"Product was created. Id: {id.ToString()}";
            }
            catch(SqlException ex)
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
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void grdFoods_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            List<SqlParameter> prms = new List<SqlParameter>();

            TextBox txtProductName = (TextBox)this.grdFoods.Rows[e.RowIndex].FindControl("txtProductName");
            TextBox txtBriefDesc = (TextBox)this.grdFoods.Rows[e.RowIndex].FindControl("txtBriefDesc");
            TextBox txtFullDesc = (TextBox)this.grdFoods.Rows[e.RowIndex].FindControl("txtFullDesc");
            TextBox txtPrice = (TextBox)this.grdFoods.Rows[e.RowIndex].FindControl("txtPrice");
            CheckBox chkFeatured = (CheckBox)this.grdFoods.Rows[e.RowIndex].FindControl("chkFeatured");
            FileUpload uplImage = (FileUpload)this.grdFoods.Rows[e.RowIndex].FindControl("uplUpdateImage");
            DropDownList ddlCategories = (DropDownList)this.grdFoods.Rows[e.RowIndex].FindControl("ddlCategories");
            DropDownList ddlStatus = (DropDownList)this.grdFoods.Rows[e.RowIndex].FindControl("ddlStatus");

            try
            {
                string productName = txtProductName.Text.Trim();
                string productBriefDesc = txtBriefDesc.Text.Trim();
                string productFullDesc = txtFullDesc.Text.Trim();
                decimal price = Convert.ToDecimal(txtPrice.Text.Trim());
                bool featured = chkFeatured.Checked;
                string fileName = $"{ Server.MapPath("~/img/")}{ uplImage.FileName}";
                string imageName = $"~/img/{ uplImage.FileName }";
                string altText = uplImage.FileName;
                int productId = Convert.ToInt32(this.grdFoods.DataKeys[e.RowIndex].Values[0]);

                int categoryId = ddlCategories.SelectedIndex > 0 ? Convert.ToInt32(ddlCategories.SelectedValue) : 0;
                int statusId = ddlStatus.SelectedIndex > 0 ? Convert.ToInt32(ddlStatus.SelectedValue) : 0;

                bool status = false;
                // If the status is Available, Back ordered, or Temporarily available, the product is active
                // If not, the product is inactive.
                switch (statusId)
                {
                    case 1:
                        status = true;
                        break;
                    case 2:
                        status = false;
                        break;
                    case 3:
                        status = true;
                        break;
                    case 4:
                        status = true;
                        break;
                    case 5:
                        status = false;
                        break;
                    default:
                        break;
                }

                uplImage.SaveAs(fileName);

                prms.Add(Common.SetProductIdParam(productId));
                prms.Add(Common.SetProductNameParam(productName));
                prms.Add(Common.SetProductBriefDescParam(productBriefDesc));
                prms.Add(Common.SetProductFullDescParam(productFullDesc));
                prms.Add(Common.SetProductStatusCodeParam(status));
                prms.Add(Common.SetProductStatusIdParam(statusId));
                prms.Add(Common.SetProductPriceParam(price));
                prms.Add(Common.SetProductFeaturedParam(featured));
                prms.Add(Common.SetCategoryIdParam(categoryId));

                if (fileName != "") //Don't make changes to the current image
                {
                    prms.Add(Common.SetProductImageName(imageName));
                    prms.Add(Common.SetProductImageDate(DateTime.Now));
                    prms.Add(Common.SetProductImageAlt(altText));
                }

                DBHelper.NonQuery("UpdateProduct", prms.ToArray());

                grdCustomers.EditIndex = -1;
                LoadFoodsGridView();
                lblMessage.Text = "Product was updated";
            }
            catch (Exception ex)
            {
                lblError.Text = ex.Message;
            }
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void grdFoods_RowEditing(object sender, GridViewEditEventArgs e)
        {
            grdFoods.EditIndex = e.NewEditIndex;

            LoadFoodsGridView();

            Control ddlToFindCategory = this.grdFoods.Rows[e.NewEditIndex].FindControl("ddlCategories");
            DropDownList ddlCategory = ddlToFindCategory != null ? (DropDownList)(ddlToFindCategory) : null;
            Control ddlToFindStatus = this.grdFoods.Rows[e.NewEditIndex].FindControl("ddlStatus");
            DropDownList ddlStatus = ddlToFindStatus != null ? (DropDownList)(ddlToFindStatus) : null;

            if (ddlCategory != null && ddlStatus != null)
            {
                int productId = Convert.ToInt32(this.grdFoods.DataKeys[e.NewEditIndex].Values[0]);
                SqlParameter prmProductIdForCateogory = new SqlParameter() { ParameterName = "@ProductId", SqlDbType = SqlDbType.Int, Value = productId };
                int categoryId = DBHelper.GetQueryValue<int>("SELECT categoryId FROM Products WHERE id=@ProductId", "categoryId", new SqlParameter[] { prmProductIdForCateogory }, CommandType.Text);
                SqlParameter prmProductIdForStatus = new SqlParameter() { ParameterName = "@ProductId", SqlDbType = SqlDbType.Int, Value = productId };
                int statusId = DBHelper.GetQueryValue<int>("SELECT statusId FROM Products WHERE id=@ProductId", "statusId", new SqlParameter[] { prmProductIdForStatus }, CommandType.Text);

                BindCategoryDropdownList(ddlCategory);
                BindStatusDropdownList(ddlStatus);

                ddlCategory.SelectedValue = categoryId.ToString();
                ddlStatus.SelectedValue = statusId.ToString();
            }
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void grdFoods_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            grdFoods.EditIndex = -1;
            LoadFoodsGridView();
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void grdFoods_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            grdFoods.PageIndex = e.NewPageIndex;
            LoadFoodsGridView();
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void grdCustomers_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if(e.CommandName == "btnNew")
            {
                AddNewCustomer();
                DBHelper.DataBindingWithPaging(this.grdCustomers, "SelectCustomers");
            }
        }

        /// <summary>
        /// 
        /// </summary>
        private void AddNewCustomer()
        {
            TextBox txtUserNameNew = (TextBox)this.grdCustomers.FooterRow.FindControl("txtUserNameNew");
            TextBox txtFirstNameNew = (TextBox)this.grdCustomers.FooterRow.FindControl("txtFirstNameNew");
            TextBox txtLastNameNew = (TextBox)this.grdCustomers.FooterRow.FindControl("txtLastNameNew");
            TextBox txtEmailNew = (TextBox)this.grdCustomers.FooterRow.FindControl("txtEmailNew");
            TextBox txtStreetNew = (TextBox)this.grdCustomers.FooterRow.FindControl("txtStreetNew");
            TextBox txtCityNew = (TextBox)this.grdCustomers.FooterRow.FindControl("txtCityNew");
            TextBox txtProvinceNew = (TextBox)this.grdCustomers.FooterRow.FindControl("txtProvinceNew");
            TextBox txtPostalCodeNew = (TextBox)this.grdCustomers.FooterRow.FindControl("txtPostalCodeNew");
            TextBox txtPhoneNew = (TextBox)this.grdCustomers.FooterRow.FindControl("txtPhoneNew");
            TextBox txtPasswordNew = (TextBox)this.grdCustomers.FooterRow.FindControl("txtPasswordNew");
            CheckBox chkArchivedNew = (CheckBox)this.grdCustomers.FooterRow.FindControl("chkArchivedNew");
            CheckBox chkValidatedNew = (CheckBox)this.grdCustomers.FooterRow.FindControl("chkValidatedNew");
            TextBox txtBirthdayNew = (TextBox)this.grdCustomers.FooterRow.FindControl("txtBirthdayNew");

            int id = 0;

            try
            {
                string userName = txtUserNameNew.Text.Trim();
                string firstName = txtFirstNameNew.Text.Trim();
                string lastname = txtLastNameNew.Text.Trim();
                string email = txtEmailNew.Text.Trim();
                string street = txtStreetNew.Text.Trim();
                string city = txtCityNew.Text.Trim();
                string province = txtProvinceNew.Text.Trim();
                string postalCode = txtPostalCodeNew.Text.Trim();
                DateTime birthday = Convert.ToDateTime(txtBirthdayNew.Text.Trim());
                string phone = txtPhoneNew.Text.Trim();
                string password = txtPasswordNew.Text.Trim();
                bool archieved = chkArchivedNew.Checked;
                bool validated = chkValidatedNew.Checked;

                List<SqlParameter> prms = new List<SqlParameter>();

                prms.Add(Common.SetCustomerUserNameParam(userName));
                prms.Add(Common.SetCustomerFirstNameParam(firstName));
                prms.Add(Common.SetCustomerLastNameParam(lastname));
                prms.Add(Common.SetCustomerEmailParam(email));
                prms.Add(Common.SetCustomerStreetParam(street));
                prms.Add(Common.SetCustomerCityParam(city));
                prms.Add(Common.SetCustomerProvinceParam(province));
                prms.Add(Common.SetCustomerPostalCodeParam(postalCode));
                prms.Add(Common.SetCustomerPhoneParam(phone));
                prms.Add(Common.SetCustomerPasswordParam(password));
                prms.Add(Common.SetCustomerBirthDayParam(birthday));
                prms.Add(Common.SetCustomerValidatedParam(validated));
                prms.Add(Common.SetCustomerArchivedParam(archieved));
                prms.Add(new SqlParameter()
                {
                    ParameterName = "@Id",
                    SqlDbType = SqlDbType.Int,
                    Direction = ParameterDirection.Output
                });

                id = DBHelper.Insert<int>("InsertCustomer", "@Id", prms.ToArray());
                lblMessage.Text = $"Customer was created. Id: {id.ToString()}";
            }
            catch (SqlException ex)
            {
                lblError.Text = ex.Message;
            }
            catch (Exception ex)
            {
                lblError.Text = ex.Message;
            }
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void grdCustomers_RowEditing(object sender, GridViewEditEventArgs e)
        {
            grdCustomers.EditIndex = e.NewEditIndex;
            DBHelper.DataBindingWithPaging(this.grdCustomers, "SelectCustomers");
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void grdCustomers_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            TextBox txtUserName = (TextBox)this.grdCustomers.Rows[e.RowIndex].FindControl("txtUserName");
            TextBox txtFirstName = (TextBox)this.grdCustomers.Rows[e.RowIndex].FindControl("txtFirstName");
            TextBox txtLastName = (TextBox)this.grdCustomers.Rows[e.RowIndex].FindControl("txtLastName");
            TextBox txtEmail = (TextBox)this.grdCustomers.Rows[e.RowIndex].FindControl("txtEmail");
            TextBox txtStreet = (TextBox)this.grdCustomers.Rows[e.RowIndex].FindControl("txtStreet");
            TextBox txtCity = (TextBox)this.grdCustomers.Rows[e.RowIndex].FindControl("txtCity");
            TextBox txtProvince = (TextBox)this.grdCustomers.Rows[e.RowIndex].FindControl("txtProvince");
            TextBox txtPostalCode = (TextBox)this.grdCustomers.Rows[e.RowIndex].FindControl("txtPostalCode");
            TextBox txtBirthday = (TextBox)this.grdCustomers.Rows[e.RowIndex].FindControl("txtBirthday");
            TextBox txtPhone = (TextBox)this.grdCustomers.Rows[e.RowIndex].FindControl("txtPhone");
            TextBox txtPassword = (TextBox)this.grdCustomers.Rows[e.RowIndex].FindControl("txtPassword");
            CheckBox chkArchived = (CheckBox)this.grdCustomers.Rows[e.RowIndex].FindControl("chkArchived");
            CheckBox chkValidated = (CheckBox)this.grdCustomers.Rows[e.RowIndex].FindControl("chkValidated");

            try
            {
                List<SqlParameter> prms = new List<SqlParameter>();

                int customerId = Convert.ToInt32(this.grdCustomers.DataKeys[e.RowIndex].Values[0]);
                string userName = txtUserName.Text.Trim();
                string firstName = txtFirstName.Text.Trim();
                string lastname = txtLastName.Text.Trim();
                string email = txtEmail.Text.Trim();
                string street = txtStreet.Text.Trim();
                string city = txtCity.Text.Trim();
                string province = txtProvince.Text.Trim();
                string postalCode = txtPostalCode.Text.Trim();
                DateTime birthday = Convert.ToDateTime(txtBirthday.Text.Trim());
                string phone = txtPhone.Text.Trim();
                string password = txtPassword.Text.Trim();
                bool archieved = chkArchived.Checked;
                bool validated = chkValidated.Checked;

                prms.Add(Common.SetCustomerIdParam(customerId));
                prms.Add(Common.SetCustomerUserNameParam(userName));
                prms.Add(Common.SetCustomerFirstNameParam(firstName));
                prms.Add(Common.SetCustomerLastNameParam(lastname));
                prms.Add(Common.SetCustomerEmailParam(email));
                prms.Add(Common.SetCustomerStreetParam(street));
                prms.Add(Common.SetCustomerCityParam(city));
                prms.Add(Common.SetCustomerProvinceParam(province));
                prms.Add(Common.SetCustomerPostalCodeParam(postalCode));
                prms.Add(Common.SetCustomerPhoneParam(phone));
                prms.Add(Common.SetCustomerPasswordParam(password));
                prms.Add(Common.SetCustomerBirthDayParam(birthday));
                prms.Add(Common.SetCustomerValidatedParam(validated));
                prms.Add(Common.SetCustomerArchivedParam(archieved));

                DBHelper.NonQuery("UpdateCustomer", prms.ToArray());
            }
            catch (SqlException ex)
            {
                lblError.Text = ex.Message;
            }
            catch (Exception ex)
            {
                lblError.Text = ex.Message;
            }

            grdCustomers.EditIndex = -1;
            DBHelper.DataBindingWithPaging(this.grdCustomers, "SelectCustomers");
            lblMessage.Text = "Customer was updated";
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void grdCustomers_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            grdCustomers.PageIndex = e.NewPageIndex;
            DBHelper.DataBindingWithPaging(this.grdCustomers, "SelectCustomers");
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void grdCustomers_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            grdCustomers.EditIndex = -1;
            DBHelper.DataBindingWithPaging(this.grdCustomers, "SelectCustomers");
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void grdCustomers_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int customerId = Convert.ToInt32(this.grdCustomers.DataKeys[e.RowIndex].Values[0]);
            SqlParameter prm = new SqlParameter() { ParameterName = "@CustomerId", SqlDbType = SqlDbType.Int, Value = customerId };

            DBHelper.NonQuery("DeleteCustomer", new SqlParameter[] { prm });
            DBHelper.DataBindingWithPaging(this.grdCustomers, "SelectCustomers");
        }
    }
}