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
    public class IntervenientiController : Controller
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
            Intervenient i = !String.IsNullOrWhiteSpace(id) ? new Intervenient(uid, conStr, Convert.ToInt32(id)) : new Intervenient();
            return PartialView("_PartialIntervenient", i);
        }

        [AuthorizeUser(ActionName = "Nomenclatoare", Recursive = false)]
        public JsonResult Edit(Intervenient intervenient)
        {
            response toReturn = new response(); 
            string conStr = Session["conStr"].ToString(); //ConfigurationManager.ConnectionStrings["MySQLConnectionString"].ConnectionString;
            int uid = Convert.ToInt32(Session["CURENT_USER_ID"]);
            Intervenient i = null;
            if (intervenient != null)
            {
                i = new Intervenient(uid, conStr);
                PropertyInfo[] pis = intervenient.GetType().GetProperties();
                foreach (PropertyInfo pi in pis)
                {
                    pi.SetValue(i, pi.GetValue(intervenient));
                }
            }
            if(i.ID == null) // insert
            {
                toReturn = i.Insert();
            }
            else //update
            {
                toReturn = i.Update();
            }
            return Json(toReturn, JsonRequestBehavior.AllowGet);
        }
    }
}