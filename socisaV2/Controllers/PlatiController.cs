using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using SOCISA;
using SOCISA.Models;
using System.Reflection;
using Newtonsoft.Json;

namespace socisaWeb.Controllers
{
    //[DefaultAuthorize]
    [Authorize]
    public class PlatiController : Controller
    {
        [AuthorizeUser(ActionName = "Import", Recursive = false)]
        [AuthorizeUser(ActionName = "Plati", Recursive = false)]
        public ActionResult Import()
        {
            string conStr = Session["conStr"].ToString(); //ConfigurationManager.ConnectionStrings["MySQLConnectionString"].ConnectionString;
            return PartialView("PlatiImport", new ImportPlataView(Convert.ToInt32(Session["CURENT_USER_ID"]), conStr));
        }

        [AuthorizeUser(ActionName = "Import", Recursive = false)]
        [AuthorizeUser(ActionName = "Plati", Recursive = false)]
        [HttpPost]
        public JsonResult PostExcelFile()
        {
            string conStr = Session["conStr"].ToString(); //ConfigurationManager.ConnectionStrings["MySQLConnectionString"].ConnectionString;
            HttpPostedFileBase f = Request.Files[0];
            string initFName = f.FileName;
            string extension = f.FileName.Substring(f.FileName.LastIndexOf('.'));
            string newFName = Guid.NewGuid() + extension;
            Request.Files[0].SaveAs(System.IO.Path.Combine(CommonFunctions.GetImportsFolder(), newFName));
            PlatiRepository pr = new PlatiRepository(Convert.ToInt32(Session["CURENT_USER_ID"]), conStr);
            response r = pr.GetPlatiFromExcel("Sheet1", newFName);
            bool societateDiferita = false;
            foreach (object[] o in (object[])r.Result)
            {
                if (((PlataExtended)o[1]).Dosar.ID_SOCIETATE_CASCO != Convert.ToInt32(Session["ID_SOCIETATE"])) // se incearca incarcarea pt. alta societate decat cea a utilizatorului curent
                {
                    societateDiferita = true;
                    break;
                }
            }
            if (societateDiferita)
            {
                response toReturn = new response(false, String.Format("Nu puteti incarca plati pentru alta societate decat cea curenta ({0})!", ((SocietateAsigurare)Session["SOCIETATE_ASIGURARE"]).DENUMIRE), null, null, null);
                return Json(toReturn, JsonRequestBehavior.AllowGet);
            }
            r = pr.ImportPlatiDirect("Sheet1", newFName, 0); // 0 = import manual
            JsonResult result = Json(r, JsonRequestBehavior.AllowGet);
            result.MaxJsonLength = Int32.MaxValue;
            return result;
        }

        [AuthorizeUser(ActionName = "Import", Recursive = false)]
        [AuthorizeUser(ActionName = "Plati", Recursive = false)]
        [HttpPost]
        public JsonResult GetPlatiFromLog(DateTime? ImportDate)
        {
            string conStr = Session["conStr"].ToString(); //ConfigurationManager.ConnectionStrings["MySQLConnectionString"].ConnectionString;
            PlatiRepository pr = new PlatiRepository(Convert.ToInt32(Session["CURENT_USER_ID"]), conStr);
            response r = pr.GetPlatiFromLog(ImportDate);
            JsonResult result = Json(r, JsonRequestBehavior.AllowGet);
            result.MaxJsonLength = Int32.MaxValue;
            return result;
        }

        //[AuthorizeUser(ActionName = "Plati", Recursive = false)]
        public ActionResult Index()
        {
            return PartialView("PlatiView", new PlataView());
        }

        //[AuthorizeUser(ActionName = "Plati", Recursive = false)]
        public JsonResult Details(int id) // id dosar
        {
            string conStr = Session["conStr"].ToString(); //ConfigurationManager.ConnectionStrings["MySQLConnectionString"].ConnectionString;
            PlataView pv = new PlataView(Convert.ToInt32(Session["CURENT_USER_ID"]), id, conStr);
            JsonResult result = Json(Newtonsoft.Json.JsonConvert.SerializeObject(pv, Newtonsoft.Json.Formatting.None, new Newtonsoft.Json.Converters.IsoDateTimeConverter() { DateTimeFormat = SOCISA.CommonFunctions.DATE_FORMAT }), JsonRequestBehavior.AllowGet);
            result.MaxJsonLength = Int32.MaxValue;
            return result;
        }

        [AuthorizeUser(ActionName = "Plati", Recursive = false)]
        [HttpPost]
        public JsonResult Edit(Plata Plata)
        {
            response toReturn = new response(true, "", null, null, new List<Error>());

            string conStr = Session["conStr"].ToString(); //ConfigurationManager.ConnectionStrings["MySQLConnectionString"].ConnectionString;
            int _CURENT_USER_ID = Convert.ToInt32(Session["CURENT_USER_ID"]);

            if (Plata.ID == null) // insert
            {
                Plata p = new Plata(_CURENT_USER_ID, conStr);
                PropertyInfo[] pis = Plata.GetType().GetProperties();
                foreach (PropertyInfo pi in pis)
                {
                    pi.SetValue(p, pi.GetValue(Plata));
                }
                toReturn = p.Insert();
            }
            else //
            {
                Plata p = new Plata(_CURENT_USER_ID, conStr, Convert.ToInt32(Plata.ID));
                string s = JsonConvert.SerializeObject(Plata, Formatting.None, new Newtonsoft.Json.Converters.IsoDateTimeConverter() { DateTimeFormat = CommonFunctions.DATE_FORMAT });
                toReturn = p.Update(s);
            }
            return Json(toReturn, JsonRequestBehavior.AllowGet);
        }

        [AuthorizeUser(ActionName = "Plati", Recursive = false)]
        [HttpPost]
        public JsonResult Delete(int id)
        {
            response r = new response();
            string conStr = Session["conStr"].ToString(); //ConfigurationManager.ConnectionStrings["MySQLConnectionString"].ConnectionString;
            int _CURENT_USER_ID = Convert.ToInt32(Session["CURENT_USER_ID"]);
            //DosareRepository dr = new DosareRepository(_CURENT_USER_ID, conStr);
            Plata p = new Plata(_CURENT_USER_ID, conStr, id);
            r = p.Delete();
            return Json(r, JsonRequestBehavior.AllowGet);
        }

        [AuthorizeUser(ActionName = "Plati", Recursive = false)]
        [HttpPost]
        public JsonResult MovePendingToOk(PlataExtended plata)
        {
            string conStr = Session["conStr"].ToString(); //ConfigurationManager.ConnectionStrings["MySQLConnectionString"].ConnectionString;
            int _CURENT_USER_ID = Convert.ToInt32(Session["CURENT_USER_ID"]);
            Plata p = new Plata(_CURENT_USER_ID, conStr);
            PropertyInfo[] pis = plata.Plata.GetType().GetProperties();
            foreach (PropertyInfo pi in pis)
            {
                pi.SetValue(p, pi.GetValue(plata.Plata)); // ca sa avem un obiect si cu credentiale
            }

            response toReturn = p.UpdateWithErrors();
            if (!toReturn.Status)
                return Json(toReturn, JsonRequestBehavior.AllowGet);
            toReturn = p.Validare();
            if (!toReturn.Status)
                return Json(toReturn, JsonRequestBehavior.AllowGet);
            PlatiRepository pr = new PlatiRepository(_CURENT_USER_ID, conStr);
            toReturn = pr.MovePendingToOk(Convert.ToInt32(p.ID));
            return Json(toReturn, JsonRequestBehavior.AllowGet);
        }
    }
}