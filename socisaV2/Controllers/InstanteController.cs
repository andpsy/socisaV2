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
    public class InstanteController : Controller
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
            Nomenclator i = !String.IsNullOrWhiteSpace(id) && id != "null" ? new Nomenclator(uid, conStr, "instante", Convert.ToInt32(id)) : new Nomenclator();
            return PartialView("_PartialInstanta", i);
        }

        [AuthorizeUser(ActionName = "Nomenclatoare", Recursive = false)]
        public JsonResult Edit(Nomenclator Instanta)
        {
            response toReturn = new response(); 
            string conStr = Session["conStr"].ToString(); //ConfigurationManager.ConnectionStrings["MySQLConnectionString"].ConnectionString;
            int uid = Convert.ToInt32(Session["CURENT_USER_ID"]);
            Nomenclator i = null;
            if (Instanta != null)
            {
                i = new Nomenclator(uid, conStr, "instante");
                PropertyInfo[] pis = Instanta.GetType().GetProperties();
                foreach (PropertyInfo pi in pis)
                {
                    pi.SetValue(i, pi.GetValue(Instanta));
                }
            }
            i.TableName = "instante";
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