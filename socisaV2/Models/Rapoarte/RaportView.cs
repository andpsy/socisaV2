using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using SOCISA;
using SOCISA.Models;

namespace socisaWeb
{
    public class RaportView
    {
        public SOCISA.Models.Action[] Actions { get; set; }

        public RaportView() { }

        public RaportView(int _CURENT_USER_ID, string conStr)
        {
            RapoarteRepository rr = new RapoarteRepository(_CURENT_USER_ID, conStr);
            this.Actions = (SOCISA.Models.Action[])rr.GetMenu().Result;
        }
    }
}