// author: Kwangeun Oh
// date: 2019.03.05
// file: ucProductsSearch.ascx.cs

using System;
using System.Collections.Generic;
using System.Linq;

namespace VieKoreaFoods.UserControls
{
    /// <summary>
    /// ucProductsSearch Partial Class
    /// </summary>
    public partial class ucProductsSearch : System.Web.UI.UserControl
    {
        string[] removedSearchWords = { "the", "at", "a", "and", "or" };

        /// <summary>
        /// Page is loaded.
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        /// <summary>
        /// As Search button event handler, it above all check whether or not the all words check box is checked. 
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void btnSearch_Click(object sender, EventArgs e)
        {
            string queryString = $"{ QueryStringBuilder() }&all={this.chkAllWords.Checked}";
            Response.Redirect($"~/UserPage/products.aspx{queryString}");
        }

        /// <summary>
        /// It builds the querystring. In case of more than one word are filled in the search box,
        /// Querstring would is made like word1="blah1"&word2="blah2".
        /// </summary>
        /// <returns>returns complete querystring.</returns>
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
        /// Words filled in the search box are divided into a each word.
        /// </summary>
        /// <returns>Returns an array of all words</returns>
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