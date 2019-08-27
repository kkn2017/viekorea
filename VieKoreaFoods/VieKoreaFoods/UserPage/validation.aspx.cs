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
    public partial class validation : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if(!IsPostBack)
            {
                bool validated = false;

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