﻿using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace VieKoreaFoods.UserControls
{
    public partial class ucCart : System.Web.UI.UserControl
    {
        public static double tax;
        public static double shippingCost;
        public static double totalCost;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                GetCart();
                GetCartTotal();
            }
        }

        private void GetCart()
        {
            Common.GetCart(this.grdCart, Request, Response);

            if (this.grdCart.Rows.Count == 0)
            {
                this.btnCheckout.Visible = false;
                this.btnContinueShopping.Visible = false;
                this.btnUpdateCart.Visible = false;
                this.lblTotal.Text = "No items in cart";
                this.lblCartTotal.Visible = false;
                this.lblTaxShippingCost.Visible = false;
            }
        }

        private void GetCartTotal()
        {

            double subTotal = Convert.ToDouble(Common.GetCartTotal(Request, Response));
            double[] shippingCosts = { 0.00, 7.00, 12.00 };
            tax = subTotal * 0.15;

            // According to the sub total, apply different shipping costs to the total cost.
            if (subTotal == 0.00)
            {
                totalCost = 0.00;
            }
            else if (subTotal <= 35.00)
            {
                shippingCost = shippingCosts[1];
                totalCost = subTotal + tax + shippingCost;
            }
            else if (subTotal > 35.00 && subTotal <= 75.00)
            {
                shippingCost = shippingCosts[2];
                totalCost = subTotal + tax + shippingCost;
            }
            else
            {
                shippingCost = shippingCosts[0];
                totalCost = subTotal + tax + shippingCost;
            }

            this.lblCartTotal.Text = $"Total cost: {totalCost.ToString("c2")}";

            if (this.lblCartTotal.Text.Equals("$0.00"))
            {
                this.lblTaxShippingCost.Text = "";
            }
            else
            {
                this.lblTaxShippingCost.Text = $"Shipping cost: {shippingCost.ToString("c2")} Tax: {tax.ToString("c2")}";
            }
        }

        protected void btnUpdateCart_Click(object sender, EventArgs e)
        {
            string CartUId = Common.GetCartId(Request, Response);

            //One form of saving changes. One item at a time when there is a change
            foreach (GridViewRow row in this.grdCart.Rows)
            {
                if (row.RowType == DataControlRowType.DataRow)
                {
                    TextBox txt = (TextBox)row.FindControl("txtQty");
                    HiddenField hdn = (HiddenField)row.FindControl("hdnCurrentQty");
                    CheckBox chkRemove = (CheckBox)row.FindControl("chkRemove");

                    int qty = chkRemove.Checked ? 0 : Convert.ToInt32(txt.Text.Trim());
                    int currentQty = Convert.ToInt32(hdn.Value);
                    int productId = Convert.ToInt32(this.grdCart.DataKeys[row.RowIndex].Value);

                    //Save us a round trip
                    if (currentQty != qty)
                        UpdateCartItem(CartUId, productId, qty);
                }
            }

            GetCart();
            GetCartTotal();

            //Update the MasterPage label
            string cartId = Common.GetCartId(Request, Response);
            int count = Common.GetCartCount(cartId);
            Label lblCartItemsCount = (Label)this.Page.Master.FindControl("lblCartItemsCount");

            if (lblCartItemsCount != null)
                lblCartItemsCount.Text = count == 1 ? $"{count} item in cart" : count > 1 ? $"{count} items in cart" : "";
        }

        protected void btnContinueShopping_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/UserPage/products.aspx");
        }

        private void UpdateCartItem(string CartUId, int productId, int qty)
        {
            List<SqlParameter> prms = new List<SqlParameter>();
            prms.Add(new SqlParameter()
            {
                ParameterName = "@CartUId",
                SqlDbType = SqlDbType.VarChar,
                Size = 50,
                Value = CartUId
            });
            prms.Add(new SqlParameter()
            {
                ParameterName = "@ProdId",
                SqlDbType = SqlDbType.Int,
                Value = productId
            });
            prms.Add(new SqlParameter()
            {
                ParameterName = "@Qty",
                SqlDbType = SqlDbType.Int,
                Value = qty
            });

            DBHelper.NonQuery("UpdateCart", prms.ToArray());
        }

        protected void btnCheckout_Click(object sender, EventArgs e)
        {
            Response.Redirect("");
        }
    }
}