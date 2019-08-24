using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.SessionState;
using System.Web.UI;

namespace VieKoreaFoods
{
    public class Common
    {
        /// <summary>
        /// 
        /// </summary>
        /// <param name="request"></param>
        /// <param name="response"></param>
        /// <returns></returns>
        public static string GetCartId(HttpRequest request, HttpResponse response)
        {
            //Get the Cart Guid from the Cookie or Make a new one
            string CartUId = "";

            if (request.Cookies["CartUId"] != null)
            {
                CartUId = request.Cookies["CartUId"].Value;
            }
            else
            {
                Guid cartGuid = Guid.NewGuid();

                response.Cookies["CartUId"].Value = cartGuid.ToString();
                response.Cookies["CartUId"].Expires.AddDays(30);
                CartUId = cartGuid.ToString();
            }

            return CartUId;
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="cartId"></param>
        /// <returns></returns>
        public static int GetCartCount(string cartId)
        {
            string CartUId = cartId;

            List<SqlParameter> prms = new List<SqlParameter>();

            prms.Add(new SqlParameter()
            {
                ParameterName = "@CartUId",
                SqlDbType = SqlDbType.VarChar,
                Size = 50,
                Value = CartUId
            });

            int count = DBHelper.GetScalarValue<int>("CartCount", prms.ToArray());

            return count;
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="session"></param>
        /// <returns></returns>
        public static Boolean IsUserAuthenticated(HttpSessionState session)
        {
            return session["authenticated"] != null && session["authenticatedUser"] != null
                && session["validatedUser"] != null && session["admin"] == null;
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="session"></param>
        /// <returns></returns>
        public static Boolean IsAdminAuthenticated(HttpSessionState session)
        {
            return session["authenticated"] != null && session["authenticatedUser"] != null && session["admin"] != null
                && session["validatedUser"] == null;
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="session"></param>
        /// <returns></returns>
        public static string GetAuthenticatedUser(HttpSessionState session)
        {
            if (IsUserAuthenticated(session))
                return session["authenticatedUser"].ToString();
            else
                return "";
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="ctrl"></param>
        /// <param name="request"></param>
        /// <param name="response"></param>
        public static void GetCart(Control ctrl, HttpRequest request, HttpResponse response)
        {
            string CartUId = Common.GetCartId(request, response);
            List<SqlParameter> prms = new List<SqlParameter>();

            prms.Add(new SqlParameter()
            {
                ParameterName = "@CartUId",
                SqlDbType = SqlDbType.VarChar,
                Size = 50,
                Value = CartUId
            });

            DBHelper.DataBinding(ctrl, "SelectCart", prms.ToArray());
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="request"></param>
        /// <param name="response"></param>
        /// <returns></returns>
        public static decimal GetCartTotal(HttpRequest request, HttpResponse response)
        {
            string CartUId = Common.GetCartId(request, response);
            List<SqlParameter> prms = new List<SqlParameter>();

            prms.Add(new SqlParameter()
            {
                ParameterName = "@CartUId",
                SqlDbType = SqlDbType.VarChar,
                Size = 50,
                Value = CartUId
            });

            decimal cartTotal = DBHelper.GetQueryValue<decimal>("CartTotal", "Total", prms.ToArray());

            return cartTotal;
        }
    }
}