using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Configuration;
using SOCISA;
using SOCISA.Models;
using Newtonsoft.Json;
using System.Reflection;

namespace socisaWeb.Controllers
{
    //[DefaultAuthorize]
    [Authorize]
    public class DocumenteScanateProceseController : Controller
    {
        //[AuthorizeUser(ActionName = "Dosare", Recursive = false)]
        //[AuthorizeToken]
        public ActionResult Index()
        {
            return PartialView();
        }

        //[AuthorizeUser(ActionName = "Dosare", Recursive = false)]
        //[AuthorizeToken]
        public ActionResult Search()
        {
            string conStr = Session["conStr"].ToString(); //ConfigurationManager.ConnectionStrings["MySQLConnectionString"].ConnectionString;
            return PartialView("_DocumenteScanateProcese", new DocumentScanatProcesView(Convert.ToInt32(Session["CURENT_USER_ID"]), conStr));
        }

        //[AuthorizeUser(ActionName = "Procese", Recursive = false)]
        //[AuthorizeToken]
        public ActionResult Details(string id) // id_proces
        {
            string conStr = Session["conStr"].ToString(); //ConfigurationManager.ConnectionStrings["MySQLConnectionString"].ConnectionString;
            int uid = Convert.ToInt32(Session["CURENT_USER_ID"]);
            DocumentScanatProcesView dspv = new DocumentScanatProcesView(uid, conStr);
            try
            {
                dspv = !String.IsNullOrWhiteSpace(id) ? new DocumentScanatProcesView(uid, conStr, Convert.ToInt32(id)) : new DocumentScanatProcesView(uid, conStr);
            }catch(Exception exp) { LogWriter.Log(exp); }
            return PartialView("_DocumenteScanateProcese", dspv);
        }

        //[AuthorizeUser(ActionName = "Dosare", Recursive = false)]
        //[AuthorizeToken]
        public JsonResult Detail(int id)
        {
            string conStr = Session["conStr"].ToString(); //ConfigurationManager.ConnectionStrings["MySQLConnectionString"].ConnectionString;
            DocumenteScanateProceseRepository dsr = new DocumenteScanateProceseRepository(Convert.ToInt32(Session["CURENT_USER_ID"]), conStr);
            response r = dsr.Find(id);

            //return Json(r, JsonRequestBehavior.AllowGet);
            JsonResult result = Json(r, JsonRequestBehavior.AllowGet);
            result.MaxJsonLength = Int32.MaxValue;
            return result;
        }

        [AuthorizeUser(ActionName = "Procese", Recursive = false)]
        [HttpPost]
        public JsonResult Edit(DocumentScanatProces CurDocumentScanatProces)
        {
            response r = new response();
            string conStr = Session["conStr"].ToString(); //ConfigurationManager.ConnectionStrings["MySQLConnectionString"].ConnectionString;
            if (CurDocumentScanatProces.ID == null) // insert
            {
                DocumentScanatProces d = new DocumentScanatProces(Convert.ToInt32(Session["CURENT_USER_ID"]), conStr);
                PropertyInfo[] pis = CurDocumentScanatProces.GetType().GetProperties();
                foreach(PropertyInfo pi in pis)
                {
                    pi.SetValue(d, pi.GetValue(CurDocumentScanatProces));
                }
                r = d.Insert();
                //return Json(r, JsonRequestBehavior.AllowGet);
                JsonResult result = Json(r, JsonRequestBehavior.AllowGet);
                result.MaxJsonLength = Int32.MaxValue;
                return result;
            }
            else // edit
            {
                DocumenteScanateProceseRepository dsr = new DocumenteScanateProceseRepository(Convert.ToInt32(Session["CURENT_USER_ID"]), conStr);
                DocumentScanatProces d = (DocumentScanatProces)dsr.Find(Convert.ToInt32(CurDocumentScanatProces.ID)).Result;
                //string s = JsonConvert.SerializeObject(CurDocumentScanat, Formatting.None, new Newtonsoft.Json.Converters.IsoDateTimeConverter() { DateTimeFormat = "dd.MM.yyyy" });
                string s = CommonFunctions.GenerateJsonFromModifiedFields(d, CurDocumentScanatProces);
                r = d.Update(s);
                //return Json(r, JsonRequestBehavior.AllowGet);
                JsonResult result = Json(r, JsonRequestBehavior.AllowGet);
                result.MaxJsonLength = Int32.MaxValue;
                return result;
            }
        }

        [AuthorizeUser(ActionName = "Procese", Recursive = false)]
        [HttpPost]
        public JsonResult PostFile(string tip_document, int id_proces_stadiu)
        {
            HttpPostedFileBase f = Request.Files[0];
            string initFName = f.FileName;
            string extension = f.FileName.Substring(f.FileName.LastIndexOf('.'));
            string newFName = Guid.NewGuid() + extension;
            Request.Files[0].SaveAs(System.IO.Path.Combine(CommonFunctions.GetScansFolder(), newFName));
            //string toReturn = "{\"DENUMIRE_FISIER\":\"" + initFName + "\",\"EXTENSIE_FISIER\":\"" + extension + "\",\"CALE_FISIER\":\"" + newFName + "\"}";
            string conStr = Session["conStr"].ToString(); //ConfigurationManager.ConnectionStrings["MySQLConnectionString"].ConnectionString;
            DocumentScanatProces ds = new DocumentScanatProces(Convert.ToInt32(Session["CURENT_USER_ID"]), conStr);
            ds.ID_PROCES_STADIU = id_proces_stadiu;
            ds.TIP_DOCUMENT = tip_document;
            ds.CALE_FISIER = newFName;
            ds.DENUMIRE_FISIER = initFName;
            ds.EXTENSIE_FISIER = extension;
            response r = ds.Insert();
            JsonResult result = Json(r, JsonRequestBehavior.AllowGet);
            result.MaxJsonLength = Int32.MaxValue;
            return result;
        }

        [AuthorizeUser(ActionName = "Procese", Recursive = false)]
        [HttpPost]
        public JsonResult Delete(int id)
        {
            string conStr = Session["conStr"].ToString(); //ConfigurationManager.ConnectionStrings["MySQLConnectionString"].ConnectionString;
            DocumenteScanateProceseRepository dsr = new DocumenteScanateProceseRepository(Convert.ToInt32(Session["CURENT_USER_ID"]), conStr);
            DocumentScanatProces d = (DocumentScanatProces)dsr.Find(id).Result;
            response r = d.Delete();
            return Json(r, JsonRequestBehavior.AllowGet);
        }

        [AuthorizeUser(ActionName = "Procese", Recursive = false)]
        [HttpPost]
        public JsonResult RegenerareFisierDinDb(int id)
        {
            string conStr = Session["conStr"].ToString(); //ConfigurationManager.ConnectionStrings["MySQLConnectionString"].ConnectionString;
            DocumentScanatProces ds = new DocumentScanatProces(Convert.ToInt32(Session["CURENT_USER_ID"]), conStr, id);
            response r = FileManager.RestoreFileFromDb(ds);
            return Json(r, JsonRequestBehavior.AllowGet);
        }

        protected override JsonResult Json(object data, string contentType, System.Text.Encoding contentEncoding, JsonRequestBehavior behavior)
        {
            return new JsonResult()
            {
                Data = data,
                ContentType = contentType,
                ContentEncoding = contentEncoding,
                JsonRequestBehavior = behavior,
                MaxJsonLength = Int32.MaxValue
            };
        }
    }
}