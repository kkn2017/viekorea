using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace VieKoreaFoods.UserControl
{
    public partial class ucSlideOrMenu : System.Web.UI.UserControl
    {
        public bool IsIndex { get; set; }
        public bool IsAdmin { get; set; }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (!IsIndex)
                {
                    DBHelper.DataBinding(this.lstCategories, "SelectCategories");
                }
            }
        }
    }
}