using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace VieKoreaFoods.UserControls
{
    public partial class ucProductsSearch : System.Web.UI.UserControl
    {
        string[] removedSearchWords = { "the", "at", "a", "and", "or" };

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void btnSearch_Click(object sender, EventArgs e)
        {
            string queryString = $"{ QueryStringBuilder() }&all={this.chkAllWords.Checked}";
            Response.Redirect($"~/UserPage/products.aspx{queryString}");
        }

        /// <summary>
        /// 
        /// </summary>
        /// <returns></returns>
        private string QueryStringBuilder()
        {
            string queryStringBuild = "?";
            string[] filteredWords = FilterSearchWords();

            int counter = filteredWords.Count() > 4 ? 3 : filteredWords.Count() - 1;
            for (int i = 0; i <= counter; i++)
            {
                queryStringBuild += i == 0 ? $"word{i + 1}={filteredWords[i]}" : $"&word{i + 1}={filteredWords[i]}";
            }

            return queryStringBuild;
        }

        /// <summary>
        /// 
        /// </summary>
        /// <returns></returns>
        private string[] FilterSearchWords()
        {
            string[] words = this.txtSearch.Text.Split(new[] { ',', ' ' }, StringSplitOptions.RemoveEmptyEntries);
            List<string> cleanWords = new List<string>();

            foreach (string word in words)
            {
                if (removedSearchWords.Where(w => w.ToLower() == word.ToLower()).Count() == 0)
                {
                    cleanWords.Add(word);
                }
            }

            return cleanWords.ToArray();
        }
    }
}