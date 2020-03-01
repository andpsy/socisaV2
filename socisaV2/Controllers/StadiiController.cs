using System;
using System.Web.Mvc;
using SOCISA;
using SOCISA.Models;
using System.Reflection;

namespace socisaWeb.Controllers
{
    //[DefaultAuthorize]
    [Authorize]
    public class StadiiController : Controller
    {
        //[AuthorizeUser(ActionName = "Nomenclatoare", Recursive = false)]
        public ActionResult Index()
        {
            string conStr = Session["conStr"].ToString(); //ConfigurationManager.ConnectionStrings["MySQLConnectionString"].ConnectionString;
            int CURENT_USER_ID = Convert.ToInt32(Session["CURENT_USER_ID"]);
            StadiuView sv = new StadiuView(CURENT_USER_ID, conStr);
            return PartialView("_PartialStadiu", sv);
        }

        //[AuthorizeUser(ActionName = "Nomenclatoare", Recursive = false)]
        public ActionResult Details(string id)
        {
            string conStr = Session["conStr"].ToString(); //ConfigurationManager.ConnectionStrings["MySQLConnectionString"].ConnectionString;
            int uid = Convert.ToInt32(Session["CURENT_USER_ID"]);
            Stadiu s = !String.IsNullOrWhiteSpace(id) ? new Stadiu(uid, conStr, Convert.ToInt32(id)) : new Stadiu();
            return PartialView("_PartialStadiu", s);
        }

        [AuthorizeUser(ActionName = "Nomenclatoare", Recursive = false)]
        public JsonResult Edit(Stadiu stadiu)
        {
            response toReturn = new response(); 
            string conStr = Session["conStr"].ToString(); //ConfigurationManager.ConnectionStrings["MySQLConnectionString"].ConnectionString;
            int uid = Convert.ToInt32(Session["CURENT_USER_ID"]);
            Stadiu s = null;
            if (stadiu != null)
            {
                s = new Stadiu(uid, conStr);
                PropertyInfo[] pis = stadiu.GetType().GetProperties();
                foreach (PropertyInfo pi in pis)
                {
                    pi.SetValue(s, pi.GetValue(stadiu));
                }
            }
            if(s.ID == null) // insert
            {
                toReturn = s.Insert();
            }
            else //update
            {
                toReturn = s.Update();
            }
            return Json(toReturn, JsonRequestBehavior.AllowGet);
        }

        [AuthorizeUser(ActionName = "Nomenclatoare", Recursive = false)]
        [HttpPost]
        public JsonResult Delete(int id)
        {
            response r = new response();
            string conStr = Session["conStr"].ToString(); //ConfigurationManager.ConnectionStrings["MySQLConnectionString"].ConnectionString;
            int _CURENT_USER_ID = Convert.ToInt32(Session["CURENT_USER_ID"]);
            Stadiu s = new Stadiu(_CURENT_USER_ID, conStr, id);
            r = s.Delete();
            return Json(r, JsonRequestBehavior.AllowGet);
        }
    }
}