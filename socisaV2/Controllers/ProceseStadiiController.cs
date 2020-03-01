using System;
using System.Web.Mvc;
using SOCISA;
using SOCISA.Models;
using System.Reflection;
using Newtonsoft.Json;

namespace socisaWeb.Controllers
{
    //[DefaultAuthorize]
    [Authorize]
    public class ProceseStadiiController : Controller
    {
        //[AuthorizeUser(ActionName = "Procese", Recursive = false)]
        public ActionResult Index()
        {
            string conStr = Session["conStr"].ToString(); //ConfigurationManager.ConnectionStrings["MySQLConnectionString"].ConnectionString;
            int CURENT_USER_ID = Convert.ToInt32(Session["CURENT_USER_ID"]);
            ProcesStadiuView psv = new ProcesStadiuView(CURENT_USER_ID, conStr);
            return PartialView("_PartialProceseStadii", psv);
        }

        //[AuthorizeUser(ActionName = "Procese", Recursive = false)]
        public JsonResult Details(string _id, string _tip)
        {
            string conStr = Session["conStr"].ToString(); //ConfigurationManager.ConnectionStrings["MySQLConnectionString"].ConnectionString;
            int uid = Convert.ToInt32(Session["CURENT_USER_ID"]);
            ProcesStadiuView psv = new ProcesStadiuView(uid, conStr);
            try
            {
                psv = !String.IsNullOrWhiteSpace(_id) ? new ProcesStadiuView(uid, conStr, Convert.ToInt32(_id), _tip) : new ProcesStadiuView(uid, conStr);
            }
            catch (Exception exp) { LogWriter.Log(exp); }
            string toReturn = JsonConvert.SerializeObject(psv, Formatting.None, new Newtonsoft.Json.Converters.IsoDateTimeConverter() { DateTimeFormat = CommonFunctions.DATE_FORMAT });

            return Json(toReturn, JsonRequestBehavior.AllowGet);
        }

        [AuthorizeUser(ActionName = "Procese", Recursive = false)]
        public JsonResult Edit(ProcesStadiuExtended ProcesStadiuExtended)
        {
            response toReturn = new response();
            string conStr = Session["conStr"].ToString(); //ConfigurationManager.ConnectionStrings["MySQLConnectionString"].ConnectionString;
            int uid = Convert.ToInt32(Session["CURENT_USER_ID"]);
            Sentinta s = null;
            ProcesStadiu ps = null;
            if (ProcesStadiuExtended != null)
            {
                if (ProcesStadiuExtended.Sentinta != null && ProcesStadiuExtended.ProcesStadiu.ID_SENTINTA != null)
                {
                    s = new Sentinta(uid, conStr);
                    PropertyInfo[] pis = ProcesStadiuExtended.Sentinta.GetType().GetProperties();
                    foreach (PropertyInfo pi in pis)
                    {
                        pi.SetValue(s, pi.GetValue(ProcesStadiuExtended.Sentinta));
                    }
                }

                ps = new ProcesStadiu(uid, conStr);
                PropertyInfo[] pis2 = ProcesStadiuExtended.ProcesStadiu.GetType().GetProperties();
                foreach (PropertyInfo pi in pis2)
                {
                    pi.SetValue(ps, pi.GetValue(ProcesStadiuExtended.ProcesStadiu));
                }
            }
            if (ps.ID == null) // insert
            {
                if (!ProcesStadiuExtended.Stadiu.STADIU_CU_SENTINTA)
                {
                    ps.ID_SENTINTA = null;
                    s = null;
                }
                if (s != null)
                {
                    toReturn = s.Insert();
                }
                if (s == null || toReturn.Status)
                {
                    toReturn = ps.Insert();
                    toReturn.Message = JsonConvert.SerializeObject(new ProcesStadiuExtended(ps), Formatting.None, new Newtonsoft.Json.Converters.IsoDateTimeConverter() { DateTimeFormat = CommonFunctions.DATE_FORMAT });
                }
            }
            else //update
            {
                ProcesStadiu existingPS = new ProcesStadiu(uid, conStr, Convert.ToInt32(ps.ID));
                if (!ProcesStadiuExtended.Stadiu.STADIU_CU_SENTINTA)
                {
                    ps.ID_SENTINTA = null;
                }
                if (existingPS.ID_SENTINTA != null && ps.ID_SENTINTA != null)
                {
                    toReturn = s.Update();
                }
                if (existingPS.ID_SENTINTA == null && ps.ID_SENTINTA != null)
                {
                    toReturn = s.Insert();
                    if (toReturn.Status)
                    {
                        ps.ID_SENTINTA = toReturn.InsertedId;
                    }
                }
                if (existingPS.ID_SENTINTA != null && ps.ID_SENTINTA == null)
                {
                    if (s != null)
                    {
                        toReturn = s.Delete();
                    }
                }

                if (toReturn.Status)
                {
                    toReturn = ps.Update();
                    toReturn.Message = JsonConvert.SerializeObject(new ProcesStadiuExtended(ps), Formatting.None, new Newtonsoft.Json.Converters.IsoDateTimeConverter() { DateTimeFormat = CommonFunctions.DATE_FORMAT });
                }
            }
            
            return Json(toReturn, JsonRequestBehavior.AllowGet);
        }
        /*
        public JsonResult Edit(ProcesStadiu ProcesStadiu)
        {
            response toReturn = new response(); 
            string conStr = Session["conStr"].ToString(); //ConfigurationManager.ConnectionStrings["MySQLConnectionString"].ConnectionString;
            int uid = Convert.ToInt32(Session["CURENT_USER_ID"]);
            ProcesStadiu s = null;
            if (ProcesStadiu != null)
            {
                s = new ProcesStadiu(uid, conStr);
                PropertyInfo[] pis = ProcesStadiu.GetType().GetProperties();
                foreach (PropertyInfo pi in pis)
                {
                    pi.SetValue(s, pi.GetValue(ProcesStadiu));
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
        */

        [AuthorizeUser(ActionName = "Procese", Recursive = false)]
        [HttpPost]
        public JsonResult Delete(int id)
        {
            response r = new response();
            string conStr = Session["conStr"].ToString(); //ConfigurationManager.ConnectionStrings["MySQLConnectionString"].ConnectionString;
            int _CURENT_USER_ID = Convert.ToInt32(Session["CURENT_USER_ID"]);
            //DosareRepository dr = new DosareRepository(_CURENT_USER_ID, conStr);
            ProcesStadiu ps = new ProcesStadiu(_CURENT_USER_ID, conStr, id);
            r = ps.Delete();
            return Json(r, JsonRequestBehavior.AllowGet);
        }
    }
}