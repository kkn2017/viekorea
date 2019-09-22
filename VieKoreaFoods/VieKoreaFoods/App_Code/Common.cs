// author: Kwangeun Oh
// date: 2019.03.02
// file: Common.cs

using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.SessionState;
using System.Web.UI;

namespace VieKoreaFoods
{
    /// <summary>
    /// Common Class has common methods to be used frequently such calling sql parameters
    /// </summary>
    public class Common
    {
        /// <summary>
        /// Get CartId as random combination of integers and strings that is set by calling global universal identifier.
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
        /// Get the count of items in the cart.
        /// </summary>
        /// <param name="cartId"></param>
        /// <returns>returns the number of the cart</returns>
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
        /// Check whether or not the User session key are authenticated, authenticatedUser, admin, and validatedUser
        /// </summary>
        /// <param name="session"></param>
        /// <returns></returns>
        public static Boolean IsUserAuthenticated(HttpSessionState session)
        {
            return session["authenticated"] != null && session["authenticatedUser"] != null
                && session["validatedUser"] != null && session["admin"] == null;
        }

        /// <summary>
        /// Check whether or not the Admin session key are authenticated, authenticatedUser, admin, and validatedUser
        /// </summary>
        /// <param name="session"></param>
        /// <returns></returns>
        public static Boolean IsAdminAuthenticated(HttpSessionState session)
        {
            return session["authenticated"] != null && session["authenticatedUser"] != null && session["admin"] != null
                && session["validatedUser"] == null;
        }

        /// <summary>
        /// Get authenticated user when session key is authenticatedUser
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
        /// Get the subtotal of items in the cart excluding tax and delivery cost.
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

        #region [Common Product SqlParams] - Set Each content of the product as Sql Parameter
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

        #region [Common Customer SqlParams]  - Set Each content of the customer as Sql Parameter
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

        #region [Common Administrator SqlParams] -  - Set Each content of the administrator as Sql Parameter
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