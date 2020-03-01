using SOCISA.Models;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Web;

namespace socisaWeb
{
    public class DosarView
    {
        public Dosar Dosar { get; set; }
        public DosarJson dosarJson { get; set; }
        public Dosar[] DosareResult { get; set; }
        //public SocietateAsigurare[] SocietatiCASCO { get; set; }
        //public SocietateAsigurare[] SocietatiRCA { get; set; }
        public SocietateAsigurare[] SocietatiAsigurare { get; set; }
        public Nomenclator[] TipuriCaz { get; set; }
        public Nomenclator[] TipuriDosar { get; set; }
        public List<string> StatusDosare { get; set; }
        public int FilteredRowsCount { get; set; }

        public DosarView() { }

        public DosarView(int _CURENT_USER_ID, string conStr)
        {
            SocietatiAsigurareRepository sar = new SocietatiAsigurareRepository(_CURENT_USER_ID, conStr);
            //this.SocietatiCASCO = this.SocietatiRCA = (SocietateAsigurare[])sar.GetAll().Result;
            this.SocietatiAsigurare = (SocietateAsigurare[])sar.GetAll().Result;
            NomenclatoareRepository nr = new NomenclatoareRepository(_CURENT_USER_ID, conStr);
            this.TipuriCaz = (Nomenclator[])nr.GetAll("tip_caz").Result;
            this.TipuriDosar = (Nomenclator[])nr.GetAll("tip_dosare").Result;
            this.StatusDosare = SOCISA.CommonFunctions.STATUS_DOSARE;
            this.DosareResult = null;
            this.Dosar = new Dosar();
            Dosar.ID_SOCIETATE_CASCO = Convert.ToInt32(HttpContext.Current.Session["ID_SOCIETATE"]);
            this.dosarJson = new DosarJson();
            this.FilteredRowsCount = 0;
        }


        public DosarView(int _CURENT_USER_ID, int _ID_SOCIETATE, string conStr):this(_CURENT_USER_ID, _ID_SOCIETATE, conStr, null)
        {

        }

        public DosarView(int _CURENT_USER_ID, int _ID_SOCIETATE, string conStr, string predefinedFilter)
        {
            if (HttpContext.Current.Session["TOKEN"] == null) // nu e request din link email notificare
            {
                SocietatiAsigurareRepository sar = new SocietatiAsigurareRepository(_CURENT_USER_ID, conStr);
                //this.SocietatiCASCO = this.SocietatiRCA = (SocietateAsigurare[])sar.GetAll().Result;
                this.SocietatiAsigurare = (SocietateAsigurare[])sar.GetAll().Result;
                NomenclatoareRepository nr = new NomenclatoareRepository(_CURENT_USER_ID, conStr);
                this.TipuriCaz = (Nomenclator[])nr.GetAll("tip_caz").Result;
                this.TipuriDosar = (Nomenclator[])nr.GetAll("tip_dosare").Result;
                this.StatusDosare = SOCISA.CommonFunctions.STATUS_DOSARE;
                try
                {
                    //daca vrem sa aducem din start inregistrari !!!
                    DosareRepository dr = new DosareRepository(_CURENT_USER_ID, conStr);
                    //string filter = String.Format(" DOSARE.ID_SOCIETATE_CASCO = {0} ", HttpContext.Current.Session["ID_SOCIETATE"]);
                    string filter = String.IsNullOrWhiteSpace(predefinedFilter) ? String.Format(" DOSARE.ID_SOCIETATE_CASCO = {0} ", HttpContext.Current.Session["ID_SOCIETATE"]) : predefinedFilter;
                    string limit = String.Format(" LIMIT 0, {0} ", (SOCISA.CommonFunctions.ROWS_BLOCK_SIZE).ToString());
                    this.DosareResult = (Dosar[])dr.GetFiltered(null, null, filter, limit).Result;
                    this.Dosar = DosareResult[0];
                    this.dosarJson = new DosarJson(_CURENT_USER_ID, _ID_SOCIETATE, conStr);
                    this.FilteredRowsCount = Convert.ToInt32(dr.CountFiltered(null, null, filter, null).Result);
                }
                catch
                {
                    this.DosareResult = null;
                    this.Dosar = new Dosar();
                    Dosar.ID_SOCIETATE_CASCO = Convert.ToInt32(HttpContext.Current.Session["ID_SOCIETATE"]);
                    this.dosarJson = new DosarJson();
                    this.FilteredRowsCount = 0;
                }
            }
            else // request din link email notificare - doar un dosar
            {
                SocietatiAsigurareRepository sar = new SocietatiAsigurareRepository(_CURENT_USER_ID, conStr);
                //this.SocietatiCASCO = this.SocietatiRCA = (SocietateAsigurare[])sar.GetAll().Result;
                this.SocietatiAsigurare = (SocietateAsigurare[])sar.GetAll().Result;
                NomenclatoareRepository nr = new NomenclatoareRepository(_CURENT_USER_ID, conStr);
                this.TipuriCaz = (Nomenclator[])nr.GetAll("tip_caz").Result;
                this.TipuriDosar = (Nomenclator[])nr.GetAll("tip_dosare").Result;
                this.StatusDosare = SOCISA.CommonFunctions.STATUS_DOSARE;
                try
                {
                    string token = HttpContext.Current.Session["TOKEN"].ToString();
                    int id_dosar = Convert.ToInt32(token.Substring(token.LastIndexOf('|') + 1));
                    Dosar d = new Dosar(_CURENT_USER_ID, conStr, id_dosar);
                    DosareResult = new Dosar[] { d };
                    Dosar = d;
                    this.dosarJson = new DosarJson(_CURENT_USER_ID, _ID_SOCIETATE, conStr);
                    this.FilteredRowsCount = 1;
                }
                catch
                {
                    DosareResult = null;
                    Dosar = new Dosar();
                    Dosar.ID_SOCIETATE_CASCO = Convert.ToInt32(HttpContext.Current.Session["ID_SOCIETATE"]);
                    dosarJson = new DosarJson();
                    FilteredRowsCount = 0;
                }
            }
        }

        public DosarView(int _CURENT_USER_ID, int _ID_SOCIETATE, Dosar dosar, string conStr)
        {
            if (HttpContext.Current.Session["TOKEN"] == null) // nu e request din link email notificare
            {
                this.Dosar = dosar;
                this.dosarJson = new DosarJson(_CURENT_USER_ID, _ID_SOCIETATE, conStr);
                SocietatiAsigurareRepository sar = new SocietatiAsigurareRepository(_CURENT_USER_ID, conStr);
                //this.SocietatiCASCO = this.SocietatiRCA = (SocietateAsigurare[])sar.GetAll().Result;
                this.SocietatiAsigurare = (SocietateAsigurare[])sar.GetAll().Result;
                NomenclatoareRepository nr = new NomenclatoareRepository(_CURENT_USER_ID, conStr);
                this.TipuriCaz = (Nomenclator[])nr.GetAll("tip_caz").Result;
                this.TipuriDosar = (Nomenclator[])nr.GetAll("tip_dosare").Result;
                this.StatusDosare = SOCISA.CommonFunctions.STATUS_DOSARE;

                //daca vrem sa aducem din start inregistrari !!!
                DosareRepository dr = new DosareRepository(_CURENT_USER_ID, conStr);
                string filter = String.Format(" DOSARE.ID_SOCIETATE_CASCO = {0} ", HttpContext.Current.Session["ID_SOCIETATE"]);
                string limit = String.Format(" LIMIT 0, {0} ", (SOCISA.CommonFunctions.ROWS_BLOCK_SIZE).ToString());
                this.DosareResult = (Dosar[])dr.GetFiltered(null, null, filter, limit).Result;
                this.FilteredRowsCount = Convert.ToInt32(dr.CountFiltered(null, null, filter, null).Result);
            }
            else // request din link email notificare - doar un dosar
            {
                SocietatiAsigurareRepository sar = new SocietatiAsigurareRepository(_CURENT_USER_ID, conStr);
                //this.SocietatiCASCO = this.SocietatiRCA = (SocietateAsigurare[])sar.GetAll().Result;
                this.SocietatiAsigurare = (SocietateAsigurare[])sar.GetAll().Result;
                NomenclatoareRepository nr = new NomenclatoareRepository(_CURENT_USER_ID, conStr);
                this.TipuriCaz = (Nomenclator[])nr.GetAll("tip_caz").Result;
                this.TipuriDosar = (Nomenclator[])nr.GetAll("tip_dosare").Result;
                this.StatusDosare = SOCISA.CommonFunctions.STATUS_DOSARE;

                this.Dosar = dosar;
                DosareResult = new Dosar[] { dosar };
                this.dosarJson = new DosarJson(_CURENT_USER_ID, _ID_SOCIETATE, conStr);
                this.FilteredRowsCount = 1;
            }
        }
    }

    public class DosarJson
    {
        public string NumeAsiguratCasco { get; set; }
        public string NumeAsiguratRca { get; set; }
        public string NumarAutoCasco { get; set; }
        public string NumarAutoRca { get; set; }
        public string NumeIntervenient { get; set; }
        [Display(Name = "DOSAR_FARA_DOCUMENTE", ResourceType = typeof(socisaV2.Resources.DosareResx))]
        public bool? DosarFaraDocumente { get; set; }
        [Display(Name = "DOSAR_FARA_PROCES", ResourceType = typeof(socisaV2.Resources.DosareResx))]
        public bool? DosarFaraProces { get; set; }

        //public string TipDosar { get; set; }
        //[Display(Name = "Data Eveniment")]
        [Display(Name = "DATA_EVENIMENT_START", ResourceType = typeof(socisaV2.Resources.DosareResx))]
        public DateTime? DataEvenimentStart { get; set; }

        //[Display(Name = "pana la:")]
        [Display(Name = "DATA_EVENIMENT_END", ResourceType = typeof(socisaV2.Resources.DosareResx))]
        public DateTime? DataEvenimentEnd { get; set; }

        //[Display(Name = "Data SCA")]
        [Display(Name = "DATA_SCA_START", ResourceType = typeof(socisaV2.Resources.DosareResx))]
        public DateTime? DataScaStart { get; set; }

        //[Display(Name = "pana la:")]
        [Display(Name = "DATA_SCA_END", ResourceType = typeof(socisaV2.Resources.DosareResx))]
        public DateTime? DataScaEnd { get; set; }

        //[Display(Name = "Data Iesire CASCO")]
        [Display(Name = "DATA_IESIRE_CASCO_START", ResourceType = typeof(socisaV2.Resources.DosareResx))]
        public DateTime? DataIesireCascoStart { get; set; }

        //[Display(Name = "pana la:")]
        [Display(Name = "DATA_IESIRE_CASCO_END", ResourceType = typeof(socisaV2.Resources.DosareResx))]
        public DateTime? DataIesireCascoEnd { get; set; }

        //[Display(Name = "Data Intrare RCA")]
        [Display(Name = "DATA_INTRARE_RCA_START", ResourceType = typeof(socisaV2.Resources.DosareResx))]
        public DateTime? DataIntrareRcaStart { get; set; }

        //[Display(Name = "pana la:")]
        [Display(Name = "DATA_INTRARE_RCA_END", ResourceType = typeof(socisaV2.Resources.DosareResx))]
        public DateTime? DataIntrareRcaEnd { get; set; }

        //[Display(Name = "Data Avizare")]
        [Display(Name = "DATA_AVIZARE_START", ResourceType = typeof(socisaV2.Resources.DosareResx))]
        public DateTime? DataAvizareStart { get; set; }

        //[Display(Name = "pana la:")]
        [Display(Name = "DATA_AVIZARE_END", ResourceType = typeof(socisaV2.Resources.DosareResx))]
        public DateTime? DataAvizareEnd { get; set; }

        //[Display(Name = "Data Notificare")]
        [Display(Name = "DATA_NOTIFICARE_START", ResourceType = typeof(socisaV2.Resources.DosareResx))]
        public DateTime? DataNotificareStart { get; set; }

        //[Display(Name = "pana la:")]
        [Display(Name = "DATA_NOTIFICARE_END", ResourceType = typeof(socisaV2.Resources.DosareResx))]
        public DateTime? DataNotificareEnd { get; set; }


        //[Display(Name = "Data Creare")]
        [Display(Name = "DATA_CREARE_START", ResourceType = typeof(socisaV2.Resources.DosareResx))]
        public DateTime? DataCreareStart { get; set; }

        //[Display(Name = "pana la:")]
        [Display(Name = "DATA_CREARE_END", ResourceType = typeof(socisaV2.Resources.DosareResx))]
        public DateTime? DataCreareEnd { get; set; }

    
        //[Display(Name = "Data Ultimei Modificari")]
        [Display(Name = "DATA_ULTIMEI_MODIFICARI_START", ResourceType = typeof(socisaV2.Resources.DosareResx))]
        public DateTime? DataUltimeiModificariStart { get; set; }

        //[Display(Name = "pana la:")]
        [Display(Name = "DATA_ULTIMEI_MODIFICARI_END", ResourceType = typeof(socisaV2.Resources.DosareResx))]
        public DateTime? DataUltimeiModificariEnd { get; set; }

        public int? LimitStart { get; set; }
        public int? LimitEnd { get; set; }

        public bool IsAvizat { get; set; }

        public string CalitateSocietate { get; set; }

        public DosarJson() { }

        public DosarJson(int _CURENT_USER_ID, int _ID_SOCIETATE, string conStr) {}
    }
}