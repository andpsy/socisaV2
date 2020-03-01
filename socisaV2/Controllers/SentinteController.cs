using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using SOCISA;
using SOCISA.Models;
using System.Reflection;
using Newtonsoft.Json;

namespace socisaWeb.Controllers
{
    //[DefaultAuthorize]
    [Authorize]
    public class SentinteController : Controller
    {
        //[AuthorizeUser(ActionName = "Sentinte", Recursive = false)]
        public ActionResult Index()
        {
            string conStr = Session["conStr"].ToString(); //ConfigurationManager.ConnectionStrings["MySQLConnectionString"].ConnectionString;
            var toReturn = PartialView("SentinteView", new SentintaView(Convert.ToInt32(Session["CURENT_USER_ID"]), conStr));
            return toReturn;
        }

        //[AuthorizeUser(ActionName = "Sentinte", Recursive = false)]
        public JsonResult Details(int id) // id proces_stadiu
        {
            string conStr = Session["conStr"].ToString(); //ConfigurationManager.ConnectionStrings["MySQLConnectionString"].ConnectionString;
            SentintaView cv = new SentintaView(Convert.ToInt32(Session["CURENT_USER_ID"]), id, conStr);
            JsonResult result = Json(JsonConvert.SerializeObject(cv, Formatting.None, new Newtonsoft.Json.Converters.IsoDateTimeConverter() { DateTimeFormat = CommonFunctions.DATE_FORMAT }), JsonRequestBehavior.AllowGet);
            result.MaxJsonLength = Int32.MaxValue;
            return result;
        }

        [AuthorizeUser(ActionName = "Sentinte", Recursive = false)]
        [HttpPost]
        public JsonResult Edit(Sentinta Sentinta)
        {
            response toReturn = new response(true, "", null, null, new List<Error>());

            string conStr = Session["conStr"].ToString(); //ConfigurationManager.ConnectionStrings["MySQLConnectionString"].ConnectionString;
            int _CURENT_USER_ID = Convert.ToInt32(Session["CURENT_USER_ID"]);

            if (Sentinta.ID == null) // insert
            {
                Sentinta p = new Sentinta(_CURENT_USER_ID, conStr);
                PropertyInfo[] pis = Sentinta.GetType().GetProperties();
                foreach (PropertyInfo pi in pis)
                {
                    pi.SetValue(p, pi.GetValue(Sentinta));
                }
                toReturn = p.Insert();
            }
            else //
            {
                Sentinta p = new Sentinta(_CURENT_USER_ID, conStr, Convert.ToInt32(Sentinta.ID));
                string s = JsonConvert.SerializeObject(Sentinta, Formatting.None, new Newtonsoft.Json.Converters.IsoDateTimeConverter() { DateTimeFormat = CommonFunctions.DATE_FORMAT });
                toReturn = p.Update(s);
            }
            return Json(toReturn, JsonRequestBehavior.AllowGet);
        }

        [AuthorizeUser(ActionName = "Sentinte", Recursive = false)]
        [HttpPost]
        public JsonResult Delete(int id)
        {
            response r = new response();
            string conStr = Session["conStr"].ToString(); //ConfigurationManager.ConnectionStrings["MySQLConnectionString"].ConnectionString;
            int _CURENT_USER_ID = Convert.ToInt32(Session["CURENT_USER_ID"]);
            //DosareRepository dr = new DosareRepository(_CURENT_USER_ID, conStr);
            Sentinta s = new Sentinta(_CURENT_USER_ID, conStr, id);
            r = s.Delete();
            return Json(r, JsonRequestBehavior.AllowGet);
        }
    }
}