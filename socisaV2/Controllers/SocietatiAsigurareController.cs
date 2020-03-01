using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using SOCISA;
using SOCISA.Models;
using System.Reflection;

namespace socisaWeb
{
    [Authorize]
    public class SocietatiAsigurareController : Controller
    {
        //[AuthorizeUser(ActionName = "Nomenclatoare", Recursive = false)]
        public ActionResult Index()
        {
            string conStr = Session["conStr"].ToString(); //ConfigurationManager.ConnectionStrings["MySQLConnectionString"].ConnectionString;
            int CURENT_USER_ID = Convert.ToInt32(Session["CURENT_USER_ID"]);
            SocietateAsigurare[] sas = (SocietateAsigurare[])(new SocietatiAsigurareRepository(CURENT_USER_ID, conStr).GetAll().Result);
            return PartialView("SocietatiAsigurare", sas);
        }

        [HttpPost]
        public JsonResult CheckHostName(string emailAddress)
        {
            string conStr = Session["conStr"].ToString(); //ConfigurationManager.ConnectionStrings["MySQLConnectionString"].ConnectionString;
            int CURENT_USER_ID = Convert.ToInt32(Session["CURENT_USER_ID"]);
            SocietatiAsigurareRepository sar = new SocietatiAsigurareRepository(CURENT_USER_ID, conStr);
            bool toReturn = sar.CheckHostName(emailAddress);
            return Json(toReturn, JsonRequestBehavior.AllowGet);
        }

        [AuthorizeUser(ActionName = "Nomenclatoare", Recursive = false)]
        [HttpPost]
        public JsonResult Edit(SocietateAsigurare societate)
        {
            response r = new response();

            string conStr = Session["conStr"].ToString();  //ConfigurationManager.ConnectionStrings["MySQLConnectionString"].ConnectionString;
            int _CURENT_USER_ID = Convert.ToInt32(Session["CURENT_USER_ID"]);
            SocietatiAsigurareRepository ur = new SocietatiAsigurareRepository(_CURENT_USER_ID, conStr);
            SocietateAsigurare s = new SocietateAsigurare(_CURENT_USER_ID, conStr);
            PropertyInfo[] pis = societate.GetType().GetProperties();
            foreach (PropertyInfo pi in pis)
            {
                pi.SetValue(s, pi.GetValue(societate));
            }
            if (societate.ID == null) // insert
            {
                r = s.Insert();
            }
            else // update
            {
                r = s.Update();
            }
            return Json(r, JsonRequestBehavior.AllowGet);
        }

        //[AuthorizeUser(ActionName = "Nomenclatoare", Recursive = false)]
        public ActionResult Details(string id)
        {
            string conStr = Session["conStr"].ToString(); //ConfigurationManager.ConnectionStrings["MySQLConnectionString"].ConnectionString;
            int uid = Convert.ToInt32(Session["CURENT_USER_ID"]);
            SocietateAsigurare sa = !String.IsNullOrWhiteSpace(id) ? new SocietateAsigurare(uid, conStr, Convert.ToInt32(id)) : new SocietateAsigurare();
            return PartialView("_PartialSocietateAsigurare", sa);
        }

        [AuthorizeUser(ActionName = "Nomenclatoare", Recursive = false)]
        [HttpPost]
        public JsonResult ConfirmEmailAddress(SocietateAsigurare societate)
        {
            response r = new response();

            string conStr = Session["conStr"].ToString();  //ConfigurationManager.ConnectionStrings["MySQLConnectionString"].ConnectionString;
            int _CURENT_USER_ID = Convert.ToInt32(Session["CURENT_USER_ID"]);
            SocietatiAsigurareRepository ur = new SocietatiAsigurareRepository(_CURENT_USER_ID, conStr);
            SocietateAsigurare s = new SocietateAsigurare(_CURENT_USER_ID, conStr, Convert.ToInt32(societate.ID));
            if(s.EMAIL_CONFIRMAT != societate.EMAIL_CONFIRMAT)
                r = ur.ConfirmEmailAddress(Convert.ToInt32(societate.ID), societate.EMAIL_CONFIRMAT, "EMAIL");
            if (s.EMAIL_NOTIFICARI_CONFIRMAT != societate.EMAIL_NOTIFICARI_CONFIRMAT)
                r = ur.ConfirmEmailAddress(Convert.ToInt32(societate.ID), societate.EMAIL_NOTIFICARI_CONFIRMAT, "EMAIL_NOTIFICARI");
            return Json(r, JsonRequestBehavior.AllowGet);
        }

    }
}