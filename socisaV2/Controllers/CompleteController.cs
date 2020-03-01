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
    public class CompleteController : Controller
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
            Nomenclator c = !String.IsNullOrWhiteSpace(id) && id != "null" ? new Nomenclator(uid, conStr, "complete", Convert.ToInt32(id)) : new Nomenclator();
            return PartialView("_PartialComplet", c);
        }

        [AuthorizeUser(ActionName = "Nomenclatoare", Recursive = false)]
        public JsonResult Edit(Nomenclator Complet)
        {
            response toReturn = new response(); 
            string conStr = Session["conStr"].ToString(); //ConfigurationManager.ConnectionStrings["MySQLConnectionString"].ConnectionString;
            int uid = Convert.ToInt32(Session["CURENT_USER_ID"]);
            Nomenclator c = null;
            if (Complet != null)
            {
                c = new Nomenclator(uid, conStr, "complete");
                PropertyInfo[] pis = Complet.GetType().GetProperties();
                foreach (PropertyInfo pi in pis)
                {
                    pi.SetValue(c, pi.GetValue(Complet));
                }
            }
            c.TableName = "complete";
            if(c.ID == null) // insert
            {
                toReturn = c.Insert();
            }
            else //update
            {
                toReturn = c.Update();
            }
            return Json(toReturn, JsonRequestBehavior.AllowGet);
        }
    }
}