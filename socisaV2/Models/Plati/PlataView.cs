using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using SOCISA;
using SOCISA.Models;

namespace socisaWeb
{
    public class PlataView
    {
        public Int32 ID_DOSAR { get; set; }
        public Nomenclator[] TipuriPlati { get; set; }
        public Plata[] Plati { get; set; }
        public Plata CurPlata { get; set; }

        public PlataView() { }

        public PlataView(int _CURENT_USER_ID, string conStr)
        {
            NomenclatoareRepository tpr = new NomenclatoareRepository(_CURENT_USER_ID, conStr);
            this.TipuriPlati = (Nomenclator[])tpr.GetAll("tip_plata").Result;
        }

        public PlataView(int _CURENT_USER_ID, int _ID_DOSAR, string conStr)
        {
            this.ID_DOSAR = _ID_DOSAR;
            NomenclatoareRepository tpr = new NomenclatoareRepository(_CURENT_USER_ID, conStr);
            this.TipuriPlati = (Nomenclator[])tpr.GetAll("tip_plata").Result;

            Dosar d = new Dosar(_CURENT_USER_ID, conStr, _ID_DOSAR);
            this.Plati = (Plata[])d.GetPlati().Result;
        }
    }
}