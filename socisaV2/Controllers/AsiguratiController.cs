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
    public class AsiguratiController : Controller
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
            Asigurat a = !String.IsNullOrWhiteSpace(id) && id != "null" ? new Asigurat(uid, conStr, Convert.ToInt32(id)) : new Asigurat();
            return PartialView("_PartialAsigurat", a);
        }

        [AuthorizeUser(ActionName = "Nomenclatoare", Recursive = false)]
        public JsonResult Edit(Asigurat asigurat)
        {
            response toReturn = new response(); 
            string conStr = Session["conStr"].ToString(); //ConfigurationManager.ConnectionStrings["MySQLConnectionString"].ConnectionString;
            int uid = Convert.ToInt32(Session["CURENT_USER_ID"]);
            Asigurat a = null;
            if (asigurat != null)
            {
                a = new Asigurat(uid, conStr);
                PropertyInfo[] pis = asigurat.GetType().GetProperties();
                foreach (PropertyInfo pi in pis)
                {
                    pi.SetValue(a, pi.GetValue(asigurat));
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