using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using SOCISA;
using SOCISA.Models;
using System.Configuration;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System.Reflection;
using System.Globalization;
using OfficeOpenXml;
using System.Data;
using System.IO;

namespace socisaWeb.Controllers
{
    //[DefaultAuthorize]
    [Authorize]
    public class DosareController : Controller
    {
        [AuthorizeUser(ActionName = "Import", Recursive = false)]
        [AuthorizeUser(ActionName = "Dosare", Recursive = false)]
        public ActionResult Import()
        {
            string conStr = Session["conStr"].ToString(); //ConfigurationManager.ConnectionStrings["MySQLConnectionString"].ConnectionString;
            return PartialView("DosareImport", new ImportDosarView(Convert.ToInt32(Session["CURENT_USER_ID"]), conStr));
        }

        [AuthorizeUser(ActionName = "Import", Recursive = false)]
        [AuthorizeUser(ActionName = "Dosare", Recursive = false)]
        [HttpPost]
        public JsonResult PostExcelFile()
        {
            string conStr = Session["conStr"].ToString(); //ConfigurationManager.ConnectionStrings["MySQLConnectionString"].ConnectionString;
            string sheet = "Sheet1";
            try
            {
                sheet = Request.Form[0].ToString();
            }catch(Exception exp)
            {
                LogWriter.Log(exp);
            }
            HttpPostedFileBase f = Request.Files[0];
            string initFName = f.FileName;
            string extension = f.FileName.Substring(f.FileName.LastIndexOf('.'));
            string newFName = Guid.NewGuid() + extension;
            Request.Files[0].SaveAs(System.IO.Path.Combine(CommonFunctions.GetImportsFolder(), newFName));
            DosareRepository dr = new DosareRepository(Convert.ToInt32(Session["CURENT_USER_ID"]), conStr);
            //response r = dr.GetDosareFromExcel("Sheet1", newFName);
            response r = dr.GetDosareFromExcel(sheet, newFName);
            if (!r.Status)
            {
                return Json(r, JsonRequestBehavior.AllowGet);
            }
            bool societateDiferita = false;
            foreach(object[] o in (object[])r.Result)
            {
                if( ((DosarExtended)o[1]).SocietateCasco.DENUMIRE_SCURTA != ((SocietateAsigurare)Session["SOCIETATE_ASIGURARE"]).DENUMIRE_SCURTA) // se incearca incarcarea pt. alta societate decat cea a utilizatorului curent
                {
                    societateDiferita = true;
                    break;
                }
            }
            if (societateDiferita)
            {
                response toReturn = new response(false, String.Format("Nu puteti incarca dosare pentru alta societate decat cea curenta ({0})!", ((SocietateAsigurare)Session["SOCIETATE_ASIGURARE"]).DENUMIRE), null, null, null);
                return Json(toReturn, JsonRequestBehavior.AllowGet);
            }
            //r = dr.ImportDosareDirect("Sheet1", newFName, 0); // 0 = import manual
            r = dr.ImportDosareDirect(sheet, newFName, 0);
            JsonResult result = Json(r, JsonRequestBehavior.AllowGet);
            result.MaxJsonLength = Int32.MaxValue;
            return result;
        }

        [AuthorizeUser(ActionName = "Import", Recursive = false)]
        [AuthorizeUser(ActionName = "Dosare", Recursive = false)]
        [HttpPost]
        public JsonResult GetDosareFromLog(DateTime? ImportDate)
        {
            string conStr = Session["conStr"].ToString(); //ConfigurationManager.ConnectionStrings["MySQLConnectionString"].ConnectionString;
            DosareRepository dr = new DosareRepository(Convert.ToInt32(Session["CURENT_USER_ID"]), conStr);
            response r = dr.GetDosareFromLog(ImportDate);
            JsonResult result = Json(r, JsonRequestBehavior.AllowGet);
            result.MaxJsonLength = Int32.MaxValue;
            return result;
        }

        [AuthorizeUser(ActionName = "Import", Recursive = false)]
        [AuthorizeUser(ActionName = "Dosare", Recursive = false)]
        [HttpPost]
        public JsonResult Import(ImportDosarView ImportDosarView)
        {
            return Json("", JsonRequestBehavior.AllowGet);
        }

        //[AuthorizeUser(ActionName = "Dosare", Recursive = false)]
        //[AuthorizeToken]
        public ActionResult Index(string id)
        {
            TempData["_view"] = "dosare";
            return PartialView();
        }

        //[AuthorizeUser(ActionName = "Dosare", Recursive = false)]
        //[AuthorizeToken]
        public ActionResult Empty()
        {
            string conStr = Session["conStr"].ToString(); //ConfigurationManager.ConnectionStrings["MySQLConnectionString"].ConnectionString;
            return PartialView("_DosareNavigator", new DosarView(Convert.ToInt32(Session["CURENT_USER_ID"]), conStr));
        }

        [AuthorizeUser(ActionName = "Dosare", Recursive = false)]
        //[AuthorizeToken]
        [HttpPost]
        public ActionResult IndexPost(string _params)
        {
            TempData["_params"] = _params;
            return PartialView("Index");
        }
        /*
        [AuthorizeUser(ActionName = "Dosare", Recursive = false)]
        //[AuthorizeToken]
        [HttpPost]
        public ActionResult SearchFiltered(string _params)
        {
            try
            {
                JObject jObj = (JObject)JsonConvert.DeserializeObject(_params);
                string filterName = jObj["filterName"].ToString();
                string filterKey = jObj["filterKey"].ToString();
                object[] args = JsonConvert.DeserializeObject<object[]>(jObj["args"].ToString());
                _params = PredefinedFilters.CreateFilter(filterName, filterKey, args);
            string conStr = Session["conStr"].ToString(); //ConfigurationManager.ConnectionStrings["MySQLConnectionString"].ConnectionString;
            return PartialView("_DosareNavigator", new DosarView(Convert.ToInt32(Session["CURENT_USER_ID"]), Convert.ToInt32(Session["ID_SOCIETATE"]), conStr, _params));
            }
            catch {
                return PartialView();
            }
        }
        */

        //[AuthorizeUser(ActionName = "Dosare", Recursive = false)]
        //[AuthorizeToken]
        [HttpGet]
        public ActionResult Show(int id)
        {
            string conStr = Session["conStr"].ToString(); //ConfigurationManager.ConnectionStrings["MySQLConnectionString"].ConnectionString;
            Dosar d = new Dosar(Convert.ToInt32(Session["CURENT_USER_ID"]), conStr, id);
            // verificam daca are drept pe dosar 
            bool? hasWright = (bool?)d.UserHasWright(Convert.ToInt32(Session["CURENT_USER_ID"])).Result;
            if (hasWright == null || !(bool)hasWright)
            {
                HttpContext.Response.Redirect("~");
                return null;
            }
            return PartialView("_DosareNavigator", new DosarView(Convert.ToInt32(Session["CURENT_USER_ID"]), Convert.ToInt32(Session["ID_SOCIETATE"]), d, conStr));
        }

        //[AuthorizeToken]
        [HttpGet]
        public ActionResult EShow(string token)
        {
            string conStr = Session["conStr"].ToString(); //ConfigurationManager.ConnectionStrings["MySQLConnectionString"].ConnectionString;
            //string conStr = Server.MapPath("~").ToLower().IndexOf("test") > 0 ? CommonFunctions.StringCipher.Decrypt(System.Configuration.ConfigurationManager.ConnectionStrings["MySQLConnectionString_test"].ConnectionString, CommonFunctions.StringCipher.RetrieveKey()) : CommonFunctions.StringCipher.Decrypt(System.Configuration.ConfigurationManager.ConnectionStrings["MySQLConnectionString"].ConnectionString, CommonFunctions.StringCipher.RetrieveKey()); // separam socisa de socisa_test

            string[] t = token.Split(new string[] { "|" }, StringSplitOptions.RemoveEmptyEntries);
            Dosar d = new Dosar(Convert.ToInt32(Session["CURENT_USER_ID"]), conStr, Convert.ToInt32(t[1]));
            return PartialView("_DosareNavigator", new DosarView(Convert.ToInt32(Session["CURENT_USER_ID"]), Convert.ToInt32(Session["ID_SOCIETATE"]), d, conStr));
        }

        [HttpPost]
        public JsonResult GetCounter(string operation, int id_dosar)
        {
            string conStr = Session["conStr"].ToString(); //ConfigurationManager.ConnectionStrings["MySQLConnectionString"].ConnectionString;
            int uid = Convert.ToInt32(Session["CURENT_USER_ID"]);
            ClickCount cc = new ClickCount(uid, conStr, operation, id_dosar);
            if(cc == null || cc.ID == null)
            {
                cc = new ClickCount(uid, conStr);
                cc.OPERATION = operation;
                cc.ID_DOSAR = id_dosar;
                cc.COUNTER = 0;
                cc.Insert();
                return Json(0, JsonRequestBehavior.AllowGet);
            }
            else
            {
                return Json(cc.COUNTER, JsonRequestBehavior.AllowGet);
            }
        }

        [HttpPost]
        public JsonResult SetCounter(string operation, int id_dosar)
        {
            try
            {
                string conStr = Session["conStr"].ToString(); //ConfigurationManager.ConnectionStrings["MySQLConnectionString"].ConnectionString;
                int uid = Convert.ToInt32(Session["CURENT_USER_ID"]);
                ClickCount cc = new ClickCount(uid, conStr, operation, id_dosar);
                if (cc == null || cc.ID == null)
                {
                    cc = new ClickCount(uid, conStr);
                    cc.OPERATION = operation;
                    cc.ID_DOSAR = id_dosar;
                    cc.COUNTER = 1;
                    cc.Insert();
                }
                else
                {
                    cc.COUNTER += 1;
                    cc.Update();
                }
                return Json(cc.COUNTER, JsonRequestBehavior.AllowGet);
            }
            catch (Exception exp)
            {
                LogWriter.Log(exp);
                return Json(0, JsonRequestBehavior.AllowGet);
            }
        }

        //[AuthorizeUser(ActionName = "Dosare", Recursive = false)]
        //[AuthorizeToken]
        [HttpPost]
        public ActionResult SearchFiltered()
        {
            try
            {
                string _params = TempData["_params"].ToString();
                JObject jObj = (JObject)JsonConvert.DeserializeObject(_params);
                string filterName = jObj["filterName"].ToString();
                string filterKey = jObj["filterKey"].ToString();
                object[] args = JsonConvert.DeserializeObject<object[]>(jObj["args"].ToString());
                _params = PredefinedFilters.CreateFilter(filterName, filterKey, args);
                string conStr = Session["conStr"].ToString(); //ConfigurationManager.ConnectionStrings["MySQLConnectionString"].ConnectionString;
                return PartialView("_DosareNavigator", new DosarView(Convert.ToInt32(Session["CURENT_USER_ID"]), Convert.ToInt32(Session["ID_SOCIETATE"]), conStr, _params));
            }
            catch
            {
                return PartialView();
            }
        }

        //[AuthorizeUser(ActionName = "Dosare", Recursive = false)]
        //[AuthorizeToken]
        public ActionResult Search()
        {
            if (TempData["_params"] == null)
            {
                string conStr = Session["conStr"].ToString(); //ConfigurationManager.ConnectionStrings["MySQLConnectionString"].ConnectionString;
                return PartialView("_DosareNavigator", new DosarView(Convert.ToInt32(Session["CURENT_USER_ID"]), Convert.ToInt32(Session["ID_SOCIETATE"]), conStr));
            }
            else
            {
                try
                {
                    string _params = TempData["_params"].ToString();
                    JObject jObj = (JObject)JsonConvert.DeserializeObject(_params);
                    string filterName = jObj["filterName"].ToString();
                    string filterKey = jObj["filterKey"].ToString();
                    object[] args = JsonConvert.DeserializeObject<object[]>(jObj["args"].ToString());
                    _params = PredefinedFilters.CreateFilter(filterName, filterKey, args);
                    string conStr = Session["conStr"].ToString(); //ConfigurationManager.ConnectionStrings["MySQLConnectionString"].ConnectionString;
                    return PartialView("_DosareNavigator", new DosarView(Convert.ToInt32(Session["CURENT_USER_ID"]), Convert.ToInt32(Session["ID_SOCIETATE"]), conStr, _params));
                }
                catch
                {
                    return PartialView();
                }

            }
        }

        /*
        //[AuthorizeUser(ActionName = "Dosare", Recursive = false)]
        //[AuthorizeToken]
        [HttpPost]
        public JsonResult Search(Dosar Dosar, DosarJson dosarJson)
        {
            //string jsonFilter = JsonConvert.SerializeObject(DosarView);
            JToken dosar = (JToken)JsonConvert.DeserializeObject(Request.Form[0]);
            JToken dosar_json = (JToken)JsonConvert.DeserializeObject(Request.Form[1]);
            response r = GetFiltered(dosar, dosar_json);
            return Json(r, JsonRequestBehavior.AllowGet);
        }
        */

        
        //[AuthorizeUser(ActionName = "Dosare", Recursive = false)]
        //[AuthorizeToken]
        [HttpPost]
        public JsonResult Search(DosarView DosarView)
        {
            //string jsonFilter = JsonConvert.SerializeObject(DosarView);
            JObject f = (JObject)JsonConvert.DeserializeObject(Request.Form[0]);
            response r = GetFiltered(f);
            return Json(r, JsonRequestBehavior.AllowGet);
        }
        

        private response GetFiltered(JObject f)
        {
            JToken jDosar = f["Dosar"];
            JToken jdosarJson = f["dosarJson"];
            return GetFiltered(jDosar, jdosarJson);
        }

        private response GetFiltered(JToken jDosar, JToken jdosarJson)
        {
            string conStr = Session["conStr"].ToString(); //ConfigurationManager.ConnectionStrings["MySQLConnectionString"].ConnectionString;
            int _CURENT_USER_ID = Convert.ToInt32(Session["CURENT_USER_ID"]);
            DosareRepository dr = new DosareRepository(_CURENT_USER_ID, conStr);

            string limit = null;

            if (jdosarJson != null)
            {
                if (jDosar == null) jDosar = JToken.FromObject(new Dosar());

                if (jdosarJson["DataEvenimentStart"] != null && !String.IsNullOrEmpty(jdosarJson["DataEvenimentStart"].ToString()) && jdosarJson["DataEvenimentEnd"] != null && !String.IsNullOrEmpty(jdosarJson["DataEvenimentEnd"].ToString()))
                {
                    jDosar["DATA_EVENIMENT"] = CommonFunctions.ToMySqlFormatDate(DateTime.ParseExact(jdosarJson["DataEvenimentStart"].ToString(), CommonFunctions.DATE_FORMAT, CultureInfo.InvariantCulture)) + "?" + CommonFunctions.ToMySqlFormatDate(DateTime.ParseExact(jdosarJson["DataEvenimentEnd"].ToString(), CommonFunctions.DATE_FORMAT, CultureInfo.InvariantCulture));
                }
                if (jdosarJson["DataScaStart"] != null && !String.IsNullOrEmpty(jdosarJson["DataScaStart"].ToString()) && jdosarJson["DataScaEnd"] != null && !String.IsNullOrEmpty(jdosarJson["DataScaEnd"].ToString()))
                {
                    jDosar["DATA_SCA"] = CommonFunctions.ToMySqlFormatDate(DateTime.ParseExact(jdosarJson["DataScaStart"].ToString(), CommonFunctions.DATE_FORMAT, CultureInfo.InvariantCulture)) + "?" + CommonFunctions.ToMySqlFormatDate(DateTime.ParseExact(jdosarJson["DataScaEnd"].ToString(), CommonFunctions.DATE_FORMAT, CultureInfo.InvariantCulture));
                }
                if (jdosarJson["DataAvizareStart"] != null && !String.IsNullOrEmpty(jdosarJson["DataAvizareStart"].ToString()) && jdosarJson["DataAvizareEnd"] != null && !String.IsNullOrEmpty(jdosarJson["DataAvizareEnd"].ToString()))
                {
                    jDosar["DATA_AVIZARE"] = CommonFunctions.ToMySqlFormatDate(DateTime.ParseExact(jdosarJson["DataAvizareStart"].ToString(), CommonFunctions.DATE_FORMAT, CultureInfo.InvariantCulture)) + "?" + CommonFunctions.ToMySqlFormatDate(DateTime.ParseExact(jdosarJson["DataAvizareEnd"].ToString(), CommonFunctions.DATE_FORMAT, CultureInfo.InvariantCulture));
                }
                if (jdosarJson["DataNotificareStart"] != null && !String.IsNullOrEmpty(jdosarJson["DataNotificareStart"].ToString()) && jdosarJson["DataNotificareEnd"] != null && !String.IsNullOrEmpty(jdosarJson["DataNotificareEnd"].ToString()))
                {
                    jDosar["DATA_NOTIFICARE"] = CommonFunctions.ToMySqlFormatDate(DateTime.ParseExact(jdosarJson["DataNotificareStart"].ToString(), CommonFunctions.DATE_FORMAT, CultureInfo.InvariantCulture)) + "?" + CommonFunctions.ToMySqlFormatDate(DateTime.ParseExact(jdosarJson["DataNotificareEnd"].ToString(), CommonFunctions.DATE_FORMAT, CultureInfo.InvariantCulture));
                }
                if (jdosarJson["DataUltimeiModificariStart"] != null && !String.IsNullOrEmpty(jdosarJson["DataUltimeiModificariStart"].ToString()) && jdosarJson["DataUltimeiModificariEnd"] != null && !String.IsNullOrEmpty(jdosarJson["DataUltimeiModificariEnd"].ToString()))
                {
                    jDosar["DATA_ULTIMEI_MODIFICARI"] = CommonFunctions.ToMySqlFormatDate(DateTime.ParseExact(jdosarJson["DataUltimeiModificariStart"].ToString(), CommonFunctions.DATE_FORMAT, CultureInfo.InvariantCulture)) + "?" + CommonFunctions.ToMySqlFormatDate(DateTime.ParseExact(jdosarJson["DataUltimeiModificariEnd"].ToString(), CommonFunctions.DATE_FORMAT, CultureInfo.InvariantCulture));
                }
                if (jdosarJson["DataCreareStart"] != null && !String.IsNullOrEmpty(jdosarJson["DataCreareStart"].ToString()) && jdosarJson["DataCreareEnd"] != null && !String.IsNullOrEmpty(jdosarJson["DataCreareEnd"].ToString()))
                {
                    jDosar["DATA_CREARE"] = CommonFunctions.ToMySqlFormatDate(DateTime.ParseExact(jdosarJson["DataCreareStart"].ToString(), CommonFunctions.DATE_FORMAT, CultureInfo.InvariantCulture)) + "?" + CommonFunctions.ToMySqlFormatDate(DateTime.ParseExact(jdosarJson["DataCreareEnd"].ToString(), CommonFunctions.DATE_FORMAT, CultureInfo.InvariantCulture));
                }
                if (jdosarJson["DataIesireCascoStart"] != null && !String.IsNullOrEmpty(jdosarJson["DataIesireCascoStart"].ToString()) && jdosarJson["DataIesireCascoEnd"] != null && !String.IsNullOrEmpty(jdosarJson["DataIesireCascoEnd"].ToString()))
                {
                    jDosar["DATA_IESIRE_CASCO"] = CommonFunctions.ToMySqlFormatDate(DateTime.ParseExact(jdosarJson["DataIesireCascoStart"].ToString(), CommonFunctions.DATE_FORMAT, CultureInfo.InvariantCulture)) + "?" + CommonFunctions.ToMySqlFormatDate(DateTime.ParseExact(jdosarJson["DataIesireCascoEnd"].ToString(), CommonFunctions.DATE_FORMAT, CultureInfo.InvariantCulture));
                }
                if (jdosarJson["DataIntrareRcaStart"] != null && !String.IsNullOrEmpty(jdosarJson["DataIntrareRcaStart"].ToString()) && jdosarJson["DataIntrareRcaEnd"] != null && !String.IsNullOrEmpty(jdosarJson["DataIntrareRcaEnd"].ToString()))
                {
                    jDosar["DATA_INTRARE_RCA"] = CommonFunctions.ToMySqlFormatDate(DateTime.ParseExact(jdosarJson["DataIntrareRcaStart"].ToString(), CommonFunctions.DATE_FORMAT, CultureInfo.InvariantCulture)) + "?" + CommonFunctions.ToMySqlFormatDate(DateTime.ParseExact(jdosarJson["DataIntrareRcaEnd"].ToString(), CommonFunctions.DATE_FORMAT, CultureInfo.InvariantCulture));
                }
                if (jdosarJson["LimitStart"] != null && !String.IsNullOrEmpty(jdosarJson["LimitStart"].ToString()) && jdosarJson["LimitEnd"] != null && !String.IsNullOrEmpty(jdosarJson["LimitEnd"].ToString()))
                {
                    limit = String.Format(" LIMIT {0},{1} ", jdosarJson["LimitStart"].ToString(), jdosarJson["LimitEnd"].ToString());
                }
                if (jdosarJson["CalitateSocietate"] != null && !String.IsNullOrEmpty(jdosarJson["CalitateSocietate"].ToString()))
                {
                    if (jdosarJson["CalitateSocietate"].ToString() == "RCA")
                        jdosarJson["CalitateSocietate"] = "AVIZAT,NECAHITAT,ACHITAT_PARTIAL,ACHITAT";
                }
            }
            //response r = dr.GetFiltered(null, null, String.Format("{'jDosar':{0},'jdosarJson':{1}}", JsonConvert.SerializeObject(jDosar), JsonConvert.SerializeObject(jdosarJson)), null);
            string jsonParam = "{\"jObject\":" + JsonConvert.SerializeObject(jDosar) + ",\"jobjectJson\":" + JsonConvert.SerializeObject(jdosarJson) + "}";
            response r = dr.GetFiltered(null, null, jsonParam, limit);
            r.InsertedId = Convert.ToInt32(dr.CountFiltered(null, null, jsonParam, null).Result); // folosim campul InsertedId pt. counter
            return r;
        }

        //[AuthorizeUser(ActionName = "Dosare", Recursive = false)]
        //[AuthorizeToken]
        public JsonResult Details(string id)
        {
            try
            {
                string conStr = Session["conStr"].ToString(); //ConfigurationManager.ConnectionStrings["MySQLConnectionString"].ConnectionString;
                DosareRepository dr = new DosareRepository(Convert.ToInt32(Session["CURENT_USER_ID"]), conStr);
                Dosar d = (Dosar)dr.Find(Convert.ToInt32(id)).Result;
                Asigurat aCasco = (Asigurat)d.GetAsiguratCasco().Result;
                Asigurat aRca = (Asigurat)d.GetAsiguratRca().Result;
                Auto autoCasco = (Auto)d.GetAutoCasco().Result;
                Auto autoRca = (Auto)d.GetAutoRca().Result;
                Intervenient i = (Intervenient)d.GetIntervenient().Result;
                Nomenclator tipDosar = (Nomenclator)d.GetTipDosar().Result;
                bool validForAvizare = d.ValidareAvizare().Status;
                bool IsAvizat = d.IsAvizat();
                /*
                int nrDocumente = Convert.ToInt32(d.GetDocumenteCount().Result);
                int nrProcese = Convert.ToInt32(d.GetProceseCount().Result);
                int nrPlati = Convert.ToInt32(d.GetPlatiCount().Result);
                bool dosarFaraDocumente = nrDocumente > 0 ? false : true;
                bool dosarFaraProces = nrProcese > 0 ? false : true;
                string toReturn = "{\"aCasco\":" + JsonConvert.SerializeObject(aCasco) + ",\"aRca\":" + JsonConvert.SerializeObject(aRca) + ",\"autoCasco\":" + JsonConvert.SerializeObject(autoCasco) + ",\"autoRca\":" + JsonConvert.SerializeObject(autoRca) + ",\"intervenient\":" + JsonConvert.SerializeObject(i) + ",\"tipDosar\":" + JsonConvert.SerializeObject(tipDosar) + ",\"validForAvizare\":" + validForAvizare.ToString().ToLower() + ",\"IsAvizat\":" + IsAvizat.ToString().ToLower() + ",\"NewStatus\":\"" + d.STATUS + "\",\"nrDocumente\":" + nrDocumente.ToString() + ",\"nrProcese\":" + nrProcese.ToString() + ",\"nrPlati\":" + nrPlati.ToString() + ",\"dosarFaraDocumente\":\"" + dosarFaraDocumente.ToString().ToLower() + "\",\"dosarFaraProces\":\"" + dosarFaraProces.ToString().ToLower() + "\"}";
                */
                bool dosarFaraDocumente = d.COUNT_DOCUMENTE > 0 ? false : true;
                bool dosarFaraProces = d.COUNT_PROCESE > 0 ? false : true;
                string toReturn = "{\"aCasco\":" + JsonConvert.SerializeObject(aCasco) + ",\"aRca\":" + JsonConvert.SerializeObject(aRca) + ",\"autoCasco\":" + JsonConvert.SerializeObject(autoCasco) + ",\"autoRca\":" + JsonConvert.SerializeObject(autoRca) + ",\"intervenient\":" + JsonConvert.SerializeObject(i) + ",\"tipDosar\":" + JsonConvert.SerializeObject(tipDosar) + ",\"validForAvizare\":" + validForAvizare.ToString().ToLower() + ",\"IsAvizat\":" + IsAvizat.ToString().ToLower() + ",\"NewStatus\":\"" + d.STATUS + "\",\"dosarFaraDocumente\":\"" + dosarFaraDocumente.ToString().ToLower() + "\",\"dosarFaraProces\":\"" + dosarFaraProces.ToString().ToLower() + "\"}";
                object j = JsonConvert.DeserializeObject(toReturn);
                return Json(toReturn, JsonRequestBehavior.AllowGet);
            }catch(Exception exp) { LogWriter.Log(exp); throw exp; }
        }

        [AuthorizeUser(ActionName = "Dosare", Recursive = false)]
        [HttpPost]
        public JsonResult MovePendingToOk(DosarExtended dosar)
        {
            string conStr = Session["conStr"].ToString(); //ConfigurationManager.ConnectionStrings["MySQLConnectionString"].ConnectionString;
            int _CURENT_USER_ID = Convert.ToInt32(Session["CURENT_USER_ID"]);

            Asigurat x = new Asigurat(_CURENT_USER_ID, conStr);
            PropertyInfo[] pis = dosar.AsiguratCasco.GetType().GetProperties();
            foreach (PropertyInfo pi in pis)
            {
                pi.SetValue(x, pi.GetValue(dosar.AsiguratCasco));
            }
            if (x.ID == null)
            {
                response r = x.Insert();
                x.ID = r.InsertedId;
            }else
            {
                x.Update();
            }
            dosar.Dosar.ID_ASIGURAT_CASCO = x.ID;


            x = new Asigurat(_CURENT_USER_ID, conStr);
            pis = dosar.AsiguratRca.GetType().GetProperties();
            foreach (PropertyInfo pi in pis)
            {
                pi.SetValue(x, pi.GetValue(dosar.AsiguratRca));
            }
            if (x.ID == null)
            {
                response r = x.Insert();
                x.ID = r.InsertedId;
            }
            else
            {
                x.Update();
            }
            dosar.Dosar.ID_ASIGURAT_RCA = x.ID;


            Auto y = new Auto(_CURENT_USER_ID, conStr);
            pis = dosar.AutoCasco.GetType().GetProperties();
            foreach (PropertyInfo pi in pis)
            {
                pi.SetValue(y, pi.GetValue(dosar.AutoCasco));
            }
            if (y.ID == null)
            {
                response r = y.Insert();
                y.ID = r.InsertedId;
            }
            else
            {
                y.Update();
            }
            dosar.Dosar.ID_AUTO_CASCO = y.ID;


            y = new Auto(_CURENT_USER_ID, conStr);
            pis = dosar.AutoRca.GetType().GetProperties();
            foreach (PropertyInfo pi in pis)
            {
                pi.SetValue(y, pi.GetValue(dosar.AutoRca));
            }
            if (y.ID == null)
            {
                response r = y.Insert();
                y.ID = r.InsertedId;
            }
            else
            {
                y.Update();
            }
            dosar.Dosar.ID_AUTO_RCA = y.ID;

            SocietateAsigurare z = new SocietateAsigurare(_CURENT_USER_ID, conStr);
            pis = dosar.SocietateCasco.GetType().GetProperties();
            foreach (PropertyInfo pi in pis)
            {
                pi.SetValue(z, pi.GetValue(dosar.SocietateCasco));
            }
            if (z.ID == null)
            {
                response r = z.Insert();
                z.ID = r.InsertedId;
            }
            else
            {
                z.Update();
            }
            dosar.Dosar.ID_SOCIETATE_CASCO = z.ID;


            z = new SocietateAsigurare(_CURENT_USER_ID, conStr);
            pis = dosar.SocietateRca.GetType().GetProperties();
            foreach (PropertyInfo pi in pis)
            {
                pi.SetValue(z, pi.GetValue(dosar.SocietateRca));
            }
            if (z.ID == null)
            {
                response r = z.Insert();
                z.ID = r.InsertedId;
            }
            else
            {
                z.Update();
            }
            dosar.Dosar.ID_SOCIETATE_RCA = z.ID;

            Intervenient i = new Intervenient(_CURENT_USER_ID, conStr);
            pis = dosar.Intervenient.GetType().GetProperties();
            foreach (PropertyInfo pi in pis)
            {
                pi.SetValue(i, pi.GetValue(dosar.Intervenient));
            }
            if (i.ID == null)
            {
                response r = i.Insert();
                i.ID = r.InsertedId;
            }
            else
            {
                i.Update();
            }
            dosar.Dosar.ID_INTERVENIENT = i.ID;

            Nomenclator td = new Nomenclator(_CURENT_USER_ID, conStr, "tip_dosare");
            pis = dosar.TipDosar.GetType().GetProperties();
            foreach (PropertyInfo pi in pis)
            {
                pi.SetValue(td, pi.GetValue(dosar.TipDosar));
            }
            if (td.ID == null)
            {
                response r = td.Insert();
                td.ID = r.InsertedId;
            }
            else
            {
                td.Update();
            }
            dosar.Dosar.ID_TIP_DOSAR = td.ID;

            Nomenclator tc = new Nomenclator(_CURENT_USER_ID, conStr, "tip_caz", dosar.Dosar.CAZ);
            if (tc == null || tc.ID == null)
            {
                tc.DENUMIRE = dosar.Dosar.CAZ;
                response r = tc.Insert();
                tc.ID = r.InsertedId;
            }
            dosar.Dosar.CAZ = tc.DENUMIRE;

            Dosar d = new Dosar(_CURENT_USER_ID, conStr);
            pis = dosar.Dosar.GetType().GetProperties();
            foreach (PropertyInfo pi in pis)
            {
                pi.SetValue(d, pi.GetValue(dosar.Dosar));
            }

            response toReturn = d.UpdateWithErrors();
            if (!toReturn.Status)
                return Json(toReturn, JsonRequestBehavior.AllowGet);
            toReturn = d.Validare();
            if (!toReturn.Status)
                return Json(toReturn, JsonRequestBehavior.AllowGet);
            DosareRepository dr = new DosareRepository(_CURENT_USER_ID, conStr);
            toReturn = dr.MovePendingToOk(Convert.ToInt32(d.ID));
            return Json(toReturn, JsonRequestBehavior.AllowGet);
        }

        [AuthorizeUser(ActionName = "Dosare", Recursive = false)]
        //[AuthorizeToken]
        [HttpPost]
        public bool ValidareAvizare(int id)
        {
            return Helpers.Helpers.ValidareAvizare(id);
        }

        [AuthorizeUser(ActionName = "Dosare", Recursive = false)]
        //[AuthorizeToken]
        [HttpPost]
        public bool ValidareTiparire(int id)
        {
            return Helpers.Helpers.ValidareTiparire(id);
        }

        [AuthorizeUser(ActionName = "Dosare", Recursive = false)]
        [HttpPost]
        public JsonResult Edit(Dosar Dosar, DosarJson dosarJson)
        {
            response r = new response();
            response toReturn = new response(true, "", null, null, new List<Error>());

            string conStr = Session["conStr"].ToString(); //ConfigurationManager.ConnectionStrings["MySQLConnectionString"].ConnectionString;
            int _CURENT_USER_ID = Convert.ToInt32(Session["CURENT_USER_ID"]);
            DosareRepository dr = new DosareRepository(_CURENT_USER_ID, conStr);
            if (Dosar.ID == null) // insert
            {
                /*
                var prop = DosarView.Dosar.GetType().GetField("authenticatedUserId", System.Reflection.BindingFlags.NonPublic | System.Reflection.BindingFlags.Instance);
                prop.SetValue(DosarView.Dosar, _CURENT_USER_ID);
                prop = DosarView.Dosar.GetType().GetField("connectionString", System.Reflection.BindingFlags.NonPublic | System.Reflection.BindingFlags.Instance);
                prop.SetValue(DosarView.Dosar, conStr);
                */
                Dosar d = new Dosar(_CURENT_USER_ID, conStr);
                PropertyInfo[] pis = Dosar.GetType().GetProperties();
                foreach(PropertyInfo pi in pis)
                {
                    pi.SetValue(d, pi.GetValue(Dosar));
                }

                if (dosarJson != null)
                {
                    if (!String.IsNullOrEmpty(dosarJson.NumeAsiguratCasco)){
                        AsiguratiRepository ar = new AsiguratiRepository(_CURENT_USER_ID, conStr);
                        Asigurat aCasco = (Asigurat)ar.Find(dosarJson.NumeAsiguratCasco).Result;
                        if (aCasco != null && aCasco.ID != null)
                        {
                            d.ID_ASIGURAT_CASCO = aCasco.ID;
                        }
                        else
                        {
                            if (d.ID_ASIGURAT_CASCO != null) // dosarul are asociat deja un asigurat
                            {
                                aCasco = new Asigurat(_CURENT_USER_ID, conStr, Convert.ToInt32(d.ID_ASIGURAT_CASCO));
                                aCasco.DENUMIRE = dosarJson.NumeAsiguratCasco;
                                r = aCasco.Update();
                            }
                            else
                            {
                                aCasco = new Asigurat(_CURENT_USER_ID, conStr);
                                aCasco.DENUMIRE = dosarJson.NumeAsiguratCasco;
                                r = aCasco.Insert();
                                aCasco.ID = r.InsertedId;
                            }
                            if (r.Status) d.ID_ASIGURAT_CASCO = Convert.ToInt32(aCasco.ID);
                            else toReturn.AddResponse(r);
                        }
                    }

                    if (!String.IsNullOrEmpty(dosarJson.NumeAsiguratRca))
                    {
                        AsiguratiRepository ar = new AsiguratiRepository(_CURENT_USER_ID, conStr);
                        Asigurat aRca = (Asigurat)ar.Find(dosarJson.NumeAsiguratRca).Result;
                        if (aRca != null && aRca.ID != null)
                        {
                            d.ID_ASIGURAT_RCA = aRca.ID;
                        }
                        else
                        {
                            if (d.ID_ASIGURAT_RCA != null) // dosarul are asociat deja un asigurat
                            {
                                aRca = new Asigurat(_CURENT_USER_ID, conStr, Convert.ToInt32(d.ID_ASIGURAT_RCA));
                                aRca.DENUMIRE = dosarJson.NumeAsiguratRca;
                                r = aRca.Update();
                            }
                            else
                            {
                                aRca = new Asigurat(_CURENT_USER_ID, conStr);
                                aRca.DENUMIRE = dosarJson.NumeAsiguratRca;
                                r = aRca.Insert();
                                aRca.ID = r.InsertedId;
                            }
                            if (r.Status) d.ID_ASIGURAT_RCA = Convert.ToInt32(aRca.ID);
                            // -- nu e obligatoriu
                            //else toReturn.AddResponse(r);
                        }
                    }

                    if (!String.IsNullOrEmpty(dosarJson.NumarAutoCasco))
                    {
                        AutoRepository ar = new AutoRepository(_CURENT_USER_ID, conStr);
                        Auto autoCasco = (Auto)ar.Find(dosarJson.NumarAutoCasco).Result;
                        if (autoCasco != null && autoCasco.ID != null)
                        {
                            d.ID_AUTO_CASCO = autoCasco.ID;
                        }
                        else
                        {
                            if (d.ID_AUTO_CASCO != null) // dosarul are asociat deja un auto
                            {
                                autoCasco = new Auto(_CURENT_USER_ID, conStr, Convert.ToInt32(d.ID_AUTO_CASCO));
                                autoCasco.NR_AUTO = dosarJson.NumarAutoCasco;
                                r = autoCasco.Update();
                            }
                            else
                            {
                                autoCasco = new Auto(_CURENT_USER_ID, conStr);
                                autoCasco.NR_AUTO = dosarJson.NumarAutoCasco;
                                r = autoCasco.Insert();
                                autoCasco.ID = r.InsertedId;
                            }
                            if (r.Status) d.ID_AUTO_CASCO = Convert.ToInt32(autoCasco.ID);
                            else toReturn.AddResponse(r);
                        }
                    }

                    if (!String.IsNullOrEmpty(dosarJson.NumarAutoRca))
                    {
                        AutoRepository ar = new AutoRepository(_CURENT_USER_ID, conStr);
                        Auto autoRca = (Auto)ar.Find(dosarJson.NumarAutoRca).Result;
                        if (autoRca != null && autoRca.ID != null)
                        {
                            d.ID_AUTO_RCA = autoRca.ID;
                        }
                        else
                        {
                            if (d.ID_AUTO_RCA != null) // dosarul are asociat deja un auto
                            {
                                autoRca = new Auto(_CURENT_USER_ID, conStr, Convert.ToInt32(d.ID_AUTO_RCA));
                                autoRca.NR_AUTO = dosarJson.NumarAutoRca;
                                r = autoRca.Update();
                            }
                            else
                            {
                                autoRca = new Auto(_CURENT_USER_ID, conStr);
                                autoRca.NR_AUTO = dosarJson.NumarAutoRca;
                                r = autoRca.Insert();
                                autoRca.ID = r.InsertedId;
                            }
                            if (r.Status) d.ID_AUTO_RCA = Convert.ToInt32(autoRca.ID);
                            else toReturn.AddResponse(r);
                        }
                    }

                    if (!String.IsNullOrEmpty(dosarJson.NumeIntervenient))
                    {
                        IntervenientiRepository ar = new IntervenientiRepository(_CURENT_USER_ID, conStr);
                        Intervenient i = (Intervenient)ar.Find(dosarJson.NumeIntervenient).Result;
                        if (i != null && i.ID != null)
                        {
                            d.ID_INTERVENIENT = i.ID;
                        }
                        else
                        {
                            if (d.ID_INTERVENIENT != null) // dosarul are asociat deja un intervenient
                            {
                                i = new Intervenient(_CURENT_USER_ID, conStr, Convert.ToInt32(d.ID_INTERVENIENT));
                                i.DENUMIRE = dosarJson.NumeIntervenient;
                                r = i.Update();
                            }
                            else
                            {
                                i = new Intervenient(_CURENT_USER_ID, conStr);
                                i.DENUMIRE = dosarJson.NumeIntervenient;
                                r = i.Insert();
                                i.ID = r.InsertedId;
                            }
                            if (r.Status) d.ID_INTERVENIENT = Convert.ToInt32(i.ID);
                            // -- nu e obligatoriu
                            //else toReturn.AddResponse(r);
                        }
                    }
                    /*
                    if (!String.IsNullOrEmpty(dosarJson.TipDosar))
                    {
                        NomenclatoareRepository ar = new NomenclatoareRepository(_CURENT_USER_ID, conStr);
                        Nomenclator tipDosar = (Nomenclator)ar.Find("tip_dosare", dosarJson.TipDosar).Result;
                        if (tipDosar != null && tipDosar.ID != null)
                        {
                            d.ID_TIP_DOSAR = tipDosar.ID;
                        }
                        else
                        {
                            tipDosar = new Nomenclator(_CURENT_USER_ID, conStr, "tip_dosare");
                            tipDosar.DENUMIRE = dosarJson.TipDosar;
                            r = tipDosar.Insert();
                            if (r.Status) d.ID_TIP_DOSAR = Convert.ToInt32(tipDosar.ID);
                            // -- nu e obligatoriu
                            //else toReturn.AddResponse(r);
                        }
                    }
                    */
                }
                if (!toReturn.Status)
                    return Json(toReturn, JsonRequestBehavior.AllowGet);

                r = d.Insert();
                return Json(r, JsonRequestBehavior.AllowGet);
            }
            else { // update
                Dosar d = (Dosar)dr.Find(Convert.ToInt32(Dosar.ID)).Result;
                Asigurat aCasco = (Asigurat)d.GetAsiguratCasco().Result;
                Asigurat aRca = (Asigurat)d.GetAsiguratRca().Result;
                Auto autoCasco = (Auto)d.GetAutoCasco().Result;
                Auto autoRca = (Auto)d.GetAutoRca().Result;
                Intervenient i = (Intervenient)d.GetIntervenient().Result;
                Nomenclator tipDosar = (Nomenclator)d.GetTipDosar().Result;

                if (dosarJson.NumeAsiguratCasco != aCasco.DENUMIRE)
                {
                    if (!String.IsNullOrWhiteSpace(dosarJson.NumeAsiguratCasco))
                    {
                        if (d.ID_ASIGURAT_CASCO != null) // dosarul are asociat deja un asigurat
                        {
                            aCasco = new Asigurat(_CURENT_USER_ID, conStr, Convert.ToInt32(d.ID_ASIGURAT_CASCO));
                            aCasco.DENUMIRE = dosarJson.NumeAsiguratCasco;
                            r = aCasco.Update();
                        }
                        else
                        {
                            aCasco = new Asigurat(_CURENT_USER_ID, conStr);
                            aCasco.DENUMIRE = dosarJson.NumeAsiguratCasco;
                            r = aCasco.Insert();
                            aCasco.ID = r.InsertedId;
                        }
                        if (r.Status) Dosar.ID_ASIGURAT_CASCO = Convert.ToInt32(aCasco.ID);
                        else toReturn.AddResponse(r);

                        /*
                        //if (aCasco == null || aCasco.ID == null)
                        {
                            Asigurat at = new Asigurat(_CURENT_USER_ID, conStr, dosarJson.NumeAsiguratCasco);
                            if (at.ID == null)
                            {
                                at.DENUMIRE = dosarJson.NumeAsiguratCasco;
                                r = at.Insert();
                                if (r.Status)
                                    at.ID = r.InsertedId;
                                else
                                    toReturn.AddResponse(r);
                            }
                            Dosar.ID_ASIGURAT_CASCO = at.ID;
                        }
                        */
                        /*
                        else
                        {
                            aCasco.DENUMIRE = dosarJson.NumeAsiguratCasco;
                            r = aCasco.Update();
                            if (!r.Status)
                                toReturn.AddResponse(r);
                        }
                        */
                    }
                    else
                    {
                        Dosar.ID_ASIGURAT_CASCO = null;
                    }
                }

                if (dosarJson.NumeAsiguratRca != aRca.DENUMIRE)
                {
                    if (!String.IsNullOrWhiteSpace(dosarJson.NumeAsiguratRca))
                    {
                        if (d.ID_ASIGURAT_RCA != null) // dosarul are asociat deja un asigurat
                        {
                            aRca = new Asigurat(_CURENT_USER_ID, conStr, Convert.ToInt32(d.ID_ASIGURAT_RCA));
                            aRca.DENUMIRE = dosarJson.NumeAsiguratRca;
                            r = aRca.Update();
                        }
                        else
                        {
                            aRca = new Asigurat(_CURENT_USER_ID, conStr);
                            aRca.DENUMIRE = dosarJson.NumeAsiguratRca;
                            r = aRca.Insert();
                            aRca.ID = r.InsertedId;
                        }
                        if (r.Status) Dosar.ID_ASIGURAT_RCA = Convert.ToInt32(aRca.ID);
                        // -- nu e obligatoriu
                        //else toReturn.AddResponse(r);

                        /*
                        //if (aRca == null || aRca.ID == null)
                        {
                            Asigurat at = new Asigurat(_CURENT_USER_ID, conStr, dosarJson.NumeAsiguratRca);
                            if (at.ID == null)
                            {
                                at.DENUMIRE = dosarJson.NumeAsiguratRca;
                                r = at.Insert();
                                if (r.Status)
                                    at.ID = r.InsertedId;
                                else
                                    toReturn.AddResponse(r);
                            }
                            Dosar.ID_ASIGURAT_RCA = at.ID;
                        }
                        */
                        /*
                        else
                        {
                            aRca.DENUMIRE = dosarJson.NumeAsiguratRca;
                            r = aRca.Update();
                            if (!r.Status)
                                toReturn.AddResponse(r);
                        }
                        */
                    }
                    else
                    {
                        Dosar.ID_ASIGURAT_RCA = null;
                    }
                }

                if (dosarJson.NumarAutoCasco != autoCasco.NR_AUTO)
                {
                    if (!String.IsNullOrWhiteSpace(dosarJson.NumarAutoCasco))
                    {
                        if (d.ID_AUTO_CASCO != null) // dosarul are asociat deja un auto
                        {
                            autoCasco = new Auto(_CURENT_USER_ID, conStr, Convert.ToInt32(d.ID_AUTO_CASCO));
                            autoCasco.NR_AUTO = dosarJson.NumarAutoCasco;
                            r = autoCasco.Update();
                        }
                        else
                        {
                            autoCasco = new Auto(_CURENT_USER_ID, conStr);
                            autoCasco.NR_AUTO = dosarJson.NumarAutoCasco;
                            r = autoCasco.Insert();
                            autoCasco.ID = r.InsertedId;
                        }
                        if (r.Status) Dosar.ID_AUTO_CASCO = Convert.ToInt32(autoCasco.ID);
                        else toReturn.AddResponse(r);

                        /*
                        //if (autoCasco == null || autoCasco.ID == null)
                        {
                            Auto at = new Auto(_CURENT_USER_ID, conStr, dosarJson.NumarAutoCasco);
                            if (at.ID == null)
                            {
                                at.NR_AUTO = dosarJson.NumarAutoCasco;
                                r = at.Insert();
                                if (r.Status)
                                    at.ID = r.InsertedId;
                                else
                                    toReturn.AddResponse(r);
                            }
                            Dosar.ID_AUTO_CASCO = at.ID;
                        }
                        */
                        /*
                        else
                        {
                            autoCasco.NR_AUTO = dosarJson.NumarAutoCasco;
                            r = autoCasco.Update();
                            if (!r.Status)
                                toReturn.AddResponse(r);
                        }
                        */
                    }
                    else
                    {
                        Dosar.ID_AUTO_CASCO = null;
                    }
                }

                if (dosarJson.NumarAutoRca != autoRca.NR_AUTO)
                {
                    if (!String.IsNullOrWhiteSpace(dosarJson.NumarAutoRca))
                    {
                        if (d.ID_AUTO_RCA != null) // dosarul are asociat deja un auto
                        {
                            autoRca = new Auto(_CURENT_USER_ID, conStr, Convert.ToInt32(d.ID_AUTO_RCA));
                            autoRca.NR_AUTO = dosarJson.NumarAutoRca;
                            r = autoRca.Update();
                        }
                        else
                        {
                            autoRca = new Auto(_CURENT_USER_ID, conStr);
                            autoRca.NR_AUTO = dosarJson.NumarAutoRca;
                            r = autoRca.Insert();
                            autoRca.ID = r.InsertedId;
                        }
                        if (r.Status) Dosar.ID_AUTO_RCA = Convert.ToInt32(autoRca.ID);
                        else toReturn.AddResponse(r);

                        /*
                        //if (autoRca == null || autoRca.ID == null)
                        {
                            Auto at = new Auto(_CURENT_USER_ID, conStr, dosarJson.NumarAutoRca);
                            if (at.ID == null)
                            {
                                at.NR_AUTO = dosarJson.NumarAutoRca;
                                r = at.Insert();
                                if (r.Status)
                                    at.ID = r.InsertedId;
                                else
                                    toReturn.AddResponse(r);
                            }
                            Dosar.ID_AUTO_RCA = at.ID;
                        }
                        */
                        /*
                        else
                        {
                            autoRca.NR_AUTO = dosarJson.NumarAutoRca;
                            r = autoRca.Update();
                            if (!r.Status)
                                toReturn.AddResponse(r);
                        }
                        */
                    }
                    else
                    {
                        Dosar.ID_AUTO_RCA = null;
                    }
                }

                if (dosarJson.NumeIntervenient != i.DENUMIRE)
                {
                    if (!String.IsNullOrWhiteSpace(dosarJson.NumeIntervenient))
                    {
                        if (d.ID_INTERVENIENT != null) // dosarul are asociat deja un intervenient
                        {
                            i = new Intervenient(_CURENT_USER_ID, conStr, Convert.ToInt32(d.ID_INTERVENIENT));
                            i.DENUMIRE = dosarJson.NumeIntervenient;
                            r = i.Update();
                        }
                        else
                        {
                            i = new Intervenient(_CURENT_USER_ID, conStr);
                            i.DENUMIRE = dosarJson.NumeIntervenient;
                            r = i.Insert();
                            i.ID = r.InsertedId;
                        }
                        if (r.Status) Dosar.ID_INTERVENIENT = Convert.ToInt32(i.ID);
                        // -- nu e obligatoriu
                        //else toReturn.AddResponse(r);

                        /*
                        //if (i == null || i.ID == null)
                        {
                            Intervenient at = new Intervenient(_CURENT_USER_ID, conStr, dosarJson.NumeIntervenient);
                            if (at.ID == null)
                            {
                                at.DENUMIRE = dosarJson.NumeIntervenient;
                                r = at.Insert();
                                if (r.Status)
                                    at.ID = r.InsertedId;
                                else
                                    toReturn.AddResponse(r);
                            }
                            Dosar.ID_INTERVENIENT = at.ID;
                        }
                        */
                        /*
                        else
                        {
                            i.DENUMIRE = dosarJson.NumeIntervenient;
                            r = i.Update();
                            if (!r.Status)
                                toReturn.AddResponse(r);
                        }
                        */
                    }
                    else
                    {
                        Dosar.ID_INTERVENIENT = null;
                    }
                }
                
                if (!toReturn.Status)
                    return Json(toReturn, JsonRequestBehavior.AllowGet);

                string s = JsonConvert.SerializeObject(Dosar, Formatting.None, new Newtonsoft.Json.Converters.IsoDateTimeConverter() { DateTimeFormat = CommonFunctions.DATE_FORMAT });
                r = d.Update(s);

                return Json(r, JsonRequestBehavior.AllowGet);
            }
        }

        [AuthorizeUser(ActionName = "Dosare", Recursive = false)]
        [HttpPost]
        public JsonResult UpdateCounterDocumente(int id, int value)
        {
            string conStr = Session["conStr"].ToString(); //ConfigurationManager.ConnectionStrings["MySQLConnectionString"].ConnectionString;
            int _CURENT_USER_ID = Convert.ToInt32(Session["CURENT_USER_ID"]);
            Dosar d = new Dosar(_CURENT_USER_ID, conStr, id);
            response toReturn = d.UpdateCounterDocumente(value);
            return Json(toReturn, JsonRequestBehavior.AllowGet);
        }

        [AuthorizeUser(ActionName = "Dosare", Recursive = false)]
        [HttpPost]
        public JsonResult UpdateCounterProcese(int id, int value)
        {
            string conStr = Session["conStr"].ToString(); //ConfigurationManager.ConnectionStrings["MySQLConnectionString"].ConnectionString;
            int _CURENT_USER_ID = Convert.ToInt32(Session["CURENT_USER_ID"]);
            Dosar d = new Dosar(_CURENT_USER_ID, conStr, id);
            response toReturn = d.UpdateCounterProcese(value);
            return Json(toReturn, JsonRequestBehavior.AllowGet);
        }

        [AuthorizeUser(ActionName = "Dosare", Recursive = false)]
        [HttpPost]
        public JsonResult EditOld(DosarView DosarView)
        {
            response r = new response();
            response toReturn = new response(true, "", null, null, new List<Error>());

            string conStr = Session["conStr"].ToString(); //ConfigurationManager.ConnectionStrings["MySQLConnectionString"].ConnectionString;
            int _CURENT_USER_ID = Convert.ToInt32(Session["CURENT_USER_ID"]);
            DosareRepository dr = new DosareRepository(_CURENT_USER_ID, conStr);
            if (DosarView.Dosar.ID == null) // insert
            {
                /*
                var prop = DosarView.Dosar.GetType().GetField("authenticatedUserId", System.Reflection.BindingFlags.NonPublic | System.Reflection.BindingFlags.Instance);
                prop.SetValue(DosarView.Dosar, _CURENT_USER_ID);
                prop = DosarView.Dosar.GetType().GetField("connectionString", System.Reflection.BindingFlags.NonPublic | System.Reflection.BindingFlags.Instance);
                prop.SetValue(DosarView.Dosar, conStr);
                */
                Dosar d = new Dosar(_CURENT_USER_ID, conStr);
                PropertyInfo[] pis = DosarView.Dosar.GetType().GetProperties();
                foreach (PropertyInfo pi in pis)
                {
                    pi.SetValue(d, pi.GetValue(DosarView.Dosar));
                }

                if (DosarView.dosarJson != null)
                {
                    if (!String.IsNullOrEmpty(DosarView.dosarJson.NumeAsiguratCasco))
                    {
                        AsiguratiRepository ar = new AsiguratiRepository(_CURENT_USER_ID, conStr);
                        Asigurat aCasco = (Asigurat)ar.Find(DosarView.dosarJson.NumeAsiguratCasco).Result;
                        if (aCasco != null && aCasco.ID != null)
                        {
                            d.ID_ASIGURAT_CASCO = aCasco.ID;
                        }
                        else
                        {
                            aCasco = new Asigurat(_CURENT_USER_ID, conStr);
                            aCasco.DENUMIRE = DosarView.dosarJson.NumeAsiguratCasco;
                            r = aCasco.Insert();
                            if (r.Status) d.ID_ASIGURAT_CASCO = Convert.ToInt32(aCasco.ID);
                            else toReturn.AddResponse(r);
                        }
                    }

                    if (!String.IsNullOrEmpty(DosarView.dosarJson.NumeAsiguratRca))
                    {
                        AsiguratiRepository ar = new AsiguratiRepository(_CURENT_USER_ID, conStr);
                        Asigurat aRca = (Asigurat)ar.Find(DosarView.dosarJson.NumeAsiguratRca).Result;
                        if (aRca != null && aRca.ID != null)
                        {
                            d.ID_ASIGURAT_RCA = aRca.ID;
                        }
                        else
                        {
                            aRca = new Asigurat(_CURENT_USER_ID, conStr);
                            aRca.DENUMIRE = DosarView.dosarJson.NumeAsiguratRca;
                            r = aRca.Insert();
                            if (r.Status) d.ID_ASIGURAT_RCA = Convert.ToInt32(aRca.ID);
                            // -- nu e obligatoriu
                            //else toReturn.AddResponse(r);
                        }
                    }

                    if (!String.IsNullOrEmpty(DosarView.dosarJson.NumarAutoCasco))
                    {
                        AutoRepository ar = new AutoRepository(_CURENT_USER_ID, conStr);
                        Auto autoCasco = (Auto)ar.Find(DosarView.dosarJson.NumarAutoCasco).Result;
                        if (autoCasco != null && autoCasco.ID != null)
                        {
                            d.ID_AUTO_CASCO = autoCasco.ID;
                        }
                        else
                        {
                            autoCasco = new Auto(_CURENT_USER_ID, conStr);
                            autoCasco.NR_AUTO = DosarView.dosarJson.NumarAutoCasco;
                            r = autoCasco.Insert();
                            if (r.Status) d.ID_AUTO_CASCO = Convert.ToInt32(autoCasco.ID);
                            else toReturn.AddResponse(r);
                        }
                    }

                    if (!String.IsNullOrEmpty(DosarView.dosarJson.NumarAutoRca))
                    {
                        AutoRepository ar = new AutoRepository(_CURENT_USER_ID, conStr);
                        Auto autoRca = (Auto)ar.Find(DosarView.dosarJson.NumarAutoRca).Result;
                        if (autoRca != null && autoRca.ID != null)
                        {
                            d.ID_AUTO_RCA = autoRca.ID;
                        }
                        else
                        {
                            autoRca = new Auto(_CURENT_USER_ID, conStr);
                            autoRca.NR_AUTO = DosarView.dosarJson.NumarAutoRca;
                            r = autoRca.Insert();
                            if (r.Status) d.ID_AUTO_RCA = Convert.ToInt32(autoRca.ID);
                            else toReturn.AddResponse(r);
                        }
                    }

                    if (!String.IsNullOrEmpty(DosarView.dosarJson.NumeIntervenient))
                    {
                        IntervenientiRepository ar = new IntervenientiRepository(_CURENT_USER_ID, conStr);
                        Intervenient i = (Intervenient)ar.Find(DosarView.dosarJson.NumeIntervenient).Result;
                        if (i != null && i.ID != null)
                        {
                            d.ID_INTERVENIENT = i.ID;
                        }
                        else
                        {
                            i = new Intervenient(_CURENT_USER_ID, conStr);
                            i.DENUMIRE = DosarView.dosarJson.NumeIntervenient;
                            r = i.Insert();
                            if (r.Status) d.ID_INTERVENIENT = Convert.ToInt32(i.ID);
                            // -- nu e obligatoriu
                            //else toReturn.AddResponse(r);
                        }
                    }
                    /*
                    if (!String.IsNullOrEmpty(DosarView.dosarJson.TipDosar))
                    {
                        NomenclatoareRepository ar = new NomenclatoareRepository(_CURENT_USER_ID, conStr);
                        Nomenclator tipDosar = (Nomenclator)ar.Find("tip_dosare", DosarView.dosarJson.TipDosar).Result;
                        if (tipDosar != null && tipDosar.ID != null)
                        {
                            d.ID_TIP_DOSAR = tipDosar.ID;
                        }
                        else
                        {
                            tipDosar = new Nomenclator(_CURENT_USER_ID, conStr, "tip_dosare");
                            tipDosar.DENUMIRE = DosarView.dosarJson.TipDosar;
                            r = tipDosar.Insert();
                            if (r.Status) d.ID_TIP_DOSAR = Convert.ToInt32(tipDosar.ID);
                            // -- nu e obligatoriu
                            //else toReturn.AddResponse(r);
                        }
                    }
                    */
                }
                if (!toReturn.Status)
                    return Json(toReturn, JsonRequestBehavior.AllowGet);

                r = d.Insert();
                return Json(r, JsonRequestBehavior.AllowGet);
            }
            else
            { // update
                Dosar d = (Dosar)dr.Find(Convert.ToInt32(DosarView.Dosar.ID)).Result;
                Asigurat aCasco = (Asigurat)d.GetAsiguratCasco().Result;
                Asigurat aRca = (Asigurat)d.GetAsiguratRca().Result;
                Auto autoCasco = (Auto)d.GetAutoCasco().Result;
                Auto autoRca = (Auto)d.GetAutoRca().Result;
                Intervenient i = (Intervenient)d.GetIntervenient().Result;
                Nomenclator tipDosar = (Nomenclator)d.GetTipDosar().Result;

                if (DosarView.dosarJson.NumeAsiguratCasco != aCasco.DENUMIRE)
                {
                    aCasco.DENUMIRE = DosarView.dosarJson.NumeAsiguratCasco;
                    if (aCasco.ID == null)
                    {
                        r = aCasco.Insert();
                        if (r.Status) DosarView.Dosar.ID_ASIGURAT_CASCO = r.InsertedId;
                    }
                    else
                        r = aCasco.Update();
                    if (!r.Status)
                        toReturn.AddResponse(r);
                }
                if (DosarView.dosarJson.NumeAsiguratRca != aRca.DENUMIRE)
                {
                    aRca.DENUMIRE = DosarView.dosarJson.NumeAsiguratRca;
                    if (aRca.ID == null)
                    {
                        r = aRca.Insert();
                        if (r.Status) DosarView.Dosar.ID_ASIGURAT_RCA = r.InsertedId;
                    }
                    else
                        r = aRca.Update();
                    if (!r.Status)
                        toReturn.AddResponse(r);
                }
                if (DosarView.dosarJson.NumarAutoCasco != autoCasco.NR_AUTO)
                {
                    autoCasco.NR_AUTO = DosarView.dosarJson.NumarAutoCasco;
                    if (autoCasco.ID == null)
                    {
                        r = autoCasco.Insert();
                        if (r.Status) DosarView.Dosar.ID_AUTO_CASCO = r.InsertedId;
                    }
                    else
                        r = autoCasco.Update();
                    if (!r.Status)
                        toReturn.AddResponse(r);
                }
                if (DosarView.dosarJson.NumarAutoRca != autoRca.NR_AUTO)
                {
                    autoRca.NR_AUTO = DosarView.dosarJson.NumarAutoRca;
                    if (autoRca.ID == null)
                    {
                        r = autoRca.Insert();
                        if (r.Status) DosarView.Dosar.ID_AUTO_RCA = r.InsertedId;
                    }
                    else
                        r = autoRca.Update();
                    if (!r.Status)
                        toReturn.AddResponse(r);
                }
                if (DosarView.dosarJson.NumeIntervenient != i.DENUMIRE)
                {
                    i.DENUMIRE = DosarView.dosarJson.NumeIntervenient;
                    if (i.ID == null)
                    {
                        r = i.Insert();
                        if (r.Status) DosarView.Dosar.ID_INTERVENIENT = r.InsertedId;
                    }
                    else
                        r = i.Update();
                    if (!r.Status)
                        toReturn.AddResponse(r);
                }
                /*
                if (DosarView.dosarJson.TipDosar != tipDosar.DENUMIRE)
                {
                    tipDosar.DENUMIRE = DosarView.dosarJson.TipDosar;
                    if (tipDosar.ID == null)
                    {
                        tipDosar.Insert();
                        if (r.Status) DosarView.Dosar.ID_TIP_DOSAR = r.InsertedId;
                    }
                    else
                        r = tipDosar.Update();
                    if (!r.Status)
                        toReturn.AddResponse(r);
                }
                */
                if (!toReturn.Status)
                    return Json(toReturn, JsonRequestBehavior.AllowGet);

                string s = JsonConvert.SerializeObject(DosarView.Dosar, Formatting.None, new Newtonsoft.Json.Converters.IsoDateTimeConverter() { DateTimeFormat = CommonFunctions.DATE_FORMAT });
                r = d.Update(s);
                return Json(r, JsonRequestBehavior.AllowGet);
            }
        }

        [AuthorizeUser(ActionName = "Dosare", Recursive = false)]
        [HttpPost]
        public JsonResult Email(int id)
        {
            try
            {
                response r = new response();
                string conStr = Session["conStr"].ToString(); //ConfigurationManager.ConnectionStrings["MySQLConnectionString"].ConnectionString;
                int _CURENT_USER_ID = Convert.ToInt32(Session["CURENT_USER_ID"]);
                Dosar d = new Dosar(_CURENT_USER_ID, conStr, id);
                // verificam daca are drept pe dosar 
                bool? hasWright = (bool?)d.UserHasWright(_CURENT_USER_ID).Result;
                if (hasWright == null || !(bool)hasWright)
                {
                    HttpContext.Response.Redirect("~");
                    return null;
                }
                else
                {
                    DateTime dAvizare = DateTime.Now;
                    r = d.SendCerereDespagubire(EmailProfiles.AwsCereriSES);
                    if (r.Status)
                    {
                        d.DATA_AVIZARE = d.DATA_INTRARE_RCA = d.DATA_IESIRE_CASCO = d.DATA_ULTIMEI_MODIFICARI = dAvizare;
                        response tR = d.Update();
                        if (!tR.Status)
                            r.AddResponse(tR);
                    }
                    //r = new response(true, "", null, null, null);
                    return Json(r, JsonRequestBehavior.AllowGet);
                }
            }catch(Exception exp)
            {
                LogWriter.Log(exp);
                throw exp;
            }
        }
        
        [AuthorizeUser(ActionName = "Dosare", Recursive = false)]
        [HttpPost]
        public JsonResult Avizare(int id, string avizat)
        {
            response r = new response();
            string conStr = Session["conStr"].ToString(); //ConfigurationManager.ConnectionStrings["MySQLConnectionString"].ConnectionString;
            int _CURENT_USER_ID = Convert.ToInt32(Session["CURENT_USER_ID"]);
            //DosareRepository dr = new DosareRepository(_CURENT_USER_ID, conStr);
            Dosar d = new Dosar(_CURENT_USER_ID, conStr, id);
            // verificam daca are drept pe dosar 
            bool? hasWright = (bool?)d.UserHasWright(_CURENT_USER_ID).Result;
            if (hasWright == null || !(bool)hasWright)
            {
                HttpContext.Response.Redirect("~");
                return null;
            }

            //r = dr.Avizare(id, avizat);
            r = d.Avizare(avizat);
            return Json(r, JsonRequestBehavior.AllowGet);
        }

        [AuthorizeUser(ActionName = "Dosare", Recursive = false)]
        [HttpPost]
        public JsonResult ChangeStatus(int id, string status)
        {
            response r = new response();
            string conStr = Session["conStr"].ToString(); //ConfigurationManager.ConnectionStrings["MySQLConnectionString"].ConnectionString;
            int _CURENT_USER_ID = Convert.ToInt32(Session["CURENT_USER_ID"]);
            //DosareRepository dr = new DosareRepository(_CURENT_USER_ID, conStr);
            Dosar d = new Dosar(_CURENT_USER_ID, conStr, id);
            // verificam daca are drept pe dosar 
            bool? hasWright = (bool?)d.UserHasWright(_CURENT_USER_ID).Result;
            if (hasWright == null || !(bool)hasWright)
            {
                HttpContext.Response.Redirect("~");
                return null;
            }
            r = d.ChangeStatus(status);
            return Json(r, JsonRequestBehavior.AllowGet);
        }

        [AuthorizeUser(ActionName = "Dosare", Recursive = false)]
        [HttpPost]
        public JsonResult Delete(int id)
        {
            response r = new response();
            string conStr = Session["conStr"].ToString(); //ConfigurationManager.ConnectionStrings["MySQLConnectionString"].ConnectionString;
            int _CURENT_USER_ID = Convert.ToInt32(Session["CURENT_USER_ID"]);
            //DosareRepository dr = new DosareRepository(_CURENT_USER_ID, conStr);
            Dosar d = new Dosar(_CURENT_USER_ID, conStr, id);
            // verificam daca are drept pe dosar 
            bool? hasWright = (bool?)d.UserHasWright(_CURENT_USER_ID).Result;
            if (hasWright == null || !(bool)hasWright)
            {
                HttpContext.Response.Redirect("~");
                return null;
            }

            r = d.Delete();
            return Json(r, JsonRequestBehavior.AllowGet);
        }

        [AuthorizeUser(ActionName = "Dosare", Recursive = false)]
        //[AuthorizeToken]
        [HttpPost]
        //public JsonResult Print(int id, int tip)
        public void Print(int id, int tip)
        {
            response r = new response();
            string conStr = Session["conStr"].ToString(); //ConfigurationManager.ConnectionStrings["MySQLConnectionString"].ConnectionString;
            int _CURENT_USER_ID = Convert.ToInt32(Session["CURENT_USER_ID"]);
            Dosar d = new Dosar(_CURENT_USER_ID, conStr, id);
            // verificam daca are drept pe dosar 
            
            bool? hasWright = (bool?)d.UserHasWright(_CURENT_USER_ID).Result;
            if (hasWright == null || !(bool)hasWright)
            {
                //HttpContext.Response.Redirect("~");
                //return null;
                Response.BinaryWrite(null);
            }
            else            
            {
                DosareRepository dr = new DosareRepository(_CURENT_USER_ID, conStr);
                switch (tip)
                {
                    case 0:
                        r = dr.ExportDosarCompletToPdf(id);
                        break;
                    case 1:
                        r = dr.ExportDosarToPdf(id);
                        break;
                    case 2:
                        r = dr.ExportDocumenteDosarToPdf(id);
                        break;
                }
                if (r.Status)
                {
                    //r.Result = r.Message = r.Message.Substring(r.Message.LastIndexOf("\\") + 1);
                    byte[] pdfContent = System.IO.File.ReadAllBytes(r.Message);
                    Response.BinaryWrite(pdfContent);
                }
                else
                {
                    Response.BinaryWrite(null);
                }
                //return Json(r, JsonRequestBehavior.AllowGet);
            }
        }

        [AuthorizeUser(ActionName = "Dosare", Recursive = false)]
        //[AuthorizeToken]
        [HttpPost]
        //public JsonResult DownloadDocs(int id)
        public void DownloadDocs(int id, bool bulk)
        {
            response r = new response();
            string conStr = Session["conStr"].ToString(); //ConfigurationManager.ConnectionStrings["MySQLConnectionString"].ConnectionString;
            int _CURENT_USER_ID = Convert.ToInt32(Session["CURENT_USER_ID"]);
            Dosar d = new Dosar(_CURENT_USER_ID, conStr, id);
            // verificam daca are drept pe dosar 

            bool? hasWright = (bool?)d.UserHasWright(_CURENT_USER_ID).Result;
            if (hasWright == null || !(bool)hasWright)
            {
                //HttpContext.Response.Redirect("~");
                //return null;
                Response.BinaryWrite(null);
            }
            else
            {
                r = FileManager.CreateZipFromDosar(d, bulk);
                if (r.Status)
                {
                    //r.Result = r.Message = r.Message.Substring(r.Message.LastIndexOf("\\") + 1);
                    byte[] zipContent = System.IO.File.ReadAllBytes(r.Message);
                    Response.BinaryWrite(zipContent);
                }
                else
                {
                    Response.BinaryWrite(null);
                }
                //return Json(r, JsonRequestBehavior.AllowGet);
            }
        }

        //[AuthorizeUser(ActionName = "Dosare", Recursive = false)]
        //[AuthorizeToken]
        [HttpGet]
        //public JsonResult Print(int id)
        public void EPrint(string token)
        {
            //string token = Session["TOKEN"].ToString();
            int id_dosar = Convert.ToInt32(token.Substring(token.LastIndexOf('|') + 1));

            response r = new response();
            string conStr = Session["conStr"].ToString(); //ConfigurationManager.ConnectionStrings["MySQLConnectionString"].ConnectionString;
            int _CURENT_USER_ID = Convert.ToInt32(Session["CURENT_USER_ID"]);
            Dosar d = new Dosar(_CURENT_USER_ID, conStr, id_dosar);
            /*
            // verificam daca are drept pe dosar 
            bool? hasWright = (bool?)d.UserHasWright(_CURENT_USER_ID).Result;
            if (hasWright == null || !(bool)hasWright)
            {
                //HttpContext.Response.Redirect("~");
                //return null;
                Response.BinaryWrite(null);
            }
            else
            */
            {
                DosareRepository dr = new DosareRepository(_CURENT_USER_ID, conStr);
                r = dr.ExportDocumenteDosarToPdf(id_dosar);
                if (r.Status)
                {
                    //r.Result = r.Message = r.Message.Substring(r.Message.LastIndexOf("\\") + 1);
                    byte[] pdfContent = System.IO.File.ReadAllBytes(r.Message);
                    //Response.BinaryWrite(pdfContent);
                    Response.ContentType = "application/pdf";
                    Response.OutputStream.Write(pdfContent, 0, pdfContent.Length);
                    Response.Flush();
                    Response.Close();
                }
                else
                {
                    Response.BinaryWrite(null);
                }
                //return Json(r, JsonRequestBehavior.AllowGet);
            }
        }

        //[AuthorizeUser(ActionName = "Dosare", Recursive = false)]
        //[AuthorizeToken]
        [HttpGet]
        public void EZipBulk(string token)
        {
            CreateZip(token, false);
        }

        //[AuthorizeUser(ActionName = "Dosare", Recursive = false)]
        //[AuthorizeToken]
        [HttpGet]
        public void EZip(string token)
        {
            CreateZip(token, true);
        }

        private void CreateZip(string token, bool bulk)
        {
            //string token = Session["TOKEN"].ToString();
            int id_dosar = Convert.ToInt32(token.Substring(token.LastIndexOf('|') + 1));

            response r = new response();
            string conStr = Session["conStr"].ToString(); //ConfigurationManager.ConnectionStrings["MySQLConnectionString"].ConnectionString;
            int _CURENT_USER_ID = Convert.ToInt32(Session["CURENT_USER_ID"]);
            Dosar d = new Dosar(_CURENT_USER_ID, conStr, id_dosar);
            /*
            // verificam daca are drept pe dosar 
            bool? hasWright = (bool?)d.UserHasWright(_CURENT_USER_ID).Result;
            if (hasWright == null || !(bool)hasWright)
            {
                //HttpContext.Response.Redirect("~");
                //return null;
                Response.BinaryWrite(null);
            }
            else
            */
            {
                r = FileManager.CreateZipFromDosar(d, bulk);
                if (r.Status)
                {
                    byte[] zipContent = System.IO.File.ReadAllBytes(r.Message);
                    Response.ContentType = "application/zip";
                    Response.OutputStream.Write(zipContent, 0, zipContent.Length);
                    Response.Flush();
                    Response.Close();
                }
                else
                {
                    Response.BinaryWrite(null);
                }
            }
        }

        //[AuthorizeUser(ActionName = "Dosare", Recursive = false)]
        //[AuthorizeToken]
        [HttpPost]
        public void ExportBorderouToExcel(DosarView DosarView)
        {
            /*
            //TO DO: aducere dosare extended din filtrare
            JObject f = (JObject)JsonConvert.DeserializeObject(Request.Form[0]);
            JToken jDosare = f["DosareResult"];
            DataTable table = (DataTable)JsonConvert.DeserializeObject(JsonConvert.SerializeObject(jDosare, Formatting.None, new Newtonsoft.Json.Converters.IsoDateTimeConverter() { DateTimeFormat = SOCISA.CommonFunctions.DATE_FORMAT }), (typeof(DataTable)));

            using (ExcelPackage pack = new ExcelPackage())
            {
                ExcelWorksheet ws = pack.Workbook.Worksheets.Add("Dosare");
                ws.Cells["A1"].LoadFromDataTable(table, true);
                var ms = new System.IO.MemoryStream();
                pack.SaveAs(ms);
                Response.BinaryWrite(ms.GetBuffer());
            }
            */
            JObject f = (JObject)JsonConvert.DeserializeObject(Request.Form[0]);
            JToken jDosar = f["Dosar"];
            string sd = jDosar["DATA_SCA"].Value<string>();
            string id_soc_rca = jDosar["ID_SOCIETATE_RCA"].Value<string>();
            DateTime d = Convert.ToDateTime(CommonFunctions.SwitchBackFormatedDate(sd));
            string conStr = Session["conStr"].ToString(); //ConfigurationManager.ConnectionStrings["MySQLConnectionString"].ConnectionString;
            int _CURENT_USER_ID = Convert.ToInt32(Session["CURENT_USER_ID"]);

            DosareRepository dr = new DosareRepository(_CURENT_USER_ID, conStr);
            Dosar[] dosare = (Dosar[]) dr.GetFiltered(null, null, String.Format(" DOSARE.DATA_SCA = '{0}' AND DOSARE.ID_SOCIETATE_CASCO = '{1}' AND DOSARE.ID_SOCIETATE_RCA = '{2}' ", CommonFunctions.ToMySqlFormatDate(d), Convert.ToInt32(Session["ID_SOCIETATE"]), Convert.ToInt32(id_soc_rca) ), null).Result;

            DataTable table = (DataTable)JsonConvert.DeserializeObject(JsonConvert.SerializeObject(dosare, Formatting.None, new Newtonsoft.Json.Converters.IsoDateTimeConverter() { DateTimeFormat = SOCISA.CommonFunctions.DATE_FORMAT }), (typeof(DataTable)));
            List<string> columns_to_remove = new List<string>();
            foreach(DataColumn dc in table.Columns)
            {
                if(
                    !dc.ColumnName.ToLower().Equals("id") &&
                    !dc.ColumnName.ToLower().Contains("nr_dosar_casco") &&
                    !dc.ColumnName.ToLower().Contains("nr_sca") &&
                    !dc.ColumnName.ToLower().Contains("data_sca") &&
                    !dc.ColumnName.ToLower().Contains("nr_polita_casco") &&
                    !dc.ColumnName.ToLower().Contains("nr_auto_casco") &&
                    !dc.ColumnName.ToLower().Contains("nr_polita_rca") &&
                    !dc.ColumnName.ToLower().Contains("nr_auto_rca") &&
                    !dc.ColumnName.ToLower().Contains("data_eveniment") &&
                    !dc.ColumnName.ToLower().Contains("valoare_regres") &&
                    !dc.ColumnName.ToLower().Contains("data_avizare")
                )
                {
                    columns_to_remove.Add(dc.ColumnName);
                }
            }
            foreach (string col_name in columns_to_remove)
            {
                table.Columns.Remove(col_name);
            }
            DataColumn newdc = new DataColumn("ASIGURAT_CASCO", Type.GetType("System.String"));
            table.Columns.Add(newdc);
            newdc = new DataColumn("ASIGURATOR_RCA", Type.GetType("System.String"));
            table.Columns.Add(newdc);
            table.AcceptChanges();

            foreach(DataRow drow in table.Rows)
            {
                try
                {
                    Dosar dosar = new Dosar(_CURENT_USER_ID, conStr, Convert.ToInt32(drow["ID"]));
                    Asigurat aCasco = (Asigurat)dosar.GetAsiguratCasco().Result;
                    drow["ASIGURAT_CASCO"] = aCasco.DENUMIRE;
                    SocietateAsigurare sRca = (SocietateAsigurare)dosar.GetSocietateRca().Result;
                    drow["ASIGURATOR_RCA"] = sRca.DENUMIRE;
                }catch(Exception exp) { LogWriter.Log(exp); }
            }
            table.AcceptChanges();

            using (ExcelPackage pack = new ExcelPackage())
            {
                ExcelWorksheet ws = pack.Workbook.Worksheets.Add("Dosare");
                ws.Cells["A1"].LoadFromDataTable(table, true);
                var ms = new System.IO.MemoryStream();
                pack.SaveAs(ms);
                Response.BinaryWrite(ms.GetBuffer());
            }
        }

        //[AuthorizeUser(ActionName = "Dosare", Recursive = false)]
        //[AuthorizeToken]
        [HttpPost]
        public void ExportDosareToExcel(DosarView DosarView)
        {
            string conStr = Session["conStr"].ToString(); //ConfigurationManager.ConnectionStrings["MySQLConnectionString"].ConnectionString;
            int _CURENT_USER_ID = Convert.ToInt32(Session["CURENT_USER_ID"]);

            //string jsonFilter = JsonConvert.SerializeObject(DosarView);
            JObject f = (JObject)JsonConvert.DeserializeObject(Request.Form[0]);
            response r = GetFiltered(f);
            Dosar[] dosare = (Dosar[])r.Result;

            DataTable table = (DataTable)JsonConvert.DeserializeObject(JsonConvert.SerializeObject(dosare, Formatting.None, new Newtonsoft.Json.Converters.IsoDateTimeConverter() { DateTimeFormat = SOCISA.CommonFunctions.DATE_FORMAT }), (typeof(DataTable)));
            List<string> columns_to_remove = new List<string>();
            foreach (DataColumn dc in table.Columns)
            {
                if (
                    !dc.ColumnName.ToLower().Equals("id") &&
                    !dc.ColumnName.ToLower().Contains("nr_dosar_casco") &&
                    !dc.ColumnName.ToLower().Contains("nr_sca") &&
                    !dc.ColumnName.ToLower().Contains("data_sca") &&
                    !dc.ColumnName.ToLower().Contains("nr_polita_casco") &&
                    !dc.ColumnName.ToLower().Contains("nr_auto_casco") &&
                    !dc.ColumnName.ToLower().Contains("nr_polita_rca") &&
                    !dc.ColumnName.ToLower().Contains("nr_auto_rca") &&
                    !dc.ColumnName.ToLower().Contains("data_eveniment") &&
                    !dc.ColumnName.ToLower().Contains("valoare_regres") &&
                    !dc.ColumnName.ToLower().Contains("data_avizare")
                )
                {
                    columns_to_remove.Add(dc.ColumnName);
                }
            }
            foreach (string col_name in columns_to_remove)
            {
                table.Columns.Remove(col_name);
            }
            DataColumn newdc = new DataColumn("ASIGURAT_CASCO", Type.GetType("System.String"));
            table.Columns.Add(newdc);
            newdc = new DataColumn("ASIGURATOR_RCA", Type.GetType("System.String"));
            table.Columns.Add(newdc);
            table.AcceptChanges();

            foreach (DataRow drow in table.Rows)
            {
                try
                {
                    Dosar dosar = new Dosar(_CURENT_USER_ID, conStr, Convert.ToInt32(drow["ID"]));
                    Asigurat aCasco = (Asigurat)dosar.GetAsiguratCasco().Result;
                    drow["ASIGURAT_CASCO"] = aCasco.DENUMIRE;
                    SocietateAsigurare sRca = (SocietateAsigurare)dosar.GetSocietateRca().Result;
                    drow["ASIGURATOR_RCA"] = sRca.DENUMIRE;
                }
                catch (Exception exp) { LogWriter.Log(exp); }
            }
            table.AcceptChanges();

            using (ExcelPackage pack = new ExcelPackage())
            {
                ExcelWorksheet ws = pack.Workbook.Worksheets.Add("Dosare");
                ws.Cells["A1"].LoadFromDataTable(table, true);
                var ms = new System.IO.MemoryStream();
                pack.SaveAs(ms);
                Response.BinaryWrite(ms.GetBuffer());
            }
        }
    }
}
