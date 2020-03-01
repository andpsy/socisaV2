using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;
using SOCISA;
using SOCISA.Models;

namespace socisaWeb
{
    public class ProcesView
    {
        public int? ID_DOSAR { get; set; }
        public int? ID_PROCES { get; set; }
        public Nomenclator[] TipuriProcese { get; set; }
        public Nomenclator[] Instante { get; set; }
        public Nomenclator[] Complete { get; set; }
        public StadiuCombo[] Stadii { get; set; }
        //public ProcesExtended[] Procese { get; set; }
        public Proces[] Procese { get; set; }
        public ProcesExtended CurProces { get; set; }
        public ProcesJson procesJson { get; set; }
        public int FilteredRowsCount { get; set; }
        //public Dosar Dosar { get; set; }

        //public Contract[] Contracte { get; set; }
        public string[] TipDocumenteScanateProcese { get; set; }

        //public Parte[] Parti { get; set; }
        public Nomenclator[] Calitati { get; set; }
        public SocietateAsigurare Societate { get; set; }

        public ProcesView() {
            this.TipuriProcese = this.Instante = this.Complete = this.Calitati = (new List<Nomenclator>()).ToArray();
            this.Stadii = (new List<StadiuCombo>()).ToArray();
            //this.Contracte = (new List<Contract>()).ToArray();
            this.TipDocumenteScanateProcese = (new List<string>()).ToArray();
            //this.Parti = (new List<Parte>()).ToArray();
            this.Societate = new SocietateAsigurare();
            this.Procese = null;
            this.CurProces = new ProcesExtended(new Proces());
            this.FilteredRowsCount = 0;
            this.procesJson = new ProcesJson();
        }

        public ProcesView(int _CURENT_USER_ID, string conStr) : this(_CURENT_USER_ID, conStr, null) { }


        public ProcesView(int _CURENT_USER_ID, string conStr, string predefinedFilter)
        {
            NomenclatoareRepository tpr = new NomenclatoareRepository(_CURENT_USER_ID, conStr);
            this.TipuriProcese = (Nomenclator[])tpr.GetAll("tip_procese").Result;
            this.Instante = (Nomenclator[])tpr.GetAll("instante").Result;
            this.Complete = (Nomenclator[])tpr.GetAll("complete").Result;
            //ContracteRepository cr = new ContracteRepository(_CURENT_USER_ID, conStr);
            //this.Contracte = (Contract[])cr.GetAll().Result;
            ProceseRepository pr = new ProceseRepository(_CURENT_USER_ID, conStr);
            this.TipDocumenteScanateProcese = (string[])pr.GetTipDocumenteScanatePocese().Result;
            //PartiRepository par = new PartiRepository(_CURENT_USER_ID, conStr);
            //this.Parti = (Parte[])par.GetAll().Result;
            this.Calitati = (Nomenclator[])tpr.GetAll("calitati").Result;
            //Utilizator u = new Utilizator(_CURENT_USER_ID, conStr, _CURENT_USER_ID);
            //this.Societate = (SocietateAsigurare)u.GetSocietatiAsigurare().Result;
            this.Societate = new SocietateAsigurare(_CURENT_USER_ID, conStr, Convert.ToInt32(HttpContext.Current.Session["ID_SOCIETATE"]));
            //this.CurProces = new ProcesExtended(new Proces());
            //this.procesJson = new ProcesJson();
            StadiiRepository sr = new StadiiRepository(_CURENT_USER_ID, conStr);
            this.Stadii = (StadiuCombo[])sr.GetCombo().Result;

            this.Procese = null;
            this.CurProces = new ProcesExtended(new Proces());
            this.FilteredRowsCount = 0;
            this.procesJson = new ProcesJson();

            if (predefinedFilter != "empty")
            {
                try
                {
                    //daca vrem sa aducem din start inregistrari !!!
                    string initFilter = String.Format(" ((PROCESE.ID_DOSAR IS NULL AND (PROCESE.ID_RECLAMANT={0} OR PROCESE.ID_PARAT={0} OR PROCESE.ID_TERT={0})) OR (PROCESE.ID_DOSAR IS NOT NULL AND (DOSARE.ID_SOCIETATE_CASCO={0} OR DOSARE.ID_SOCIETATE_RCA={0}))) ", Convert.ToInt32(HttpContext.Current.Session["ID_SOCIETATE"]));

                    ProceseRepository prep = new ProceseRepository(_CURENT_USER_ID, conStr);
                    string filter = String.IsNullOrWhiteSpace(predefinedFilter) ? initFilter : predefinedFilter;
                    string limit = String.Format(" LIMIT 0, {0} ", (CommonFunctions.ROWS_BLOCK_SIZE).ToString());
                    /*
                    this.Procese = (ProcesExtended[])prep.GetFilteredExtended(null, null, filter, limit).Result;
                    this.CurProces = this.Procese[0];
                    */
                    this.Procese = (Proces[])prep.GetFiltered(null, null, filter, limit).Result;
                    this.CurProces = new ProcesExtended(this.Procese[0]);
                    this.FilteredRowsCount = Convert.ToInt32(prep.CountFiltered(null, null, filter, null).Result);
                    this.procesJson = new ProcesJson();
                }
                catch
                {
                    this.Procese = null;
                    this.CurProces = new ProcesExtended(new Proces());
                    this.FilteredRowsCount = 0;
                    this.procesJson = new ProcesJson();
                }
            }
        }

        public ProcesView(int _CURENT_USER_ID, string conStr, int _ID_DOSAR) : this(_CURENT_USER_ID, conStr, _ID_DOSAR, null)
        {
        }

        public ProcesView(int _CURENT_USER_ID, string conStr, int? _ID_DOSAR, int? _ID_PROCES)
        {
            NomenclatoareRepository tpr = new NomenclatoareRepository(_CURENT_USER_ID, conStr);
            this.TipuriProcese = (Nomenclator[])tpr.GetAll("tip_procese").Result;
            this.Instante = (Nomenclator[])tpr.GetAll("instante").Result;
            this.Complete = (Nomenclator[])tpr.GetAll("complete").Result;
            //ContracteRepository cr = new ContracteRepository(_CURENT_USER_ID, conStr);
            //this.Contracte = (Contract[])cr.GetAll().Result;
            ProceseRepository pr = new ProceseRepository(_CURENT_USER_ID, conStr);
            this.TipDocumenteScanateProcese = (string[])pr.GetTipDocumenteScanatePocese().Result;
            //PartiRepository par = new PartiRepository(_CURENT_USER_ID, conStr);
            //this.Parti = (Parte[])par.GetAll().Result;
            this.Calitati = (Nomenclator[])tpr.GetAll("calitati").Result;
            ////Utilizator u = new Utilizator(_CURENT_USER_ID, conStr, _CURENT_USER_ID);
            ////this.Societate = (SocietateAsigurare)u.GetSocietatiAsigurare().Result;
            this.Societate = new SocietateAsigurare(_CURENT_USER_ID, conStr, Convert.ToInt32(HttpContext.Current.Session["ID_SOCIETATE"]));
            StadiiRepository sr = new StadiiRepository(_CURENT_USER_ID, conStr);
            this.Stadii = (StadiuCombo[])sr.GetCombo().Result;

            this.CurProces = new ProcesExtended(new Proces());
            this.procesJson = new ProcesJson();
            if (_ID_DOSAR != null && _ID_PROCES == null)
            {
                this.ID_DOSAR = Convert.ToInt32(_ID_DOSAR);
                this.ID_PROCES = null;
                Dosar d = new Dosar(_CURENT_USER_ID, conStr, Convert.ToInt32(_ID_DOSAR));
                //this.Dosar = d;
                this.Procese = (Proces[])d.GetProcese().Result;
                /*
                Proces[] ps = (Proces[])d.GetProcese().Result;
                this.Procese = new ProcesExtended[ps.Length];
                for (int i = 0; i < ps.Length; i++)
                {
                    this.Procese[i] = new ProcesExtended(ps[i]);
                }
                */
                this.procesJson = new ProcesJson();
                this.procesJson.Calitate = d.ID_SOCIETATE_CASCO == Societate.ID ? "RECLAMANT" : "PARAT";
                SocietateAsigurare cealaltaSocietate = new SocietateAsigurare(_CURENT_USER_ID, conStr, Convert.ToInt32(d.ID_SOCIETATE_CASCO == Societate.ID ? d.ID_SOCIETATE_RCA : d.ID_SOCIETATE_CASCO));
                this.procesJson.Reclamant = d.ID_SOCIETATE_CASCO == Societate.ID ? Societate.DENUMIRE : cealaltaSocietate.DENUMIRE;
                this.procesJson.Parat = d.ID_SOCIETATE_CASCO == Societate.ID ? cealaltaSocietate.DENUMIRE : Societate.DENUMIRE;
                this.procesJson.Tert = "";
            }
            if (_ID_DOSAR == null && _ID_PROCES != null)
            {
                this.ID_PROCES = Convert.ToInt32(_ID_PROCES);
                this.ID_DOSAR = null;

                this.procesJson.Reclamant = "";
                this.procesJson.Parat = "";
                this.procesJson.Tert = "";
            }
        }
    }

    public class ProcesJson
    {
        public string Reclamant { get; set; }
        public string Parat { get; set; }
        public string Tert { get; set; }
        public string TipProces { get; set; }
        public string Complet { get; set; }
        public string Instanta { get; set; }
        public string Contract { get; set; }
        public string Calitate { get; set; }
        public int? Stadiu { get; set; }
        public string DataStadiu { get; set; }

        [Display(Name = "DATA_SCA_START", ResourceType = typeof(socisaV2.Resources.ProceseResx))]
        public DateTime? DataScaStart { get; set; }

        [Display(Name = "DATA_SCA_END", ResourceType = typeof(socisaV2.Resources.ProceseResx))]
        public DateTime? DataScaEnd { get; set; }

        [Display(Name = "DATA_DEPUNERE_START", ResourceType = typeof(socisaV2.Resources.ProceseResx))]
        public DateTime? DataDepunereStart { get; set; }

        [Display(Name = "DATA_DEPUNERE_END", ResourceType = typeof(socisaV2.Resources.ProceseResx))]
        public DateTime? DataDepunereEnd { get; set; }

        [Display(Name = "DATA_EXECUTARE_START", ResourceType = typeof(socisaV2.Resources.ProceseResx))]
        public DateTime? DataExecutareStart { get; set; }

        [Display(Name = "DATA_EXECUTARE_END", ResourceType = typeof(socisaV2.Resources.ProceseResx))]
        public DateTime? DataExecutareEnd { get; set; }

        [Display(Name = "DATA_STADIU_START", ResourceType = typeof(socisaV2.Resources.ProceseResx))]
        public DateTime? DataStadiuStart { get; set; }

        [Display(Name = "DATA_STADIU_END", ResourceType = typeof(socisaV2.Resources.ProceseResx))]
        public DateTime? DataStadiuEnd { get; set; }


        public int? LimitStart { get; set; }
        public int? LimitEnd { get; set; }

        public ProcesJson() { }

        public ProcesJson(int _CURENT_USER_ID, int _ID_SOCIETATE, string conStr) { }
    }
}