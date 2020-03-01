using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using SOCISA;
using SOCISA.Models;

namespace socisaWeb
{
    public class ProcesStadiuView
    {
        public int? ID_DOSAR { get; set; }
        public int? ID_PROCES { get; set; }
        public ProcesStadiuExtended[] ProceseStadii { get; set; }
        public ProcesStadiuExtended CurProcesStadiu { get; set; }
        public StadiuCombo[] Stadii { get; set; }
        //public Sentinta[] Sentinte { get; set; }
        public DocumentScanatProces[] DocumenteScanateProces { get; set; }

        public ProcesStadiuView() { }

        public ProcesStadiuView(int _CURENT_USER_ID, string conStr)
        {
            StadiiRepository sr = new StadiiRepository(_CURENT_USER_ID, conStr);
            this.Stadii = (StadiuCombo[])sr.GetCombo().Result;
            //SentinteRepository senr = new SentinteRepository(_CURENT_USER_ID, conStr);
            //this.Sentinte = (Sentinta[])senr.GetAll().Result;
        }

        public ProcesStadiuView(int _CURENT_USER_ID, string conStr, int _ID, string _tip_id)
        {
            StadiiRepository sr = new StadiiRepository(_CURENT_USER_ID, conStr);
            this.Stadii = (StadiuCombo[])sr.GetCombo().Result;
            //SentinteRepository senr = new SentinteRepository(_CURENT_USER_ID, conStr);
            //this.Sentinte = (Sentinta[])senr.GetAll().Result;
            ProcesStadiu[] pss = null;
            switch (_tip_id)
            {
                case "proces":
                    this.ID_PROCES = _ID;
                    this.ID_DOSAR = null;
                    Proces p = new Proces(_CURENT_USER_ID, conStr, _ID);
                    pss = (ProcesStadiu[])p.GetStadii().Result;
                    break;
                case "dosar":
                    this.ID_PROCES = null;
                    this.ID_DOSAR = _ID;
                    Dosar d = new Dosar(_CURENT_USER_ID, conStr, _ID);
                    pss = (ProcesStadiu[])d.GetStadii().Result;
                    break;
            }
            this.ProceseStadii = new ProcesStadiuExtended[pss.Length];
            for (int i = 0; i < pss.Length; i++)
            {
                this.ProceseStadii[i] = new ProcesStadiuExtended(pss[i]);
            }
            this.CurProcesStadiu = new ProcesStadiuExtended(new ProcesStadiu());
        }
    }
}