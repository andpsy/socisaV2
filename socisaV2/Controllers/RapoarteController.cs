using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using SOCISA.Models;
using SOCISA;
using System.Reflection;
using Newtonsoft.Json.Linq;
using System.Data;
using OfficeOpenXml;
using MySql.Data.MySqlClient;
using Newtonsoft.Json;

namespace socisaWeb.Controllers
{
    //[DefaultAuthorize]
    [Authorize]
    public class RapoarteController : Controller
    {
        //[AuthorizeUser(ActionName = "Rapoarte", Recursive = false)]
        public ActionResult Index()
        {
            string conStr = Session["conStr"].ToString(); //ConfigurationManager.ConnectionStrings["MySQLConnectionString"].ConnectionString;
            int _CURENT_USER_ID = Convert.ToInt32(Session["CURENT_USER_ID"]);
            return PartialView("RapoarteView", new RaportView(_CURENT_USER_ID, conStr));
        }

        //[AuthorizeUser(ActionName = "Rapoarte", Recursive = false)]
        //[AuthorizeToken]
        public ActionResult SelectorLoader(string id)
        {
            string conStr = Session["conStr"].ToString(); //ConfigurationManager.ConnectionStrings["MySQLConnectionString"].ConnectionString;
            int _CURENT_USER_ID = Convert.ToInt32(Session["CURENT_USER_ID"]);
            string viewName = id.Replace(" ", "_") + "View";
            switch (id)
            {
                case "Raport termene":
                    return PartialView(viewName, new RaportTermeneView(_CURENT_USER_ID, conStr));
                default:
                    return PartialView(viewName);
            }            
        }

        //[AuthorizeUser(ActionName = "Rapoarte", Recursive = false)]
        //[AuthorizeToken]
        [HttpPost]
        public void RaportExcel(string FilterObject)
        {
            string conStr = Session["conStr"].ToString(); //ConfigurationManager.ConnectionStrings["MySQLConnectionString"].ConnectionString;
            int _CURENT_USER_ID = Convert.ToInt32(Session["CURENT_USER_ID"]);

            List<MySqlParameter> _parameters = new List<MySqlParameter>();
            DataAccess da = null;
            MySqlDataReader r = null;
            DataTable dt = new DataTable();

            JObject j = JObject.FromObject(JsonConvert.DeserializeObject(FilterObject, CommonFunctions.JsonDeserializerSettings));
            string tipRaport = j["TipRaport"].ToString();
            switch (tipRaport)
            {
                case "Raport termene":
                    _parameters.Add(new MySqlParameter("_TERMEN_START", CommonFunctions.ToMySqlFormatDate(Convert.ToDateTime(j["_TERMEN_START"]) )));
                    _parameters.Add(new MySqlParameter("_TERMEN_END", CommonFunctions.ToMySqlFormatDate(Convert.ToDateTime(j["_TERMEN_END"]))));
                    _parameters.Add(new MySqlParameter("_SOCIETATI", j["_SOCIETATI"] != null ? j["_SOCIETATI"].ToString() : Session["ID_SOCIETATE"].ToString()));
                    da = new DataAccess(_CURENT_USER_ID, conStr, CommandType.StoredProcedure, "RAPORTsp_termene", _parameters.ToArray());
                    r = da.ExecuteSelectQuery();
                    break;
            }
            dt.Load(r);

            using (ExcelPackage pack = new ExcelPackage())
            {
                ExcelWorksheet ws = pack.Workbook.Worksheets.Add("Sheet1");
                ws.Cells["A1"].LoadFromDataTable(dt, true);
                var ms = new System.IO.MemoryStream();
                pack.SaveAs(ms);
                Response.BinaryWrite(ms.GetBuffer());
            }
        }

    }
}