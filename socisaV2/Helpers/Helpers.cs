using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace socisaWeb.Helpers
{
    public static class Helpers
    {
        public static MvcHtmlString If(this MvcHtmlString value, bool evaluation)
        {
            return evaluation ? value : MvcHtmlString.Empty;
        }

        public static MvcHtmlString HasRight(this MvcHtmlString value, string right)
        {
            bool hasRight = false;
            SOCISA.Models.Nomenclator n = (SOCISA.Models.Nomenclator)HttpContext.Current.Session["CURENT_USER_TYPE"];
            if (n.DENUMIRE.ToLower() == "administrator")
            {
                hasRight = true;
            }
            else
            {
                SOCISA.Models.Drept[] ds = (SOCISA.Models.Drept[])HttpContext.Current.Session["CURENT_USER_RIGHTS"];
                foreach (SOCISA.Models.Drept d in ds)
                {
                    if (d.DENUMIRE == right || d.DENUMIRE.ToLower() == "administrare")
                    {
                        hasRight = true;
                        break;
                    }
                }
            }
            return hasRight ? value : MvcHtmlString.Empty;
        }

        public static bool HasRight(string right)
        {
            bool hasRight = false;
            SOCISA.Models.Nomenclator n = (SOCISA.Models.Nomenclator)HttpContext.Current.Session["CURENT_USER_TYPE"];
            if (n.DENUMIRE.ToLower() == "administrator")
            {
                hasRight = true;
            }
            else
            {
                SOCISA.Models.Drept[] ds = (SOCISA.Models.Drept[])HttpContext.Current.Session["CURENT_USER_RIGHTS"];
                foreach (SOCISA.Models.Drept d in ds)
                {
                    if (d.DENUMIRE == right || d.DENUMIRE.ToLower() == "administrare")
                    {
                        hasRight = true;
                        break;
                    }
                }
            }
            return hasRight;
        }

        public static bool HasAction(string action)
        {
            bool hasAction = false;
            SOCISA.Models.Nomenclator n = (SOCISA.Models.Nomenclator)HttpContext.Current.Session["CURENT_USER_TYPE"];
            if (n.DENUMIRE.ToLower() == "administrator")
            {
                hasAction = true;
            }
            else
            {
                SOCISA.Models.Action[] aas = (SOCISA.Models.Action[])HttpContext.Current.Session["CURENT_USER_ACTIONS"];
                foreach (SOCISA.Models.Action a in aas)
                {
                    if (a.NAME == action || a.NAME.ToLower() == "administrare")
                    {
                        hasAction = true;
                        break;
                    }
                }
            }
            return hasAction;
        }

        public static bool ValidareAvizare(int id)
        {
            string conStr = HttpContext.Current.Session["conStr"].ToString(); //System.Configuration.ConfigurationManager.ConnectionStrings["MySQLConnectionString"].ConnectionString;
            int uid = Convert.ToInt32(HttpContext.Current.Session["CURENT_USER_ID"]);
            SOCISA.Models.Dosar d = new SOCISA.Models.Dosar(uid, conStr, id);
            return d.ValidareAvizare().Status;
        }

        public static bool ValidareTiparire(int id)
        {
            string conStr = HttpContext.Current.Session["conStr"].ToString(); //System.Configuration.ConfigurationManager.ConnectionStrings["MySQLConnectionString"].ConnectionString;
            int uid = Convert.ToInt32(HttpContext.Current.Session["CURENT_USER_ID"]);
            SOCISA.Models.Dosar d = new SOCISA.Models.Dosar(uid, conStr, id);
            return d.ValidareTiparire().Status;
        }

        public static bool IsAvizat(int id)
        {
            string conStr = HttpContext.Current.Session["conStr"].ToString(); //System.Configuration.ConfigurationManager.ConnectionStrings["MySQLConnectionString"].ConnectionString;
            int uid = Convert.ToInt32(HttpContext.Current.Session["CURENT_USER_ID"]);
            SOCISA.Models.Dosar d = new SOCISA.Models.Dosar(uid, conStr, id);
            return d.IsAvizat();
        }

        public static bool IsExpirat(int id)
        {
            string conStr = HttpContext.Current.Session["conStr"].ToString(); //System.Configuration.ConfigurationManager.ConnectionStrings["MySQLConnectionString"].ConnectionString;
            int uid = Convert.ToInt32(HttpContext.Current.Session["CURENT_USER_ID"]);
            SOCISA.Models.Dosar d = new SOCISA.Models.Dosar(uid, conStr, id);
            return d.IsExpirat();
        }

        public static MvcHtmlString Image(this HtmlHelper helper, string src, string altText, string height = null, string width = null, string maxheight = null, string maxwidth = null, string cssClass = null)
        {
            var builder = new TagBuilder("img");
            builder.MergeAttribute("src", src);
            builder.MergeAttribute("alt", altText);

            if (!string.IsNullOrWhiteSpace(height))
            {
                builder.MergeAttribute("height", height);
            }
            if (!string.IsNullOrWhiteSpace(width))
            {
                builder.MergeAttribute("width", width);
            }
            if (!string.IsNullOrWhiteSpace(maxheight))
            {
                builder.MergeAttribute("max-height", maxheight);
            }
            if (!string.IsNullOrWhiteSpace(maxwidth))
            {
                builder.MergeAttribute("max-width", maxwidth);
            }
            if (!string.IsNullOrWhiteSpace(cssClass))
            {
                builder.MergeAttribute("class", cssClass);
            }
            return MvcHtmlString.Create(builder.ToString(TagRenderMode.SelfClosing));
        }
    }
}