using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using SOCISA;
using SOCISA.Models;
using System.Reflection;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System.Globalization;
using System.Data;
using OfficeOpenXml;

namespace socisaWeb.Controllers
{
    //[DefaultAuthorize]
    [Authorize]
    public class ProceseController : Controller
    {
        //[AuthorizeUser(ActionName = "Procese", Recursive = false)]
        public ActionResult Index()
        {
            string conStr = Session["conStr"].ToString(); //ConfigurationManager.ConnectionStrings["MySQLConnectionString"].ConnectionString;
            int _CURENT_USER_ID = Convert.ToInt32(Session["CURENT_USER_ID"]);
            return PartialView("ProceseView", new ProcesView(_CURENT_USER_ID, conStr));
        }

        /*
        //[AuthorizeUser(ActionName = "Procese", Recursive = false)]
        //[AuthorizeToken]
        [HttpPost]
        public JsonResult Search(ProcesView ProcesView)
        {
            //string jsonFilter = JsonConvert.SerializeObject(ProcesView);
            JObject f = (JObject)JsonConvert.DeserializeObject(Request.Form[0]);
            response r = GetFiltered(f);
            return Json(JsonConvert.SerializeObject(r, Formatting.None, new Newtonsoft.Json.Converters.IsoDateTimeConverter() { DateTimeFormat = CommonFunctions.DATE_FORMAT }), JsonRequestBehavior.AllowGet);
        }
        */
        //[AuthorizeUser(ActionName = "Procese", Recursive = false)]
        //[AuthorizeToken]
        [HttpPost]
        public JsonResult Search(Proces Proces, ProcesJson procesJson)
        {
            response r = GetFiltered(JToken.FromObject(Proces), JToken.FromObject(procesJson));
            return Json(JsonConvert.SerializeObject(r, Formatting.None, new Newtonsoft.Json.Converters.IsoDateTimeConverter() { DateTimeFormat = CommonFunctions.DATE_FORMAT }), JsonRequestBehavior.AllowGet);
        }

        public response GetFiltered(JToken jProces, JToken jprocesJson)
        {
            string conStr = Session["conStr"].ToString(); //ConfigurationManager.ConnectionStrings["MySQLConnectionString"].ConnectionString;
            int _CURENT_USER_ID = Convert.ToInt32(Session["CURENT_USER_ID"]);
            ProceseRepository pr = new ProceseRepository(_CURENT_USER_ID, conStr);

            string limit = null;

            if (jprocesJson != null)
            {
                if (jprocesJson["LimitStart"] != null && !String.IsNullOrEmpty(jprocesJson["LimitStart"].ToString()) && jprocesJson["LimitEnd"] != null && !String.IsNullOrEmpty(jprocesJson["LimitEnd"].ToString()))
                {
                    limit = String.Format(" LIMIT {0},{1} ", jprocesJson["LimitStart"].ToString(), jprocesJson["LimitEnd"].ToString());
                }
            }
            //response r = dr.GetFiltered(null, null, String.Format("{'jProces':{0},'jprocesJson':{1}}", JsonConvert.SerializeObject(jProces), JsonConvert.SerializeObject(jprocesJson)), null);
            string jsonParam = CreateFilterString(jProces, jprocesJson);
            //response r = pr.GetFilteredExtended(null, null, jsonParam, limit);
            response r = pr.GetFiltered(null, null, jsonParam, limit);
            r.InsertedId = Convert.ToInt32(pr.CountFiltered(null, null, jsonParam, null).Result); // folosim campul InsertedId pt. counter
            return r;
        }

        private string CreateFilterString(JToken jProces, JToken jprocesJson)
        {
            if (jprocesJson != null)
            {
                if (jProces == null) jProces = JToken.FromObject(new Dosar());

                if (jprocesJson["DataScaStart"] != null && !String.IsNullOrEmpty(jprocesJson["DataScaStart"].ToString()) && jprocesJson["DataScaEnd"] != null && !String.IsNullOrEmpty(jprocesJson["DataScaEnd"].ToString()))
                {
                    jProces["DATA_SCA"] = CommonFunctions.ToMySqlFormatDate(DateTime.ParseExact(jprocesJson["DataScaStart"].ToString(), CommonFunctions.DATE_TIME_FORMAT, CultureInfo.InvariantCulture)) + "?" + CommonFunctions.ToMySqlFormatDate(DateTime.ParseExact(jprocesJson["DataScaEnd"].ToString(), CommonFunctions.DATE_TIME_FORMAT, CultureInfo.InvariantCulture));
                }
                if (jprocesJson["DataDepunereStart"] != null && !String.IsNullOrEmpty(jprocesJson["DataDepunereStart"].ToString()) && jprocesJson["DataDepunereEnd"] != null && !String.IsNullOrEmpty(jprocesJson["DataDepunereEnd"].ToString()))
                {
                    jProces["DATA_DEPUNERE"] = CommonFunctions.ToMySqlFormatDate(DateTime.ParseExact(jprocesJson["DataDepunereStart"].ToString(), CommonFunctions.DATE_TIME_FORMAT, CultureInfo.InvariantCulture)) + "?" + CommonFunctions.ToMySqlFormatDate(DateTime.ParseExact(jprocesJson["DataDepunereEnd"].ToString(), CommonFunctions.DATE_TIME_FORMAT, CultureInfo.InvariantCulture));
                }
                if (jprocesJson["DataExecutareStart"] != null && !String.IsNullOrEmpty(jprocesJson["DataExecutareStart"].ToString()) && jprocesJson["DataExecutareEnd"] != null && !String.IsNullOrEmpty(jprocesJson["DataExecutareEnd"].ToString()))
                {
                    jProces["DATA_EXECUTARE"] = CommonFunctions.ToMySqlFormatDate(DateTime.ParseExact(jprocesJson["DataExecutareStart"].ToString(), CommonFunctions.DATE_TIME_FORMAT, CultureInfo.InvariantCulture)) + "?" + CommonFunctions.ToMySqlFormatDate(DateTime.ParseExact(jprocesJson["DataExecutareEnd"].ToString(), CommonFunctions.DATE_TIME_FORMAT, CultureInfo.InvariantCulture));
                }
                if (jprocesJson["DataStadiuStart"] != null && !String.IsNullOrEmpty(jprocesJson["DataStadiuStart"].ToString()) && jprocesJson["DataStadiuEnd"] != null && !String.IsNullOrEmpty(jprocesJson["DataStadiuEnd"].ToString()))
                {
                    jprocesJson["DataStadiu"] = CommonFunctions.ToMySqlFormatDate(DateTime.ParseExact(jprocesJson["DataStadiuStart"].ToString(), CommonFunctions.DATE_TIME_FORMAT, CultureInfo.InvariantCulture)) + "?" + CommonFunctions.ToMySqlFormatDate(DateTime.ParseExact(jprocesJson["DataStadiuEnd"].ToString(), CommonFunctions.DATE_TIME_FORMAT, CultureInfo.InvariantCulture));
                }
                if (jprocesJson["Calitate"] != null && !String.IsNullOrWhiteSpace(jprocesJson["Calitate"].ToString()))
                {
                    switch (jprocesJson["Calitate"].ToString())
                    {
                        case "RECLAMANT":
                            jprocesJson["Calitate"] = String.Format( " ((PROCESE.ID_DOSAR IS NULL AND PROCESE.ID_RECLAMANT={0}) OR (PROCESE.ID_DOSAR IS NOT NULL AND DOSARE.ID_SOCIETATE_CASCO={0})) ", Session["ID_SOCIETATE"].ToString());
                            break;
                        case "PARAT":
                            jprocesJson["Calitate"] = String.Format(" ((PROCESE.ID_DOSAR IS NULL AND PROCESE.ID_PARAT={0}) OR (PROCESE.ID_DOSAR IS NOT NULL AND DOSARE.ID_SOCIETATE_RCA={0})) ", Session["ID_SOCIETATE"].ToString());
                            break;
                        case "TERT":
                            jprocesJson["Calitate"] = String.Format(" (PROCESE.ID_DOSAR IS NULL AND PROCESE.ID_TERT={0}) ", Session["ID_SOCIETATE"].ToString());
                            break;
                        default:
                            jprocesJson["Calitate"] = String.Format(" ((PROCESE.ID_DOSAR IS NULL AND (PROCESE.ID_RECLAMANT={0} OR PROCESE.ID_PARAT={0} OR PROCESE.ID_TERT={0})) OR (PROCESE.ID_DOSAR IS NOT NULL AND (DOSARE.ID_SOCIETATE_CASCO={0} OR DOSARE.ID_SOCIETATE_RCA={0}))) ", Session["ID_SOCIETATE"].ToString());
                            break;
                    }
                }
                else
                {
                    jprocesJson["Calitate"] = String.Format(" ((PROCESE.ID_DOSAR IS NULL AND (PROCESE.ID_RECLAMANT={0} OR PROCESE.ID_PARAT={0} OR PROCESE.ID_TERT={0})) OR (PROCESE.ID_DOSAR IS NOT NULL AND (DOSARE.ID_SOCIETATE_CASCO={0} OR DOSARE.ID_SOCIETATE_RCA={0}))) ", Session["ID_SOCIETATE"].ToString());
                }
            }
            //response r = dr.GetFiltered(null, null, String.Format("{'jProces':{0},'jprocesJson':{1}}", JsonConvert.SerializeObject(jProces), JsonConvert.SerializeObject(jprocesJson)), null);
            string jsonParam = "{\"jObject\":" + JsonConvert.SerializeObject(jProces) + ",\"jobjectJson\":" + JsonConvert.SerializeObject(jprocesJson) + "}";
            return jsonParam;
        }

        private response GetFiltered(JObject f)
        {
            JToken jProces = f["ProcesView"]["CurProces"]["Proces"];
            JToken jprocesJson = f["ProcesView"]["procesJson"];
            return GetFiltered(jProces, jprocesJson);
        }


        //[AuthorizeUser(ActionName = "Procese", Recursive = false)]
        //[AuthorizeToken]
        public ActionResult Empty()
        {
            string conStr = Session["conStr"].ToString(); //ConfigurationManager.ConnectionStrings["MySQLConnectionString"].ConnectionString;
            int _CURENT_USER_ID = Convert.ToInt32(Session["CURENT_USER_ID"]);
            return PartialView("ProceseView", new ProcesView(_CURENT_USER_ID, conStr, "empty"));
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
                return PartialView("ProceseView", new ProcesView(Convert.ToInt32(Session["CURENT_USER_ID"]), conStr, _params));
            }
            catch
            {
                return PartialView();
            }
        }

        //[AuthorizeUser(ActionName = "Procese", Recursive = false)]
        public JsonResult Details(string id) // id dosar
        {
            string conStr = Session["conStr"].ToString(); //ConfigurationManager.ConnectionStrings["MySQLConnectionString"].ConnectionString;
            ProcesView pv = new ProcesView(Convert.ToInt32(Session["CURENT_USER_ID"]), conStr, Convert.ToInt32(id));
            JsonResult result = Json(Newtonsoft.Json.JsonConvert.SerializeObject(pv, Newtonsoft.Json.Formatting.None, new Newtonsoft.Json.Converters.IsoDateTimeConverter() { DateTimeFormat = SOCISA.CommonFunctions.DATE_FORMAT }), JsonRequestBehavior.AllowGet);
            result.MaxJsonLength = Int32.MaxValue;
            return result;
        }

        //[AuthorizeUser(ActionName = "Procese", Recursive = false)]
        public JsonResult Detail(int id) // id dosar
        {
            int _CURENT_USER_ID = Convert.ToInt32(Session["CURENT_USER_ID"]);
            string conStr = Session["conStr"].ToString(); //ConfigurationManager.ConnectionStrings["MySQLConnectionString"].ConnectionString;
            ProcesExtended pe = new ProcesExtended(new Proces(_CURENT_USER_ID, conStr, id), false, Convert.ToInt32(Session["ID_SOCIETATE"]));
            JsonResult result = Json(JsonConvert.SerializeObject(pe, Formatting.None, new Newtonsoft.Json.Converters.IsoDateTimeConverter() { DateTimeFormat = CommonFunctions.DATE_FORMAT }), JsonRequestBehavior.AllowGet);
            result.MaxJsonLength = Int32.MaxValue;
            return result;
        }

        //[AuthorizeUser(ActionName = "Procese", Recursive = false)]
        [HttpGet]
        public JsonResult GetStadiuCurent(int id)
        {
            response r = new response();
            string conStr = Session["conStr"].ToString(); //ConfigurationManager.ConnectionStrings["MySQLConnectionString"].ConnectionString;
            int _CURENT_USER_ID = Convert.ToInt32(Session["CURENT_USER_ID"]);
            Proces p = new Proces(_CURENT_USER_ID, conStr, id);
            ProcesStadiu ps = (ProcesStadiu)p.GetStadiuCurent().Result;
            ProcesStadiuExtended toReturn = new ProcesStadiuExtended(ps);
            return Json(JsonConvert.SerializeObject(toReturn, Formatting.None, new Newtonsoft.Json.Converters.IsoDateTimeConverter() { DateTimeFormat = CommonFunctions.DATE_FORMAT }), JsonRequestBehavior.AllowGet);
        }

        [AuthorizeUser(ActionName = "Procese", Recursive = false)]
        [HttpPost]
        public JsonResult Edit(Proces Proces, ProcesJson procesJson)
        {
            response toReturn = new response(true, "", null, null, new List<Error>());

            string conStr = Session["conStr"].ToString(); //ConfigurationManager.ConnectionStrings["MySQLConnectionString"].ConnectionString;
            int _CURENT_USER_ID = Convert.ToInt32(Session["CURENT_USER_ID"]);
            int _ID_SOCIETATE = Convert.ToInt32(Session["ID_SOCIETATE"]);
            Dosar d = Proces.ID_DOSAR == null ? new Dosar() : new Dosar(_CURENT_USER_ID, conStr, Convert.ToInt32(Proces.ID_DOSAR));

            if (Proces.ID == null) // insert
            {
                Proces p = new Proces(_CURENT_USER_ID, conStr);
                PropertyInfo[] pis = Proces.GetType().GetProperties();
                foreach (PropertyInfo pi in pis)
                {
                    pi.SetValue(p, pi.GetValue(Proces));
                }
                string calitate = ((Nomenclator)p.GetCalitate(_ID_SOCIETATE).Result).DENUMIRE;

                if (!String.IsNullOrWhiteSpace(procesJson.Reclamant) || !String.IsNullOrWhiteSpace(procesJson.Parat) || !String.IsNullOrWhiteSpace(procesJson.Tert))
                {

                    if ((calitate == "PARAT" || calitate == "TERT") && !String.IsNullOrWhiteSpace(procesJson.Reclamant)) {
                        Parte reclamant = new Parte(_CURENT_USER_ID, conStr);
                        reclamant.DENUMIRE = procesJson.Reclamant;
                        toReturn = reclamant.Insert();
                        if (toReturn.Status)
                        {
                            if (p.ID_DOSAR == null || (p.ID_DOSAR != null && d.ID_SOCIETATE_CASCO == null)) {
                                p.ID_RECLAMANT = toReturn.InsertedId;
                            }
                        }
                    }
                    if ((calitate == "RECLAMANT" || calitate == "TERT") && !String.IsNullOrWhiteSpace(procesJson.Parat)) {
                        Parte parat = new Parte(_CURENT_USER_ID, conStr);
                        parat.DENUMIRE = procesJson.Parat;
                        toReturn = parat.Insert();
                        if (toReturn.Status)
                        {
                            if (p.ID_DOSAR == null || (p.ID_DOSAR != null && d.ID_SOCIETATE_RCA == null))
                            {
                                p.ID_PARAT = toReturn.InsertedId;
                            }
                        }
                    }
                    if (calitate != "TERT" && !String.IsNullOrWhiteSpace(procesJson.Tert)) {
                        Parte tert = new Parte(_CURENT_USER_ID, conStr);
                        tert.DENUMIRE = procesJson.Parat;
                        toReturn = tert.Insert();
                        if (toReturn.Status)
                        {
                            p.ID_TERT = toReturn.InsertedId;
                        }
                    }
                }

                if (toReturn.Status)
                {
                    toReturn = p.Insert();
                }
            }
            else // update
            {
                Proces p = new Proces(_CURENT_USER_ID, conStr, Convert.ToInt32(Proces.ID));
                string calitate = ((Nomenclator)p.GetCalitate(_ID_SOCIETATE).Result).DENUMIRE;

                if (!String.IsNullOrWhiteSpace(procesJson.Reclamant) || !String.IsNullOrWhiteSpace(procesJson.Parat) || !String.IsNullOrWhiteSpace(procesJson.Tert))
                {
                    if (calitate == "PARAT" || calitate == "TERT") {
                        if (p.ID_DOSAR == null || (p.ID_DOSAR != null && d.ID_SOCIETATE_CASCO == null))
                        {
                            if (Proces.ID_RECLAMANT == null)
                            {
                                if (!String.IsNullOrWhiteSpace(procesJson.Reclamant))
                                {
                                    Parte reclamant = new Parte(_CURENT_USER_ID, conStr);
                                    reclamant.DENUMIRE = procesJson.Reclamant;
                                    toReturn = reclamant.Insert();
                                    if (toReturn.Status)
                                    {
                                        //p.ID_RECLAMANT = toReturn.InsertedId;
                                        Proces.ID_RECLAMANT = toReturn.InsertedId;
                                    }
                                }
                            }
                            else
                            {
                                dynamic initReclamant = p.GetReclamant(_ID_SOCIETATE).Result;
                                if (!String.IsNullOrWhiteSpace(procesJson.Reclamant))
                                {
                                    if (!String.IsNullOrWhiteSpace(procesJson.Reclamant) && initReclamant.DENUMIRE != procesJson.Reclamant)
                                    {
                                        initReclamant.DENUMIRE = procesJson.Reclamant;
                                        toReturn = initReclamant.Update();
                                    }
                                }
                                else
                                {
                                    toReturn = initReclamant.Delete();
                                    if (toReturn.Status)
                                    {
                                        //p.ID_RECLAMANT = null;
                                        Proces.ID_RECLAMANT = null;
                                    }
                                }
                            }
                        }
                    }
                    if (calitate == "RECLAMANT" || calitate == "TERT") {
                        if (p.ID_DOSAR == null || (p.ID_DOSAR != null && d.ID_SOCIETATE_RCA == null))
                        {
                            if (Proces.ID_PARAT == null)
                            {
                                if (!String.IsNullOrWhiteSpace(procesJson.Parat))
                                {
                                    Parte parat = new Parte(_CURENT_USER_ID, conStr);
                                    parat.DENUMIRE = procesJson.Reclamant;
                                    toReturn = parat.Insert();
                                    if (toReturn.Status)
                                    {
                                        //p.ID_PARAT = toReturn.InsertedId;
                                        Proces.ID_PARAT = toReturn.InsertedId;
                                    }
                                }
                            }
                            else
                            {
                                dynamic initParat = p.GetParat(_ID_SOCIETATE).Result;
                                if (!String.IsNullOrWhiteSpace(procesJson.Parat))
                                {
                                    if (!String.IsNullOrWhiteSpace(procesJson.Parat) && initParat.DENUMIRE != procesJson.Parat)
                                    {
                                        initParat.DENUMIRE = procesJson.Parat;
                                        toReturn = initParat.Update();
                                    }
                                }
                                else
                                {
                                    toReturn = initParat.Delete();
                                    if (toReturn.Status)
                                    {
                                        //p.ID_PARAT = null;
                                        Proces.ID_PARAT = null;
                                    }
                                }
                            }
                        }
                    }
                    if (calitate != "TERT")
                    {
                        if (Proces.ID_TERT == null)
                        {
                            if (!String.IsNullOrWhiteSpace(procesJson.Tert))
                            {
                                Parte tert = new Parte(_CURENT_USER_ID, conStr);
                                tert.DENUMIRE = procesJson.Tert;
                                toReturn = tert.Insert();
                                if (toReturn.Status)
                                {
                                    //p.ID_TERT = toReturn.InsertedId;
                                    Proces.ID_TERT = toReturn.InsertedId;
                                }
                            }
                        }
                        else
                        {
                            dynamic initTert = p.GetTert(_ID_SOCIETATE).Result;
                            if (!String.IsNullOrWhiteSpace(procesJson.Tert))
                            {
                                if (!String.IsNullOrWhiteSpace(procesJson.Tert) && initTert.DENUMIRE != procesJson.Tert)
                                {
                                    initTert.DENUMIRE = procesJson.Tert;
                                    toReturn = initTert.Update();
                                }
                            }
                            else
                            {
                                toReturn = initTert.Delete();
                                if (toReturn.Status)
                                {
                                    //p.ID_TERT = null;
                                    Proces.ID_TERT = null;
                                }
                            }
                        }
                    }
                }
                if (toReturn.Status)
                {
                    string s = JsonConvert.SerializeObject(Proces, Formatting.None, new Newtonsoft.Json.Converters.IsoDateTimeConverter() { DateTimeFormat = CommonFunctions.DATE_FORMAT });
                    toReturn = p.Update(s);
                }
            }
            return Json(toReturn, JsonRequestBehavior.AllowGet);
        }

        /*
        [AuthorizeUser(ActionName = "Procese", Recursive = false)]
        [HttpPost]
        public JsonResult Edit(Proces Proces)
        {
            response toReturn = new response(true, "", null, null, new List<Error>());

            string conStr = Session["conStr"].ToString(); //ConfigurationManager.ConnectionStrings["MySQLConnectionString"].ConnectionString;
            int _CURENT_USER_ID = Convert.ToInt32(Session["CURENT_USER_ID"]);

            if (Proces.ID == null) // insert
            {
                Proces p = new Proces(_CURENT_USER_ID, conStr);
                PropertyInfo[] pis = Proces.GetType().GetProperties();
                foreach (PropertyInfo pi in pis)
                {
                    pi.SetValue(p, pi.GetValue(Proces));
                }
                toReturn = p.Insert();
            }
            else //
            {
                Proces p = new Proces(_CURENT_USER_ID, conStr, Convert.ToInt32(Proces.ID));
                string s = JsonConvert.SerializeObject(Proces, Formatting.None, new Newtonsoft.Json.Converters.IsoDateTimeConverter() { DateTimeFormat = CommonFunctions.DATE_FORMAT });
                toReturn = p.Update(s);
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
            Proces p = new Proces(_CURENT_USER_ID, conStr, id);
            r = p.Delete();
            return Json(r, JsonRequestBehavior.AllowGet);
        }


        //[AuthorizeUser(ActionName = "Procese", Recursive = false)]
        //[AuthorizeToken]
        [HttpPost]
        //public void ExportProceseToExcel(ProcesView ProcesView)
        public void ExportProceseToExcel(Proces Proces, ProcesJson procesJson)
        {
            string conStr = Session["conStr"].ToString(); //ConfigurationManager.ConnectionStrings["MySQLConnectionString"].ConnectionString;
            int _CURENT_USER_ID = Convert.ToInt32(Session["CURENT_USER_ID"]);
            ProceseRepository pr = new ProceseRepository(_CURENT_USER_ID, conStr);

            string _f = CreateFilterString(JToken.FromObject(Proces), JToken.FromObject(procesJson));
            response r = pr.ExportExcel(null, null, _f, null);
            DataTable proceseDt = (DataTable)r.Result;

            using (ExcelPackage pack = new ExcelPackage())
            {
                ExcelWorksheet ws = pack.Workbook.Worksheets.Add("Procese");
                ws.Cells["A1"].LoadFromDataTable(proceseDt, true);
                var ms = new System.IO.MemoryStream();
                pack.SaveAs(ms);
                Response.BinaryWrite(ms.GetBuffer());
            }
        }


        //[AuthorizeUser(ActionName = "Procese", Recursive = false)]
        //[AuthorizeToken]
        [HttpPost]
        //public void ExportProceseToExcel(ProcesView ProcesView)
        public void ExportProceseToExcelOld(Proces Proces, ProcesJson procesJson)
        {
            string conStr = Session["conStr"].ToString(); //ConfigurationManager.ConnectionStrings["MySQLConnectionString"].ConnectionString;
            int _CURENT_USER_ID = Convert.ToInt32(Session["CURENT_USER_ID"]);

            //string jsonFilter = JsonConvert.SerializeObject(DosarView);
            /*
            JObject f = (JObject)JsonConvert.DeserializeObject(Request.Form[0]);
            response r = GetFiltered(f);
            */
            response r = GetFiltered(JToken.FromObject(Proces), JToken.FromObject(procesJson));

            ProcesExtended[] procese = (ProcesExtended[])r.Result;

            //DataTable table = (DataTable)JsonConvert.DeserializeObject(JsonConvert.SerializeObject(procese, Formatting.None, new Newtonsoft.Json.Converters.IsoDateTimeConverter() { DateTimeFormat = CommonFunctions.DATE_FORMAT }), (typeof(DataTable)));

            Proces p = new Proces();
            PropertyInfo[] pis = p.GetType().GetProperties();
            DataTable proceseDt = new DataTable("Procese");
            foreach (PropertyInfo pi in pis)
            {
                DataColumn dc = new DataColumn(pi.Name, Type.GetType("System.String"));
                proceseDt.Columns.Add(dc);
            }
            proceseDt.AcceptChanges();
            foreach (ProcesExtended pe in procese)
            {
                DataRow dr = proceseDt.NewRow();
                pis = pe.Proces.GetType().GetProperties();
                foreach (PropertyInfo pi in pis)
                {
                    try
                    {
                        dr[pi.Name] = pi.GetValue(pe.Proces) == null ? null : pi.GetValue(pe.Proces).ToString();
                    }
                    catch { dr[pi.Name] = null; }
                }
                proceseDt.Rows.Add(dr);
            }
            proceseDt.AcceptChanges();

            /*
            List<string> columns_to_remove = new List<string>();
            foreach (DataColumn dc in proceseDt.Columns)
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
                proceseDt.Columns.Remove(col_name);
            }
            */

            /*
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
            */
            proceseDt.AcceptChanges();

            using (ExcelPackage pack = new ExcelPackage())
            {
                ExcelWorksheet ws = pack.Workbook.Worksheets.Add("Procese");
                ws.Cells["A1"].LoadFromDataTable(proceseDt, true);
                var ms = new System.IO.MemoryStream();
                pack.SaveAs(ms);
                Response.BinaryWrite(ms.GetBuffer());
            }
        }
    }
}