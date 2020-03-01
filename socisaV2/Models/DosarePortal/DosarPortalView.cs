using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;
using Newtonsoft.Json;
using Newtonsoft.Json.Converters;
using SOCISA;
using SOCISA.Models;
using socisaV2.PortalWS;

namespace socisaWeb
{
    public class DosarPortalView
    {
        public socisaV2.PortalWS.Dosar[] Dosare {get;set;}

        public DosarPortalView()
        {
            this.Dosare = new socisaV2.PortalWS.Dosar[] { new socisaV2.PortalWS.Dosar() };
        }

        public DosarPortalView(string nr_dosar_instanta)
        {
            QuerySoapClient ws = new QuerySoapClient();

            this.Dosare = ws.CautareDosare2(nr_dosar_instanta, null, null, null, null, null, null, null);
        }
    }

    public class SedintaPortalView
    {
        public SedintaPortal[] SedintePortal { get; set; }

        public SedintaPortalView(){ }

        public SedintaPortalView(int _CURENT_USER_ID, string conStr, DateTime data)
        {
            SedintePortalRepository spr = new SedintePortalRepository(_CURENT_USER_ID, conStr);
            this.SedintePortal = (SedintaPortal[])spr.GetByDate(data).Result;
        }

        public SedintaPortalView(int _CURENT_USER_ID, string conStr, DateTime data, int? id_societate)
        {
            SedintePortalRepository spr = new SedintePortalRepository(_CURENT_USER_ID, conStr);
            this.SedintePortal = (SedintaPortal[])spr.GetByDate(data, id_societate).Result;
        }
    }

    public class ImportSedintaPortalView
    {
        public SedintaPortal SedintaPortal { get; set; }
        public socisaV2.PortalWS.Dosar Dosar { get; set; }
        public socisaV2.PortalWS.DosarSedinta DosarSedinta { get; set; }
        public Stadiu[] Stadii { get; set; }
        public ProcesStadiuExtended ProcesStadiuExtended { get; set; }
        public bool TermenAdministrativPortal { get; set; }
        public bool TermenAdministrativ { get; set; }
        public bool Sentinta { get; set; }

        public ImportSedintaPortalView() { }

        public ImportSedintaPortalView(int _CURENT_USER_ID, string conStr, int id)
        {
            this.SedintaPortal = new SedintaPortal(_CURENT_USER_ID, conStr, id);
            this.Stadii = (Stadiu[])(new StadiiRepository(_CURENT_USER_ID, conStr).GetAll().Result);
            QuerySoapClient ws = new QuerySoapClient();
            socisaV2.PortalWS.Dosar[] ds = ws.CautareDosare2(SedintaPortal.NR_DOSAR_INSTANTA, null, null, null, null, null, null, null);
            this.Dosar = ds[0];
            DosarSedinta[] dos = this.Dosar.sedinte;
            foreach (DosarSedinta d in dos)
            {
                if (d.data.Date == Convert.ToDateTime(SedintaPortal.DATA_SEDINTA).Date)
                {
                    this.DosarSedinta = d;
                    break;
                }
            }
            this.TermenAdministrativPortal = this.TermenAdministrativ = this.DosarSedinta.complet.ToLower().IndexOf("administrativ") > -1;
            this.Sentinta = this.DosarSedinta.documentSedinta != null;

            this.ProcesStadiuExtended = new ProcesStadiuExtended(new ProcesStadiu(_CURENT_USER_ID, conStr));
            this.ProcesStadiuExtended.ProcesStadiu.ID_DOSAR = this.SedintaPortal.ID_DOSAR;
            this.ProcesStadiuExtended.ProcesStadiu.ID_PROCES = this.SedintaPortal.ID_PROCES;
            this.ProcesStadiuExtended.ProcesStadiu.DATA = this.SedintaPortal.DATA;
            this.ProcesStadiuExtended.ProcesStadiu.TERMEN = this.DosarSedinta.data;
            this.ProcesStadiuExtended.ProcesStadiu.ORA = this.DosarSedinta.ora;
            this.ProcesStadiuExtended.ProcesStadiu.OBSERVATII = String.Format("{0} - {1}", this.DosarSedinta.solutie, this.DosarSedinta.solutieSumar);
            foreach (Stadiu s in this.Stadii)
            {
                if(s.DENUMIRE.ToLower().IndexOf(this.Dosar.stadiuProcesualNume.ToLower()) > -1 && s.PARENT_ID != null)
                {
                    this.ProcesStadiuExtended.ProcesStadiu.ID_STADIU = s.ID;
                    break;
                }
            }
            if (this.Sentinta)
            {
                this.ProcesStadiuExtended.Sentinta.NR_SENTINTA = this.DosarSedinta.numarDocument.ToString();
                this.ProcesStadiuExtended.Sentinta.DATA_SENTINTA = this.DosarSedinta.dataDocument;
                this.ProcesStadiuExtended.Sentinta.DATA_COMUNICARE = this.DosarSedinta.dataPronuntare;
                this.ProcesStadiuExtended.Sentinta.SOLUTIE = String.Format("{0} - {1}", this.DosarSedinta.solutie, this.DosarSedinta.solutieSumar);
            }
        }
    }
}