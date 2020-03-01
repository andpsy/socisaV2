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
    public class PartiController : Controller
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
            Nomenclator i = !String.IsNullOrWhiteSpace(id) && id != "null" ? new Nomenclator(uid, conStr, "parti", Convert.ToInt32(id)) : new Nomenclator();
            return PartialView("_PartialParte", i);
        }

        [AuthorizeUser(ActionName = "Nomenclatoare", Recursive = false)]
        public JsonResult Edit(Nomenclator Parte)
        {
            response toReturn = new response(); 
            string conStr = Session["conStr"].ToString(); //ConfigurationManager.ConnectionStrings["MySQLConnectionString"].ConnectionString;
            int uid = Convert.ToInt32(Session["CURENT_USER_ID"]);
            Nomenclator i = null;
            if (Parte != null)
            {
                i = new Nomenclator(uid, conStr, "parti");
                PropertyInfo[] pis = Parte.GetType().GetProperties();
                foreach (PropertyInfo pi in pis)
                {
                    pi.SetValue(i, pi.GetValue(Parte));
                }
            }
            i.TableName = "parti";
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