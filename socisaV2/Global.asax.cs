using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Optimization;
using System.Web.Routing;
using System.Web.Helpers;
using System.Security.Cryptography;
using System.Text;
using System.IO;
using SOCISA;
using System.ComponentModel;
using System.Threading;
using System.Globalization;
//using System.Web.Http;
using ImranB.ModelBindingFix;


namespace socisaWeb
{
    public static class ExtensionMethods
    {
        // returns the number of milliseconds since Jan 1, 1970 (useful for converting C# dates to JS dates)
        public static string UnixTicks(this DateTime dt)
        {
            DateTime d1 = new DateTime(1970, 1, 1);
            DateTime d2 = dt.ToUniversalTime();
            TimeSpan ts = new TimeSpan(d2.Ticks - d1.Ticks);
            return String.Format("/Date({0})/", ts.TotalMilliseconds);
        }

        public static Nullable<T> ToNullable<T>(this string s) where T : struct
        {
            Nullable<T> result = new Nullable<T>();
            try
            {
                if (!string.IsNullOrWhiteSpace(s))
                {
                    TypeConverter conv = TypeDescriptor.GetConverter(typeof(T));
                    result = (T)conv.ConvertFrom(s);
                }
            }
            catch { }
            return result;
        }
    }

    public class MvcApplication : System.Web.HttpApplication
    {
        protected void Application_Start()
        {
            AreaRegistration.RegisterAllAreas();
            System.Web.Http.GlobalConfiguration.Configure(WebApiConfig.Register);
            //WebApiConfig.Register(System.Web.Http.GlobalConfiguration.Configuration);
            //System.Web.Http.GlobalConfiguration.Configuration.EnsureInitialized();

            FilterConfig.RegisterGlobalFilters(GlobalFilters.Filters);
            RouteConfig.RegisterRoutes(RouteTable.Routes);
            BundleConfig.RegisterBundles(BundleTable.Bundles);

            ModelBinders.Binders[typeof(DateTime)] = new DateTimeModelBinder(CommonFunctions.DATE_TIME_FORMAT);
            ModelBinders.Binders[typeof(DateTime?)] = new DateTimeModelBinder(CommonFunctions.DATE_TIME_FORMAT);
            //ModelBinders.Binders.Add(typeof(DateTime), new DateTimeModelBinder("dd.MM.yyyy HH:mm:ss"));
            //ModelBinders.Binders.Add(typeof(DateTime?), new DateTimeModelBinder("dd.MM.yyyy HH:mm:ss"));
            ModelBinders.Binders[typeof(Double)] = new DoubleModelBinder();
            ModelBinders.Binders[typeof(Double?)] = new DoubleModelBinder();

            //ModelBinders.Binders.Remove(typeof(byte[]));
            //ModelBinders.Binders.Add(typeof(byte[]), new CustomByteArrayModelBinder());
            //ModelBinders.Binders[typeof(ImportDosarView)] = new CustomImportDosareModelBinder();
            GlobalFilters.Filters.Add(new GlobalAntiForgeryTokenAttribute(false));

            //System.Net.ServicePointManager.ServerCertificateValidationCa‌​llback += (se, cert, chain, sslerror) => true;
            Fixer.FixModelBindingIssue();

        }

        protected void Session_Start(object sender, EventArgs e)
        {
            string culture = System.Configuration.ConfigurationManager.AppSettings["DefaultUICulture"];
            Session["Culture"] = culture;
            CultureInfo cultureInfo = new CultureInfo(culture);
            //Thread.CurrentThread.CurrentCulture = cultureInfo;
            Thread.CurrentThread.CurrentUICulture = cultureInfo;

            string conStr = Server.MapPath("~").ToLower().IndexOf("test") > 0 ? CommonFunctions.StringCipher.Decrypt(System.Configuration.ConfigurationManager.ConnectionStrings["MySQLConnectionString_test"].ConnectionString, CommonFunctions.StringCipher.RetrieveKey()) : CommonFunctions.StringCipher.Decrypt(System.Configuration.ConfigurationManager.ConnectionStrings["MySQLConnectionString"].ConnectionString, CommonFunctions.StringCipher.RetrieveKey()); // separam socisa de socisa_test
            //string conStr = StringCipher.Decrypt(System.Configuration.ConfigurationManager.ConnectionStrings["MySQLConnectionString_test"].ConnectionString, key);
            HttpContext.Current.Session["conStr"] = conStr;

            //TestFunctions(key);
        }

        protected void TestFunctions(string key)
        {

        }

        protected void Session_End(object sender, EventArgs e)
        {
            /*
            try
            {
                string conStr = Session["conStr"].ToString(); //System.Configuration.ConfigurationManager.ConnectionStrings["MySQLConnectionString"].ConnectionString;
                SOCISA.Models.Utilizator u = (SOCISA.Models.Utilizator)Session["CURENT_USER"];
                u.IS_ONLINE = false;
                u.Update();
                System.Web.Security.FormsAuthentication.SignOut();
            }
            catch (Exception exp) { SOCISA.LogWriter.Log(exp); }
            */
        }
        /*
        public static void RegisterGlobalFilters(GlobalFilterCollection filters)
        {
            filters.Add(new GlobalAntiForgeryTokenAttribute(false));
        }
        */

        protected void Application_End(object sender, EventArgs e)
        {

        }

        protected void Application_AcquireRequestState(object sender, EventArgs e)
        {
            string culture = CultureInfo.CurrentCulture.Name;
            //string culture = System.Configuration.ConfigurationManager.AppSettings["DefaultUICulture"];
            if (HttpContext.Current.Session != null && HttpContext.Current.Session["Culture"] != null)
            {
                culture = Convert.ToString(HttpContext.Current.Session["Culture"]);
            }
            CultureInfo cultureInfo = new CultureInfo(culture);
            //Thread.CurrentThread.CurrentCulture = cultureInfo;
            Thread.CurrentThread.CurrentUICulture = cultureInfo;
        }
    }

    public class DateTimeModelBinder : IModelBinder
    {
        private readonly string _customFormat;
        public DateTimeModelBinder(string CustomFormat)
        {
            this._customFormat = CustomFormat;
        }
        object IModelBinder.BindModel(ControllerContext controllerContext, ModelBindingContext bindingContext)
        {
            ValueProviderResult value = bindingContext.ValueProvider.GetValue(bindingContext.ModelName);
            if (value == null || String.IsNullOrEmpty(value.AttemptedValue)) return null;
            try
            {
                string formatedDate = value.AttemptedValue;
                if (value.AttemptedValue.Length == 10)
                    formatedDate = String.Format("{0} 00:00:00", value.AttemptedValue);
                //return DateTime.ParseExact(value.AttemptedValue, this._customFormat, System.Globalization.CultureInfo.InvariantCulture);
                return DateTime.ParseExact(formatedDate, this._customFormat, CultureInfo.InvariantCulture);
            }
            catch(Exception exp) { LogWriter.Log(exp); return null; }
        }
    }

    public class DoubleModelBinder : IModelBinder
    {
        object IModelBinder.BindModel(ControllerContext controllerContext, ModelBindingContext bindingContext)
        {
            ValueProviderResult value = bindingContext.ValueProvider.GetValue(bindingContext.ModelName);
            if (value == null || String.IsNullOrWhiteSpace(value.AttemptedValue)) return null;
            string formatedValue = value.AttemptedValue;
            try
            {
                return Convert.ToDouble(formatedValue, new CultureInfo("EN-en"));
            }
            catch
            {
                try
                {
                    return Convert.ToDouble(formatedValue, CultureInfo.CurrentCulture);
                }
                catch (Exception exp) { LogWriter.Log(exp); return null; }
            }
        }
    }

    public class CustomByteArrayModelBinder : IModelBinder
    {
        object IModelBinder.BindModel(ControllerContext controllerContext, ModelBindingContext bindingContext)
        {
            ValueProviderResult value = bindingContext.ValueProvider.GetValue(bindingContext.ModelName);
            if (value == null || String.IsNullOrEmpty(value.AttemptedValue)) return null;
            try
            {
                return Convert.FromBase64String(value.AttemptedValue);
            }
            catch (Exception exp) { SOCISA.LogWriter.Log(exp); return null; }
        }
    }

    public class CustomImportDosareModelBinder : IModelBinder
    {
        object IModelBinder.BindModel(ControllerContext controllerContext, ModelBindingContext bindingContext)
        {
            //ValueProviderResult value = bindingContext.ValueProvider.GetValue(bindingContext.ModelName);
            ValueProviderResult value = ((DictionaryValueProvider<object>)(((ValueProviderCollection)bindingContext.ValueProvider)[2])).GetValue("ImportDosarView[0][0].Status");
            if (value == null || String.IsNullOrEmpty(value.AttemptedValue)) return null;
            try
            {
                return Newtonsoft.Json.JsonConvert.DeserializeObject<ImportDosarView>(value.AttemptedValue);
            }
            catch (Exception exp) { SOCISA.LogWriter.Log(exp); return null; }
        }
    }

    /*
    public class DefaultAuthorizeAttribute : AuthorizeAttribute
    {
        public override void OnAuthorization(AuthorizationContext filterContext)
        {
            var action = filterContext.ActionDescriptor;
            if (action.IsDefined(typeof(AuthorizeTokenAttribute), true)) return;

            base.OnAuthorization(filterContext);
        }
    }
    */

    /*
    public class AuthorizeTokenAttribute : AuthorizeAttribute
    {
        protected override bool AuthorizeCore(HttpContextBase httpContext)
        {
            try
            {
                //string conStr = httpContext.Session["conStr"].ToString();
                string conStr = httpContext.Server.MapPath("~").ToLower().IndexOf("test") > 0 ? CommonFunctions.StringCipher.Decrypt(System.Configuration.ConfigurationManager.ConnectionStrings["MySQLConnectionString_test"].ConnectionString, CommonFunctions.StringCipher.RetrieveKey()) : CommonFunctions.StringCipher.Decrypt(System.Configuration.ConfigurationManager.ConnectionStrings["MySQLConnectionString"].ConnectionString, CommonFunctions.StringCipher.RetrieveKey()); // separam socisa de socisa_test

                string Token = httpContext.Request.Params["URL"].ToString().Substring(httpContext.Request.Params["URL"].ToString().LastIndexOf('/') + 1);
                if (String.IsNullOrWhiteSpace(Token) || Token.IndexOf('|') < 0)
                    return true; // pt. acces normal, pt. care vom face autorizarea in AuthorizeUserAttribute
                httpContext.Session["TOKEN"] = Token;
                SOCISA.Models.Utilizator u = null;
                MySql.Data.MySqlClient.MySqlConnection con = new MySql.Data.MySqlClient.MySqlConnection(conStr);
                MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand();
                cmd.Connection = con;
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.CommandText = "UTILIZATORIsp_GetByUserName";
                cmd.Parameters.Add(new MySql.Data.MySqlClient.MySqlParameter("_USER_NAME", "email"));
                con.Open();
                MySql.Data.MySqlClient.MySqlDataReader r = cmd.ExecuteReader(System.Data.CommandBehavior.CloseConnection);
                while (r.Read())
                {
                    int authenticatedUserId = Convert.ToInt32(r["ID"]);
                    u = new SOCISA.Models.Utilizator(Convert.ToInt32(authenticatedUserId), conStr, r);
                    break;
                }
                r.Close(); r.Dispose();
                if (con != null && con.State == System.Data.ConnectionState.Open)
                {
                    con.Close();
                    con.Dispose();
                }

                if (u == null)
                {
                    return false;
                }

                string[] separator = { "|" };
                string[] token = Token.Split(separator, StringSplitOptions.RemoveEmptyEntries);
                string md5p = token[0];
                int id = Convert.ToInt32(token[1]);
                SOCISA.Models.Dosar d = new SOCISA.Models.Dosar(Convert.ToInt32(u.ID), conStr, id);
                MD5 md5h = MD5.Create();
                if (!CommonFunctions.VerifyMd5Hash(md5h, d.NR_DOSAR_CASCO, md5p))
                {
                    return false;
                }
                httpContext.Session["conStr"] = conStr;
                httpContext.Session["CURENT_USER_ID"] = u.ID;
                httpContext.Session["CURENT_USER"] = u;
                System.Web.Security.FormsAuthentication.SetAuthCookie(u.USER_NAME, false);
                //System.Web.Security.FormsAuthentication.SetAuthCookie("", false);
                SOCISA.Models.NomenclatoareRepository nr = new SOCISA.Models.NomenclatoareRepository(Convert.ToInt32(u.ID), conStr);
                SOCISA.Models.Nomenclator n = (SOCISA.Models.Nomenclator)nr.Find("TIP_UTILIZATORI", Convert.ToInt32(u.ID_TIP_UTILIZATOR)).Result;
                httpContext.Session["CURENT_USER_TYPE"] = n;
                httpContext.Session["CURENT_USER_RIGHTS"] = (SOCISA.Models.Drept[])u.GetDrepturi().Result;
                httpContext.Session["CURENT_USER_ACTIONS"] = (SOCISA.Models.Action[])u.GetActions().Result;
                httpContext.Session["CURENT_USER_SETTINGS"] = (SOCISA.Models.Setare[])u.GetSetari().Result;
                httpContext.Session["CURENT_USER_SOCIETATI_ADMINISTRATE"] = (SOCISA.Models.SocietateAsigurare[])u.GetSocietatiAdministrate().Result;

                httpContext.Session["ID_SOCIETATE"] = d.ID_SOCIETATE_CASCO;
                SOCISA.Models.SocietateAsigurare sa = new SOCISA.Models.SocietateAsigurare(Convert.ToInt32(u.ID_SOCIETATE), conStr, Convert.ToInt32(d.ID_SOCIETATE_CASCO));
                httpContext.Session["SOCIETATE_ASIGURARE"] = sa;
                return true;
            }
            catch (Exception exp)
            {
                LogWriter.Log(exp);
                return false;
            }
        }
    }
    */

    public class AuthorizeUserAttribute : AuthorizeAttribute
    {
        public string ActionName { get; set; }
        public bool Recursive { get; set; }

        protected override bool AuthorizeCore(HttpContextBase httpContext)
        {
            // ***************** TEMPORAR PT. TEST AFISARE DOSAR DIN LINK EMAIL **********************
            /*
            try
            {
                string Token = httpContext.Request.Params["URL"].ToString().Substring(httpContext.Request.Params["URL"].ToString().LastIndexOf('/') + 1);
                if (!String.IsNullOrWhiteSpace(Token) && Token.IndexOf('|') > -1)
                    return true; // pt. acces normal, pt. care vom face autorizarea in AuthorizeUserAttribute
            }
            catch(Exception exp) { LogWriter.Log(exp); }
            */
            // ***************************************************************************************

            /*
            var isAuthorized = base.AuthorizeCore(httpContext);
            if (!isAuthorized)
            {
                return false;
            }
            */

            if (httpContext.Session["CURENT_USER_ID"] == null)
                return false;

            SOCISA.Models.Utilizator u = (SOCISA.Models.Utilizator)httpContext.Session["CURENT_USER"];
            string ut = ((SOCISA.Models.Nomenclator)u.GetTipUtilizator().Result).DENUMIRE;
            if (ut != "Administrator" || (ut == "Administrator" && httpContext.Request.Url.ToString().IndexOf("SelectSocietate") == -1))
            {
                if (httpContext.Session["ID_SOCIETATE"] == null)
                    return false;
            }

            SOCISA.Models.Action[] userActions = (SOCISA.Models.Action[])u.GetActions().Result;
            /*
            bool userHasAction = false;
            foreach(SOCISA.Models.Action a in userActions)
            {
                if (a.NAME == ActionName)
                {
                    userHasAction = true;
                    break;
                }
            }
            return userHasAction;
            */
            return UserHasAction(ActionName, userActions, Recursive);
        }

        protected bool UserHasAction(string actionName, SOCISA.Models.Action[] actions, bool recursive)
        {
            bool toReturn = false;
            foreach(SOCISA.Models.Action a in actions)
            {
                if(actionName == a.NAME)
                {
                    if (a.PARENT_ID != null && recursive)
                    {
                        //SOCISA.Models.Action aParent = new SOCISA.Models.Action(Convert.ToInt32(HttpContext.Current.Session["CURENT_USER_ID"]), System.Configuration.ConfigurationManager.ConnectionStrings["MySQLConnectionString"].ConnectionString, Convert.ToInt32(a.PARENT_ID));
                        SOCISA.Models.Action aParent = new SOCISA.Models.Action(Convert.ToInt32(HttpContext.Current.Session["CURENT_USER_ID"]), HttpContext.Current.Session["conStr"].ToString(), Convert.ToInt32(a.PARENT_ID));
                        toReturn = UserHasAction(aParent.NAME, actions, recursive);
                    }
                    else
                    {
                        toReturn = true;
                    }
                    break;
                }
            }
            return toReturn;
        }
    }

    [AttributeUsage(AttributeTargets.Method | AttributeTargets.Class, AllowMultiple = false, Inherited = true)]
    public class ValidateJsonAntiForgeryTokenAttribute : FilterAttribute, IAuthorizationFilter
    {
        public void OnAuthorization(AuthorizationContext filterContext)
        {
            if (filterContext == null)
            {
                throw new ArgumentNullException("filterContext");
            }

            var httpContext = filterContext.HttpContext;
            var cookie = httpContext.Request.Cookies[AntiForgeryConfig.CookieName];
            AntiForgery.Validate(cookie != null ? cookie.Value : null, httpContext.Request.Headers["__RequestVerificationToken"]);
        }
    }

    public class GlobalAntiForgeryTokenAttribute : FilterAttribute, IAuthorizationFilter
    {
        private readonly bool autoValidateAllPost;

        public GlobalAntiForgeryTokenAttribute(bool autoValidateAllPost)
        {
            this.autoValidateAllPost = autoValidateAllPost;
        }

        private const string RequestVerificationTokenKey = "__RequestVerificationToken";
        public void OnAuthorization(AuthorizationContext filterContext)
        {
            if (filterContext == null)
            {
                throw new ArgumentNullException("filterContext");
            }
            var req = filterContext.HttpContext.Request;
            if (req.HttpMethod.ToUpperInvariant() != "GET")
            {
                if (req.Form[RequestVerificationTokenKey] == null && req.IsAjaxRequest()) // && req.Headers[RequestVerificationTokenKey] != null 
                {
                    var cookie = req.Cookies[AntiForgeryConfig.CookieName];
                    if (req.Headers[RequestVerificationTokenKey] == null || cookie == null)
                        throw new HttpAntiForgeryException();
                    AntiForgery.Validate(cookie != null ? cookie.Value : null, req.Headers[RequestVerificationTokenKey]);
                    
                }
                else
                {
                    //if (autoValidateAllPost)
                        AntiForgery.Validate();
                }
            }
        }
    }
}
