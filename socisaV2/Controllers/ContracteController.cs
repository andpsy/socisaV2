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
    public class ContracteController : Controller
    {
        //[AuthorizeUser(ActionName = "Contracte", Recursive = false)]
        public ActionResult Index()
        {
            string conStr = Session["conStr"].ToString(); //ConfigurationManager.ConnectionStrings["MySQLConnectionString"].ConnectionString;
            var toReturn = PartialView("ContracteView", new ContractView(Convert.ToInt32(Session["CURENT_USER_ID"]), conStr));
            return toReturn;
        }

        //[AuthorizeUser(ActionName = "Contracte", Recursive = false)]
        public JsonResult Details(int id) // id proces
        {
            string conStr = Session["conStr"].ToString(); //ConfigurationManager.ConnectionStrings["MySQLConnectionString"].ConnectionString;
            ContractView cv = new ContractView(Convert.ToInt32(Session["CURENT_USER_ID"]), id, conStr);
            JsonResult result = Json(Newtonsoft.Json.JsonConvert.SerializeObject(cv, Newtonsoft.Json.Formatting.None, new Newtonsoft.Json.Converters.IsoDateTimeConverter() { DateTimeFormat = SOCISA.CommonFunctions.DATE_FORMAT }), JsonRequestBehavior.AllowGet);
            result.MaxJsonLength = Int32.MaxValue;
            return result;
        }

        [AuthorizeUser(ActionName = "Contracte", Recursive = false)]
        [HttpPost]
        public JsonResult Edit(Contract Contract)
        {
            response toReturn = new response(true, "", null, null, new List<Error>());

            string conStr = Session["conStr"].ToString(); //ConfigurationManager.ConnectionStrings["MySQLConnectionString"].ConnectionString;
            int _CURENT_USER_ID = Convert.ToInt32(Session["CURENT_USER_ID"]);

            if (Contract.ID == null) // insert
            {
                Contract p = new Contract(_CURENT_USER_ID, conStr);
                PropertyInfo[] pis = Contract.GetType().GetProperties();
                foreach (PropertyInfo pi in pis)
                {
                    pi.SetValue(p, pi.GetValue(Contract));
                }
                toReturn = p.Insert();
            }
            else //
            {
                Contract p = new Contract(_CURENT_USER_ID, conStr, Convert.ToInt32(Contract.ID));
                string s = JsonConvert.SerializeObject(Contract, Formatting.None, new Newtonsoft.Json.Converters.IsoDateTimeConverter() { DateTimeFormat = CommonFunctions.DATE_FORMAT });
                toReturn = p.Update(s);
            }
            return Json(toReturn, JsonRequestBehavior.AllowGet);
        }

        [AuthorizeUser(ActionName = "Contracte", Recursive = false)]
        [HttpPost]
        public JsonResult Delete(int id)
        {
            response r = new response();
            string conStr = Session["conStr"].ToString(); //ConfigurationManager.ConnectionStrings["MySQLConnectionString"].ConnectionString;
            int _CURENT_USER_ID = Convert.ToInt32(Session["CURENT_USER_ID"]);
            //DosareRepository dr = new DosareRepository(_CURENT_USER_ID, conStr);
            Contract p = new Contract(_CURENT_USER_ID, conStr, id);
            r = p.Delete();
            return Json(r, JsonRequestBehavior.AllowGet);
        }
    }
}