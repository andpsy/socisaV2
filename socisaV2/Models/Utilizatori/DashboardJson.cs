using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations;
using SOCISA;
using SOCISA.Models;

namespace socisaWeb
{
    public class DashboardJson
    {
        //[Display(Name = "Total dosare in baza de date")]
        [Display(Name = "DOSARE_TOTAL", ResourceType = typeof(socisaV2.Resources.DashboardResx))]
        public int DOSARE_TOTAL { get; set; }

        //[Display(Name = "Total dosare CASCO in baza de date")]
        [Display(Name = "DOSARE_CASCO_TOTAL", ResourceType = typeof(socisaV2.Resources.DashboardResx))]
        public int DOSARE_CASCO_TOTAL { get; set; }

        //[Display(Name = "Total dosare RCA in baza de date")]
        [Display(Name = "DOSARE_RCA_TOTAL", ResourceType = typeof(socisaV2.Resources.DashboardResx))]
        public int DOSARE_RCA_TOTAL { get; set; }

        // -- doar pt. Admin si Super --

        //[Display(Name = "Dosare neasignate")]
        [Display(Name = "DOSARE_NEASIGNATE", ResourceType = typeof(socisaV2.Resources.DashboardResx))]
        public int DOSARE_NEASIGNATE { get; set; }

        //[Display(Name = "Dosare CASCO neasignate")]
        [Display(Name = "DOSARE_CASCO_NEASIGNATE", ResourceType = typeof(socisaV2.Resources.DashboardResx))]
        public int DOSARE_CASCO_NEASIGNATE { get; set; }

        //[Display(Name = "Dosare RCA neasignate")]
        [Display(Name = "DOSARE_CASCO_NEASIGNATE", ResourceType = typeof(socisaV2.Resources.DashboardResx))]
        public int DOSARE_RCA_NEASIGNATE { get; set; }

        //[Display(Name = "Dosare neasignate de la ultimul login")]
        [Display(Name = "DOSARE_CASCO_NEASIGNATE", ResourceType = typeof(socisaV2.Resources.DashboardResx))]
        public int DOSARE_NEASIGNATE_FROM_LAST_LOGIN { get; set; }

        //[Display(Name = "Dosare CASCO neasignate de la ultimul login")]
        [Display(Name = "DOSARE_NEASIGNATE_CASCO_FROM_LAST_LOGIN", ResourceType = typeof(socisaV2.Resources.DashboardResx))]
        public int DOSARE_NEASIGNATE_CASCO_FROM_LAST_LOGIN { get; set; }

        //[Display(Name = "Dosare RCA neasignate de la ultimul login")]
        [Display(Name = "DOSARE_NEASIGNATE_RCA_FROM_LAST_LOGIN", ResourceType = typeof(socisaV2.Resources.DashboardResx))]
        public int DOSARE_NEASIGNATE_RCA_FROM_LAST_LOGIN { get; set; }

        // -- pt. All --

        //[Display(Name = "Dosare noi de la ultimul login")]
        [Display(Name = "DOSARE_FROM_LAST_LOGIN", ResourceType = typeof(socisaV2.Resources.DashboardResx))]
        public int DOSARE_FROM_LAST_LOGIN { get; set; }

        //[Display(Name = "Dosare CASCO noi de la ultimul login")]
        [Display(Name = "DOSARE_CASCO_FROM_LAST_LOGIN", ResourceType = typeof(socisaV2.Resources.DashboardResx))]
        public int DOSARE_CASCO_FROM_LAST_LOGIN { get; set; }

        //[Display(Name = "Dosare RCA noi de la ultimul login")]
        [Display(Name = "DOSARE_RCA_FROM_LAST_LOGIN", ResourceType = typeof(socisaV2.Resources.DashboardResx))]
        public int DOSARE_RCA_FROM_LAST_LOGIN { get; set; }

        //[Display(Name = "Dosare neoperate")]
        [Display(Name = "DOSARE_NEOPERATE", ResourceType = typeof(socisaV2.Resources.DashboardResx))]
        public int DOSARE_NEOPERATE { get; set; }

        //[Display(Name = "Dosare CASCO neoperate")]
        [Display(Name = "DOSARE_CASCO_NEOPERATE", ResourceType = typeof(socisaV2.Resources.DashboardResx))]
        public int DOSARE_CASCO_NEOPERATE { get; set; }

        //[Display(Name = "Dosare RCA neoperate")]
        [Display(Name = "DOSARE_RCA_NEOPERATE", ResourceType = typeof(socisaV2.Resources.DashboardResx))]
        public int DOSARE_RCA_NEOPERATE { get; set; }

        //[Display(Name = "Mesaje noi")]
        [Display(Name = "MESAJE_NOI", ResourceType = typeof(socisaV2.Resources.DashboardResx))]
        public int MESAJE_NOI { get; set; }

        //[Display(Name = "Mesaje noi (DOSAR NOU)")]
        [Display(Name = "MESAJE_NOI_DOSAR_NOU", ResourceType = typeof(socisaV2.Resources.DashboardResx))]
        public int MESAJE_NOI_DOSAR_NOU { get; set; }

        //[Display(Name = "Mesaje noi (DOCUMENT NOU)")]
        [Display(Name = "MESAJE_NOI_DOCUMENT_NOU", ResourceType = typeof(socisaV2.Resources.DashboardResx))]
        public int MESAJE_NOI_DOCUMENT_NOU { get; set; }

        //[Display(Name = "Total procese in baza de date")]
        [Display(Name = "PROCESE_TOTAL", ResourceType = typeof(socisaV2.Resources.DashboardResx))]
        public int PROCESE_TOTAL { get; set; }

        //[Display(Name = "Total procese Reclamant")]
        [Display(Name = "PROCESE_RECLAMANT_TOTAL", ResourceType = typeof(socisaV2.Resources.DashboardResx))]
        public int PROCESE_RECLAMANT_TOTAL { get; set; }

        //[Display(Name = "Total procese Parat")]
        [Display(Name = "PROCESE_PARAT_TOTAL", ResourceType = typeof(socisaV2.Resources.DashboardResx))]
        public int PROCESE_PARAT_TOTAL { get; set; }

        //[Display(Name = "Total procese noi")]
        [Display(Name = "PROCESE_NOI_TOTAL", ResourceType = typeof(socisaV2.Resources.DashboardResx))]
        public int PROCESE_NOI_TOTAL { get; set; }

        /* -- PENTRU STATUS DOSARE -- */
        [Display(Name = "DOSARE_INCOMPLETE", ResourceType = typeof(socisaV2.Resources.DashboardResx))]
        public int DOSARE_INCOMPLETE { get; set; }
        [Display(Name = "DOSARE_NEAVIZATE", ResourceType = typeof(socisaV2.Resources.DashboardResx))]
        public int DOSARE_NEAVIZATE { get; set; }
        [Display(Name = "DOSARE_AVIZATE", ResourceType = typeof(socisaV2.Resources.DashboardResx))]
        public int DOSARE_AVIZATE { get; set; }
        [Display(Name = "DOSARE_AVIZATE_NEEXPEDIATE", ResourceType = typeof(socisaV2.Resources.DashboardResx))]
        public int DOSARE_AVIZATE_NEEXPEDIATE { get; set; }
        [Display(Name = "DOSARE_NEACHITATE", ResourceType = typeof(socisaV2.Resources.DashboardResx))]
        public int DOSARE_NEACHITATE { get; set; }
        [Display(Name = "DOSARE_ACHITATE_PARTIAL", ResourceType = typeof(socisaV2.Resources.DashboardResx))]
        public int DOSARE_ACHITATE_PARTIAL { get; set; }
        [Display(Name = "DOSARE_ACHITATE", ResourceType = typeof(socisaV2.Resources.DashboardResx))]
        public int DOSARE_ACHITATE { get; set; }
        [Display(Name = "DOSARE_AVIZATE_TOTAL", ResourceType = typeof(socisaV2.Resources.DashboardResx))]
        public int DOSARE_AVIZATE_TOTAL { get; set; }

        [Display(Name = "DOSARE_FARA_DOCUMENTE", ResourceType = typeof(socisaV2.Resources.DashboardResx))]
        public int DOSARE_FARA_DOCUMENTE { get; set; }
        [Display(Name = "DOSARE_FARA_PROCES", ResourceType = typeof(socisaV2.Resources.DashboardResx))]
        public int DOSARE_FARA_PROCES { get; set; }
        /* --- */

        /* -- PENTRU TERMENE -- */
        [Display(Name = "TERMENE_IN_URMATOARELE_7_ZILE", ResourceType = typeof(socisaV2.Resources.DashboardResx))]
        public int TERMENE_IN_URMATOARELE_7_ZILE { get; set; }
        [Display(Name = "TERMENE_DEPASITE", ResourceType = typeof(socisaV2.Resources.DashboardResx))]
        public int TERMENE_DEPASITE { get; set; }
        /* --- */

        public List<string> LABELS_STATUS;
        public List<int> VALUES_STATUS;
        public List<string> LABELS_STATUS_AVIZATE;
        public List<int> VALUES_STATUS_AVIZATE;


        public DashboardJson() { }

        public DashboardJson(int ID_UTILIZATOR, int ID_SOCIETATE, string conStr)
        {
            DataAccess da = new DataAccess(ID_UTILIZATOR, conStr, System.Data.CommandType.StoredProcedure, "DASHBOARDsp_select", new object[] { new MySql.Data.MySqlClient.MySqlParameter("_ID_SOCIETATE", ID_SOCIETATE), new MySql.Data.MySqlClient.MySqlParameter("_EXPIRATION_DAYS", 15) }); // TO DO: de adaugat parametru in setari !!!
            MySql.Data.MySqlClient.MySqlDataReader r = da.ExecuteSelectQuery();
            while (r.Read())
            {
                System.Data.IDataRecord dj = (System.Data.IDataRecord)r;
                try { this.DOSARE_TOTAL = Convert.ToInt32(dj["DOSARE_TOTAL"]); }
                catch { }
                try { this.DOSARE_CASCO_TOTAL = Convert.ToInt32(dj["DOSARE_CASCO_TOTAL"]); }
                catch { }
                try { this.DOSARE_RCA_TOTAL = Convert.ToInt32(dj["DOSARE_RCA_TOTAL"]); }
                catch { }

                // -- doar pt. Admin si Super --
                try { this.DOSARE_NEASIGNATE = Convert.ToInt32(dj["DOSARE_NEASIGNATE"]); }
                catch { }
                try { this.DOSARE_CASCO_NEASIGNATE = Convert.ToInt32(dj["DOSARE_CASCO_NEASIGNATE"]); }
                catch { }
                try { this.DOSARE_RCA_NEASIGNATE = Convert.ToInt32(dj["DOSARE_RCA_NEASIGNATE"]); }
                catch { }

                try { this.DOSARE_NEASIGNATE_FROM_LAST_LOGIN = Convert.ToInt32(dj["DOSARE_NEASIGNATE_FROM_LAST_LOGIN"]); }
                catch { }
                try { this.DOSARE_NEASIGNATE_CASCO_FROM_LAST_LOGIN = Convert.ToInt32(dj["DOSARE_NEASIGNATE_CASCO_FROM_LAST_LOGIN"]); }
                catch { }
                try { this.DOSARE_NEASIGNATE_RCA_FROM_LAST_LOGIN = Convert.ToInt32(dj["DOSARE_NEASIGNATE_RCA_FROM_LAST_LOGIN"]); }
                catch { }

                // -- pt. All --
                try { this.DOSARE_FROM_LAST_LOGIN = Convert.ToInt32(dj["DOSARE_FROM_LAST_LOGIN"]); }
                catch { }
                try { this.DOSARE_CASCO_FROM_LAST_LOGIN = Convert.ToInt32(dj["DOSARE_CASCO_FROM_LAST_LOGIN"]); }
                catch { }
                try { this.DOSARE_RCA_FROM_LAST_LOGIN = Convert.ToInt32(dj["DOSARE_RCA_FROM_LAST_LOGIN"]); }
                catch { }

                try { this.DOSARE_NEOPERATE = Convert.ToInt32(dj["DOSARE_NEOPERATE"]); }
                catch { this.DOSARE_NEOPERATE = 0; }
                try { this.DOSARE_CASCO_NEOPERATE = Convert.ToInt32(dj["DOSARE_CASCO_NEOPERATE"]); }
                catch { this.DOSARE_CASCO_NEOPERATE = 0; }
                try { this.DOSARE_RCA_NEOPERATE = Convert.ToInt32(dj["DOSARE_RCA_NEOPERATE"]); }
                catch { this.DOSARE_RCA_NEOPERATE = 0; }

                try { this.PROCESE_TOTAL = Convert.ToInt32(dj["PROCESE_TOTAL"]); }
                catch { this.PROCESE_TOTAL = 0; }
                try { this.PROCESE_RECLAMANT_TOTAL = Convert.ToInt32(dj["PROCESE_RECLAMANT_TOTAL"]); }
                catch { this.PROCESE_RECLAMANT_TOTAL = 0; }
                try { this.PROCESE_PARAT_TOTAL = Convert.ToInt32(dj["PROCESE_PARAT_TOTAL"]); }
                catch { this.PROCESE_PARAT_TOTAL = 0; }
                try { this.PROCESE_NOI_TOTAL = Convert.ToInt32(dj["PROCESE_NOI_TOTAL"]); }
                catch { this.PROCESE_NOI_TOTAL = 0; }

                /* -- PT. STATUS DOSARE -- */
                try { this.DOSARE_INCOMPLETE = Convert.ToInt32(dj["DOSARE_INCOMPLETE"]); }
                catch { this.DOSARE_INCOMPLETE = 0; }
                try { this.DOSARE_NEAVIZATE = Convert.ToInt32(dj["DOSARE_NEAVIZATE"]); }
                catch { this.DOSARE_NEAVIZATE = 0; }
                try { this.DOSARE_AVIZATE = Convert.ToInt32(dj["DOSARE_AVIZATE"]); }
                catch { this.DOSARE_AVIZATE = 0; }
                try { this.DOSARE_AVIZATE_NEEXPEDIATE = Convert.ToInt32(dj["DOSARE_AVIZATE_NEEXPEDIATE"]); }
                catch { this.DOSARE_AVIZATE_NEEXPEDIATE = 0; }
                try { this.DOSARE_NEACHITATE = Convert.ToInt32(dj["DOSARE_NEACHITATE"]); }
                catch { this.DOSARE_NEACHITATE = 0; }
                try { this.DOSARE_ACHITATE_PARTIAL = Convert.ToInt32(dj["DOSARE_ACHITATE_PARTIAL"]); }
                catch { this.DOSARE_ACHITATE_PARTIAL = 0; }
                try { this.DOSARE_ACHITATE = Convert.ToInt32(dj["DOSARE_ACHITATE"]); }
                catch { this.DOSARE_ACHITATE = 0; }
                try { this.DOSARE_AVIZATE_TOTAL = DOSARE_AVIZATE+ DOSARE_NEACHITATE+ DOSARE_ACHITATE_PARTIAL+ DOSARE_ACHITATE; }
                catch { this.DOSARE_AVIZATE_TOTAL = 0; }

                try { this.DOSARE_FARA_DOCUMENTE = Convert.ToInt32(dj["DOSARE_FARA_DOCUMENTE"]); }
                catch { this.DOSARE_FARA_DOCUMENTE = 0; }
                try { this.DOSARE_FARA_PROCES = Convert.ToInt32(dj["DOSARE_FARA_PROCES"]); }
                catch { this.DOSARE_FARA_PROCES = 0; }
                /* --- */

                /* -- PENTRU TERMENE -- */
                try { this.TERMENE_IN_URMATOARELE_7_ZILE = Convert.ToInt32(dj["TERMENE_IN_URMATOARELE_7_ZILE"]); }
                catch { this.TERMENE_IN_URMATOARELE_7_ZILE = 0; }
                try { this.TERMENE_DEPASITE = Convert.ToInt32(dj["TERMENE_DEPASITE"]); }
                catch { this.TERMENE_DEPASITE = 0; }
                /* --- */

                /* -- PENTRU MESAJE -- */
                try { this.MESAJE_NOI = Convert.ToInt32(dj["MESAJE_NOI"]); }
                catch { }
                try { this.MESAJE_NOI_DOSAR_NOU = Convert.ToInt32(dj["MESAJE_NOI_DOSAR_NOU"]); }
                catch { }
                try { this.MESAJE_NOI_DOCUMENT_NOU = Convert.ToInt32(dj["MESAJE_NOI_DOCUMENT_NOU"]); }
                catch { }
                /* --- */

                break;
            }

            LABELS_STATUS = new List<string>() {
                socisaV2.Resources.DashboardResx.DOSARE_INCOMPLETE,
                socisaV2.Resources.DashboardResx.DOSARE_NEOPERATE,
                socisaV2.Resources.DashboardResx.DOSARE_AVIZATE_TOTAL
            };
            LABELS_STATUS_AVIZATE = new List<string>() {
                socisaV2.Resources.DashboardResx.DOSARE_AVIZATE,
                socisaV2.Resources.DashboardResx.DOSARE_NEACHITATE,
                socisaV2.Resources.DashboardResx.DOSARE_ACHITATE_PARTIAL,
                socisaV2.Resources.DashboardResx.DOSARE_ACHITATE
            };

            VALUES_STATUS = new List<int>()
            {
                DOSARE_INCOMPLETE,
                DOSARE_NEAVIZATE,
                DOSARE_AVIZATE_TOTAL
            };
            VALUES_STATUS_AVIZATE = new List<int>()
            {
                DOSARE_AVIZATE,
                DOSARE_NEACHITATE,
                DOSARE_ACHITATE_PARTIAL,
                DOSARE_ACHITATE
            };
            r.Close(); r.Dispose(); da.CloseConnection();
        }
    }

    public class DashBoardView
    {
        public DosarExtended[] DosareExtended { get; set; }
        public UtilizatorExtended[] UtilizatoriExtended { get; set; }

        public DashBoardView() { }

        public DashBoardView(Utilizator utilizator, string conStr, int ID_SOCIETATE, int _selectType)
        {
            try
            {
                //Dosar[] ds = (Dosar[])utilizator.GetDosareNoi(ID_SOCIETATE).Result;
                Dosar[] ds = null;
                switch (_selectType)
                {
                    case 0:
                        Utilizator[] us = (Utilizator[])utilizator.GetUtilizatoriSubordonati().Result;
                        /*
                        List<UtilizatorExtended> ues = new List<UtilizatorExtended>(us.Length);
                        foreach (Utilizator u in us)
                        {
                            UtilizatorExtended ue = new UtilizatorExtended(u);
                            ues.Add(ue);
                        }
                        this.UtilizatoriExtended = ues.ToArray();
                        */
                        this.UtilizatoriExtended = new UtilizatorExtended[us.Length];
                        for(int i = 0; i < us.Length; i++)
                        {
                            this.UtilizatoriExtended[i] = new UtilizatorExtended(us[i]);
                        }
                        break;
                    case 1:
                        ds = (Dosar[])utilizator.GetDosareNeasignate(ID_SOCIETATE).Result;

                        us = (Utilizator[])utilizator.GetUtilizatoriSubordonati().Result;
                        /*
                        ues = new List<UtilizatorExtended>(us.Length);
                        foreach (Utilizator u in us)
                        {
                            UtilizatorExtended ue = new UtilizatorExtended(u);
                            ues.Add(ue);
                        }
                        this.UtilizatoriExtended = ues.ToArray();
                        */
                        this.UtilizatoriExtended = new UtilizatorExtended[us.Length];
                        for (int i = 0; i < us.Length; i++)
                        {
                            this.UtilizatoriExtended[i] = new UtilizatorExtended(us[i]);
                        }
                        break;
                    case 2:
                        ds = (Dosar[])utilizator.GetDosareNeoperate(ID_SOCIETATE).Result;
                        break;
                }
                /*
                List<DosarExtended> des = new List<DosarExtended>(ds.Length);
                foreach (Dosar d in ds)
                {
                    DosarExtended de = new DosarExtended(d);
                    des.Add(de);
                }
                this.DosareExtended = des.ToArray();
                */
                this.DosareExtended = new DosarExtended[ds.Length];
                for(int i = 0; i < ds.Length; i++)
                {
                    this.DosareExtended[i] = new DosarExtended(ds[i]);
                }
            }
            catch { }
        }
    }
}