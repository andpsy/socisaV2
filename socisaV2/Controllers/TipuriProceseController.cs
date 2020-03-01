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
    public class TipuriProceseController : Controller
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
            Nomenclator tp = !String.IsNullOrWhiteSpace(id) && id != "null" ? new Nomenclator(uid, conStr, "tip_procese", Convert.ToInt32(id)) : new Nomenclator();
            return PartialView("_PartialTipProces", tp);
        }

        [AuthorizeUser(ActionName = "Nomenclatoare", Recursive = false)]
        public JsonResult Edit(Nomenclator TipProces)
        {
            response toReturn = new response(); 
            string conStr = Session["conStr"].ToString(); //ConfigurationManager.ConnectionStrings["MySQLConnectionString"].ConnectionString;
            int uid = Convert.ToInt32(Session["CURENT_USER_ID"]);
            Nomenclator tp = null;
            if (TipProces != null)
            {
                tp = new Nomenclator(uid, conStr, "tip_procese");
                PropertyInfo[] pis = TipProces.GetType().GetProperties();
                foreach (PropertyInfo pi in pis)
                {
                    pi.SetValue(tp, pi.GetValue(TipProces));
                }
            }
            tp.TableName = "tip_procese";
            if(tp.ID == null) // insert
            {
                toReturn = tp.Insert();
            }
            else //update
            {
                toReturn = tp.Update();
            }
            return Json(toReturn, JsonRequestBehavior.AllowGet);
        }
    }
}