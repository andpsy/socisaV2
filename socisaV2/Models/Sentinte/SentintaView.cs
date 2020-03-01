using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using SOCISA;
using SOCISA.Models;

namespace socisaWeb
{
    public class SentintaView
    {
        public Sentinta CurSentinta { get; set; }
        public Sentinta[] Sentinte { get; set; }

        public SentintaView() { }

        public SentintaView(int _CURENT_USER_ID, string conStr)
        {
            SentinteRepository cr = new SentinteRepository(_CURENT_USER_ID, conStr);
            this.Sentinte = (Sentinta[])cr.GetAll().Result;
        }

        public SentintaView(int _CURENT_USER_ID, int _ID_PROCES_STADIU, string conStr)
        {
            ProcesStadiu ps = new ProcesStadiu(_CURENT_USER_ID, conStr, _ID_PROCES_STADIU);
            this.CurSentinta = (Sentinta)ps.GetSentinta().Result;
            ContracteRepository cr = new ContracteRepository(_CURENT_USER_ID, conStr);
            this.Sentinte = (Sentinta[])cr.GetAll().Result;
        }
    }
}