using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using SOCISA.Models;
using SOCISA;
using System.Reflection;
using Newtonsoft.Json;

namespace socisaWeb.Controllers
{
    //[DefaultAuthorize]
    [Authorize]
    public class NotificariEmailController : Controller
    {
        //[AuthorizeUser(ActionName = "Administrare", Recursive = false)]
        public ActionResult Index()
        {
            string conStr = Session["conStr"].ToString(); //ConfigurationManager.ConnectionStrings["MySQLConnectionString"].ConnectionString;
            int uid = Convert.ToInt32(Session["CURENT_USER_ID"]);
            //NotificariEmailView nev = new NotificariEmailView(uid, conStr);
            NotificariEmailView nev = new NotificariEmailView(uid, conStr, DateTime.Now.Date);
            return PartialView("NotificariEmail", nev);
        }

        //[AuthorizeUser(ActionName = "Administrare", Recursive = false)]
        [HttpPost]
        public JsonResult Filter(string _data)
        {
            try
            {
                string conStr = Session["conStr"].ToString(); //ConfigurationManager.ConnectionStrings["MySQLConnectionString"].ConnectionString;
                int uid = Convert.ToInt32(Session["CURENT_USER_ID"]);
                DateTime d = CommonFunctions.SwitchBackFormatedDate(_data) == null ? new DateTime() : CommonFunctions.SwitchBackFormatedDate(_data).Value.Date;
                NotificariEmailView nev = new NotificariEmailView(uid, conStr, d);
                return Json(JsonConvert.SerializeObject(nev, Formatting.None, new Newtonsoft.Json.Converters.IsoDateTimeConverter() { DateTimeFormat = CommonFunctions.DATE_FORMAT }), JsonRequestBehavior.AllowGet);
            }catch(Exception exp)
            {
                LogWriter.Log(exp);
                response r = new response(false, exp.Message, null, null, new List<Error>() { new Error(exp) });
                return Json(r, JsonRequestBehavior.AllowGet);
            }
        }

        //[AuthorizeUser(ActionName = "Administrare", Recursive = false)]
        [HttpPost]
        public JsonResult UpdateCheckDates(string _timestamp)
        {
            DateTime _d = DateTime.Now;
            string conStr = Session["conStr"].ToString(); //ConfigurationManager.ConnectionStrings["MySQLConnectionString"].ConnectionString;
            int uid = Convert.ToInt32(Session["CURENT_USER_ID"]);
            EmailNotificationsRepository enr = new EmailNotificationsRepository(uid, conStr);
            response r = enr.UpdateCheckedTimes(Convert.ToDateTime(_timestamp), _d);
            return Json(r, JsonRequestBehavior.AllowGet);
        }
    }
}