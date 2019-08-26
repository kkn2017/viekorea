using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace VieKoreaFoods.UserControl
{
    public partial class ucProducts : System.Web.UI.UserControl
    {
        // Boolean property called Featured for checking whether or not it wants featured products. 
        public bool Featured { get; set; }

        /// <summary>
        /// Populate the general data of products on the web page when ucProducts usercontrol is activated
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void Page_Load(object sender, EventArgs e)
        {
            // string id and categoryId initialize the id queryString and categoryId queryString 
            string id = Request.QueryString["id"];
            string categoryId = Request.QueryString["categoryId"];

            // If the featured boolean is true, then Feature products are populated on the page 
            if (this.Featured)
            {
                this.lblHeading.Text = "This week's foods";
                LoadFeaturedProducts();
            }
            // If the cateogryId QueryString is requested, then products by categoryId are loaded.
            else if (!string.IsNullOrEmpty(categoryId))
            {
                int category = 0;

                if (int.TryParse(categoryId, out category))
                {
                    List<SqlParameter> prms = new List<SqlParameter>();
                    prms.Add(CategoryParamHelper(category));
                    this.lblHeading.Text = $"{DBHelper.GetQueryValue<string>("SelectCategories", "name", prms.ToArray())}";

                    LoadProductsByCategory(category);
                }
                else
                {
                    this.lblHeading.Text = "No such category";
                }
            }
            // If QueryString means searching for products, then product search method is activated.
            else if (Request.QueryString["word1"] != null)
            {
                ProductSearch();
            }
            // If id QueryString is requested, then product details are loaded.
            else if (!string.IsNullOrEmpty(id))
            {
                int productId = 0;
                if (Int32.TryParse(id, out productId))
                {
                    LoadProductDetails(productId);
                    this.lblHeading.Text = "Details";
                }
                else
                {
                    this.lblHeading.Text = "No such product";
                }
            }
            else
            {
                this.lblHeading.Text = "All Foods";
                LoadProducts();
            }

            ProductCountMessage();
        }
        /// <summary>
        /// Search the product by typing keywords in the product search box.
        /// </summary>
        private void ProductSearch()
        {
            List<string> searchKeys = Request.QueryString.AllKeys.Where(q => q.Contains("word")).ToList();
            bool all = Request.QueryString["all"] != null ? Request.QueryString["all"].ToString().ToLower() == "true" : false;

            List<SqlParameter> prms = new List<SqlParameter>();

            prms.Add(new SqlParameter() { ParameterName = "@MatchAllWords", SqlDbType = SqlDbType.Bit, Value = all });

            searchKeys.ForEach(w =>
            {
                prms.Add(new SqlParameter()
                {
                    ParameterName = $"@Key{w}",
                    SqlDbType = SqlDbType.NVarChar,
                    Size = 50,
                    Value = Request.QueryString[w]
                });
            });

            this.lblHeading.Text = "Product search results";

            DBHelper.DataBinding(this.rptProducts, "SearchProducts", prms.ToArray());
        }

        /// <summary>
        /// The error message is displayed when product count is zero.
        /// </summary>
        private void ProductCountMessage()
        {
            //this.lblError.Text = this.rptProducts.Items.Count == 0 ? "No products found" : "";
        }


        /// <summary>
        /// Load Product Deatails
        /// </summary>
        /// <param name="productId"></param>
        private void LoadProductDetails(int id)
        {
            List<SqlParameter> prms = new List<SqlParameter>();
            if (id != 0)
            {
                prms.Add(ProductParamHelper(id));
            }

            LoadProducts(prms);
        }

        /// <summary>
        /// Initialize the sqlParameter by productId
        /// </summary>
        /// <param name="productId"></param>
        /// <returns></returns>
        private SqlParameter ProductParamHelper(int productId)
        {
            return new SqlParameter()
            {
                ParameterName = "@ProductId",
                SqlDbType = SqlDbType.Int,
                Value = productId
            };
        }

        /// <summary>
        /// Load Products by categoryId
        /// </summary>
        /// <param name="categoryId"></param>
        private void LoadProductsByCategory(int categoryId)
        {
            List<SqlParameter> prms = new List<SqlParameter>();
            if (categoryId != 0)
            {
                prms.Add(CategoryParamHelper(categoryId));
            }

            LoadProducts(prms);
        }

        /// <summary>
        /// Initialize the sql parameter by the categoryId
        /// </summary>
        /// <param name="categoryId"></param>
        /// <returns></returns>
        private SqlParameter CategoryParamHelper(int categoryId)
        {
            return new SqlParameter()
            {
                ParameterName = "@CategoryId",
                SqlDbType = SqlDbType.Int,
                Value = categoryId
            };
        }

        /// <summary>
        /// Product which featured is yes is added to the list, then the porduct is loaded
        /// </summary>
        private void LoadFeaturedProducts()
        {
            List<SqlParameter> prms = new List<SqlParameter>();
            prms.Add(new SqlParameter()
            {
                ParameterName = "@Featured",
                SqlDbType = SqlDbType.Bit,
                Value = true
            });

            LoadProducts(prms);
        }

        /// <summary>
        /// Load the selected products from database
        /// </summary>
        /// <param name="prms"></param>
        private void LoadProducts(List<SqlParameter> prms = null)
        {
            if (prms == null)
            {
                prms = new List<SqlParameter>();
            }

            //Always Status true on this uc as this is public view. Only status available viewd by the public
            prms.Add(new SqlParameter()
            {
                ParameterName = "@StatusCode",
                SqlDbType = SqlDbType.Bit,
                Value = true
            });

            DBHelper.DataBinding(this.rptProducts, "SelectProducts", prms.ToArray());
        }

        /// <summary>
        /// It is the event handler clicking the add to cart button
        /// </summary>
        /// <param name="source"></param>
        /// <param name="e"></param>
        protected void rptProducts_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            try
            {
                if (e.CommandName == "Add")
                {
                    int productId = 0;

                    if (Int32.TryParse(e.CommandArgument.ToString(), out productId))
                    {
                        AddToCart(productId);
                    }
                    else
                    {
                        //this.lblError.Text = "Invalid product to add to cart";
                    }
                }
            }
            catch (SqlException ex)
            {
                //Specific SQL error 
                //lblError.Text = ex.Message;
            }
            catch (Exception ex)
            {
                //lblError.Text = ex.Message;
            }
        }

        /// <summary>
        /// Specific product by clicking the add to cart button is added to the cart
        /// </summary>
        /// <param name="productId"></param>
        private void AddToCart(int productId)
        {
            //Get the Cart Guid from the Cookie or Make a new one
            string CartUId = Common.GetCartId(Request, Response);

            List<SqlParameter> prms = new List<SqlParameter>();
            prms.Add(ProductParamHelper(productId));

            prms.Add(new SqlParameter()
            {
                ParameterName = "@CartUId",
                SqlDbType = SqlDbType.VarChar,
                Size = 50,
                Value = CartUId
            });

            prms.Add(new SqlParameter()
            {
                ParameterName = "@Qty",
                SqlDbType = SqlDbType.Int,
                Value = 1
            });

            DBHelper.NonQuery("AddToCart", prms.ToArray());

            Response.Redirect("~/Cart.aspx");
        }
    }
}