using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using SOCISA;
using SOCISA.Models;

namespace socisaWeb
{
    public class RaportTermeneView
    {
        public SocietateAsigurare[] SocietatiAsigurare { get; set; }

        public RaportTermeneView() { }

        public RaportTermeneView(int _CURENT_USER_ID, string conStr)
        {
            SocietatiAsigurareRepository sar = new SocietatiAsigurareRepository(_CURENT_USER_ID, conStr);
            this.SocietatiAsigurare = (SocietateAsigurare[])sar.GetAll().Result;
        }
    }
}