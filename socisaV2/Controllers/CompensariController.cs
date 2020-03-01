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
using System.IO;

namespace socisaWeb.Controllers
{
    //[DefaultAuthorize]
    [Authorize]
    public class CompensariController : Controller
    {
        [AuthorizeUser(ActionName = "Compensari", Recursive = false)]
        //[AuthorizeToken]
        public ActionResult Index()
        {
            string conStr = Session["conStr"].ToString(); //ConfigurationManager.ConnectionStrings["MySQLConnectionString"].ConnectionString;
            return PartialView("Compensari", new CompensariView(Convert.ToInt32(Session["CURENT_USER_ID"]), conStr));
        }

        [AuthorizeUser(ActionName = "Compensari", Recursive = false)]
        //[AuthorizeToken]
        [HttpPost]
        public void Print(string data, int tip)
        {
            try
            {
                string fileName = "";
                switch (tip)
                {
                    case 0:
                        fileName = Path.Combine(CommonFunctions.GetCompensariFolder(), String.Format("PROCES_VERBAL_{0}.pdf", data.Replace(".", "_")));
                        break;
                    case 1:
                        fileName = Path.Combine(CommonFunctions.GetCompensariFolder(), String.Format("ANEXE_{0}.pdf", data.Replace(".", "_")));
                        break;
                    case 2:
                        fileName = Path.Combine(CommonFunctions.GetCompensariFolder(), String.Format("SINTEZA_{0}.pdf", data.Replace(".", "_")));
                        break;
                }
                byte[] pdfContent = System.IO.File.ReadAllBytes(fileName);
                Response.BinaryWrite(pdfContent);
            }catch(Exception exp)
            {
                LogWriter.Log(exp);
                Response.BinaryWrite(null);
            }
        }
    }
}