using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace VieKoreaFoods.Admin
{
    public partial class admin_images : System.Web.UI.Page
    {
        /// <summary>
        /// 
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void Page_Load(object sender, EventArgs e)
        {
            if(!IsPostBack)
            {
                FileBinding();
            }
        }

        /// <summary>
        /// 
        /// </summary>
        private void FileBinding()
        {
            DirectoryInfo dir = new DirectoryInfo(Server.MapPath("~/tmp_img/"));
            FileInfo[] files;
            files = dir.GetFiles();
            this.rptTmpImages.DataSource = files;
            this.rptTmpImages.DataBind();
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="source"></param>
        /// <param name="e"></param>
        protected void rptTmpImages_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if(e.CommandName == "Upload")
            {
                try
                {
                    int id = 0;
                    string fileName = e.CommandArgument.ToString().Trim();
                    string tmpPath = $@"{Server.MapPath("~/tmp_img/")}";
                    string targetPath = $@"{Server.MapPath("~/img/")}";

                    string tmpFile = Path.Combine(tmpPath, fileName);
                    string targetFile = Path.Combine(targetPath, fileName);

                    if(Directory.Exists(targetPath) || !File.Exists(targetFile))
                    {
                        File.Copy(tmpFile, targetFile, true);

                        string sqlFileName = $"~/img/{fileName}";

                        List<SqlParameter> prms = new List<SqlParameter>();
                        prms.Add(new SqlParameter() { ParameterName = "@Name", SqlDbType = SqlDbType.NVarChar, Size = 50, Value = sqlFileName });
                        prms.Add(new SqlParameter() { ParameterName = "@AltText", SqlDbType = SqlDbType.NVarChar, Size = 50, Value = fileName });
                        prms.Add(new SqlParameter() { ParameterName = "@Id", SqlDbType = SqlDbType.Int, Direction = ParameterDirection.Output });

                        id = DBHelper.Insert<int>("InsertSiteImage", "@Id" ,prms.ToArray());

                        File.Delete(tmpFile);

                        FileBinding();
                        this.lblMessage.Text = $"The { fileName } has been uploaded to the img directory and database Image Number in database is "  + $"{ id }.<br /> For your Information, this file in the tmp_img directory was autometically deleted. ";
                    }
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
        }
    }
}