// author: Kwangeun Oh
// date: 2019.03.05
// file: validation.aspx.cs

using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;

namespace VieKoreaFoods.UserPage
{
    /// <summary>
    /// Validation Partial Class
    /// </summary>
    public partial class validation : System.Web.UI.Page
    {
        /// <summary>
        /// Validation Page is loaded.
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void Page_Load(object sender, EventArgs e)
        {
            if(!IsPostBack)
            {
                bool validated = false;

                // User Account is validated, when the validation gets id querystring. 
                if(!string.IsNullOrEmpty(Request.QueryString["id"]))
                {
                    validated = true;
                    int id = Convert.ToInt32(Request.QueryString["id"]);

                    List<SqlParameter> prms = new List<SqlParameter>()
                    {
                        new SqlParameter()
                        {
                            ParameterName = "@id",
                            SqlDbType = SqlDbType.Int,
                            Value = id
                        },

                        new SqlParameter()
                        {
                            ParameterName = "@Validated",
                            SqlDbType = SqlDbType.Bit,
                            Value = validated
                        }
                    };

                    DBHelper.NonQuery("UpdateValidation", prms.ToArray());

                    lblValidation.Text = "Your account is successfully validated.";
                }
            }
        }
    }
}