using MySql.Data.MySqlClient;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Reflection;
using Newtonsoft.Json;
using System.ComponentModel.DataAnnotations;
using System.Net;
using System.Net.Mail;
using System.Configuration;
using System.Security.Cryptography;
using System.Web;

namespace SOCISA.Models
{
    /// <summary>
    /// Clasa care contine definitia obiectului ce mapeaza tabela cu Dosare din baza de date
    /// </summary>
    public class Dosar
    {
        private const string _TEMPLATE_CERERE_DESPAGUBIRE1 = "Cerere_despagubire_t1.pdf";
        private const string _TEMPLATE_CERERE_DESPAGUBIRE2 = "Cerere_despagubire_t2.pdf";
        private const string _TEMPLATE_CERERE_DESPAGUBIRE3 = "Cerere_t2.pdf";
        private const string _TEMPLATE_CERERE_DESPAGUBIRE4 = "Cerere_t1.pdf";

        const string _TABLE_NAME = "dosare";
        private int authenticatedUserId { get; set; }
        private string connectionString { get; set; }

        [Key]
        [JsonProperty(NullValueHandling = NullValueHandling.Include)]
        public int? ID { get; set; }

        //[Display(Name = "Numar SCA")]
        [Display(Name = "NR_SCA", ResourceType = typeof(socisaV2.Resources.DosareResx))]
        [JsonProperty(NullValueHandling = NullValueHandling.Include)]
        public string NR_SCA { get; set; }

        //[Display(Name = "Data SCA")]
        [Display(Name = "DATA_SCA", ResourceType = typeof(socisaV2.Resources.DosareResx))]
        [DataType(DataType.Date)]
        [JsonProperty(NullValueHandling = NullValueHandling.Include)]
        public DateTime? DATA_SCA { get; set; }

        //[Required(ErrorMessage = "Campul \"Asigurat pagubit (CASCO)\" este obligatoriu!")]
        [Required(ErrorMessageResourceName = "emptyAsiguratCasco", ErrorMessageResourceType = typeof(socisaV2.Resources.ErrorMessagesResx))]
        //[Display(Name = "Asigurat pagubit (CASCO)")]
        [Display(Name = "ID_ASIGURAT_CASCO", ResourceType = typeof(socisaV2.Resources.DosareResx))]
        [JsonProperty(NullValueHandling = NullValueHandling.Include)]
        public int? ID_ASIGURAT_CASCO { get; set; }

        //public string ASIGURAT_CASCO { get; set; }
        /* public AsiguratiJson AsiguratCasco { get; set; } */

        //[Required(ErrorMessage = "Campul \"Numar polita CASCO\" este obligatoriu!")]
        [Required(ErrorMessageResourceName = "emptyPolitaCasco", ErrorMessageResourceType = typeof(socisaV2.Resources.ErrorMessagesResx))]
        //[Display(Name = "Numar polita CASCO")]
        [Display(Name = "NR_POLITA_CASCO", ResourceType = typeof(socisaV2.Resources.DosareResx))]
        [JsonProperty(NullValueHandling = NullValueHandling.Include)]
        public string NR_POLITA_CASCO { get; set; }

        //[Required(ErrorMessage = "Campul \"Numar Auto CASCO\" este obligatoriu!")]
        [Required(ErrorMessageResourceName = "emptyAutoCasco", ErrorMessageResourceType = typeof(socisaV2.Resources.ErrorMessagesResx))]
        //[Display(Name = "Numar Auto pagubit (CASCO)")]
        [Display(Name = "ID_AUTO_CASCO", ResourceType = typeof(socisaV2.Resources.DosareResx))]
        [JsonProperty(NullValueHandling = NullValueHandling.Include)]
        public int? ID_AUTO_CASCO { get; set; }

        /* public AutoJson AutoCasco { get; set; } */
        //public string NR_AUTO_CASCO { get; set; }

        //[Required(ErrorMessage = "Campul \"Asigurator pagubit (Societate CASCO)\" este obligatoriu!")]
        [Required(ErrorMessageResourceName = "emptyAsiguratorCasco", ErrorMessageResourceType = typeof(socisaV2.Resources.ErrorMessagesResx))]
        //[Display(Name = "Asigurator pagubit (Societate CASCO)")]
        [Display(Name = "ID_SOCIETATE_CASCO", ResourceType = typeof(socisaV2.Resources.DosareResx))]
        [JsonProperty(NullValueHandling = NullValueHandling.Include)]
        public int? ID_SOCIETATE_CASCO { get; set; }

        /* public SocietatiAsigurareJson SocietateCasco { get; set; } */

        //[Required(ErrorMessage = "Campul \"Numar polita vinovat (RCA)\" este obligatoriu!")]
        [Required(ErrorMessageResourceName = "emptyPolitaRca", ErrorMessageResourceType = typeof(socisaV2.Resources.ErrorMessagesResx))]
        //[Display(Name = "Numar polita vinovat (RCA)")]
        [Display(Name = "NR_POLITA_RCA", ResourceType = typeof(socisaV2.Resources.DosareResx))]
        [JsonProperty(NullValueHandling = NullValueHandling.Include)]
        public string NR_POLITA_RCA { get; set; }

        //[Required(ErrorMessage = "Campul \"Numar Auto vinovat (RCA)\" este obligatoriu!")]
        [Required(ErrorMessageResourceName = "emptyAutoRca", ErrorMessageResourceType = typeof(socisaV2.Resources.ErrorMessagesResx))]
        //[Display(Name = "Numar Auto vinovat (RCA)")]
        [Display(Name = "ID_AUTO_RCA", ResourceType = typeof(socisaV2.Resources.DosareResx))]
        [JsonProperty(NullValueHandling = NullValueHandling.Include)]
        public int? ID_AUTO_RCA { get; set; }

        //public string NR_AUTO_RCA { get; set; }
        /* public AutoJson AutoRca { get; set; } */

        //[Required(ErrorMessage = "Campul \"Valoare Dauna\" este obligatoriu!")]
        [Required(ErrorMessageResourceName = "emptyValoareDauna", ErrorMessageResourceType = typeof(socisaV2.Resources.ErrorMessagesResx))]
        //[Display(Name = "Valoare Dauna")]
        [Display(Name = "VALOARE_DAUNA", ResourceType = typeof(socisaV2.Resources.DosareResx))]
        [JsonProperty(NullValueHandling = NullValueHandling.Include)]
        public double? VALOARE_DAUNA { get; set; }

        //[Required(ErrorMessage = "Campul \"Valoare Regres\" este obligatoriu!")]
        [Required(ErrorMessageResourceName = "emptyValoareRegres", ErrorMessageResourceType = typeof(socisaV2.Resources.ErrorMessagesResx))]
        //[Display(Name = "Valoare Regres")]
        [Display(Name = "VALOARE_REGRES", ResourceType = typeof(socisaV2.Resources.DosareResx))]
        [JsonProperty(NullValueHandling = NullValueHandling.Include)]
        public double? VALOARE_REGRES { get; set; }

        //[Display(Name = "Nume sofer vinovat (Intervenient)")]
        [Display(Name = "ID_INTERVENIENT", ResourceType = typeof(socisaV2.Resources.DosareResx))]
        [JsonProperty(NullValueHandling = NullValueHandling.Include)]
        public int? ID_INTERVENIENT { get; set; }

        //public string INTERVENIENT { get; set; }
        /* public IntervenientiJson Intervenient { get; set; } */

        //[Required(ErrorMessage = "Campul \"Numar dosar CASCO\" este obligatoriu!")]
        [Required(ErrorMessageResourceName = "emptyNrDosarCasco", ErrorMessageResourceType = typeof(socisaV2.Resources.ErrorMessagesResx))]
        //[Display(Name = "Numar dosar CASCO")]
        [Display(Name = "NR_DOSAR_CASCO", ResourceType = typeof(socisaV2.Resources.DosareResx))]
        [JsonProperty(NullValueHandling = NullValueHandling.Include)]
        public string NR_DOSAR_CASCO { get; set; }

        //[Display(Name = "VMD")]
        [Display(Name = "VMD", ResourceType = typeof(socisaV2.Resources.DosareResx))]
        [JsonProperty(NullValueHandling = NullValueHandling.Include)]
        public double? VMD { get; set; }

        //[Display(Name = "Observatii")]
        [Display(Name = "OBSERVATII", ResourceType = typeof(socisaV2.Resources.DosareResx))]
        [JsonProperty(NullValueHandling = NullValueHandling.Include)]
        public string OBSERVATII { get; set; }

        //[Required(ErrorMessage = "Campul \"Asigurator vinovat (Societate RCA)\" este obligatoriu!")]
        [Required(ErrorMessageResourceName = "emptyAsiguratorRca", ErrorMessageResourceType = typeof(socisaV2.Resources.ErrorMessagesResx))]
        //[Display(Name = "Asigurator vinovat (Societate RCA)")]
        [Display(Name = "ID_SOCIETATE_RCA", ResourceType = typeof(socisaV2.Resources.DosareResx))]
        [JsonProperty(NullValueHandling = NullValueHandling.Include)]
        public int? ID_SOCIETATE_RCA { get; set; }

        /* public SocietatiAsigurareJson SocietateRca { get; set; } */

        //[Required(ErrorMessage = "Campul \"Data eveniment\" este obligatoriu!")]
        [Required(ErrorMessageResourceName = "emptyDataEveniment", ErrorMessageResourceType = typeof(socisaV2.Resources.ErrorMessagesResx))]
        //[Display(Name = "Data eveniment")]
        [Display(Name = "DATA_EVENIMENT", ResourceType = typeof(socisaV2.Resources.DosareResx))]
        [DataType(DataType.Date)]
        [JsonProperty(NullValueHandling = NullValueHandling.Include)]
        public DateTime? DATA_EVENIMENT { get; set; }

        //[Display(Name = "Rezerva Dauna")]
        [Display(Name = "REZERVA_DAUNA", ResourceType = typeof(socisaV2.Resources.DosareResx))]
        [JsonProperty(NullValueHandling = NullValueHandling.Include)]
        public double? REZERVA_DAUNA { get; set; }

        //[Display(Name = "Data intrare RCA")]
        [Display(Name = "DATA_INTRARE_RCA", ResourceType = typeof(socisaV2.Resources.DosareResx))]
        [DataType(DataType.Date)]
        [JsonProperty(NullValueHandling = NullValueHandling.Include)]
        public DateTime? DATA_INTRARE_RCA { get; set; }

        //[Display(Name = "Data iesire CASCO")]
        [Display(Name = "DATA_IESIRE_CASCO", ResourceType = typeof(socisaV2.Resources.DosareResx))]
        [DataType(DataType.Date)]
        [JsonProperty(NullValueHandling = NullValueHandling.Include)]
        public DateTime? DATA_IESIRE_CASCO { get; set; }

        ///[Display(Name = "Numar intrare RCA")]
        [Display(Name = "NR_INTRARE_RCA", ResourceType = typeof(socisaV2.Resources.DosareResx))]
        [JsonProperty(NullValueHandling = NullValueHandling.Include)]
        public string NR_INTRARE_RCA { get; set; }

        //[Display(Name = "Numar iesire CASCO")]
        [Display(Name = "NR_IESIRE_CASCO", ResourceType = typeof(socisaV2.Resources.DosareResx))]
        [JsonProperty(NullValueHandling = NullValueHandling.Include)]
        public string NR_IESIRE_CASCO { get; set; }

        //[Display(Name = "Asigurat vinovat (RCA)")]
        [Display(Name = "ID_ASIGURAT_RCA", ResourceType = typeof(socisaV2.Resources.DosareResx))]
        [JsonProperty(NullValueHandling = NullValueHandling.Include)]
        public int? ID_ASIGURAT_RCA { get; set; }

        //public string ASIGURAT_RCA { get; set; }
        /* public AsiguratiJson AsiguratRca { get; set; } */

        //[Required(ErrorMessage = "Campul \"Tip Dosar\" este obligatoriu!")]
        [Required(ErrorMessageResourceName = "emptyTipDosar", ErrorMessageResourceType = typeof(socisaV2.Resources.ErrorMessagesResx))]
        //[Display(Name = "Tip Dosar")]
        [Display(Name = "ID_TIP_DOSAR", ResourceType = typeof(socisaV2.Resources.DosareResx))]
        [JsonProperty(NullValueHandling = NullValueHandling.Include)]
        public int? ID_TIP_DOSAR { get; set; }

        /* public NomenclatorJson TipDosar { get; set; } */

        //[Display(Name = "Suma IBNR")]
        [Display(Name = "SUMA_IBNR", ResourceType = typeof(socisaV2.Resources.DosareResx))]
        [JsonProperty(NullValueHandling = NullValueHandling.Include)]
        public double? SUMA_IBNR { get; set; }

        //[Display(Name = "Data Avizare")]
        [Display(Name = "DATA_AVIZARE", ResourceType = typeof(socisaV2.Resources.DosareResx))]
        [DataType(DataType.Date)]
        [JsonProperty(NullValueHandling = NullValueHandling.Include)]
        public DateTime? DATA_AVIZARE { get; set; }

        //[Display(Name = "Data Notificare")]
        [Display(Name = "DATA_NOTIFICARE", ResourceType = typeof(socisaV2.Resources.DosareResx))]
        [DataType(DataType.Date)]
        [JsonProperty(NullValueHandling = NullValueHandling.Include)]
        public DateTime? DATA_NOTIFICARE { get; set; }

        //[Display(Name = "Data ultimei modificari")]
        [Display(Name = "DATA_ULTIMEI_MODIFICARI", ResourceType = typeof(socisaV2.Resources.DosareResx))]
        [DataType(DataType.Date)]
        [JsonProperty(NullValueHandling = NullValueHandling.Include)]
        public DateTime? DATA_ULTIMEI_MODIFICARI { get; set; }

        //[Display(Name = "Viza CASCO")]
        [Display(Name = "STATUS", ResourceType = typeof(socisaV2.Resources.DosareResx))]
        [JsonProperty(NullValueHandling = NullValueHandling.Include)]
        public string STATUS { get; set; }

        //[Display(Name = "Caz constatare amiabila")]
        [Display(Name = "CAZ", ResourceType = typeof(socisaV2.Resources.DosareResx))]
        [JsonProperty(NullValueHandling = NullValueHandling.Include)]
        public string CAZ { get; set; }

        //[Display(Name = "Data crearii")]
        [Display(Name = "DATA_CREARE", ResourceType = typeof(socisaV2.Resources.DosareResx))]
        [DataType(DataType.Date)]
        [JsonProperty(NullValueHandling = NullValueHandling.Include)]
        public DateTime? DATA_CREARE { get; set; }

        //[Display(Name = "Loc accident")]
        [Display(Name = "LOC_ACCIDENT", ResourceType = typeof(socisaV2.Resources.DosareResx))]
        [JsonProperty(NullValueHandling = NullValueHandling.Include)]
        public string LOC_ACCIDENT { get; set; }

        //[Display(Name = "Dosar de instanta")]
        [Display(Name = "INSTANTA", ResourceType = typeof(socisaV2.Resources.DosareResx))]
        [JsonProperty(NullValueHandling = NullValueHandling.Include)]
        public bool? INSTANTA { get; set; }

        [JsonProperty(NullValueHandling = NullValueHandling.Include)]
        public int? COUNT_DOCUMENTE { get; set; }

        [JsonProperty(NullValueHandling = NullValueHandling.Include)]
        public int? COUNT_PROCESE { get; set; }

        [JsonProperty(NullValueHandling = NullValueHandling.Include)]
        public int? COUNT_PLATI { get; set; }

        [JsonProperty(NullValueHandling = NullValueHandling.Include)]
        public int? COUNT_STADII { get; set; }

        [Display(Name = "REST_PLATA", ResourceType = typeof(socisaV2.Resources.DosareResx))]
        [JsonProperty(NullValueHandling = NullValueHandling.Include)]
        public double? REST_PLATA { get; set; }

        [Display(Name = "SEND_STATUS", ResourceType = typeof(socisaV2.Resources.DosareResx))]
        [JsonProperty(NullValueHandling = NullValueHandling.Include)]
        public string SEND_STATUS { get; set; }

        /*
        public DosareProceseJson[] DosareProcese { get; set; }
        public ProceseJson[] Procese { get; set; }
        public DosareStadiiJson[] DosareStadii { get; set; }
        public StadiiJson[] Stadii { get; set; }
        public DosarePlatiJson[] DosarePlati { get; set; }
        public PlatiJson[] Plati { get; set; }
        public DosarePlatiContracteJson[] DosarePlatiContracte { get; set; }
        public PlatiContracteJson[] PlatiContract { get; set; }
        public UtilizatoriDosareJson[] UtilizatoriDosare { get; set; }
        public UtilizatoriJson[] Utilizatori { get; set; }
        public MesajeJson[] Mesaje { get; set; }
        */

        /// <summary>
        /// Constructorul default
        /// </summary>
        public Dosar() { }

        public Dosar(int _authenticatedUserId, string _connectionString)
        {
            authenticatedUserId = _authenticatedUserId;
            connectionString = _connectionString;
        }

        /// <summary>
        /// Constructor pentru crearea unui obiect pe baza ID-ului unic
        /// </summary>
        /// <param name="_ID">ID-ul unic din baza de date</param>
        public Dosar(int _auhenticatedUserId, string _connectionString, int _ID) {
            authenticatedUserId = _auhenticatedUserId;
            connectionString = _connectionString;
            DataAccess da = new DataAccess(authenticatedUserId, connectionString, CommandType.StoredProcedure, "DOSAREsp_GetById", new object[] { new MySqlParameter("_ID", _ID) });
            MySqlDataReader r = da.ExecuteSelectQuery();
            while (r.Read())
            {
                IDataRecord item = (IDataRecord)r;
                DosarConstructor(item);
                break;
            }
            r.Close(); r.Dispose(); da.CloseConnection();
        }

        /// <summary>
        /// Constructor pentru crearea unui Dosar cu erori din tabela temporara de import pe baza ID-ului unic
        /// </summary>
        /// <param name="_ID">ID-ul unic din baza de date</param>
        /// <param name="_hasErrors">selector pt. tabela - true - din pending, false - din dosare</param>
        public Dosar(int _auhenticatedUserId, string _connectionString, int _ID, bool _hasErrors)
        {
            authenticatedUserId = _auhenticatedUserId;
            connectionString = _connectionString;
            DataAccess da = new DataAccess(authenticatedUserId, connectionString, CommandType.StoredProcedure, _hasErrors ? "PENDING_IMPORT_ERRORSsp_GetById" : "DOSAREsp_GetById", new object[] { new MySqlParameter("_ID", _ID) });
            MySqlDataReader r = da.ExecuteSelectQuery();
            while (r.Read())
            {
                IDataRecord item = (IDataRecord)r;
                DosarConstructor(item);
                break;
            }
            r.Close(); r.Dispose(); da.CloseConnection();
        }

        /// <summary>
        /// Constructor pentru crearea unui obiect pe baza numarului Casco
        /// </summary>
        /// <param name="_NR_CASCO">Nr. Casco din baza de date</param>
        public Dosar(int _auhenticatedUserId, string _connectionString, string _NR_CASCO)
        {
            authenticatedUserId = _auhenticatedUserId;
            connectionString = _connectionString;
            DataAccess da = new DataAccess(authenticatedUserId, connectionString, CommandType.StoredProcedure, "DOSAREsp_GetByNrCasco", new object[] { new MySqlParameter("_NR_CASCO", _NR_CASCO) });
            MySqlDataReader r = da.ExecuteSelectQuery();
            while (r.Read())
            {
                IDataRecord item = (IDataRecord)r;
                DosarConstructor(item);
                break;
            }
            r.Close(); r.Dispose(); da.CloseConnection();
        }

        /// <summary>
        /// Constructor pentru crearea unui obiect pe baza unei inregistrari din baza de date
        /// </summary>
        /// <param name="_dosar">Inregistrare din baza de date</param>
        public Dosar(int _authenticatedUserId, string _connectionString, IDataRecord item)
        {
            authenticatedUserId = _authenticatedUserId;
            connectionString = _connectionString;
            DosarConstructor(item);
        }

        /// <summary>
        /// Functie pt. popularea Dosarului curent, folosita de mai multi constructori
        /// </summary>
        /// <param name="_dosar">Inregistrare din DB cu informatiile dosarului curent</param>
        public void DosarConstructor(IDataRecord _dosar)
        {
            try { this.ID = Convert.ToInt32(_dosar["ID"]); }
            catch { }
            try { this.NR_SCA = _dosar["NR_SCA"].ToString(); }
            catch { }
            try { this.DATA_SCA = CommonFunctions.IsNullable(_dosar["DATA_SCA"]) ? null : (DateTime?)Convert.ToDateTime(_dosar["DATA_SCA"]); }
            catch { }
            try { this.ID_ASIGURAT_CASCO = Convert.ToInt32(_dosar["ID_ASIGURAT_CASCO"]); }
            catch { }
            //try{this.ASIGURAT_CASCO = _dosar["ASIGURAT_CASCO"].ToString();}catch{}
            /* try { this.AsiguratCasco = GetAsiguratCasco(); } catch { } */
            try { this.NR_POLITA_CASCO = _dosar["NR_POLITA_CASCO"].ToString(); }
            catch { }
            try { this.ID_AUTO_CASCO = Convert.ToInt32(_dosar["ID_AUTO_CASCO"]); }
            catch { }
            //try{this.NR_AUTO_CASCO = _dosar["NR_AUTO_CASCO"].ToString();}catch{}
            try { this.ID_SOCIETATE_CASCO = Convert.ToInt32(_dosar["ID_SOCIETATE_CASCO"]); }
            catch { }
            /* try { this.SocietateCasco = GetSocietateCasco(); } catch { } */
            try { this.NR_POLITA_RCA = _dosar["NR_POLITA_RCA"].ToString(); }
            catch { }
            try { this.ID_AUTO_RCA = Convert.ToInt32(_dosar["ID_AUTO_RCA"]); }
            catch { }
            //try{this.NR_AUTO_RCA = _dosar["NR_AUTO_RCA"].ToString();}catch{}
            try { this.VALOARE_DAUNA = Convert.ToDouble(_dosar["VALOARE_DAUNA"]); }
            catch { }
            try { this.VALOARE_REGRES = Convert.ToDouble(_dosar["VALOARE_REGRES"]); }
            catch { }
            try { this.ID_INTERVENIENT = Convert.ToInt32(_dosar["ID_INTERVENIENT"]); }
            catch { }
            //try{this.INTERVENIENT = _dosar["INTERVENIENT"].ToString();}catch{}
            /* try { this.Intervenient = GetIntervenient(); } catch { } */
            try { this.NR_DOSAR_CASCO = _dosar["NR_DOSAR_CASCO"].ToString(); }
            catch { }
            try { this.VMD = Convert.ToDouble(_dosar["VMD"]); }
            catch { }
            try { this.OBSERVATII = _dosar["OBSERVATII"].ToString(); }
            catch { }
            try { this.ID_SOCIETATE_RCA = Convert.ToInt32(_dosar["ID_SOCIETATE_RCA"]); }
            catch { }
            /* try { this.SocietateRca = GetSocietateRca(); } catch { } */
            try { this.DATA_EVENIMENT = CommonFunctions.IsNullable(_dosar["DATA_EVENIMENT"]) ? null : (DateTime?)Convert.ToDateTime(_dosar["DATA_EVENIMENT"]); }
            catch { }
            try { this.REZERVA_DAUNA = Convert.ToDouble(_dosar["REZERVA_DAUNA"]); }
            catch { }
            try { this.DATA_INTRARE_RCA = CommonFunctions.IsNullable(_dosar["DATA_INTRARE_RCA"]) ? null : (DateTime?)Convert.ToDateTime(_dosar["DATA_INTRARE_RCA"]); }
            catch { }
            try { this.DATA_IESIRE_CASCO = CommonFunctions.IsNullable(_dosar["DATA_IESIRE_CASCO"]) ? null : (DateTime?)Convert.ToDateTime(_dosar["DATA_IESIRE_CASCO"]); }
            catch { }
            try { this.NR_INTRARE_RCA = _dosar["NR_INTRARE_RCA"].ToString(); }
            catch { }
            try { this.NR_IESIRE_CASCO = _dosar["NR_IESIRE_CASCO"].ToString(); }
            catch { }
            try { this.ID_ASIGURAT_RCA = Convert.ToInt32(_dosar["ID_ASIGURAT_RCA"]); }
            catch { }
            //try{this.ASIGURAT_RCA = _dosar["ASIGURAT_RCA"].ToString();}catch{}
            /* try { this.AsiguratRca = GetAsiguratRca(); } catch { } */
            try { this.ID_TIP_DOSAR = Convert.ToInt32(_dosar["ID_TIP_DOSAR"]); }
            catch { }
            /* try { this.TipDosar = GetTipDosar(); } catch { } */
            try { this.SUMA_IBNR = Convert.ToDouble(_dosar["SUMA_IBNR"]); }
            catch { }
            try { this.DATA_AVIZARE = CommonFunctions.IsNullable(_dosar["DATA_AVIZARE"]) ? null : (DateTime?)Convert.ToDateTime(_dosar["DATA_AVIZARE"]); }
            catch { }
            try { this.DATA_NOTIFICARE = CommonFunctions.IsNullable(_dosar["DATA_NOTIFICARE"]) ? null : (DateTime?)Convert.ToDateTime(_dosar["DATA_NOTIFICARE"]); }
            catch { }
            try { this.DATA_ULTIMEI_MODIFICARI = CommonFunctions.IsNullable(_dosar["DATA_ULTIMEI_MODIFICARI"]) ? null : (DateTime?)Convert.ToDateTime(_dosar["DATA_ULTIMEI_MODIFICARI"]); }
            catch { }
            try { this.STATUS = _dosar["STATUS"].ToString(); }
            catch { }
            try { this.CAZ = _dosar["CAZ"].ToString(); }
            catch { }
            try { this.DATA_CREARE = CommonFunctions.IsNullable(_dosar["DATA_CREARE"]) ? null : (DateTime?)Convert.ToDateTime(_dosar["DATA_CREARE"]); }
            catch { }
            try { this.LOC_ACCIDENT = _dosar["LOC_ACCIDENT"].ToString(); }
            catch { }
            try { this.INSTANTA = Convert.ToBoolean(_dosar["INSTANTA"]); }
            catch { }
            try { this.COUNT_DOCUMENTE = Convert.ToInt32(_dosar["COUNT_DOCUMENTE"]); }
            catch { }
            try { this.COUNT_PROCESE = Convert.ToInt32(_dosar["COUNT_PROCESE"]); }
            catch { }
            try { this.COUNT_PLATI = Convert.ToInt32(_dosar["COUNT_PLATI"]); }
            catch { }
            try { this.COUNT_STADII = Convert.ToInt32(_dosar["COUNT_STADII"]); }
            catch { }
            try { this.REST_PLATA = Convert.ToDouble(_dosar["REST_PLATA"]); }
            catch { }
            try { this.SEND_STATUS = _dosar["SEND_STATUS"].ToString(); }
            catch { }

            /*
            try { this.Procese = GetProcese(); }
            catch { }
            try { this.AutoCasco = GetAutoCasco(); }
            catch { }
            try { this.AutoRca = GetAutoRca(); }
            catch { }
            try { this.Plati = GetPlati(); }
            catch { }
            try { this.PlatiContract = GetPlatiContracte(); }
            catch { }
            try { this.Utilizatori = GetUtilizatori(); }
            catch { }
            try { this.Mesaje = GetMesaje(); }
            catch { }
            */
        }

        /// <summary>
        /// Metoda pt. popularea Stadiilor Dosarului
        /// </summary>
        /// <returns>vector de SOCISA.StadiiJson</returns>
        public response GetStadii()
        {
            try
            {
                DataAccess da = new DataAccess(authenticatedUserId, connectionString, CommandType.StoredProcedure, "PROCESE_STADIIsp_GetByIdDosar", new object[] { new MySqlParameter("_ID_DOSAR", this.ID) });
                MySqlDataReader r = da.ExecuteSelectQuery();
                List<ProcesStadiu> aList = new List<ProcesStadiu>();
                while (r.Read())
                {
                    aList.Add(new ProcesStadiu(authenticatedUserId, connectionString, Convert.ToInt32(r["ID"])));
                }
                r.Close(); r.Dispose(); da.CloseConnection();
                return new response(true, JsonConvert.SerializeObject(aList.ToArray(), CommonFunctions.JsonSerializerSettings), aList.ToArray(), null, null);
            }
            catch (Exception exp) { LogWriter.Log(exp); return new response(false, exp.ToString(), null, null, new List<Error>() { new Error(exp) }); }
        }

        public response GetStadiiCount()
        {
            try
            {
                DataAccess da = new DataAccess(authenticatedUserId, connectionString, CommandType.StoredProcedure, "STADIIsp_GetByIdDosarCount", new object[] { new MySqlParameter("_ID_DOSAR", this.ID) });
                return da.ExecuteScalarQuery();
            }
            catch (Exception exp) { LogWriter.Log(exp); return new response(false, exp.ToString(), null, null, new List<Error>() { new Error(exp) }); }
        }

        /// <summary>
        /// Metoda pt. popularea Proceselor asociate Dosarului
        /// </summary>
        /// <returns>vector de SOCISA.Procese</returns>
        public response GetProcese()
        {
            try
            {
                DataAccess da = new DataAccess(authenticatedUserId, connectionString, CommandType.StoredProcedure, "PROCESEsp_GetByIdDosar", new object[] { new MySqlParameter("_ID_DOSAR", this.ID) });
                MySqlDataReader r = da.ExecuteSelectQuery();
                /*
                ArrayList aList = new ArrayList();
                while (r.Read())
                {
                    Proces p = new Proces(authenticatedUserId, connectionString, Convert.ToInt32(r["ID"]));
                    aList.Add(p);
                }
                r.Close(); r.Dispose(); da.CloseConnection();
                Proces[] toReturn = new Proces[aList.Count];
                for (int i = 0; i < aList.Count; i++)
                {
                    toReturn[i] = (Proces)aList[i];
                }
                return new response(true, Newtonsoft.Json.JsonConvert.SerializeObject(toReturn, CommonFunctions.JsonSerializerSettings), toReturn, null, null);
                */
                List<Proces> aList = new List<Proces>();
                while (r.Read())
                {
                    aList.Add(new Proces(authenticatedUserId, connectionString, Convert.ToInt32(r["ID"])));
                }
                r.Close(); r.Dispose(); da.CloseConnection();
                return new response(true, JsonConvert.SerializeObject(aList.ToArray(), CommonFunctions.JsonSerializerSettings), aList.ToArray(), null, null);
            }
            catch (Exception exp) { LogWriter.Log(exp); return new response(false, exp.ToString(), null, null, new List<Error>() { new Error(exp) }); }
        }

        public response GetProceseCount()
        {
            try
            {
                DataAccess da = new DataAccess(authenticatedUserId, connectionString, CommandType.StoredProcedure, "PROCESEsp_GetByIdDosarCount", new object[] { new MySqlParameter("_ID_DOSAR", this.ID) });
                return da.ExecuteScalarQuery();
            }
            catch (Exception exp) { LogWriter.Log(exp); return new response(false, exp.ToString(), null, null, new List<Error>() { new Error(exp) }); }
        }

        public response GetPlati()
        {
            try
            {
                DataAccess da = new DataAccess(authenticatedUserId, connectionString, CommandType.StoredProcedure, "PLATIsp_GetByIdDosar", new object[] { new MySqlParameter("_ID_DOSAR", this.ID) });
                MySqlDataReader r = da.ExecuteSelectQuery();
                /*
                ArrayList aList = new ArrayList();
                while (r.Read())
                {
                    Plata p = new Plata(authenticatedUserId, connectionString, Convert.ToInt32(r["ID"]));
                    aList.Add(p);
                }
                r.Close(); r.Dispose(); da.CloseConnection();
                Plata[] toReturn = new Plata[aList.Count];
                for (int i = 0; i < aList.Count; i++)
                {
                    toReturn[i] = (Plata)aList[i];
                }
                return new response(true, Newtonsoft.Json.JsonConvert.SerializeObject(toReturn, CommonFunctions.JsonSerializerSettings), toReturn, null, null);
                */
                List<Plata> aList = new List<Plata>();
                while (r.Read())
                {
                    aList.Add(new Plata(authenticatedUserId, connectionString, Convert.ToInt32(r["ID"])));
                }
                r.Close(); r.Dispose(); da.CloseConnection();
                return new response(true, JsonConvert.SerializeObject(aList.ToArray(), CommonFunctions.JsonSerializerSettings), aList.ToArray(), null, null);
            }
            catch (Exception exp) { LogWriter.Log(exp); return new response(false, exp.ToString(), null, null, new List<Error>() { new Error(exp) }); }
        }

        public response GetPlatiCount()
        {
            try
            {
                DataAccess da = new DataAccess(authenticatedUserId, connectionString, CommandType.StoredProcedure, "PLATIsp_GetByIdDosarCount", new object[] { new MySqlParameter("_ID_DOSAR", this.ID) });
                return da.ExecuteScalarQuery();
            }
            catch (Exception exp) { LogWriter.Log(exp); return new response(false, exp.ToString(), null, null, new List<Error>() { new Error(exp) }); }
        }

        public response GetSumaPlati()
        {
            try
            {
                DataAccess da = new DataAccess(authenticatedUserId, connectionString, CommandType.StoredProcedure, "DOSAREsp_GetSumaPlati", new object[] { new MySqlParameter("_ID_DOSAR", this.ID) });
                return da.ExecuteScalarQuery();
            }
            catch (Exception exp) { LogWriter.Log(exp); return new response(false, exp.ToString(), null, null, new List<Error>() { new Error(exp) }); }
        }

        public void GetNewStatus(bool _updateDb)
        {
            double TOTAL_PLATI = 0;
            try { TOTAL_PLATI = Convert.ToDouble(this.GetSumaPlati().Result); } catch { }
            if (TOTAL_PLATI > 0)
            {
                if (this.VALOARE_REGRES > 0)
                {
                    this.STATUS = this.VALOARE_REGRES - TOTAL_PLATI > 0 ? "ACHITAT_PARTIAL" : "ACHITAT";
                }
                else
                    this.STATUS = IsExpirat() ? "NEACHITAT" : "AVIZAT";
            }
            else
            {
                this.STATUS = IsExpirat() ? "NEACHITAT" : "AVIZAT";
            }
            if (_updateDb)
                ChangeStatus(this.STATUS);
        }

        public bool IsExpirat()
        {
            if (CommonFunctions.GetBusinessDays(Convert.ToDateTime(this.DATA_AVIZARE), DateTime.Now) >= 15) // TO DO: PUT 15 IN SETTINGS
            {
                return true;
            }
            return false;
        }
        /*
        /// <summary>
        /// Metoda pt. popularea Platilor asociate Dosarului
        /// </summary>
        /// <returns>vector de SOCISA.PlatiJson</returns>
        public response GetPlati()
        {
            try
            {
                DataAccess da = new DataAccess(CommandType.StoredProcedure, "DOSARE_PLATIsp_GetByIdDosar", new object[] { new MySqlParameter("_ID_DOSAR", this.ID) });
                DataTable dosarePlati = da.ExecuteSelectQuery().Tables[0];
                // this.DosarePlati = SOCISA.DosarePlati.GetDosarePlati(dosarePlati);

                PlatiJson[] toReturn = new PlatiJson[dosarePlati.Rows.Count];
                for (int i = 0; i < dosarePlati.Rows.Count; i++)
                {
                    toReturn[i] = new PlatiJson(Convert.ToInt32(dosarePlati.Rows[i]["ID_PLATA"]));
                }
                return new response(true, Newtonsoft.Json.JsonConvert.SerializeObject(toReturn, CommonFunctions.JsonSerializerSettings), toReturn, null, null);
            }
            catch (Exception exp) { LogWriter.Log(exp); return new response(false, exp.ToString(), null, null, new List<Error>() { new Error(exp) }); }
        }

        /// <summary>
        /// Metoda pt. popularea Platilor pe contract asociate Dosarului
        /// </summary>
        /// <returns>vector de SOCISA.PlatiContracteJson</returns>
        public response GetPlatiContracte()
        {
            try
            {
                DataAccess da = new DataAccess(CommandType.StoredProcedure, "DOSARE_PLATI_CONTRACTEsp_GetByIdDosar", new object[] { new MySqlParameter("_ID_DOSAR", this.ID) });
                DataTable dosarePlatiContracte = da.ExecuteSelectQuery().Tables[0];
                // this.DosarePlatiContracte = SOCISA.DosarePlatiContracte.GetDosarePlatiContracte(dosarePlatiContracte);

                PlatiContracteJson[] toReturn = new PlatiContracteJson[dosarePlatiContracte.Rows.Count];
                for (int i = 0; i < dosarePlatiContracte.Rows.Count; i++)
                {
                    toReturn[i] = new PlatiContracteJson(Convert.ToInt32(dosarePlatiContracte.Rows[i]["ID_PLATA_CONTRACT"]));
                }
                return new response(true, Newtonsoft.Json.JsonConvert.SerializeObject(toReturn, CommonFunctions.JsonSerializerSettings), toReturn, null, null);
            }
            catch (Exception exp) { LogWriter.Log(exp); return new response(false, exp.ToString(), null, null, new List<Error>() { new Error(exp) }); }
        }
        */
        /// <summary>
        /// Metoda pt. popularea Mesajelor carora le este asociat Dosarul
        /// </summary>
        /// <returns>vector de SOCISA.MesajeJson</returns>
        public response GetMesaje()
        {
            try
            {
                DataAccess da = new DataAccess(authenticatedUserId, connectionString, CommandType.StoredProcedure, "MESAJEsp_GetByIdDosar", new object[] { new MySqlParameter("_ID_DOSAR", this.ID) });
                MySqlDataReader r = da.ExecuteSelectQuery();
                /*
                ArrayList aList = new ArrayList();
                while (r.Read())
                {
                    //Mesaj a = new Mesaj(authenticatedUserId, connectionString, Convert.ToInt32(r["ID"]));
                    Mesaj a = new Mesaj(authenticatedUserId, connectionString, r);
                    aList.Add(a);
                }
                r.Close(); r.Dispose(); da.CloseConnection();
                Mesaj[] toReturn = new Mesaj[aList.Count];
                for (int i = 0; i < aList.Count; i++)
                {
                    toReturn[i] = (Mesaj)aList[i];
                }
                return new response(true, Newtonsoft.Json.JsonConvert.SerializeObject(toReturn, CommonFunctions.JsonSerializerSettings), toReturn, null, null);
                */
                List<Mesaj> aList = new List<Mesaj>();
                while (r.Read())
                {
                    aList.Add(new Mesaj(authenticatedUserId, connectionString, r));
                }
                r.Close(); r.Dispose(); da.CloseConnection();
                return new response(true, Newtonsoft.Json.JsonConvert.SerializeObject(aList.ToArray(), CommonFunctions.JsonSerializerSettings), aList.ToArray(), null, null);
            }
            catch (Exception exp) { LogWriter.Log(exp); return new response(false, exp.ToString(), null, null, new List<Error>() { new Error(exp) }); }
        }

        public response GetSentMesaje()
        {
            try
            {
                DataAccess da = new DataAccess(authenticatedUserId, connectionString, CommandType.StoredProcedure, "MESAJEsp_GetByIdDosarSent", new object[] { new MySqlParameter("_ID_DOSAR", this.ID) });
                MySqlDataReader r = da.ExecuteSelectQuery();
                /*
                ArrayList aList = new ArrayList();
                while (r.Read())
                {
                    //Mesaj a = new Mesaj(authenticatedUserId, connectionString, Convert.ToInt32(r["ID"]));
                    Mesaj a = new Mesaj(authenticatedUserId, connectionString, r);
                    aList.Add(a);
                }
                r.Close(); r.Dispose(); da.CloseConnection();
                Mesaj[] toReturn = new Mesaj[aList.Count];
                for (int i = 0; i < aList.Count; i++)
                {
                    toReturn[i] = (Mesaj)aList[i];
                }
                return new response(true, Newtonsoft.Json.JsonConvert.SerializeObject(toReturn, CommonFunctions.JsonSerializerSettings), toReturn, null, null);
                */
                List<Mesaj> aList = new List<Mesaj>();
                while (r.Read())
                {
                    aList.Add(new Mesaj(authenticatedUserId, connectionString, r));
                }
                r.Close(); r.Dispose(); da.CloseConnection();
                return new response(true, Newtonsoft.Json.JsonConvert.SerializeObject(aList.ToArray(), CommonFunctions.JsonSerializerSettings), aList.ToArray(), null, null);
            }
            catch (Exception exp) { LogWriter.Log(exp); return new response(false, exp.ToString(), null, null, new List<Error>() { new Error(exp) }); }
        }

        public response GetNewMesaje(DateTime _LAST_REFRESH)
        {
            try
            {
                DataAccess da = new DataAccess(authenticatedUserId, connectionString, CommandType.StoredProcedure, "MESAJEsp_GetByIdDosarNew", new object[] { new MySqlParameter("_ID_DOSAR", this.ID), new MySqlParameter("_LAST_REFRESH", _LAST_REFRESH) });
                response r = da.ExecuteScalarQuery();
                return r;
            }
            catch (Exception exp) { LogWriter.Log(exp); return new response(false, exp.ToString(), null, null, new List<Error>() { new Error(exp) }); }
        }

        /// <summary>
        /// Metoda pt. popularea Autoturismului CASCO din Dosar
        /// </summary>
        /// <returns>SOCISA.AutoJson</returns>
        public response GetAutoCasco()
        {
            try
            {
                Auto toReturn = new Auto(authenticatedUserId, connectionString, Convert.ToInt32(this.ID_AUTO_CASCO));
                return new response(true, Newtonsoft.Json.JsonConvert.SerializeObject(toReturn, CommonFunctions.JsonSerializerSettings), toReturn, null, null);
            }
            catch (Exception exp) { LogWriter.Log(exp); return new response(false, exp.ToString(), null, null, new List<Error>() { new Error(exp) }); }
        }

        /// <summary>
        /// Metoda pt. popularea Autoturismului RCA din Dosar
        /// </summary>
        /// <returns>SOCISA.AutoJson</returns>
        public response GetAutoRca()
        {
            try
            {
                Auto toReturn = new Auto(authenticatedUserId, connectionString, Convert.ToInt32(this.ID_AUTO_RCA));
                return new response(true, Newtonsoft.Json.JsonConvert.SerializeObject(toReturn, CommonFunctions.JsonSerializerSettings), toReturn, null, null);
            }
            catch (Exception exp) { LogWriter.Log(exp); return new response(false, exp.ToString(), null, null, new List<Error>() { new Error(exp) }); }
        }

        /// <summary>
        /// Metoda pt. popularea Asiguratului CASCO din Dosar
        /// </summary>
        /// <returns>SOCISA.AsiguratiJson</returns>
        public response GetAsiguratCasco()
        {
            try
            {
                Asigurat toReturn = new Asigurat(authenticatedUserId, connectionString, Convert.ToInt32(this.ID_ASIGURAT_CASCO));
                return new response(true, Newtonsoft.Json.JsonConvert.SerializeObject(toReturn, CommonFunctions.JsonSerializerSettings), toReturn, null, null);
            }
            catch (Exception exp) { LogWriter.Log(exp); return new response(false, exp.ToString(), null, null, new List<Error>() { new Error(exp) }); }
        }

        /// <summary>
        /// Metoda pt. popularea Asiguratului RCA din Dosar
        /// </summary>
        /// <returns>SOCISA.AsiguratiJson</returns>
        public response GetAsiguratRca()
        {
            try
            {
                Asigurat toReturn = new Asigurat(authenticatedUserId, connectionString, Convert.ToInt32(this.ID_ASIGURAT_RCA));
                return new response(true, Newtonsoft.Json.JsonConvert.SerializeObject(toReturn, CommonFunctions.JsonSerializerSettings), toReturn, null, null);
            }
            catch (Exception exp) { LogWriter.Log(exp); return new response(false, exp.ToString(), null, null, new List<Error>() { new Error(exp) }); }
        }

        /// <summary>
        /// Metoda pt. popularea Societatii CASCO din Dosar
        /// </summary>
        /// <returns>SOCISA.SocietatiAsigurareJson</returns>
        public response GetSocietateCasco()
        {
            try
            {
                SocietateAsigurare toReturn = new SocietateAsigurare(authenticatedUserId, connectionString, Convert.ToInt32(this.ID_SOCIETATE_CASCO));
                return new response(true, Newtonsoft.Json.JsonConvert.SerializeObject(toReturn, CommonFunctions.JsonSerializerSettings), toReturn, null, null);
            }
            catch (Exception exp) { LogWriter.Log(exp); return new response(false, exp.ToString(), null, null, new List<Error>() { new Error(exp) }); }
        }

        /// <summary>
        /// Metoda pt. popularea Societatii RCA din Dosar
        /// </summary>
        /// <returns>SOCISA.SocietatiAsigurareJson</returns>
        public response GetSocietateRca()
        {
            try
            {
                SocietateAsigurare toReturn = new SocietateAsigurare(authenticatedUserId, connectionString, Convert.ToInt32(this.ID_SOCIETATE_RCA));
                return new response(true, Newtonsoft.Json.JsonConvert.SerializeObject(toReturn, CommonFunctions.JsonSerializerSettings), toReturn, null, null);
            }
            catch (Exception exp) { LogWriter.Log(exp); return new response(false, exp.ToString(), null, null, new List<Error>() { new Error(exp) }); }
        }

        /// <summary>
        /// Metoda pt. popularea Intervenientului din Dosar
        /// </summary>
        /// <returns>SOCISA.IntervenientiJson</returns>
        public response GetIntervenient()
        {
            try
            {
                Intervenient toReturn = new Intervenient(authenticatedUserId, connectionString, Convert.ToInt32(this.ID_INTERVENIENT));
                return new response(true, Newtonsoft.Json.JsonConvert.SerializeObject(toReturn, CommonFunctions.JsonSerializerSettings), toReturn, null, null);
            }
            catch (Exception exp) { LogWriter.Log(exp); return new response(false, exp.ToString(), null, null, new List<Error>() { new Error(exp) }); }
        }

        /// <summary>
        /// Metoda pt. popularea Tipului Dosarului
        /// </summary>
        /// <returns>SOCISA.NomenclatorJson</returns>
        public response GetTipDosar()
        {
            try
            {
                Nomenclator toReturn = new Nomenclator(authenticatedUserId, connectionString, "tip_dosare", (Convert.ToInt32(this.ID_TIP_DOSAR)));
                return new response(true, Newtonsoft.Json.JsonConvert.SerializeObject(toReturn, CommonFunctions.JsonSerializerSettings), toReturn, null, null);
            }
            catch (Exception exp) { LogWriter.Log(exp); return new response(false, exp.ToString(), null, null, new List<Error>() { new Error(exp) }); }
        }

        /// <summary>
        /// Metoda pt. popularea Utilizatorilor carora le este assignat Dosarul
        /// </summary>
        /// <returns>vector de SOCISA.UtilizatoriJson</returns>
        public response GetUtilizatori()
        {
            try
            {
                DataAccess da = new DataAccess(authenticatedUserId, connectionString, CommandType.StoredProcedure, "UTILIZATORI_DOSAREsp_GetByIdDosar", new object[] { new MySqlParameter("_ID_DOSAR", this.ID) });
                MySqlDataReader r = da.ExecuteSelectQuery();
                /*
                ArrayList aList = new ArrayList();
                while (r.Read())
                {
                    Utilizator a = new Utilizator(authenticatedUserId, connectionString, Convert.ToInt32(r["ID_UTILIZATOR"]));
                    aList.Add(a);
                }
                r.Close(); r.Dispose(); da.CloseConnection();
                Utilizator[] toReturn = new Utilizator[aList.Count];
                for (int i = 0; i < aList.Count; i++)
                {
                    toReturn[i] = (Utilizator)aList[i];
                }
                return new response(true, Newtonsoft.Json.JsonConvert.SerializeObject(toReturn, CommonFunctions.JsonSerializerSettings), toReturn, null, null);
                */
                List<Utilizator> aList = new List<Utilizator>();
                while (r.Read())
                {
                    aList.Add(new Utilizator(authenticatedUserId, connectionString, Convert.ToInt32(r["ID_UTILIZATOR"])));
                }
                r.Close(); r.Dispose(); da.CloseConnection();
                return new response(true, Newtonsoft.Json.JsonConvert.SerializeObject(aList.ToArray(), CommonFunctions.JsonSerializerSettings), aList.ToArray(), null, null);
            }
            catch (Exception exp) { LogWriter.Log(exp); return new response(false, exp.ToString(), null, null, new List<Error>() { new Error(exp) }); }
        }

        public response UserHasWright(int _ID_UTILIZATOR)
        {
            try
            {
                bool hasWright = false;
                Utilizator utilizator = new Utilizator(authenticatedUserId, connectionString, _ID_UTILIZATOR);
                string tipU = ((Nomenclator)utilizator.GetTipUtilizator().Result).DENUMIRE;
                if (tipU == "Administrator")
                    return new response(true, "", true, null, null);

                if (tipU == "Super" && (utilizator.ID_SOCIETATE == this.ID_SOCIETATE_CASCO || (utilizator.ID_SOCIETATE == this.ID_SOCIETATE_RCA && (this.STATUS != "INCOMPLET" && this.STATUS != "NEAVIZAT"))))
                    return new response(true, "", true, null, null);

                if (tipU == "Email" && (utilizator.ID_SOCIETATE == this.ID_SOCIETATE_CASCO || (utilizator.ID_SOCIETATE == this.ID_SOCIETATE_RCA && (this.STATUS != "INCOMPLET" && this.STATUS != "NEAVIZAT"))))
                    return new response(true, "", true, null, null);


                Utilizator[] us = (Utilizator[])this.GetUtilizatori().Result;
                foreach (Utilizator u in us)
                {
                    if (u.ID == _ID_UTILIZATOR)
                    {
                        hasWright = true;
                        break;
                    }
                }
                return new response(true, "", hasWright, null, null);
            }
            catch (Exception exp) { LogWriter.Log(exp); return new response(false, exp.ToString(), null, null, new List<Error>() { new Error(exp) }); }
        }

        public response GetDocumente()
        {
            try
            {
                DataAccess da = new DataAccess( authenticatedUserId, connectionString, CommandType.StoredProcedure, "DOCUMENTE_SCANATEsp_GetByIdDosar", new object[] { new MySqlParameter("_ID_DOSAR", this.ID) });
                MySqlDataReader r = da.ExecuteSelectQuery();
                /*
                ArrayList aList = new ArrayList();
                while (r.Read())
                {
                    DocumentScanat a = new DocumentScanat(authenticatedUserId, connectionString, Convert.ToInt32(r["ID"]));
                    aList.Add(a);
                }
                r.Close(); r.Dispose(); da.CloseConnection();
                DocumentScanat[] toReturn = new DocumentScanat[aList.Count];
                for (int i = 0; i < aList.Count; i++)
                {
                    toReturn[i] = (DocumentScanat)aList[i];
                }
                return new response(true, JsonConvert.SerializeObject(toReturn, CommonFunctions.JsonSerializerSettings), toReturn, null, null);
                */
                List<DocumentScanat> aList = new List<DocumentScanat>();
                while (r.Read())
                {
                    aList.Add(new DocumentScanat(authenticatedUserId, connectionString, Convert.ToInt32(r["ID"])));
                }
                r.Close(); r.Dispose(); da.CloseConnection();
                return new response(true, JsonConvert.SerializeObject(aList.ToArray(), CommonFunctions.JsonSerializerSettings), aList.ToArray(), null, null);
            }
            catch (Exception exp) { LogWriter.Log(exp); return new response(false, exp.ToString(), null, null, new List<Error>() { new Error(exp) }); }
        }

        public response GetDocumenteTipuri()
        {
            try
            {
                DataAccess da = new DataAccess(authenticatedUserId, connectionString, CommandType.StoredProcedure, "DOSAREsp_DocumenteTipuri", new object[] { new MySqlParameter("_ID_DOSAR", this.ID) });
                MySqlDataReader r = da.ExecuteSelectQuery();
                ArrayList aList = new ArrayList();
                while (r.Read())
                {
                    aList.Add(new object[] { r["ID"], r["DENUMIRE"], r["CNT"] });
                }
                r.Close(); r.Dispose(); da.CloseConnection();
                return new response(true, JsonConvert.SerializeObject(aList.ToArray(), CommonFunctions.JsonSerializerSettings), aList.ToArray(), null, null);
            }
            catch (Exception exp) { LogWriter.Log(exp); return new response(false, exp.ToString(), null, null, new List<Error>() { new Error(exp) }); }
        }

        public response GetDocumenteCount()
        {
            try
            {
                DataAccess da = new DataAccess(authenticatedUserId, connectionString, CommandType.StoredProcedure, "DOCUMENTE_SCANATEsp_GetByIdDosarCount", new object[] { new MySqlParameter("_ID_DOSAR", this.ID) });
                return da.ExecuteScalarQuery();
            }
            catch (Exception exp) { LogWriter.Log(exp); return new response(false, exp.ToString(), null, null, new List<Error>() { new Error(exp) }); }
        }

        public response IsAssigned()
        {
            try
            {
                DataAccess da = new DataAccess(authenticatedUserId, connectionString, CommandType.StoredProcedure, "DOSAREsp_IsAssigned", new object[] { new MySqlParameter("_ID_DOSAR", this.ID) });
                return da.ExecuteScalarQuery();
            }
            catch (Exception exp) { LogWriter.Log(exp); return new response(false, exp.ToString(), null, null, new List<Error>() { new Error(exp) }); }
        }

        public response Avizare(string _avizat)
        {
            try
            {
                response r = ValidareAvizare();
                if (r.Status)
                {
                    DataAccess da = new DataAccess(authenticatedUserId, connectionString, CommandType.StoredProcedure, "DOSAREsp_Avizare", new object[] { new MySqlParameter("_ID", this.ID), new MySqlParameter("_STATUS", _avizat) });
                    r = da.ExecuteUpdateQuery();
                    if (r.Status)
                    {
                        try
                        {
                            MesajeRepository mr = new MesajeRepository(authenticatedUserId, connectionString);
                            string partial_sub = String.Format("DOSAR {0}", _avizat == "AVIZAT" ? "NOU" : "ELIMINAT");
                            string subiect = String.Format("{0} ({1})", partial_sub, this.NR_DOSAR_CASCO);
                            mr.GenerateAndSendMessage(this.ID, DateTime.Now, subiect, subiect, partial_sub, authenticatedUserId, (int)Importanta.Low);
                        }
                        catch { }
                    }
                    return new response(true, "", null, null, null);
                }else
                {
                    return r;
                }
            }
            catch (Exception exp) { LogWriter.Log(exp); return new response(false, exp.ToString(), null, null, new List<Error>() { new Error(exp) }); }
        }

        public response ChangeStatus(string _status)
        {
            try
            {
                DataAccess da = new DataAccess(authenticatedUserId, connectionString, CommandType.StoredProcedure, "DOSAREsp_ChangeStatus", new object[] { new MySqlParameter("_ID", this.ID), new MySqlParameter("_STATUS", _status) });
                response r = da.ExecuteUpdateQuery();
                return r;
            }
            catch (Exception exp) { LogWriter.Log(exp); return new response(false, exp.ToString(), null, null, new List<Error>() { new Error(exp) }); }
        }

        public bool IsAvizat()
        {
            //Nomenclator tip_dosar = (Nomenclator)this.GetTipDosar().Result;
            //if ((this.STATUS == "INCOMPLET" || this.STATUS == "NEAVIZAT") && tip_dosar.DENUMIRE.ToUpper() != "REGRES NON-RCA" )
            if (this.STATUS == "INCOMPLET" || this.STATUS == "NEAVIZAT")
                return false;
            return true;
        }

        public response ValidareAvizare()
        {
            response r = this.Validare();
            if (!r.Status)
            {
                return r;
            }
            bool isValid = true;
            string tipDosar = ((Nomenclator)this.GetTipDosar().Result).DENUMIRE;
            switch (tipDosar.ToUpper())
            {
                case "REGRES RCA":
                    TipDocumenteRepository tdr = new TipDocumenteRepository(authenticatedUserId, connectionString);
                    TipDocument[] tipuri_document = (TipDocument[])tdr.GetAll().Result;
                    DocumentScanat[] documente = (DocumentScanat[])this.GetDocumente().Result;
                    if (documente == null || documente.Length == 0)
                    {
                        return new response(false, "", null, null, new List<Error>());
                    }
                    Dictionary<int, bool> validatedDocs = new Dictionary<int, bool>();

                    foreach (TipDocument td in tipuri_document)
                    {
                        bool localIsValid = false;
                        if (td.MANDATORY)
                        {
                            foreach (DocumentScanat ds in documente)
                            {
                                if (ds.ID_TIP_DOCUMENT == td.ID && ds.VIZA_CASCO) { localIsValid = true; break; }
                            }
                            validatedDocs.Add(Convert.ToInt32(td.ID), localIsValid);
                        }
                    }

                    foreach (TipDocument td in tipuri_document)
                    {
                        if (td.MANDATORY && (!validatedDocs.ContainsKey(Convert.ToInt32(td.ID)) || (validatedDocs.ContainsKey(Convert.ToInt32(td.ID)) && !validatedDocs[Convert.ToInt32(td.ID)])))
                        {
                            isValid = ValidareTipDocument(td, documente, tipuri_document, validatedDocs);
                            if (!isValid) break;
                            //validatedDocs.Add(Convert.ToInt32(td.ID), isValid);
                        }
                    }
                    break;
                case "REGRES NON-RCA":
                    isValid = true;
                    break;
                default:
                    isValid = false;
                    break;
            }
            return new response(isValid, "", null, null, isValid ? null : new List<Error>());
        }

        public response ValidareTiparire()
        {
            bool isValid = true;
            response r = this.ValidareAvizare();
            if (!r.Status) return r;
            string tipDosar = ((Nomenclator)this.GetTipDosar().Result).DENUMIRE;
            switch (tipDosar.ToUpper())
            {
                case "REGRES RCA":
                    if (ID_INTERVENIENT == null) isValid = false;
                    if (ID_ASIGURAT_RCA == null) isValid = false;
                    if (ID_SOCIETATE_RCA == null) isValid = false;
                    DocumentScanat[] dss = (DocumentScanat[])GetDocumente().Result;
                    bool proces_verbal = false;
                    foreach (DocumentScanat ds in dss)
                    {
                        TipDocument td = (TipDocument)ds.GetTipDocument().Result;
                        if (td.DENUMIRE == "PROCES VERBAL")
                        {
                            proces_verbal = true;
                            break;
                        }
                    }
                    if (String.IsNullOrWhiteSpace(CAZ) && !proces_verbal) isValid = false;
                    break;
                case "REGRES NON-RCA":
                    isValid = true;
                    break;
                default:
                    isValid = false;
                    break;
            }
            return new response(isValid, "", null, null, isValid ? null : new List<Error>());
        }

        private TipDocument GetTipDocumentByDenumire(string denumire, TipDocument[] tipuri_document)
        {
            foreach(TipDocument td in tipuri_document)
            {
                if (td.DENUMIRE == denumire) return td;
            }
            return null;
        }

        private bool ValidareTipDocument(TipDocument td, DocumentScanat[] documente, TipDocument[] tipuri_document, Dictionary<int, bool> validatedDocs)
        {
            bool isValid = false;
            if (td.MANDATORY)
            {
                switch (td.DENUMIRE)
                {
                    case "CEDAM":
                        TipDocument tDoc = GetTipDocumentByDenumire("POLITA VINOVAT", tipuri_document);
                        if (tDoc != null)
                        {
                            if (validatedDocs.ContainsKey(Convert.ToInt32(tDoc.ID)) && validatedDocs[Convert.ToInt32(tDoc.ID)])
                            {
                                return true;
                            }
                        }
                        break;
                    case "POLITA VINOVAT":
                        tDoc = GetTipDocumentByDenumire("CEDAM", tipuri_document);
                        if (tDoc != null)
                        {
                            if (validatedDocs.ContainsKey(Convert.ToInt32(tDoc.ID)) && validatedDocs[Convert.ToInt32(tDoc.ID)])
                            {
                                return true;
                            }
                        }
                        break;
                    case "FACTURA DE REPARATII":
                        tDoc = GetTipDocumentByDenumire("CALCUL VMD", tipuri_document);
                        if (tDoc != null)
                        {
                            if (validatedDocs.ContainsKey(Convert.ToInt32(tDoc.ID)) && validatedDocs[Convert.ToInt32(tDoc.ID)])
                            {
                                return true;
                            }
                        }
                        break;
                    case "CALCUL VMD":
                        tDoc = GetTipDocumentByDenumire("FACTURA DE REPARATII", tipuri_document);
                        if (tDoc != null)
                        {
                            if (validatedDocs.ContainsKey(Convert.ToInt32(tDoc.ID)) && validatedDocs[Convert.ToInt32(tDoc.ID)])
                            {
                                return true;
                            }
                        }
                        break;

                    case "PROCES VERBAL":
                        tDoc = GetTipDocumentByDenumire("CONSTATARE AMIABILA", tipuri_document);
                        if (tDoc != null)
                        {
                            if (validatedDocs.ContainsKey(Convert.ToInt32(tDoc.ID)) && validatedDocs[Convert.ToInt32(tDoc.ID)])
                            {
                                return true;
                            }
                        }
                        break;
                    case "CONSTATARE AMIABILA":
                        tDoc = GetTipDocumentByDenumire("PROCES VERBAL", tipuri_document);
                        if (tDoc != null)
                        {
                            if (validatedDocs.ContainsKey(Convert.ToInt32(tDoc.ID)) && validatedDocs[Convert.ToInt32(tDoc.ID)])
                            {
                                return true;
                            }
                        }
                        break;
                }
                /*
                foreach (DocumentScanat ds in documente)
                {
                    if (ds.ID_TIP_DOCUMENT == td.ID && ds.VIZA_CASCO) { isValid = true; break; }
                }
                */
                return isValid;
            }
            return true;
        }

        /// <summary>
        /// Metoda pentru inserarea Dosarului curent
        /// </summary>
        /// <returns>SOCISA.response = new object(bool = status, string = error message, int = id-ul cheie returnat)</returns>
        public response Insert()
        {
            response toReturn = Validare();
            if (!toReturn.Status)
            {
                return toReturn;
            }
            #region -- old --
            /* -- insert informatii externe (auto, asigurati, intervenient, tipdosar, societati) -- */
            /*
            if (this.AsiguratCasco != null)
            {
                response toReturnDac = this.AsiguratCasco.Insert();
                if (toReturnDac.Status && toReturnDac.InsertedId != null)
                    this.ID_ASIGURAT_CASCO = toReturnDac.InsertedId;
            }
            if (this.AsiguratRca != null)
            {
                response toReturnDar = this.AsiguratRca.Insert();
                if (toReturnDar.Status && toReturnDar.InsertedId != null)
                    this.ID_ASIGURAT_RCA = toReturnDar.InsertedId;
            }
            if (this.AutoCasco != null)
            {
                response toReturnDac = this.AutoCasco.Insert();
                if (toReturnDac.Status && toReturnDac.InsertedId != null)
                    this.ID_AUTO_CASCO = toReturnDac.InsertedId;
            }
            if (this.AutoRca != null)
            {
                response toReturnDAr = this.AutoRca.Insert();
                if (toReturnDAr.Status && toReturnDAr.InsertedId != null)
                    this.ID_AUTO_RCA = toReturnDAr.InsertedId;
            }
            if (this.SocietateCasco != null)
            {
                response toReturnDsc = this.SocietateCasco.Insert();
                if (toReturnDsc.Status && toReturnDsc.InsertedId != null)
                    this.ID_SOCIETATE_CASCO = toReturnDsc.InsertedId;
            }
            if (this.SocietateRca != null)
            {
                response toReturnDsr = this.SocietateRca.Insert();
                if (toReturnDsr.Status && toReturnDsr.InsertedId != null)
                    this.ID_SOCIETATE_RCA = toReturnDsr.InsertedId;
            }
            if (this.Intervenient != null)
            {
                response toReturnDi = this.Intervenient.Insert();
                if (toReturnDi.Status && toReturnDi.InsertedId != null)
                    this.ID_INTERVENIENT = toReturnDi.InsertedId;
            }
            if (this.TipDosar != null)
            {
                response toReturnDtd = this.TipDosar.Insert();
                if (toReturnDtd.Status && toReturnDtd.InsertedId != null)
                    this.ID_TIP_DOSAR = toReturnDtd.InsertedId;
            }
            */
            /* -- end insert informatii externe (auto, asigurati, intervenient, tipdosar, societati) -- */
            #endregion

            this.DATA_ULTIMEI_MODIFICARI = DateTime.Now;
            this.DATA_CREARE = DateTime.Now;
            if (String.IsNullOrWhiteSpace(STATUS))
                this.STATUS = "INCOMPLET";

            PropertyInfo[] props = this.GetType().GetProperties();
            ArrayList _parameters = new ArrayList();
            var col = CommonFunctions.table_columns(authenticatedUserId, connectionString, "dosare");
            foreach (PropertyInfo prop in props)
            {
                if (col != null && col.ToUpper().IndexOf(prop.Name.ToUpper()) > -1) // ca sa includem in Array-ul de parametri doar coloanele tabelei, nu si campurile externe si/sau alte proprietati
                {
                    string propName = prop.Name;
                    string propType = prop.PropertyType.ToString();
                    object propValue = prop.GetValue(this, null);
                    propValue = propValue == null ? DBNull.Value : propValue;
                    if (propType != null)
                    {
                        if (propName.ToUpper() != "ID") // il vom folosi doar la Edit!
                            _parameters.Add(new MySqlParameter(String.Format("_{0}", propName.ToUpper()), propValue));
                    }
                }
            }
            DataAccess da = new DataAccess(authenticatedUserId, connectionString, CommandType.StoredProcedure, "DOSAREsp_insert", _parameters.ToArray());
            toReturn = da.ExecuteInsertQuery();
            if (toReturn.Status)
            {
                this.ID = toReturn.InsertedId;
                /*
                try
                {
                    if (System.Web.HttpContext.Current.Request.Params["SEND_MESSAGE"] != null && Convert.ToBoolean(System.Web.HttpContext.Current.Request.Params["SEND_MESSAGE"]))
                        Mesaje.GenerateAndSendMessage(this.ID, DateTime.Now, "Dosar nou", Convert.ToInt32(System.Web.HttpContext.Current.Session["AUTHENTICATED_ID"]), (int)Mesaje.Importanta.Low);
                }
                catch { }
                */
                toReturn.Message = JsonConvert.SerializeObject(this, Formatting.None, new Newtonsoft.Json.Converters.IsoDateTimeConverter() { DateTimeFormat = CommonFunctions.DATE_FORMAT });
                toReturn.Result = this; // pt. ID-uri externe generate !!!
            }

            #region -- older --
            /* 
            if (this.Procese != null && this.Procese.Length > 0)
            {
                foreach (ProceseJson pj in this.Procese)
                {
                    response toReturnPj = pj.Insert();
                    if (toReturnPj.Status)
                    {
                        DosareProceseJson dpj = new DosareProceseJson();
                        dpj.ID_DOSAR = Convert.ToInt32(this.ID);
                        dpj.ID_PROCES = Convert.ToInt32(toReturnPj.InsertedId);
                        response toReturnDpj = dpj.Insert();
                    }
                }
            }

            if (this.DosareStadii != null && this.DosareStadii.Length > 0)
            {
                foreach (DosareStadiiJson dsj in this.DosareStadii)
                {
                    response toReturnSj = dsj.Stadiu.Insert();
                    if (toReturnSj.Status)
                    {
                        dsj.ID_STADIU = Convert.ToInt32(toReturnSj.InsertedId);
                        dsj.ID_DOSAR = Convert.ToInt32(this.ID);
                        response toReturnDsj = dsj.Insert();
                    }
                }
            }

            if (this.Plati != null && this.Plati.Length > 0)
            {
                foreach (PlatiJson pj in this.Plati)
                {
                    response toReturnPj = pj.Insert();
                    if (toReturnPj.Status)
                    {
                        DosarePlatiJson dpj = new DosarePlatiJson(Convert.ToInt32(toReturnPj.InsertedId));
                        dpj.ID_DOSAR = Convert.ToInt32(this.ID);
                        dpj.ID_PLATA = Convert.ToInt32(toReturnPj.InsertedId);
                        response toReturnDsj = dpj.Insert();
                    }
                }
            }

            if (this.PlatiContract != null && this.PlatiContract.Length > 0)
            {
                foreach (PlatiContracteJson pcj in this.PlatiContract)
                {
                    response toReturnPcj = pcj.Insert();
                    if (toReturnPcj.Status)
                    {
                        DosarePlatiContracteJson dpcj = new DosarePlatiContracteJson();
                        dpcj.ID_DOSAR = Convert.ToInt32(this.ID);
                        dpcj.ID_PLATA_CONTRACT = Convert.ToInt32(toReturnPcj.InsertedId);
                        response toReturnDpcj = dpcj.Insert();
                    }
                }
            }

            if (this.Utilizatori != null && this.Utilizatori.Length > 0)
            {
                foreach (UtilizatoriJson uj in this.Utilizatori)
                {
                    response toReturnUj = uj.Insert();
                    if (toReturnUj.Status)
                    {
                        UtilizatoriDosareJson udj = new UtilizatoriDosareJson();
                        udj.ID_DOSAR = Convert.ToInt32(this.ID);
                        udj.ID_UTILIZATOR = Convert.ToInt32(toReturnUj.InsertedId);
                        response toReturnUdj = udj.Insert();
                    }
                }
            }

            if (this.Mesaje != null && this.Mesaje.Length > 0)
            {
                foreach (MesajeJson mj in this.Mesaje)
                {
                    mj.ID_DOSAR = this.ID;
                    response toReturnMj = mj.Insert();
                }
            }
            */
            #endregion
            return toReturn;
        }

        /// <summary>
        /// Metoda pentru inserarea unui Dosar cu erori, rezultat in urma importului, in tabela temporara
        /// </summary>
        /// <returns>SOCISA.response = new object(bool = status, string = error message, int = id-ul cheie returnat)</returns>
        public response InsertWithErrors()
        {
            response toReturn = new response(true, "", null, null, new List<Error>());
            PropertyInfo[] props = this.GetType().GetProperties();
            ArrayList _parameters = new ArrayList();
            var col = CommonFunctions.table_columns(authenticatedUserId, connectionString, "dosare");
            foreach (PropertyInfo prop in props)
            {
                if (col != null && col.ToUpper().IndexOf(prop.Name.ToUpper()) > -1) // ca sa includem in Array-ul de parametri doar coloanele tabelei, nu si campurile externe si/sau alte proprietati
                {
                    string propName = prop.Name;
                    string propType = prop.PropertyType.ToString();
                    object propValue = prop.GetValue(this, null);
                    propValue = propValue == null ? DBNull.Value : propValue;
                    if (propType != null)
                    {
                        if (propName.ToUpper() != "ID") // il vom folosi doar la Edit!
                            _parameters.Add(new MySqlParameter(String.Format("_{0}", propName.ToUpper()), propValue));
                    }
                }
            }
            DataAccess da = new DataAccess(authenticatedUserId, connectionString, CommandType.StoredProcedure, "PENDING_IMPORT_ERRORSsp_insert", _parameters.ToArray());
            toReturn = da.ExecuteInsertQuery();
            if (toReturn.Status)
            {
                this.ID = toReturn.InsertedId;
                toReturn.Message = JsonConvert.SerializeObject(this, Formatting.None, new Newtonsoft.Json.Converters.IsoDateTimeConverter() { DateTimeFormat = CommonFunctions.DATE_FORMAT });
                toReturn.Result = this; // pt. ID-uri externe generate !!!
            }
            return toReturn;
        }

        /// <summary>
        /// Metoda pentru modificarea Dosarului curent
        /// </summary>
        /// <returns>SOCISA.response = new object(bool = status, string = error message, int = id-ul cheie returnat)</returns>
        public response Update()
        {
            Dosar originalDosar = new Dosar(this.authenticatedUserId, this.connectionString, Convert.ToInt32(this.ID)); // ne trebuie ca sa actualizam rezerva dauna din dosar

            response toReturn = Validare();
            if (!toReturn.Status)
            {
                return toReturn;
            }

            #region -- older --
            /* -- insert informatii externe (auto, asigurati, intervenient, tipdosar, societati) -- */
            /*
            if (this.AsiguratCasco != null)
            {
                response toReturnDac = this.AsiguratCasco.Insert();
                if (toReturnDac.Status && toReturnDac.InsertedId != null)
                    this.ID_ASIGURAT_CASCO = toReturnDac.InsertedId;
            }
            if (this.AsiguratRca != null)
            {
                response toReturnDar = this.AsiguratRca.Insert();
                if (toReturnDar.Status && toReturnDar.InsertedId != null)
                    this.ID_ASIGURAT_RCA = toReturnDar.InsertedId;
            }
            if (this.AutoCasco != null)
            {
                response toReturnDac = this.AutoCasco.Insert();
                if (toReturnDac.Status && toReturnDac.InsertedId != null)
                    this.ID_AUTO_CASCO = toReturnDac.InsertedId;
            }
            if (this.AutoRca != null)
            {
                response toReturnDAr = this.AutoRca.Insert();
                if (toReturnDAr.Status && toReturnDAr.InsertedId != null)
                    this.ID_AUTO_RCA = toReturnDAr.InsertedId;
            }
            if (this.SocietateCasco != null)
            {
                response toReturnDsc = this.SocietateCasco.Insert();
                if (toReturnDsc.Status && toReturnDsc.InsertedId != null)
                    this.ID_SOCIETATE_CASCO = toReturnDsc.InsertedId;
            }
            if (this.SocietateRca != null)
            {
                response toReturnDsr = this.SocietateRca.Insert();
                if (toReturnDsr.Status && toReturnDsr.InsertedId != null)
                    this.ID_SOCIETATE_RCA = toReturnDsr.InsertedId;
            }
            if (this.Intervenient != null)
            {
                response toReturnDi = this.Intervenient.Insert();
                if (toReturnDi.Status && toReturnDi.InsertedId != null)
                    this.ID_INTERVENIENT = toReturnDi.InsertedId;
            }
            */
            /* -- end insert/update external columns -- */
            #endregion 

            this.DATA_ULTIMEI_MODIFICARI = DateTime.Now;
            if (String.IsNullOrWhiteSpace(STATUS))
                this.STATUS = "INCOMPLET";

            PropertyInfo[] props = this.GetType().GetProperties();
            ArrayList _parameters = new ArrayList();
            var col = CommonFunctions.table_columns(authenticatedUserId, connectionString, "dosare");
            foreach (PropertyInfo prop in props)
            {
                if (col != null && col.ToUpper().IndexOf(prop.Name.ToUpper()) > -1) // ca sa includem in Array-ul de parametri doar coloanele tabelei, nu si campurile externe si/sau alte proprietati
                {
                    string propName = prop.Name;
                    string propType = prop.PropertyType.ToString();
                    object propValue = prop.GetValue(this, null);
                    propValue = propValue == null ? DBNull.Value : propValue;
                    if (propType != null)
                    {
                        _parameters.Add(new MySqlParameter(String.Format("_{0}", propName.ToUpper()), propValue));
                    }
                }
            }
            DataAccess da = new DataAccess(authenticatedUserId, connectionString, CommandType.StoredProcedure, "DOSAREsp_update", _parameters.ToArray());
            toReturn = da.ExecuteUpdateQuery();
            
            if (toReturn.Status)
            {
                /*
                try
                {
                    if (System.Web.HttpContext.Current.Request.Params["SEND_MESSAGE"] != null && Convert.ToBoolean(System.Web.HttpContext.Current.Request.Params["SEND_MESSAGE"]))
                        Mesaje.GenerateAndSendMessage(this.ID, DateTime.Now, "Dosar modificat", Convert.ToInt32(System.Web.HttpContext.Current.Session["AUTHENTICATED_ID"]), (int)Mesaje.Importanta.Low);
                }
                catch { }
                */

                try
                {
                    if (this.VALOARE_REGRES != originalDosar.VALOARE_REGRES)
                    {
                        //this.REZERVA_DAUNA += (this.REZERVA_DAUNA - originalDosar.REZERVA_DAUNA); // TO DO: de vazut daca rezerva dauna se poate modifica manual
                        this.GetNewStatus(true);
                    }
                }
                catch (Exception exp)
                {
                    toReturn = new response(false, exp.ToString(), null, null, new List<Error>() { new Error(exp) });
                    LogWriter.Log(exp);
                }

                toReturn.Message = JsonConvert.SerializeObject(this, Formatting.None, new Newtonsoft.Json.Converters.IsoDateTimeConverter() { DateTimeFormat = CommonFunctions.DATE_FORMAT });
                toReturn.Result = this; // pt. ID-uri externe generate !!!
            }
            return toReturn;
        }

        public response Update(string fieldValueCollection)
        {
            response r = ValidareColoane(fieldValueCollection);
            if (!r.Status)
            {
                return r;
            }
            else
            {
                Dictionary<string, string> changes = Newtonsoft.Json.JsonConvert.DeserializeObject<Dictionary<string, string>>(fieldValueCollection, CommonFunctions.JsonDeserializerSettings);
                foreach (string fieldName in changes.Keys)
                {
                    PropertyInfo[] props = this.GetType().GetProperties();
                    foreach (PropertyInfo prop in props)
                    {
                        //var col = CommonFunctions.table_columns(authenticatedUserId, connectionString, "actions");
                        //if (col != null && col.ToUpper().IndexOf(prop.Name.ToUpper()) > -1 && fieldName.ToUpper() == prop.Name.ToUpper()) // ca sa includem in Array-ul de parametri doar coloanele tabelei, nu si campurile externe si/sau alte proprietati
                        if (fieldName.ToUpper() == prop.Name.ToUpper() && fieldName.ToUpper() != "ID")
                        {
                            //var tmpVal = CommonFunctions.ConvertValue(changes[fieldName], prop.PropertyType);
                            var tmpVal = prop.PropertyType.FullName.IndexOf("System.Nullable") > -1 && changes[fieldName] == null ? null : prop.PropertyType.FullName.IndexOf("System.String") > -1 ? changes[fieldName] : prop.PropertyType.FullName.IndexOf("System.DateTime") > -1 ? CommonFunctions.SwitchBackFormatedDate(changes[fieldName]) : ((prop.PropertyType.FullName.IndexOf("Double") > -1) ? CommonFunctions.BackDoubleValue(changes[fieldName]) : Newtonsoft.Json.JsonConvert.DeserializeObject(changes[fieldName], prop.PropertyType));
                            prop.SetValue(this, tmpVal);
                            /*
                            if (prop.PropertyType.FullName.IndexOf("System.String") > -1)
                            {
                                var tmpVal = changes[fieldName];
                                prop.SetValue(this, tmpVal);
                            }
                            else if (prop.PropertyType.FullName.IndexOf("System.DateTime") > -1)
                            {
                                var tmpVal = Convert.ToDateTime(changes[fieldName]);
                                prop.SetValue(this, tmpVal);
                            }
                            else if (prop.PropertyType.FullName.IndexOf("Double") > -1 || prop.PropertyType.FullName.IndexOf("Decimal") > -1)
                            {
                                //var tmpVal = Newtonsoft.Json.JsonConvert.DeserializeObject(Convert.ToString( changes[fieldName]), prop.PropertyType, CommonFunctions.JsonDeserializerSettings);
                                var tmpVal = CommonFunctions.BackDoubleValue(changes[fieldName]);
                                prop.SetValue(this, tmpVal);
                            }
                            else
                            {
                                var tmpVal = Newtonsoft.Json.JsonConvert.DeserializeObject(changes[fieldName], prop.PropertyType);
                                prop.SetValue(this, tmpVal);
                            }
                            */
                            break;
                        }
                    }

                }
                return this.Update();
            }
        }

        /// <summary>
        /// Metoda pentru modificarea unui Dosar cu erori, rezultat in urma importului, in tabela temporara
        /// </summary>
        /// <returns>SOCISA.response = new object(bool = status, string = error message, int = id-ul cheie returnat)</returns>
        public response UpdateWithErrors()
        {
            response toReturn = new response(true, "", null, null, new List<Error>());
            PropertyInfo[] props = this.GetType().GetProperties();
            ArrayList _parameters = new ArrayList();
            var col = CommonFunctions.table_columns(authenticatedUserId, connectionString, "dosare");
            foreach (PropertyInfo prop in props)
            {
                if (col != null && col.ToUpper().IndexOf(prop.Name.ToUpper()) > -1) // ca sa includem in Array-ul de parametri doar coloanele tabelei, nu si campurile externe si/sau alte proprietati
                {
                    string propName = prop.Name;
                    string propType = prop.PropertyType.ToString();
                    object propValue = prop.GetValue(this, null);
                    propValue = propValue == null ? DBNull.Value : propValue;
                    if (propType != null)
                    {
                        _parameters.Add(new MySqlParameter(String.Format("_{0}", propName.ToUpper()), propValue));
                    }
                }
            }
            DataAccess da = new DataAccess(authenticatedUserId, connectionString, CommandType.StoredProcedure, "PENDING_IMPORT_ERRORSsp_update", _parameters.ToArray());
            toReturn = da.ExecuteUpdateQuery();
            if (toReturn.Status)
            {
                toReturn.Message = JsonConvert.SerializeObject(this, Formatting.None, new Newtonsoft.Json.Converters.IsoDateTimeConverter() { DateTimeFormat = CommonFunctions.DATE_FORMAT });
                toReturn.Result = this; // pt. ID-uri externe generate !!!
            }
            return toReturn;
        }

        /// <summary>
        /// Metoda pentru stergerea Dosarului curent
        /// </summary>
        /// <returns>SOCISA.response = new object(bool = status, string = error message, int = id-ul cheie returnat)</returns>
        public response Delete()
        {
            //lasam nomenclatoarele asociate
            response toReturn = new response(false, "", null, null, new List<Error>());;
            /*
            foreach (UtilizatoriDosareJson udj in this.UtilizatoriDosare)
            {
                udj.Delete();
            }
            foreach (DosareStadiiJson dsj in this.DosareStadii)
            {
                dsj.Delete();
            }
            foreach (DosareProceseJson dpj in this.DosareProcese)
            {
                dpj.Delete();
            }
            //DELETE PROCESE ???
            foreach (DosarePlatiJson dpj in this.DosarePlati)
            {
                dpj.Delete();
            }
            //DELETE PLATI ???
            foreach (DosarePlatiContracteJson dpcj in this.DosarePlatiContracte)
            {
                dpcj.Delete();
            }
            */
            //DELETE PLATI_CONTRACTE ???

            ArrayList _parameters = new ArrayList();
            _parameters.Add(new MySqlParameter("_ID", this.ID));
            DataAccess da = new DataAccess(authenticatedUserId, connectionString, CommandType.StoredProcedure, "DOSAREsp_soft_delete", _parameters.ToArray());
            toReturn = da.ExecuteDeleteQuery();
            /*
            if (toReturn.Status)
            {
                try
                {
                    if (System.Web.HttpContext.Current.Request.Params["SEND_MESSAGE"] != null && Convert.ToBoolean(System.Web.HttpContext.Current.Request.Params["SEND_MESSAGE"]))
                        Mesaje.GenerateAndSendMessage(this.ID, DateTime.Now, "Document nou", Convert.ToInt32(System.Web.HttpContext.Current.Session["AUTHENTICATED_ID"]), (int)Mesaje.Importanta.Low);
                }
                catch { }
            }
            */
            return toReturn;
        }

        /// <summary>
        /// Metoda pentru stergerea unui Dosar cu erori, rezultat in urma importului, in tabela temporara
        /// </summary>
        /// <returns>SOCISA.response = new object(bool = status, string = error message, int = id-ul cheie returnat)</returns>
        public response DeleteWithErrors()
        {
            //lasam nomenclatoarele asociate
            response toReturn = new response(true, "", null, null, new List<Error>()); ;
            ArrayList _parameters = new ArrayList();
            _parameters.Add(new MySqlParameter("_ID", this.ID));
            DataAccess da = new DataAccess(authenticatedUserId, connectionString, CommandType.StoredProcedure, "PENDING_IMPORT_ERRORSsp_soft_delete", _parameters.ToArray());
            toReturn = da.ExecuteDeleteQuery();
            return toReturn;
        }

        public response UpdateCounterDocumente(int _value)
        {
            DataAccess da = new DataAccess(authenticatedUserId, connectionString, CommandType.StoredProcedure, "DOSAREsp_UpdateCounterDocumente", new object[] { new MySqlParameter("_ID", this.ID), new MySqlParameter("_VALUE", _value) });
            return da.ExecuteUpdateQuery();
        }

        public response UpdateCounterProcese(int _value)
        {
            DataAccess da = new DataAccess(authenticatedUserId, connectionString, CommandType.StoredProcedure, "DOSAREsp_UpdateCounterProcese", new object[] { new MySqlParameter("_ID", this.ID), new MySqlParameter("_VALUE", _value) });
            return da.ExecuteUpdateQuery();
        }

        public response UpdateCounterPlati(int _value)
        {
            DataAccess da = new DataAccess(authenticatedUserId, connectionString, CommandType.StoredProcedure, "DOSAREsp_UpdateCounterPlati", new object[] { new MySqlParameter("_ID", this.ID), new MySqlParameter("_VALUE", _value) });
            return da.ExecuteUpdateQuery();
        }

        /// <summary>
        /// Metoda pentru preluare (import) dosar de la societate externa
        /// </summary>
        /// <returns>SOCISA.response = new object(bool = status, string = error message, int = id-ul cheie returnat)</returns>
        public void Import(int _import_type)
        {
            response r = Insert();
            Log(r, _import_type);
        }

        /// <summary>
        /// Metoda pentru logarea importului Dosarului curent
        /// </summary>
        public void Log(response r, int _import_type)
        {
            Log(r, DateTime.Now.Date, _import_type);
        }

        /// <summary>
        /// Metoda pentru logarea importului Dosarului curent
        /// </summary>
        /// <param name="_data_import">Data importului</param>
        public void Log(response r, DateTime _data_import, int _import_type)
        {
            DataAccess da = new DataAccess(authenticatedUserId, connectionString, CommandType.StoredProcedure, "DOSAREsp_import_log", new object[] { 
                new MySqlParameter("_STATUS", r.Status), 
                new MySqlParameter("_MESSAGE", r.Message), 
                new MySqlParameter("_INSERTED_ID", r.InsertedId), 
                new MySqlParameter("_ERRORS", Newtonsoft.Json.JsonConvert.SerializeObject(r.Error, CommonFunctions.JsonSerializerSettings)),
                new MySqlParameter("_IMPORT_TYPE", _import_type),
                new MySqlParameter("_DATA_IMPORT", _data_import) });
            da.ExecuteInsertQuery();
        }

        /// <summary>
        /// Metoda pentru validarea Dosarului curent
        /// </summary>
        /// <returns>SOCISA.response = new object(bool = status, string = error message, int = id-ul cheie returnat)</returns>
        public response Validare()
        {
            #region -- old --
            /*
            response toReturn = new response(true, "", null, null, new List<Error>());
            Error err = new Error();
            Validation[] validations = Validator.GetTableValidations(_TABLE_NAME);
            if (validations != null && validations.Length > 0) // daca s-au citit validarile din fisier mergem pe fisier
            {
                PropertyInfo[] pis = this.GetType().GetProperties();
                foreach (Validation v in validations)
                {
                    if (v.Active)
                    {
                        foreach (PropertyInfo pi in pis)
                        {
                            if (v.FieldName.ToUpper() == pi.Name.ToUpper())
                            {
                                switch (v.ValidationType)
                                {
                                    case "Mandatory":
                                        if (pi.GetValue(this) == null || pi.GetValue(this).ToString().Trim() == "")
                                        {
                                            toReturn.Status = false;
                                            err = ErrorParser.ErrorMessage(v.ErrorCode);
                                            toReturn.Message = string.Format("{0}{1};", toReturn.Message == null ? "" : toReturn.Message, err.ERROR_MESSAGE);
                                            toReturn.InsertedId = null;
                                            toReturn.Error.Add(err);
                                        }
                                        break;
                                    case "Confirmation":
                                        // ... TO DO ...
                                        break;
                                    case "Duplicate":
                                        try
                                        {
                                            Type typeOfThis = this.GetType();
                                            Type propertyType = pi.GetValue(this).GetType();
                                            //ConstructorInfo[] cis = typeOfThis.GetConstructors(BindingFlags.Instance | BindingFlags.Public | BindingFlags.NonPublic);
                                            ConstructorInfo ci = typeOfThis.GetConstructor(new Type[] {Type.GetType("System.Int32"), Type.GetType("System.String"), propertyType });

                                            if (ci != null && ID == null) // doar la insert verificam dublura
                                            {
                                                //Dosar dj = new Dosar(authenticatedUserId, connectionString, pi.GetValue(this).ToString()); // trebuie sa existe constructorul pt. campul trimis ca parametru !!!
                                                dynamic dj = Activator.CreateInstance(typeOfThis, new object[] { authenticatedUserId, connectionString, pi.GetValue(this) });
                                                if (dj != null && dj.ID != null)
                                                {
                                                    toReturn.Status = false;
                                                    err = ErrorParser.ErrorMessage(v.ErrorCode);
                                                    toReturn.Message = string.Format("{0}{1};", toReturn.Message == null ? "" : toReturn.Message, err.ERROR_MESSAGE);
                                                    toReturn.InsertedId = null;
                                                    toReturn.Error.Add(err);
                                                }
                                            }
                                        }
                                        catch { }
                                        break;
                                }
                                break;
                            }
                        }
                    }
                }
            }
            */
            #endregion
            bool succes;
            response toReturn = Validator.Validate(authenticatedUserId, connectionString, this, _TABLE_NAME, out succes);
            if(!succes) // daca nu s-au putut citi validarile din fisier, sau nu sunt definite in fisier, mergem pe varianta hardcodata
            {
                toReturn = new response(true, "", null, null, new List<Error>());
                Error err = new Error();

                if (this.ID_ASIGURAT_CASCO == null || this.ID_ASIGURAT_CASCO <= 0)
                {
                    toReturn.Status = false;
                    err = ErrorParser.ErrorMessage("emptyAsiguratCasco");
                    toReturn.Message = string.Format("{0}{1};", toReturn.Message == null ? "" : toReturn.Message, err.ERROR_MESSAGE);
                    toReturn.InsertedId = null;
                    toReturn.Error.Add(err);
                }
                /*
                if (this.ID_ASIGURAT_RCA == null || this.ID_ASIGURAT_RCA <= 0)
                {
                    toReturn.Status = false;
                    err = ErrorParser.ErrorMessage("emptyAsiguratRca");
                    toReturn.Message = string.Format("{0}{1};", toReturn.Message == null ? "" : toReturn.Message, err.ERROR_MESSAGE);
                    toReturn.InsertedId = null;
                    toReturn.Error.Add(err);
                }
                */
                if (this.ID_SOCIETATE_CASCO == null || this.ID_SOCIETATE_CASCO <= 0)
                {
                    toReturn.Status = false;
                    err = ErrorParser.ErrorMessage("emptyAsiguratorCasco");
                    toReturn.Message = string.Format("{0}{1};", toReturn.Message == null ? "" : toReturn.Message, err.ERROR_MESSAGE);
                    toReturn.InsertedId = null;
                    toReturn.Error.Add(err);
                }
                if (this.ID_SOCIETATE_RCA == null || this.ID_SOCIETATE_RCA <= 0)
                {
                    toReturn.Status = false;
                    err = ErrorParser.ErrorMessage("emptyAsiguratorRca");
                    toReturn.Message = string.Format("{0}{1};", toReturn.Message == null ? "" : toReturn.Message, err.ERROR_MESSAGE);
                    toReturn.InsertedId = null;
                    toReturn.Error.Add(err);
                }
                if (this.NR_DOSAR_CASCO == null || this.NR_DOSAR_CASCO.Trim() == "")
                {
                    toReturn.Status = false;
                    err = ErrorParser.ErrorMessage("emptyNrDosarCasco");
                    toReturn.Message = string.Format("{0}{1};", toReturn.Message == null ? "" : toReturn.Message, err.ERROR_MESSAGE);
                    toReturn.InsertedId = null;
                    toReturn.Error.Add(err);
                }
                if (this.NR_POLITA_CASCO == null || this.NR_POLITA_CASCO.Trim() == "")
                {
                    toReturn.Status = false;
                    err = ErrorParser.ErrorMessage("emptyNrPolitaCasco");
                    toReturn.Message = string.Format("{0}{1};", toReturn.Message == null ? "" : toReturn.Message, err.ERROR_MESSAGE);
                    toReturn.InsertedId = null;
                    toReturn.Error.Add(err);
                }
                if (this.NR_POLITA_RCA == null || this.NR_POLITA_RCA.Trim() == "")
                {
                    toReturn.Status = false;
                    err = ErrorParser.ErrorMessage("emptyNrPolitaRca");
                    toReturn.Message = string.Format("{0}{1};", toReturn.Message == null ? "" : toReturn.Message, err.ERROR_MESSAGE);
                    toReturn.InsertedId = null;
                    toReturn.Error.Add(err);
                }
                if (this.ID_AUTO_CASCO == null || this.ID_AUTO_CASCO <= 0)
                {
                    toReturn.Status = false;
                    err = ErrorParser.ErrorMessage("emptyAutoCasco");
                    toReturn.Message = string.Format("{0}{1};", toReturn.Message == null ? "" : toReturn.Message, err.ERROR_MESSAGE);
                    toReturn.InsertedId = null;
                    toReturn.Error.Add(err);
                }
                if (this.ID_AUTO_RCA == null || this.ID_AUTO_RCA <= 0)
                {
                    toReturn.Status = false;
                    err = ErrorParser.ErrorMessage("emptyAutoRca");
                    toReturn.Message = string.Format("{0}{1};", toReturn.Message == null ? "" : toReturn.Message, err.ERROR_MESSAGE);
                    toReturn.InsertedId = null;
                    toReturn.Error.Add(err);
                }
                if (this.VALOARE_DAUNA == null || this.VALOARE_DAUNA.ToString().Trim() == "")
                {
                    toReturn.Status = false;
                    err = ErrorParser.ErrorMessage("emptyValoareDauna");
                    toReturn.Message = string.Format("{0}{1};", toReturn.Message == null ? "" : toReturn.Message, err.ERROR_MESSAGE);
                    toReturn.InsertedId = null;
                    toReturn.Error.Add(err);
                }
                if (this.VALOARE_REGRES == null || this.VALOARE_REGRES.ToString().Trim() == "")
                {
                    toReturn.Status = false;
                    err = ErrorParser.ErrorMessage("emptyValoareRegres");
                    toReturn.Message = string.Format("{0}{1};", toReturn.Message == null ? "" : toReturn.Message, err.ERROR_MESSAGE);
                    toReturn.InsertedId = null;
                    toReturn.Error.Add(err);
                }
                if (this.DATA_EVENIMENT == null || this.DATA_EVENIMENT.ToString().Trim() == "")
                {
                    toReturn.Status = false;
                    err = ErrorParser.ErrorMessage("emptyDataEveniment");
                    toReturn.Message = string.Format("{0}{1};", toReturn.Message == null ? "" : toReturn.Message, err.ERROR_MESSAGE);
                    toReturn.InsertedId = null;
                    toReturn.Error.Add(err);
                }
                try
                {
                    if (ID == null) // doar la insert verificam dublura
                    {
                        Dosar dj = new Dosar(authenticatedUserId, connectionString, this.NR_DOSAR_CASCO);
                        if (dj != null && dj.ID != null)
                        {
                            toReturn.Status = false;
                            err = ErrorParser.ErrorMessage("dosarExistent");
                            toReturn.Message = string.Format("{0}{1};", toReturn.Message == null ? "" : toReturn.Message, err.ERROR_MESSAGE);
                            toReturn.InsertedId = null;
                            toReturn.Error.Add(err);
                        }
                    }
                }
                catch { }
            }
            return toReturn;
        }

        public response ValidareColoane(string fieldValueCollection)
        {
            return CommonFunctions.ValidareColoane(this, fieldValueCollection);
        }

        public response SetDataUltimeiModificari(DateTime _DATA_ULTIMEI_MODIFICARI)
        {
            response toReturn = new response(false, "", null, null, new List<Error>()); ;
            try
            {
                DataAccess da = new DataAccess(authenticatedUserId, connectionString, CommandType.StoredProcedure, "DOSAREsp_SetDataUltimeiModificari", new object[] { new MySqlParameter("_ID_DOSAR", ID), new MySqlParameter("_DATA_ULTIMEI_MODIFICARI", _DATA_ULTIMEI_MODIFICARI) });
                toReturn = da.ExecuteUpdateQuery();
            }
            catch { }
            return toReturn;
        }

        public response GetDataUltimeiModificari()
        {
            DateTime? toReturn = null;
            try
            {
                DataAccess da = new DataAccess(authenticatedUserId, connectionString, CommandType.StoredProcedure, "DOSAREsp_GetDataUltimeiModificari", new object[] { new MySqlParameter("_ID_DOSAR", ID) });
                toReturn = Convert.ToDateTime(da.ExecuteScalarQuery().Result);
                return new response(true, Newtonsoft.Json.JsonConvert.SerializeObject(toReturn, CommonFunctions.JsonSerializerSettings), toReturn, null, null);
            }
            catch (Exception exp) { LogWriter.Log(exp); return new response(false, exp.ToString(), null, null, new List<Error>() { new Error(exp) }); }
        }

        public response GetInvolvedParties()
        {
            try
            {
                DataAccess da = new DataAccess(authenticatedUserId, connectionString, CommandType.StoredProcedure, "DOSAREsp_GetInvolvedParties", new object[] { new MySqlParameter("_ID_DOSAR", ID) });
                MySqlDataReader r = da.ExecuteSelectQuery();
                /*
                ArrayList aList = new ArrayList();
                while (r.Read())
                {
                    Utilizator a = new Utilizator(authenticatedUserId, connectionString, Convert.ToInt32(r["ID"]));
                    aList.Add(a);
                }
                r.Close(); r.Dispose(); da.CloseConnection();
                Utilizator[] toReturn = new Utilizator[aList.Count];
                for (int i = 0; i < aList.Count; i++)
                {
                    toReturn[i] = (Utilizator)aList[i];
                }
                return new response(true, Newtonsoft.Json.JsonConvert.SerializeObject(toReturn, CommonFunctions.JsonSerializerSettings), toReturn, null, null);
                */
                List<Utilizator> aList = new List<Utilizator>();
                while (r.Read())
                {
                    Utilizator a = new Utilizator(authenticatedUserId, connectionString, Convert.ToInt32(r["ID"]));
                    aList.Add(a);
                }
                r.Close(); r.Dispose(); da.CloseConnection();
                return new response(true, Newtonsoft.Json.JsonConvert.SerializeObject(aList.ToArray(), CommonFunctions.JsonSerializerSettings), aList.ToArray(), null, null);
            }
            catch (Exception exp) { LogWriter.Log(exp); return new response(false, exp.ToString(), null, null, new List<Error>() { new Error(exp) }); }
        }

        /// <summary>
        /// Metoda pentru generarea filtrului de cautare/filtrare pe baza coloanelor si a valorilor acestora.
        /// Folosita la cautarea cu TypeAhead
        /// </summary>
        /// <returns>string cu filtrul ce va fi trimis ca parametru in procedura stocata din BD pentru filtrare</returns>
        public string GenerateFilterFromJsonObject()
        {
            return Filtering.GenerateFilterFromJsonObject(this);
        }

        public response HasChildrens(string tableName)
        {
            return CommonFunctions.HasChildrens(authenticatedUserId, connectionString, this, "dosare", tableName);
        }

        public response HasChildren(string tableName, int childrenId)
        {
            return CommonFunctions.HasChildren(authenticatedUserId, connectionString, this, "dosare", tableName, childrenId);
        }

        public response GetChildrens(string tableName)
        {
            return CommonFunctions.GetChildrens(this, tableName);
        }

        public response GetChildren(string tableName, int childrenId)
        {
            return CommonFunctions.GetChildren(this, tableName, childrenId);
        }

        public response ExportDocumenteDosarToPdf()
        {
            return PdfGenerator.ExportDocumenteDosarToPdf(this);
        }
        public response ExportDosarToPdf(string templateFileName)
        {
            return PdfGenerator.ExportDosarToPdf(authenticatedUserId, connectionString, templateFileName, this);
        }

        public response ExportDosarCompletToPdf(string templateFileName)
        {
            return PdfGenerator.ExportDosarCompletToPdf(authenticatedUserId, connectionString, templateFileName, this);
        }

        public response GenerateNotificarePdf()
        {
            return PdfGenerator.GenerateNotificarePdfWithPdfForm(this);
        }

        public response SendNotificare(EmailProfile ep)
        {
            response r = GenerateNotificarePdf();
            if (r.Status) {
                SocietateAsigurare sCasco = (SocietateAsigurare)this.GetSocietateCasco().Result;
                SocietateAsigurare sRca = (SocietateAsigurare)this.GetSocietateRca().Result;
                Auto autoRca = (Auto)this.GetAutoRca().Result;
                Emailing e = new Emailing(ep);
                e.Message.From = new MailAddress(ep.IncomingUser);
                e.Message.Bcc.Add(new MailAddress(ep.IncomingUser));
                //e.Message.CC.Add(new MailAddress(sCasco.EMAIL_NOTIFICARI));
                //e.Message.To.Add(new MailAddress(sRca.EMAIL_NOTIFICARI));
                e.Message.CC.Add(sCasco.EMAIL_NOTIFICARI);
                e.Message.To.Add(sRca.EMAIL_NOTIFICARI);
                e.Message.Subject = String.Format("Notificare dauna polita RCA {0} / Numar auto {1}", this.NR_POLITA_RCA, autoRca.NR_AUTO);
                e.Message.Headers.Add("ID_DOSAR", this.ID.ToString());
                e.Message.IsBodyHtml = true; // Altfel nu merge notificarea de Open si Click pe Amazon SES/SNS
                MD5 md5h = MD5.Create();
                string md5p = CommonFunctions.GetMd5Hash(md5h, this.NR_DOSAR_CASCO);
                string token = String.Format("{0}|{1}", md5p, this.ID);
                Uri uri = new Uri(System.Web.HttpContext.Current.Request.Url.AbsoluteUri);
                string pathQuery = uri.Scheme + Uri.SchemeDelimiter + uri.Authority;
                string linkDosar = String.Format("{0}/Dashboard/IndexMain/{1}", pathQuery, token);

                e.Message.Body = String.Format("Acesta este un mesaj generat automat prin care, in conformitate cu prevederile Deciziei CSA nr. 177/07.03.2011, in temeiul art. III 2. din Protocol, va instiintam despre un eveniment rutier produs din culpa unui conducator auto avand autovehiculul asigurat RCA la societatea dumneavoastra.<br /><br />Detalii suplimentare puteti gasi accesand linkul: <a ses:notrack href=\"{0}\">{1}</a>.<br /><br />Atasat va transmitem notificarea de dauna, procesul verbal sau constatarea amiabila si polita RCA.<br /><br /><br />Cu stima,<br />Echipa compensaredirecta.ro<br /><br />Va rugam sa nu raspundeti la acest email. Daca doriti sa ne contactati, scrieti-ne la avizari_rca@compensaredirecta.ro.", linkDosar, this.NR_DOSAR_CASCO);
                e.Message.Attachments.Add(new Attachment(r.Result.ToString()));

                r = e.SendMessageNotificare();
                return r;
            }
            else
            {
                return r;
            }
        }

        public response SendCerereDespagubire(EmailProfile ep)
        {
            try
            {
                string template = this.GetTemplateName();
                response r1 = ExportDosarToPdf(template);
                response r2 = ExportDocumenteDosarToPdf(); // ca sa fie generat cand acceseaza din email
                if (r1.Status && r2.Status)
                {
                    SocietateAsigurare sCasco = (SocietateAsigurare)this.GetSocietateCasco().Result;
                    SocietateAsigurare sRca = (SocietateAsigurare)this.GetSocietateRca().Result;
                    Auto autoRca = (Auto)this.GetAutoRca().Result;
                    Emailing e = new Emailing(ep);
                    e.Message.From = new MailAddress(ep.IncomingUser);
                    e.Message.Bcc.Add(new MailAddress(ep.IncomingUser));
                    //e.Message.CC.Add(new MailAddress(sCasco.EMAIL_NOTIFICARI));
                    //e.Message.To.Add(new MailAddress(sRca.EMAIL_NOTIFICARI));
                    e.Message.CC.Add(sCasco.EMAIL_NOTIFICARI);
                    e.Message.To.Add(sRca.EMAIL_NOTIFICARI);
                    //e.Message.Subject = String.Format("Cerere despagubire polita RCA {0} / Numar auto {1}", this.NR_POLITA_RCA, autoRca.NR_AUTO);
                    e.Message.Subject = String.Format("Regres casco {2} catre RCA - {0} / {1}", this.NR_POLITA_RCA, autoRca.NR_AUTO, sCasco.DENUMIRE_SCURTA);
                    e.Message.Headers.Add("ID_DOSAR", this.ID.ToString());
                    e.Message.IsBodyHtml = true; // Altfel nu merge notificarea de Open si Click pe Amazon SES/SNS
                    MD5 md5h = MD5.Create();
                    string md5p = CommonFunctions.GetMd5Hash(md5h, this.NR_DOSAR_CASCO);
                    string token = String.Format("{0}|{1}", md5p, this.ID);
                    Uri uri = new Uri(System.Web.HttpContext.Current.Request.Url.AbsoluteUri);
                    string pathQuery = uri.Scheme + Uri.SchemeDelimiter + uri.Authority;
                    //string linkDosar = String.Format("{0}/Dashboard/IndexMain/{1}", pathQuery, token);
                    //string linkDosar = String.Format("{0}/Login/{1}", pathQuery, token);
                    //string linkDosar = String.Format("{0}/Login/{1}{2}", pathQuery, "/Dashboard/IndexMain/", token);
                    //string linkDosar = String.Format("{0}/TokenLogin?_url={1}&_token={2}", pathQuery, HttpUtility.UrlEncode("/Dashboard/IndexMain/"), token);
                    //string linkDosar = String.Format("{0}/TokenLogin/{1}/{2}", pathQuery, HttpUtility.UrlEncode("/Dashboard/IndexMain/"), token);
                    string linkDosar = String.Format("{0}/Utilizatori/TokenLogin?_url={1}&_token={2}", pathQuery, HttpUtility.UrlEncode("/Dashboard/IndexMain/"), token);

                    //string linkDocumentePdf = String.Format("{0}/pdfs/{1}_documente.pdf", pathQuery, this.NR_DOSAR_CASCO);
                    //string linkDocumentePdf = String.Format("{0}/EPrint/{1}", pathQuery, token);
                    //string linkDocumentePdf = String.Format("{0}/Login/{1}{2}", pathQuery, "/EPrint/", token);
                    //string linkDocumentePdf = String.Format("{0}/TokenLogin?_url={1}&_token={2}", pathQuery, HttpUtility.UrlEncode("/EPrint/"), token);
                    //string linkDocumentePdf = String.Format("{0}/TokenLogin/{1}/{2}", pathQuery, HttpUtility.UrlEncode("/EPrint/"), token);
                    string linkDocumentePdf = String.Format("{0}/Utilizatori/TokenLogin?_url={1}&_token={2}", pathQuery, HttpUtility.UrlEncode("/EPrint/"), token);
                    string linkDocumenteZip = String.Format("{0}/Utilizatori/TokenLogin?_url={1}&_token={2}", pathQuery, HttpUtility.UrlEncode("/EZip/"), token);
                    string linkDocumenteZipBulk = String.Format("{0}/Utilizatori/TokenLogin?_url={1}&_token={2}", pathQuery, HttpUtility.UrlEncode("/EZipBulk/"), token);

                    //e.Message.Body = String.Format("Acesta este un mesaj generat automat.<br /><br />Puteti descarca documentele asociate dosarului facand click <a ses:notrack href=\"{2}\">aici</a>.<br /><br />Detalii suplimentare puteti gasi accesand linkul: <a ses:notrack href=\"{0}\">{1}</a>.<br /><br />Atasat va transmitem Cererea de despagubire.<br /><br /><br />Cu stima,<br />Echipa compensaredirecta.ro<br /><br />Va rugam sa nu raspundeti la acest email. Daca doriti sa ne contactati, scrieti-ne la avizari_rca@compensaredirecta.ro.", linkDosar, this.NR_DOSAR_CASCO, linkDocumentePdf);
                    string templateHtmlText = System.IO.File.ReadAllText(System.IO.Path.Combine(CommonFunctions.GetSettingsFolder(), "template_email_cerere_despagubire.html"));
                    templateHtmlText = templateHtmlText.Replace("{{NR_POLITA_RCA}}", NR_POLITA_RCA)
                        .Replace("{{NR_AUTO_RCA}}", autoRca.NR_AUTO)
                        .Replace("{{LINK_DOCUMENTE_PDF}}", linkDocumentePdf)
                        .Replace("{{LINK_DOSAR}}", linkDosar)
                        .Replace("{{NR_DOSAR_CASCO}}", NR_DOSAR_CASCO)
                        .Replace("{{LINK_DOCUMENTE_ZIP}}", linkDocumenteZip)
                        .Replace("{{LINK_DOCUMENTE_ZIP_BULK}}", linkDocumenteZipBulk);
                    e.Message.Body = templateHtmlText;
                    e.Message.Attachments.Add(new Attachment(r1.Result.ToString()));

                    r1 = e.SendMessageCerereDespagubire();
                    return r1;
                }
                else
                {
                    return r1;
                }
            }catch(Exception ex)
            {
                LogWriter.Log(ex);
                return new response(false, ex.Message, null, null, new List<Error>() { new Error(ex) });
            }
        }

        public string GetTemplateName()
        {
            DocumentScanat[] tmp = (DocumentScanat[])GetDocumente().Result;
            SocietateAsigurare srca = (SocietateAsigurare)GetSocietateRca().Result;
            bool faliment = false;
            if (srca.DENUMIRE.ToUpper().IndexOf("ASTRA") > -1 || srca.DENUMIRE.ToUpper().IndexOf("CARPATICA") > -1)
            {
                faliment = true;
            }
            bool constatare_amiabila = false;
            foreach (DocumentScanat ds in tmp)
            {
                Nomenclator tip_doc = new Nomenclator(authenticatedUserId, connectionString, "TIP_DOCUMENT", Convert.ToInt32(ds.ID_TIP_DOCUMENT));
                if (tip_doc.DENUMIRE == "CONSTATARE AMIABILA")
                {
                    constatare_amiabila = true;
                    break;
                }
            }
            string template = "";
            if (faliment && constatare_amiabila) template = _TEMPLATE_CERERE_DESPAGUBIRE3;
            if (faliment && !constatare_amiabila) template = _TEMPLATE_CERERE_DESPAGUBIRE4;
            if (!faliment && constatare_amiabila) template = _TEMPLATE_CERERE_DESPAGUBIRE1;
            if (!faliment && !constatare_amiabila) template = _TEMPLATE_CERERE_DESPAGUBIRE2;
            return template;
        }

        public response MovePendingToOk()
        {
            response toReturn = new response(false, "", null, null, new List<Error>()); ;
            try
            {
                DataAccess da = new DataAccess(authenticatedUserId, connectionString, CommandType.StoredProcedure, "DOSAREsp_MovePendingToOk", new object[] { new MySqlParameter("_PENDING_ID", ID) });
                toReturn = da.ExecuteInsertQuery();
            }
            catch { }
            return toReturn;
        }

        public response UpdateRestPlata(double? _rest_plata)
        {
            response toReturn = new response(false, "", null, null, new List<Error>()); ;
            try
            {
                DataAccess da = new DataAccess(authenticatedUserId, connectionString, CommandType.StoredProcedure, "DOSAREsp_UpdateRestPlata", new object[] { new MySqlParameter("_ID", ID), new MySqlParameter("_REST_PLATA", _rest_plata) });
                toReturn = da.ExecuteUpdateQuery();
            }
            catch { }
            return toReturn;
        }

        public response UpdateSendStatus(string _send_status)
        {
            response toReturn = new response(false, "", null, null, new List<Error>()); ;
            try
            {
                DataAccess da = new DataAccess(authenticatedUserId, connectionString, CommandType.StoredProcedure, "DOSAREsp_UpdateSendStatus", new object[] { new MySqlParameter("_ID", ID), new MySqlParameter("_SEND_STATUS", _send_status) });
                toReturn = da.ExecuteUpdateQuery();
            }
            catch { }
            return toReturn;
        }

    }
}