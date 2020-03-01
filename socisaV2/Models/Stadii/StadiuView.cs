using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using SOCISA;
using SOCISA.Models;

namespace socisaWeb
{
    public class StadiuView
    {
        public Stadiu[] Stadii { get; set; }
        public Stadiu CurStadiu { get; set; }

        public StadiuView() { }

        public StadiuView(int _CURENT_USER_ID, string conStr)
        {
            StadiiRepository sr = new StadiiRepository(_CURENT_USER_ID, conStr);
            this.Stadii = (Stadiu[])sr.GetAll().Result;
        }
    }
}