// author: Kwangeun Oh
// date: 2019.03.05
// file: ucSlideOrMenu.ascx.cs

using System;

namespace VieKoreaFoods.UserControl
{
    /// <summary>
    /// ucSlideOrMenu Partial Class
    /// </summary>
    public partial class ucSlideOrMenu : System.Web.UI.UserControl
    {
        public bool IsIndex { get; set; }
        public bool IsAdmin { get; set; }
        
        /// <summary>
        /// Page is loaded.
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
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