using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web.UI.WebControls;

namespace VieKoreaFoods
{
    public class DBHelper
    {
        /// <summary>
        /// Set the connection string in order to connect to database.
        /// cnn is the key of the connection strings.
        /// </summary>
        /// <returns>Return cnn as the connection string</returns>
        private static string ConnectionString()
        {
            return ConfigurationManager.ConnectionStrings["cnn"].ConnectionString;
        }

        /// <summary>
        /// Get the scalar value from the database by executing stored procedure.
        /// </summary>
        /// <typeparam name="T">Generic type</typeparam>
        /// <param name="sqlStatement">Name of the sql statement you want to call</param>
        /// <param name="prms">Array of Sql parameters</param>
        /// <param name="cmdType">Stored Procdedure as command type</param>
        /// <returns>Get a scalar value</returns>
        public static T GetScalarValue<T>(string sqlStatement, SqlParameter[] prms
            , CommandType cmdType = CommandType.StoredProcedure)
        {
            object returnValue = null;
            T value;

            using (SqlConnection conn = new SqlConnection(ConnectionString()))
            {
                // Call StoredProcedure from the database
                using (SqlCommand cmd = new SqlCommand())
                {
                    cmd.Connection = conn;
                    cmd.CommandText = sqlStatement;
                    cmd.CommandType = cmdType;

                    if (prms != null)
                    {
                        cmd.Parameters.AddRange(prms);
                    }                       

                    conn.Open();

                    returnValue = cmd.ExecuteScalar();

                    if (returnValue == DBNull.Value)
                    {
                        returnValue = null;
                    }
                        
                    conn.Close();//Not necessary as connection is within using
                }
            }

            if (returnValue != null)
            {
                value = (T)returnValue;
            }                
            else
            {
                value = default(T);
            }
                
            return value;
        }

        /// <summary>
        /// Get a query value from database by calling the stored procedure
        /// </summary>
        /// <typeparam name="T">Generic type</typeparam>
        /// <param name="sqlStatement">Call the name of the sql statement</param>
        /// <param name="ColumnName">Call the specific column of the table in database</param>
        /// <param name="prms">Array of the sql parameters</param>
        /// <param name="cmdType">Command type is stored procedure</param>
        /// <returns>Returns a query value</returns>
        public static T GetQueryValue<T>(string sqlStatement, string ColumnName
        , SqlParameter[] prms, CommandType cmdType = CommandType.StoredProcedure)
        {
            object returnValue = null;
            T value;

            using (SqlConnection conn = new SqlConnection(ConnectionString()))
            {
                //Call SProc from the database
                using (SqlCommand cmd = new SqlCommand())
                {
                    cmd.Connection = conn;
                    cmd.CommandText = sqlStatement;
                    cmd.CommandType = cmdType;

                    if (prms != null)
                    {
                        cmd.Parameters.AddRange(prms);
                    }

                    conn.Open();

                    using (SqlDataReader dr = cmd.ExecuteReader())
                    {
                        if (dr.HasRows)
                        {
                            while (dr.Read())
                            {
                                if (dr[ColumnName] != DBNull.Value)
                                {
                                    returnValue = dr[ColumnName];
                                }
                            }
                        }
                    }

                    conn.Close();
                }
            }

            if (returnValue != null)
            {
                value = (T)returnValue;
            }
            else
            {
                value = default(T);
            }

            return value;
        }

        /// <summary>
        /// Get values from the database by calling stored procudure.
        /// As data type is DataTable, call the values stored to the data table 
        /// </summary>
        /// <param name="sqlStatement">Name of the sql statement</param>
        /// <param name="prms">Array of the sql parameters</param>
        /// <param name="cmdType">Command type is Stored Procedure</param>
        /// <returns>Returns values from the database</returns>
        public static DataTable GetQuery(string sqlStatement, SqlParameter[] prms, CommandType cmdType = CommandType.StoredProcedure)
        {
            DataTable dt = new DataTable();
            using (SqlConnection conn = new SqlConnection(ConnectionString()))
            {
                using (SqlCommand cmd = new SqlCommand())
                {
                    cmd.Connection = conn;
                    cmd.CommandText = sqlStatement;
                    cmd.CommandType = cmdType;

                    if (prms != null)
                    {
                        cmd.Parameters.AddRange(prms);
                    }

                    conn.Open();
                    using (SqlDataReader dr = cmd.ExecuteReader())
                    {
                        if (dr.HasRows)
                        {
                            dt.Load(dr);
                        }
                        
                    }
                    conn.Close();
                }
            }
            return dt;
        }

        /// <summary>
        /// Insert the data into the database by calling the insert stored procedure.
        /// </summary>
        /// <typeparam name="T">Generic data type</typeparam>
        /// <param name="sqlStatement">Name of the sql statement</param>
        /// <param name="OutputParam">Output parameter</param>
        /// <param name="prms">Array of the parameters</param>
        /// <param name="cmdType">Command type is Stored Procedure</param>
        /// <returns>Return the specific value by the output parameter</returns>
        public static T Insert<T>(string sqlStatement, string OutputParam
        , SqlParameter[] prms, CommandType cmdType = CommandType.StoredProcedure)
        {
            object returnId = null;
            T id;

            using (SqlConnection conn = new SqlConnection(ConnectionString()))
            {
                //Call SProc from the database
                using (SqlCommand cmd = new SqlCommand())
                {
                    cmd.Connection = conn;
                    cmd.CommandText = sqlStatement;
                    cmd.CommandType = cmdType;

                    if (prms != null)
                    {
                        cmd.Parameters.AddRange(prms);
                    }

                    conn.Open();

                    cmd.ExecuteNonQuery();

                    returnId = cmd.Parameters[OutputParam].Value;

                    conn.Close();//Not necessary as connection is within using
                }
            }

            if (returnId != null)
            {
                id = (T)returnId;
            }                
            else
            {
                id = default(T);
            }                

            return id;
        }

        /// <summary>
        /// Insert with no return needed
        /// </summary>
        /// <param name="sqlStatement"></param>
        /// <param name=""></param>
        /// <param name="prms"></param>
        /// <param name="cmdType"></param>
        public static void Insert(string sqlStatement
        , SqlParameter[] prms, CommandType cmdType = CommandType.StoredProcedure)
        {


            using (SqlConnection conn = new SqlConnection(ConnectionString()))
            {
                //Call SProc from the database
                using (SqlCommand cmd = new SqlCommand())
                {
                    cmd.Connection = conn;
                    cmd.CommandText = sqlStatement;
                    cmd.CommandType = cmdType;

                    if (prms != null)
                        cmd.Parameters.AddRange(prms);

                    conn.Open();

                    cmd.ExecuteNonQuery();

                    conn.Close();//Not necessary as connection is within using
                }
            }
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="sqlStatement"></param>
        /// <param name="prms"></param>
        /// <param name="cmdType"></param>
        /// <returns></returns>
        public static List<SqlParameter> NonQuery(string sqlStatement
        , SqlParameter[] prms, CommandType cmdType = CommandType.StoredProcedure)
        {
            using (SqlConnection conn = new SqlConnection(ConnectionString()))
            {
                //Call SProc from the database
                using (SqlCommand cmd = new SqlCommand())
                {
                    cmd.Connection = conn;
                    cmd.CommandText = sqlStatement;
                    cmd.CommandType = cmdType;

                    if (prms != null)
                        cmd.Parameters.AddRange(prms);

                    conn.Open();

                    cmd.ExecuteNonQuery();
                    conn.Close();//Not necessary as connection is within using
                }
            }

            //Return the output params
            return prms.Where(p => p.Direction == ParameterDirection.Output).ToList();
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="bindableControl"></param>
        /// <param name="sqlStatement"></param>
        /// <param name="cmdType"></param>
        /// <param name="prms"></param>
        public static void DataBinding(object bindableControl, string sqlStatement
            , SqlParameter[] prms = null
            , CommandType cmdType = CommandType.StoredProcedure)
        {
            using (SqlConnection conn = new SqlConnection(ConnectionString()))
            {
                //Call SProc from the database
                using (SqlCommand cmd = new SqlCommand())
                {
                    cmd.Connection = conn;
                    cmd.CommandText = sqlStatement;
                    cmd.CommandType = cmdType;

                    if (prms != null)
                        cmd.Parameters.AddRange(prms);

                    conn.Open();

                    using (SqlDataReader dr = cmd.ExecuteReader())
                    {
                        if (dr.HasRows)
                        {
                            BindControl(bindableControl, dr);
                        }
                    }

                    conn.Close();//Not necessary as connection is within using
                }
            }
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="bindableControl"></param>
        /// <param name="sqlStatement"></param>
        /// <param name="prms"></param>
        /// <param name="cmdType"></param>
        public static void DataBindingWithPaging(object bindableControl, string sqlStatement
            , SqlParameter[] prms = null
            , CommandType cmdType = CommandType.StoredProcedure)
        {
            using (SqlConnection conn = new SqlConnection(ConnectionString()))
            {
                //Call SProc from the database
                using (SqlCommand cmd = new SqlCommand())
                {
                    cmd.Connection = conn;
                    cmd.CommandText = sqlStatement;
                    cmd.CommandType = cmdType;

                    if (prms != null)
                        cmd.Parameters.AddRange(prms);

                    conn.Open();

                    var da = new SqlDataAdapter(cmd);
                    var ds = new DataSet();
                    da.Fill(ds);

                    if (ds.Tables.Count > 0)
                    {
                        BindControl(bindableControl, ds.Tables[0]);
                    }

                    conn.Close();//Not necessary as connection is within using
                }
            }
        }

        /// <summary>
        /// BaseDataBoundControl
        /// GridView
        /// DropDownList 
        /// 
        /// BaseDataList
        /// DetailView
        /// </summary>
        /// <param name="bindableControl"></param>
        /// <param name="dr"></param>
        private static void BindControl(object bindableControl, SqlDataReader dr)
        {
            if (bindableControl is BaseDataBoundControl)
            {
                ((BaseDataBoundControl)bindableControl).DataSource = dr;
                ((BaseDataBoundControl)bindableControl).DataBind();
            }

            if (bindableControl is BaseDataList)
            {
                ((BaseDataList)bindableControl).DataSource = dr;
                ((BaseDataList)bindableControl).DataBind();
            }

            if (bindableControl is Repeater)
            {
                ((Repeater)bindableControl).DataSource = dr;
                ((Repeater)bindableControl).DataBind();
            }
        }

        /// <summary>
        /// BaseDataBoundControl
        /// GridView
        /// DropDownList 
        /// 
        /// BaseDataList
        /// DetailView
        /// 
        /// Using datatable to allow paging
        /// </summary>
        /// <param name="bindableControl"></param>
        /// <param name="dt">DataTable of data to bind</param>
        private static void BindControl(object bindableControl, DataTable dt)
        {
            if (bindableControl is BaseDataBoundControl)
            {
                ((BaseDataBoundControl)bindableControl).DataSource = dt;
                ((BaseDataBoundControl)bindableControl).DataBind();
            }

            if (bindableControl is BaseDataList)
            {
                ((BaseDataList)bindableControl).DataSource = dt;
                ((BaseDataList)bindableControl).DataBind();
            }

            if (bindableControl is Repeater)
            {
                ((Repeater)bindableControl).DataSource = dt;
                ((Repeater)bindableControl).DataBind();
            }

        }

        #region [Common Product SqlParams]

        public static SqlParameter SetProductIdParam(int value)
        {
            return new SqlParameter()
            {
                ParameterName = "@ProductId",
                SqlDbType = SqlDbType.Int,
                Value = value
            };
        }

        public static SqlParameter SetProductNameParam(string value)
        {
            return new SqlParameter()
            {
                ParameterName = "@ProductName",
                SqlDbType = SqlDbType.NVarChar,
                Size = 50,
                Value = value
            };
        }

        public static SqlParameter SetProductBriefDescParam(string value)
        {
            return new SqlParameter()
            {
                ParameterName = "@ProductBriefDesc",
                SqlDbType = SqlDbType.NVarChar,
                Value = value
            };
        }

        public static SqlParameter SetProductFullDescParam(string value)
        {
            return new SqlParameter()
            {
                ParameterName = "@ProductFullDesc",
                SqlDbType = SqlDbType.NVarChar,
                Value = value
            };
        }

        public static SqlParameter SetProductStatusCodeParam(bool value)
        {
            return new SqlParameter()
            {
                ParameterName = "@StatusCode",
                SqlDbType = SqlDbType.Bit,
                Value = value
            };
        }

        public static SqlParameter SetProductStatusIdParam(int value)
        {
            return new SqlParameter()
            {
                ParameterName = "@StatusId",
                SqlDbType = SqlDbType.Int,
                Value = value
            };
        }

        public static SqlParameter SetProductPriceParam(decimal value)
        {
            return new SqlParameter()
            {
                ParameterName = "@ProductPrice",
                SqlDbType = SqlDbType.Money,
                Value = value
            };
        }

        public static SqlParameter SetProductFeaturedParam(bool value)
        {
            return new SqlParameter()
            {
                ParameterName = "@Featured",
                SqlDbType = SqlDbType.Bit,
                Value = value
            };
        }

        public static SqlParameter SetCategoryIdParam(int value)
        {
            return new SqlParameter()
            {
                ParameterName = "@CategoryId",
                SqlDbType = SqlDbType.Int,
                Value = value
            };
        }

        public static SqlParameter SetProductImageName(string value)
        {
            return new SqlParameter()
            {
                ParameterName = "@ImageName",
                SqlDbType = SqlDbType.NVarChar,
                Size = 50,
                Value = value
            };
        }

        public static SqlParameter SetProductImageDate(DateTime value)
        {
            return new SqlParameter()
            {
                ParameterName = "@ImageUploadDate",
                SqlDbType = SqlDbType.DateTime,
                Value = value
            };
        }

        public static SqlParameter SetProductImageAlt(string value)
        {
            return new SqlParameter()
            {
                ParameterName = "@AltText",
                SqlDbType = SqlDbType.NVarChar,
                Size = 50,
                Value = value
            };
        }

        #endregion

        #region [Common Customer SqlParams]
        public static SqlParameter SetCustomerIdParam(int value)
        {
            return new SqlParameter()
            {
                ParameterName = "@Id",
                SqlDbType = SqlDbType.Int,
                Value = value
            };
        }

        public static SqlParameter SetCustomerUserNameParam(string value)
        {
            return new SqlParameter()
            {
                ParameterName = "@UserName",
                SqlDbType = SqlDbType.NVarChar,
                Size = 50,
                Value = value
            };
        }

        public static SqlParameter SetCustomerFirstNameParam(string value)
        {
            return new SqlParameter()
            {
                ParameterName = "@FirstName",
                SqlDbType = SqlDbType.NVarChar,
                Size = 50,
                Value = value
            };
        }

        public static SqlParameter SetCustomerLastNameParam(string value)
        {
            return new SqlParameter()
            {
                ParameterName = "@LastName",
                SqlDbType = SqlDbType.NVarChar,
                Size = 50,
                Value = value
            };
        }

        public static SqlParameter SetCustomerEmailParam(string value)
        {
            return new SqlParameter()
            {
                ParameterName = "@Email",
                SqlDbType = SqlDbType.NVarChar,
                Size = 50,
                Value = value
            };
        }

        public static SqlParameter SetCustomerStreetParam(string value)
        {
            return new SqlParameter()
            {
                ParameterName = "@Street",
                SqlDbType = SqlDbType.NVarChar,
                Size = 50,
                Value = value
            };
        }

        public static SqlParameter SetCustomerCityParam(string value)
        {
            return new SqlParameter()
            {
                ParameterName = "@City",
                SqlDbType = SqlDbType.NVarChar,
                Size = 20,
                Value = value
            };
        }

        public static SqlParameter SetCustomerProvinceParam(string value)
        {
            return new SqlParameter()
            {
                ParameterName = "@Province",
                SqlDbType = SqlDbType.NVarChar,
                Size = 2,
                Value = value
            };
        }

        public static SqlParameter SetCustomerPostalCodeParam(string value)
        {
            return new SqlParameter()
            {
                ParameterName = "@PostalCode",
                SqlDbType = SqlDbType.NVarChar,
                Size = 6,
                Value = value
            };
        }

        public static SqlParameter SetCustomerPhoneParam(string value)
        {
            return new SqlParameter()
            {
                ParameterName = "@Phone",
                SqlDbType = SqlDbType.NVarChar,
                Size = 10,
                Value = value
            };
        }

        public static SqlParameter SetCustomerPasswordParam(string value)
        {
            return new SqlParameter()
            {
                ParameterName = "@Password",
                SqlDbType = SqlDbType.NVarChar,
                Size = 15,
                Value = value
            };
        }

        public static SqlParameter SetCustomerBirthDayParam(DateTime value)
        {
            return new SqlParameter()
            {
                ParameterName = "@Birth",
                SqlDbType = SqlDbType.Date,
                Value = value
            };
        }

        public static SqlParameter SetCustomerValidatedParam(bool value)
        {
            return new SqlParameter()
            {
                ParameterName = "@Validated",
                SqlDbType = SqlDbType.Bit,
                Value = value
            };
        }

        public static SqlParameter SetCustomerArchivedParam(bool value)
        {
            return new SqlParameter()
            {
                ParameterName = "@Archieved",
                SqlDbType = SqlDbType.Bit,
                Value = value
            };
        }
        #endregion

        #region [Common Administrator SqlParams]

        public static SqlParameter SetAdminIdParam(int value)
        {
            return new SqlParameter()
            {
                ParameterName = "@Id",
                SqlDbType = SqlDbType.Int,
                Value = value
            };
        }

        public static SqlParameter SetAdminUserNameParam(string value)
        {
            return new SqlParameter()
            {
                ParameterName = "@UserName",
                SqlDbType = SqlDbType.NVarChar,
                Size = 50,
                Value = value
            };
        }

        public static SqlParameter SetAdminPasswordParam(string value)
        {
            return new SqlParameter()
            {
                ParameterName = "@Password",
                SqlDbType = SqlDbType.NVarChar,
                Size = 15,
                Value = value
            };
        }
        #endregion
    }
}