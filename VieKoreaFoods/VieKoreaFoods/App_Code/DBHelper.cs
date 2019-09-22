// author: Kwangeun Oh
// date: 2019.03.02
// file: DBHelper.cs

using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web.UI.WebControls;

namespace VieKoreaFoods
{
    /// <summary>
    /// Class to help connect the database using Sql.
    /// </summary>
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
        /// Get a query value from database by calling the stored procedure.
        /// </summary>
        /// <typeparam name="T">Generic type</typeparam>
        /// <param name="sqlStatement">Call the name of the sql statement.</param>
        /// <param name="ColumnName">Call the specific column of the table in database.</param>
        /// <param name="prms">Array of the sql parameters</param>
        /// <param name="cmdType">Command type is stored procedure.</param>
        /// <returns>Returns a query value.</returns>
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
        /// As data type is DataTable, call the values stored to the data table.
        /// </summary>
        /// <param name="sqlStatement">Name of the sql statement</param>
        /// <param name="prms">Array of the sql parameters</param>
        /// <param name="cmdType">Command type is Stored Procedure.</param>
        /// <returns>Returns values from the database.</returns>
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
        /// <returns>Return the specific value by the output parameter.</returns>
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
                    conn.Close();
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
        /// Insert data into the database.
        /// It is no return needed.
        /// </summary>
        /// <param name="sqlStatement">Name of the sql statement</param>
        /// <param name="prms">Array of sql parameters</param>
        /// <param name="cmdType">Command type is stored procedure.</param>
        public static void Insert(string sqlStatement, SqlParameter[] prms, CommandType cmdType = CommandType.StoredProcedure)
        {
            using (SqlConnection conn = new SqlConnection(ConnectionString()))
            {
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
        /// It is Nonquery method, but request such as Delete, Update to the database.
        /// </summary>
        /// <param name="sqlStatement">Name of the sql statement</param>
        /// <param name="prms">Array of the sql parameters</param>
        /// <param name="cmdType">Command type is stored procedure.</param>
        /// <returns>Return the ouput parameter.</returns>
        public static List<SqlParameter> NonQuery(string sqlStatement
        , SqlParameter[] prms, CommandType cmdType = CommandType.StoredProcedure)
        {
            using (SqlConnection conn = new SqlConnection(ConnectionString()))
            {
                using (SqlCommand cmd = new SqlCommand())
                {
                    cmd.Connection = conn;
                    cmd.CommandText = sqlStatement;
                    cmd.CommandType = cmdType;

                    if (prms != null)
                        cmd.Parameters.AddRange(prms);

                    conn.Open();
                    cmd.ExecuteNonQuery();
                    conn.Close();
                }
            }

            return prms.Where(p => p.Direction == ParameterDirection.Output).ToList();
        }

        /// <summary>
        /// Bind information from database to a specific view or table. 
        /// </summary>
        /// <param name="bindableControl">Name of the specific object</param>
        /// <param name="sqlStatement">Name of the sql statement</param>
        /// <param name="prms">Array of sql parameters</param>
        /// <param name="cmdType">Command type is stored procedure</param>
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
                    conn.Close();
                }
            }
        }

        /// <summary>
        /// Bind information from database to a specific view or table with paging.
        /// </summary>
        /// <param name="bindableControl">Name of the object to be bound</param>
        /// <param name="sqlStatement">Name of the sql statement</param>
        /// <param name="prms">Array of the sql parameters</param>
        /// <param name="cmdType">Command type is stored procedure.</param>
        public static void DataBindingWithPaging(object bindableControl, string sqlStatement
            , SqlParameter[] prms = null
            , CommandType cmdType = CommandType.StoredProcedure)
        {
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
                    var da = new SqlDataAdapter(cmd);
                    var ds = new DataSet();
                    da.Fill(ds);
                    if (ds.Tables.Count > 0)
                    {
                        BindControl(bindableControl, ds.Tables[0]);
                    }
                    conn.Close();
                }
            }
        }

        /// <summary>
        /// (BaseDataBoundControl)
        /// GridView
        /// DropDownList  
        /// (BaseDataList)
        /// DetailView
        /// (Repeater)
        /// Repeater
        /// </summary>
        /// <param name="bindableControl">Name of the object</param>
        /// <param name="dr">Name of SqlDataReader</param>
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
        /// (BaseDataBoundControl)
        /// GridView
        /// DropDownList 
        /// (BaseDataList)
        /// DetailView
        /// (Repeater)
        /// Repeater
        /// </summary>
        /// <param name="bindableControl">Name of the object</param>
        /// <param name="dt">Name of the DataTable</param>
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
    }
}