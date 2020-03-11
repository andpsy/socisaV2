using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using SOCISA.Models;
using SOCISA;
using System.Reflection;
using Newtonsoft.Json;
using System.Data;
using OfficeOpenXml;

namespace socisaWeb.Controllers
{
    //[DefaultAuthorize]
    [Authorize]
    public class NotificariEmailController : Controller
    {
        //[AuthorizeUser(ActionName = "Administrare", Recursive = false)]
        public ActionResult Index(string id)
        {
            string conStr = Session["conStr"].ToString(); //ConfigurationManager.ConnectionStrings["MySQLConnectionString"].ConnectionString;
            int uid = Convert.ToInt32(Session["CURENT_USER_ID"]);
            NotificariEmailView nev = null;

            if (id == "null")
            {
                nev = new NotificariEmailView(uid, conStr, DateTime.Now.Date);
            }
            else
            {
                nev = new NotificariEmailView(uid, conStr, Convert.ToInt32(id));
            }
            return PartialView("NotificariEmail", nev);
        }

        //[AuthorizeUser(ActionName = "Administrare", Recursive = false)]
        [HttpPost]
        public JsonResult Filter(string _data)
        {
            try
            {
                string conStr = Session["conStr"].ToString(); //ConfigurationManager.ConnectionStrings["MySQLConnectionString"].ConnectionString;
                int uid = Convert.ToInt32(Session["CURENT_USER_ID"]);
                FilterNotificari fn = JsonConvert.DeserializeObject<FilterNotificari>(_data, CommonFunctions.JsonDeserializerSettings); 

                //DateTime d = CommonFunctions.SwitchBackFormatedDate(_data) == null ? new DateTime() : CommonFunctions.SwitchBackFormatedDate(_data).Value.Date;
                NotificariEmailView nev = new NotificariEmailView(uid, conStr, fn);
                return Json(JsonConvert.SerializeObject(nev, Formatting.None, new Newtonsoft.Json.Converters.IsoDateTimeConverter() { DateTimeFormat = CommonFunctions.DATE_FORMAT }), JsonRequestBehavior.AllowGet);
            }catch(Exception exp)
            {
                LogWriter.Log(exp);
                response r = new response(false, exp.Message, null, null, new List<Error>() { new Error(exp) });
                return Json(r, JsonRequestBehavior.AllowGet);
            }
        }

        //[AuthorizeUser(ActionName = "Administrare", Recursive = false)]
        [HttpPost]
        public JsonResult UpdateCheckDates(string _data)
        {
            EmailNotificationExtended[] EmailNotifications = JsonConvert.DeserializeObject<EmailNotificationExtended[]>(_data, CommonFunctions.JsonDeserializerSettings);

            DateTime _d = DateTime.Now;
            string conStr = Session["conStr"].ToString(); //ConfigurationManager.ConnectionStrings["MySQLConnectionString"].ConnectionString;
            int uid = Convert.ToInt32(Session["CURENT_USER_ID"]);
            /*
            EmailNotificationsRepository enr = new EmailNotificationsRepository(uid, conStr);
            response r = enr.UpdateCheckedTimes(Convert.ToDateTime(_timestamp), _d);
            */
            response r = new response(true, null, null, null, null);
            foreach(EmailNotificationExtended ene in EmailNotifications)
            {
                EmailNotification en = new EmailNotification(uid, conStr, Convert.ToInt32(ene.EmailNotification.ID));
                if (en.TIME_CHECKED == null)
                {
                    en.TIME_CHECKED = _d;
                    response rtmp = en.Update();
                    if (!rtmp.Status)
                        r.AddResponse(rtmp);
                }
            }
            return Json(r, JsonRequestBehavior.AllowGet);
        }

        //[AuthorizeUser(ActionName = "Procese", Recursive = false)]
        //[AuthorizeToken]
        [HttpPost]
        //public void ExportProceseToExcel(ProcesView ProcesView)
        public void ExportToExcel(string StrEmailNotifications)
        {
            try
            {
                //var json = JsonConvert.DeserializeObject<string>(StrEmailNotifications);
                EmailNotificationExtended[] EmailNotifications = JsonConvert.DeserializeObject<EmailNotificationExtended[]>(StrEmailNotifications, CommonFunctions.JsonDeserializerSettings);
                EmailNotification en = new EmailNotification();
                PropertyInfo[] pis = en.GetType().GetProperties();
                DataTable ensDt = new DataTable("EmailNotifications");
                DataColumn dcD = new DataColumn("NR_DOSAR_CASCO", Type.GetType("System.String"));
                ensDt.Columns.Add(dcD);
                foreach (PropertyInfo pi in pis)
                {
                    DataColumn dc = new DataColumn(pi.Name, Type.GetType("System.String"));
                    ensDt.Columns.Add(dc);
                }
                ensDt.AcceptChanges();
                foreach (EmailNotificationExtended e in EmailNotifications)
                {
                    DataRow dr = ensDt.NewRow();
                    dr["NR_DOSAR_CASCO"] = e.NR_DOSAR_CASCO;
                    pis = e.EmailNotification.GetType().GetProperties();
                    foreach (PropertyInfo pi in pis)
                    {
                        try
                        {
                            dr[pi.Name] = pi.GetValue(e.EmailNotification) == null ? null : pi.GetValue(e.EmailNotification).ToString();
                        }
                        catch { dr[pi.Name] = null; }
                    }
                    ensDt.Rows.Add(dr);
                }
                ensDt.AcceptChanges();

                using (ExcelPackage pack = new ExcelPackage())
                {
                    ExcelWorksheet ws = pack.Workbook.Worksheets.Add("EmailNotifications");
                    ws.Cells["A1"].LoadFromDataTable(ensDt, true);
                    var ms = new System.IO.MemoryStream();
                    pack.SaveAs(ms);
                    Response.BinaryWrite(ms.GetBuffer());
                }
            }catch(Exception exp)
            {
                LogWriter.Log(exp);
                Response.BinaryWrite(null);
            }
        }

    }
}