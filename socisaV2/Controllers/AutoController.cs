using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using SOCISA.Models;
using SOCISA;
using System.Reflection;

namespace socisaWeb.Controllers
{
    //[DefaultAuthorize]
    [Authorize]
    public class AutoController : Controller
    {
        //[AuthorizeUser(ActionName = "Nomenclatoare", Recursive = false)]
        public ActionResult Index()
        {
            return View();
        }

        //[AuthorizeUser(ActionName = "Nomenclatoare", Recursive = false)]
        public ActionResult Details(string id)
        {
            string conStr = Session["conStr"].ToString(); //ConfigurationManager.ConnectionStrings["MySQLConnectionString"].ConnectionString;
            int uid = Convert.ToInt32(Session["CURENT_USER_ID"]);
            Auto a = !String.IsNullOrWhiteSpace(id) && id != "null" ? new Auto(uid, conStr, Convert.ToInt32(id)) : new Auto();
            return PartialView("_PartialAuto", a);
        }

        [AuthorizeUser(ActionName = "Nomenclatoare", Recursive = false)]
        public JsonResult Edit(Auto auto)
        {
            response toReturn = new response(); 
            string conStr = Session["conStr"].ToString(); //ConfigurationManager.ConnectionStrings["MySQLConnectionString"].ConnectionString;
            int uid = Convert.ToInt32(Session["CURENT_USER_ID"]);
            Auto a = null;
            if (auto != null)
            {
                a = new Auto(uid, conStr);
                PropertyInfo[] pis = auto.GetType().GetProperties();
                foreach (PropertyInfo pi in pis)
                {
                    pi.SetValue(a, pi.GetValue(auto));
                }
            }
            if(a.ID == null) // insert
            {
                toReturn = a.Insert();
            }
            else //update
            {
                toReturn = a.Update();
            }
            return Json(toReturn, JsonRequestBehavior.AllowGet);
        }
    }
}