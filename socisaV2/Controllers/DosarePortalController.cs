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
    public class DosarePortalController : Controller
    {
        //[AuthorizeUser(ActionName = "Dosare", Recursive = false)]
        public ActionResult SedinteIndex()
        {
            string conStr = Session["conStr"].ToString(); //ConfigurationManager.ConnectionStrings["MySQLConnectionString"].ConnectionString;
            int uid = Convert.ToInt32(Session["CURENT_USER_ID"]);
            int sid = Convert.ToInt32(Session["ID_SOCIETATE"]);
            SedintaPortalView spv = new SedintaPortalView(uid, conStr, DateTime.Now.Date, sid);
            return PartialView("SedintePortal", spv);
        }

        //[AuthorizeUser(ActionName = "Dosare", Recursive = false)]
        public ActionResult ImportSedintaPortalIndex(string id)
        {
            string conStr = Session["conStr"].ToString(); //ConfigurationManager.ConnectionStrings["MySQLConnectionString"].ConnectionString;
            int uid = Convert.ToInt32(Session["CURENT_USER_ID"]);
            int sid = Convert.ToInt32(Session["ID_SOCIETATE"]);
            ImportSedintaPortalView ispv = new ImportSedintaPortalView(uid, conStr, Convert.ToInt32(id));
            return PartialView("_PartialImportSedintaPortal", ispv);
        }

        [HttpPost]
        //[AuthorizeUser(ActionName = "Dosare", Recursive = false)]
        public JsonResult ImportSedintaPortal(int IdSedintaPortal, ProcesStadiu ProcesStadiu, Sentinta Sentinta)
        {
            response r = new response();
            string conStr = Session["conStr"].ToString(); //ConfigurationManager.ConnectionStrings["MySQLConnectionString"].ConnectionString;
            int uid = Convert.ToInt32(Session["CURENT_USER_ID"]);
            if(Sentinta.NR_SENTINTA != null && Sentinta.DATA_SENTINTA != null)
            {
                Sentinta s = new Sentinta(uid, conStr);
                PropertyInfo[] pis1 = Sentinta.GetType().GetProperties();
                foreach (PropertyInfo pi in pis1)
                {
                    pi.SetValue(s, pi.GetValue(Sentinta));
                }
                r = s.Insert();
                if (r.Status)
                {
                    ProcesStadiu.ID_SENTINTA = r.InsertedId;
                }
            }
            ProcesStadiu ps = new ProcesStadiu(uid, conStr);
            PropertyInfo[] pis = ProcesStadiu.GetType().GetProperties();
            foreach (PropertyInfo pi in pis)
            {
                pi.SetValue(ps, pi.GetValue(ProcesStadiu));
            }
            r = ps.Insert();
            if (r.Status)
            {
                try
                {
                    SedintaPortal sp = new SedintaPortal(uid, conStr, IdSedintaPortal);
                    sp.Delete();
                }
                catch (Exception exp) { LogWriter.Log(exp); }
            }
            return Json(r, JsonRequestBehavior.AllowGet);
        }

        //[AuthorizeUser(ActionName = "Procese", Recursive = false)]
        public ActionResult Index(string id) // nr_dosar_instanta
        {
            string conStr = Session["conStr"].ToString(); //ConfigurationManager.ConnectionStrings["MySQLConnectionString"].ConnectionString;
            int uid = Convert.ToInt32(Session["CURENT_USER_ID"]);
            DosarPortalView dpv = new DosarPortalView();
            try
            {
                Proces p = new Proces(uid, conStr, Convert.ToInt32(id));
                dpv = new DosarPortalView(p.NR_DOSAR_INSTANTA);
            }catch(Exception exp) { LogWriter.Log(exp); }
            return PartialView("_InfoDosarPortal", dpv);
        }

        //[AuthorizeUser(ActionName = "Dosare", Recursive = false)]
        public ActionResult Details(string id)
        {
            string conStr = Session["conStr"].ToString(); //ConfigurationManager.ConnectionStrings["MySQLConnectionString"].ConnectionString;
            int uid = Convert.ToInt32(Session["CURENT_USER_ID"]);
            SedintaPortal sp = new SedintaPortal(uid, conStr, Convert.ToInt32(id));
            return PartialView("_PartialSedintePortal", sp);
        }

        [AuthorizeUser(ActionName = "Dosare", Recursive = false)]
        public JsonResult Edit(SedintaPortal SedintaPortal)
        {
            response toReturn = new response(); 
            string conStr = Session["conStr"].ToString(); //ConfigurationManager.ConnectionStrings["MySQLConnectionString"].ConnectionString;
            int uid = Convert.ToInt32(Session["CURENT_USER_ID"]);
            SedintaPortal sp = new SedintaPortal(uid, conStr);
            if (SedintaPortal != null)
            {
                PropertyInfo[] pis = SedintaPortal.GetType().GetProperties();
                foreach (PropertyInfo pi in pis)
                {
                    pi.SetValue(sp, pi.GetValue(SedintaPortal));
                }
            }
            if(sp.ID == null) // insert
            {
                toReturn = sp.Insert();
            }
            else //update
            {
                toReturn = sp.Update();
            }
            return Json(toReturn, JsonRequestBehavior.AllowGet);
        }
    }
}