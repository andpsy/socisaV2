using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using SOCISA;
using SOCISA.Models;

namespace socisaWeb.Controllers
{
    //[DefaultAuthorize]
    [Authorize]
    public class ActionsController : Controller
    {
        [AuthorizeUser(ActionName = "Dashboard", Recursive = false)]
        public ActionResult Index()
        {
            Utilizator u = (Utilizator)Session["CURENT_USER"];
            if (u != null)
            {
                SOCISA.Models.Action[] actions = (SOCISA.Models.Action[])u.GetActions().Result;
                return PartialView("_ActionsMenu", actions);
            }
            return PartialView("_ActionsMenu", null);
        }

        [AuthorizeUser(ActionName = "Dashboard", Recursive = false)]
        public ActionResult IndexNavBar()
        {
            Utilizator u = (Utilizator)Session["CURENT_USER"];
            if (u != null)
            {
                SOCISA.Models.Action[] actions = (SOCISA.Models.Action[])u.GetActions().Result;
                return PartialView("_ActionsMenuNavBar", actions);
            }
            return PartialView("_ActionsMenuNavBar", null);
        }

    }
}