using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using SOCISA;
using SOCISA.Models;
using System.Configuration;
using Newtonsoft.Json.Linq;
using Newtonsoft.Json;
using System.Data;
using OfficeOpenXml;

namespace socisaWeb.Controllers
{
    //[DefaultAuthorize]
    [Authorize]
    public class DashboardController : Controller
    {
        [AuthorizeUser(ActionName = "Dashboard", Recursive = false)]
        //[AuthorizeToken]
        public ActionResult Index()
        {
            string conStr = Session["conStr"].ToString(); //ConfigurationManager.ConnectionStrings["MySQLConnectionString"].ConnectionString;
            Utilizator u = (Utilizator)Session["CURENT_USER"];
            DashboardJson dj = new DashboardJson(Convert.ToInt32( u.ID), Convert.ToInt32(Session["ID_SOCIETATE"]), conStr);
            /*
            DosareRepository dr = new DosareRepository(Convert.ToInt32(u.ID), conStr);
            dj.DOSARE_TOTAL = Convert.ToInt32(dr.CountAll().Result);
            dj.DOSARE_FROM_LAST_LOGIN = Convert.ToInt32(dr.CountFromLastLogin().Result);
            dj.MESAJE_NOI = 0;
            */
            return PartialView("_Dashboard", dj);
        }

        [AuthorizeUser(ActionName = "Dashboard", Recursive = false)]
        //[AuthorizeToken]
        public ActionResult IndexMain(string id)
        {
            string conStr = Session["conStr"].ToString(); //ConfigurationManager.ConnectionStrings["MySQLConnectionString"].ConnectionString;
            Utilizator u = (Utilizator)Session["CURENT_USER"];
            DashboardJson dj = new DashboardJson(Convert.ToInt32(u.ID), Convert.ToInt32(Session["ID_SOCIETATE"]), conStr);
            return PartialView("_DashboardMain", dj);
        }

        [AuthorizeUser(ActionName = "Dashboard", Recursive = false)]
        //[AuthorizeToken]
        public JsonResult Refresh()
        {
            string conStr = Session["conStr"].ToString(); //ConfigurationManager.ConnectionStrings["MySQLConnectionString"].ConnectionString;
            Utilizator u = (Utilizator)Session["CURENT_USER"];
            DashboardJson dj = new DashboardJson(Convert.ToInt32(u.ID), Convert.ToInt32(Session["ID_SOCIETATE"]), conStr);
            return Json(dj, JsonRequestBehavior.AllowGet);
        }


        [AuthorizeUser(ActionName = "Dashboard", Recursive = false)]
        public ActionResult GetDosareDashboardAdminAndSuper(int _type)
        {
            string conStr = Session["conStr"].ToString(); //ConfigurationManager.ConnectionStrings["MySQLConnectionString"].ConnectionString;
            Utilizator u = (Utilizator)Session["CURENT_USER"];
            DashBoardView dbv = new DashBoardView(u, conStr, Convert.ToInt32(Session["ID_SOCIETATE"]), _type);
            //return PartialView("_DosareDashboardAdminAndSuper", des.ToArray());
            return PartialView("_DosareDashboardAdminAndSuper", dbv);
        }

        [AuthorizeUser(ActionName = "Dashboard", Recursive = false)]
        public ActionResult GetDosareDashboardRegular()
        {
            string conStr = Session["conStr"].ToString(); //ConfigurationManager.ConnectionStrings["MySQLConnectionString"].ConnectionString;
            Utilizator u = (Utilizator)Session["CURENT_USER"];
            DashBoardView dbv = new DashBoardView(u, conStr, Convert.ToInt32(Session["ID_SOCIETATE"]), 2);
            //return PartialView("_DosareDashboardRegular", des.ToArray());
            return PartialView("_DosareDashboardRegular", dbv);
        }

        [AuthorizeUser(ActionName = "Dosare", Recursive = false)]
        //[AuthorizeToken]
        [HttpPost]
        public void ExportDosareToExcel(string _sort, string _order, string _filter, string _limit)
        {
            try
            {
                JObject jObj = (JObject)JsonConvert.DeserializeObject(_filter);
                string filterName = jObj["filterName"].ToString();
                string filterKey = jObj["filterKey"].ToString();
                object[] args = JsonConvert.DeserializeObject<object[]>(jObj["args"].ToString());
                _filter = PredefinedFilters.CreateFilter(filterName, filterKey, args);
            }
            catch { }


            string conStr = Session["conStr"].ToString(); //ConfigurationManager.ConnectionStrings["MySQLConnectionString"].ConnectionString;
            int _CURENT_USER_ID = Convert.ToInt32(Session["CURENT_USER_ID"]);

            DosareRepository dr = new DosareRepository(_CURENT_USER_ID, conStr);
            //Dosar[] dosare = (Dosar[])dr.GetFiltered(null, null, String.Format(" DOSARE.DATA_SCA = '{0}' AND DOSARE.ID_SOCIETATE_CASCO = '{1}' AND DOSARE.ID_SOCIETATE_RCA = '{2}' ", CommonFunctions.ToMySqlFormatDate(d), Convert.ToInt32(Session["ID_SOCIETATE"]), Convert.ToInt32(id_soc_rca)), null).Result;
            Dosar[] dosare = (Dosar[])dr.GetFiltered(_sort, _order, _filter, _limit).Result;

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

        [AuthorizeUser(ActionName = "Dosare", Recursive = false)]
        //[AuthorizeToken]
        [HttpPost]
        public void ExportTermeneToExcel(string _sort, string _order, string _filter, string _limit)
        {
            string conStr = Session["conStr"].ToString(); //ConfigurationManager.ConnectionStrings["MySQLConnectionString"].ConnectionString;
            int _CURENT_USER_ID = Convert.ToInt32(Session["CURENT_USER_ID"]);
            int sid = Convert.ToInt32(Session["ID_SOCIETATE"]);

            SedintaPortalView spv = new SedintaPortalView(_CURENT_USER_ID, conStr, DateTime.Now.Date, sid);
            
            DataTable table = (DataTable)JsonConvert.DeserializeObject(JsonConvert.SerializeObject(spv.SedintePortal, Formatting.None, new Newtonsoft.Json.Converters.IsoDateTimeConverter() { DateTimeFormat = SOCISA.CommonFunctions.DATE_FORMAT }), (typeof(DataTable)));
            List<string> columns_to_remove = new List<string>();
            foreach (DataColumn dc in table.Columns)
            {
                if (
                    !dc.ColumnName.ToLower().Equals("data") &&
                    !dc.ColumnName.ToLower().Contains("data_sedinta") &&
                    !dc.ColumnName.ToLower().Contains("instanta") &&
                    !dc.ColumnName.ToLower().Contains("ora") &&
                    !dc.ColumnName.ToLower().Contains("complet") &&
                    !dc.ColumnName.ToLower().Contains("nr_dosar_casco") &&
                    !dc.ColumnName.ToLower().Contains("nr_dosar_instanta") &&
                    !dc.ColumnName.ToLower().Contains("monitorizare")
                )
                {
                    columns_to_remove.Add(dc.ColumnName);
                }
            }
            foreach (string col_name in columns_to_remove)
            {
                table.Columns.Remove(col_name);
            }

            using (ExcelPackage pack = new ExcelPackage())
            {
                ExcelWorksheet ws = pack.Workbook.Worksheets.Add("Termene");
                ws.Cells["A1"].LoadFromDataTable(table, true);
                var ms = new System.IO.MemoryStream();
                pack.SaveAs(ms);
                Response.BinaryWrite(ms.GetBuffer());
            }
        }

        [AuthorizeUser(ActionName = "Procese", Recursive = false)]
        //[AuthorizeToken]
        [HttpPost]
        public void ExportProceseToExcel(string _sort, string _order, string _filter, string _limit)
        {
            try
            {
                JObject jObj = (JObject)JsonConvert.DeserializeObject(_filter);
                string filterName = jObj["filterName"].ToString();
                string filterKey = jObj["filterKey"].ToString();
                object[] args = JsonConvert.DeserializeObject<object[]>(jObj["args"].ToString());
                _filter = PredefinedFilters.CreateFilter(filterName, filterKey, args);
            }
            catch { }


            string conStr = Session["conStr"].ToString(); //ConfigurationManager.ConnectionStrings["MySQLConnectionString"].ConnectionString;
            int _CURENT_USER_ID = Convert.ToInt32(Session["CURENT_USER_ID"]);

            ProceseRepository pr = new ProceseRepository(_CURENT_USER_ID, conStr);
            Proces[] procese = (Proces[])pr.GetFiltered(_sort, _order, _filter, _limit).Result;

            DataTable table = (DataTable)JsonConvert.DeserializeObject(JsonConvert.SerializeObject(procese, Formatting.None, new Newtonsoft.Json.Converters.IsoDateTimeConverter() { DateTimeFormat = SOCISA.CommonFunctions.DATE_FORMAT }), (typeof(DataTable)));
            List<string> columns_to_remove = new List<string>();
            foreach (DataColumn dc in table.Columns)
            {
                if (dc.ColumnName.ToLower().IndexOf("id") > -1)
                {
                    columns_to_remove.Add(dc.ColumnName);
                }
            }
            foreach (string col_name in columns_to_remove)
            {
                table.Columns.Remove(col_name);
            }
            // TO DO: add external fields !!!
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
            table.AcceptChanges();
            using (ExcelPackage pack = new ExcelPackage())
            {
                ExcelWorksheet ws = pack.Workbook.Worksheets.Add("Procese");
                ws.Cells["A1"].LoadFromDataTable(table, true);
                var ms = new System.IO.MemoryStream();
                pack.SaveAs(ms);
                Response.BinaryWrite(ms.GetBuffer());
            }
        }
    }
}