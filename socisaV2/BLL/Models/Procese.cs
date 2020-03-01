using MySql.Data.MySqlClient;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Reflection;
using Newtonsoft.Json;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel;

namespace SOCISA.Models
{
    /// <summary>
    /// Clasa care contine definitia obiectului ce mapeaza tabela cu Procese din baza de date
    /// </summary>
    public class Proces
    {
        const string _TABLE_NAME = "procese";
        private int authenticatedUserId { get; set; }
        private string connectionString { get; set; }

        public int? ID { get; set; }

        [JsonProperty(NullValueHandling = NullValueHandling.Include)]
        [Display(Name = "NR_SCA", ResourceType = typeof(socisaV2.Resources.ProceseResx))]
        public string NR_SCA { get; set; }

        [JsonProperty(NullValueHandling = NullValueHandling.Include)]
        [Display(Name = "DATA_SCA", ResourceType = typeof(socisaV2.Resources.ProceseResx))]
        public DateTime? DATA_SCA { get; set; }

        [JsonProperty(NullValueHandling = NullValueHandling.Include)]
        [Display(Name = "NR_DOSAR_CASCO", ResourceType = typeof(socisaV2.Resources.ProceseResx))]
        public string NR_DOSAR_CASCO { get; set; }

        [JsonProperty(NullValueHandling = NullValueHandling.Include)]
        [Required(ErrorMessageResourceName = "emptyNrDosarInstantaProcese", ErrorMessageResourceType = typeof(socisaV2.Resources.ErrorMessagesResx))]
        [Display(Name = "NR_DOSAR_INSTANTA", ResourceType = typeof(socisaV2.Resources.ProceseResx))]
        public string NR_DOSAR_INSTANTA { get; set; }

        [JsonProperty(NullValueHandling = NullValueHandling.Include)]
        [Required(ErrorMessageResourceName = "emptyDataDepunereProcese", ErrorMessageResourceType = typeof(socisaV2.Resources.ErrorMessagesResx))]
        [Display(Name = "DATA_DEPUNERE", ResourceType = typeof(socisaV2.Resources.ProceseResx))]
        public DateTime? DATA_DEPUNERE { get; set; }

        [JsonProperty(NullValueHandling = NullValueHandling.Include)]
        [Display(Name = "OBSERVATII", ResourceType = typeof(socisaV2.Resources.ProceseResx))]
        public string OBSERVATII { get; set; }

        [DefaultValue(0)]
        [JsonProperty(NullValueHandling = NullValueHandling.Include)]
        [Required(ErrorMessageResourceName = "emptySumaSolicitataProcese", ErrorMessageResourceType = typeof(socisaV2.Resources.ErrorMessagesResx))]
        [Display(Name = "SUMA_SOLICITATA", ResourceType = typeof(socisaV2.Resources.ProceseResx))]
        public double? SUMA_SOLICITATA { get; set; }

        [DefaultValue(0)]
        [JsonProperty(NullValueHandling = NullValueHandling.Include)]
        [Required(ErrorMessageResourceName = "emptyPenalitatiProcese", ErrorMessageResourceType = typeof(socisaV2.Resources.ErrorMessagesResx))]
        [Display(Name = "PENALITATI", ResourceType = typeof(socisaV2.Resources.ProceseResx))]
        public double? PENALITATI { get; set; }

        [DefaultValue(0)]
        [JsonProperty(NullValueHandling = NullValueHandling.Include)]
        [Display(Name = "TAXA_TIMBRU", ResourceType = typeof(socisaV2.Resources.ProceseResx))]
        public double? TAXA_TIMBRU { get; set; }

        [DefaultValue(0)]
        [JsonProperty(NullValueHandling = NullValueHandling.Include)]
        [Display(Name = "TIMBRU_JUDICIAR", ResourceType = typeof(socisaV2.Resources.ProceseResx))]
        public double? TIMBRU_JUDICIAR { get; set; }

        [DefaultValue(0)]
        [JsonProperty(NullValueHandling = NullValueHandling.Include)]
        [Display(Name = "ONORARIU_EXPERT", ResourceType = typeof(socisaV2.Resources.ProceseResx))]
        public double? ONORARIU_EXPERT { get; set; }

        [DefaultValue(0)]
        [JsonProperty(NullValueHandling = NullValueHandling.Include)]
        [Display(Name = "ONORARIU_AVOCAT", ResourceType = typeof(socisaV2.Resources.ProceseResx))]
        public double? ONORARIU_AVOCAT { get; set; }

        [JsonProperty(NullValueHandling = NullValueHandling.Include)]
        [Display(Name = "ID_INSTANTA", ResourceType = typeof(socisaV2.Resources.ProceseResx))]
        public int? ID_INSTANTA { get; set; }

        [JsonProperty(NullValueHandling = NullValueHandling.Include)]
        [Display(Name = "ID_COMPLET", ResourceType = typeof(socisaV2.Resources.ProceseResx))]
        public int? ID_COMPLET { get; set; }

        [JsonProperty(NullValueHandling = NullValueHandling.Include)]
        [Display(Name = "ZILE_PENALIZARI", ResourceType = typeof(socisaV2.Resources.ProceseResx))]
        public int? ZILE_PENALIZARI { get; set; }

        [JsonProperty(NullValueHandling = NullValueHandling.Include)]
        [Display(Name = "CHELTUIELI_MICA_PUBLICITATE", ResourceType = typeof(socisaV2.Resources.ProceseResx))]
        public double? CHELTUIELI_MICA_PUBLICITATE { get; set; }

        [DefaultValue(0)]
        [JsonProperty(NullValueHandling = NullValueHandling.Include)]
        [Display(Name = "ONORARIU_CURATOR", ResourceType = typeof(socisaV2.Resources.ProceseResx))]
        public double? ONORARIU_CURATOR { get; set; }

        [DefaultValue(0)]
        [JsonProperty(NullValueHandling = NullValueHandling.Include)]
        [Display(Name = "ALTE_CHELTUIELI_JUDECATA", ResourceType = typeof(socisaV2.Resources.ProceseResx))]
        public double? ALTE_CHELTUIELI_JUDECATA { get; set; }

        [DefaultValue(0)]
        [JsonProperty(NullValueHandling = NullValueHandling.Include)]
        [Display(Name = "TAXA_TIMBRU_REEXAMINARE", ResourceType = typeof(socisaV2.Resources.ProceseResx))]
        public double? TAXA_TIMBRU_REEXAMINARE { get; set; }

        [JsonProperty(NullValueHandling = NullValueHandling.Include)]
        [Display(Name = "NR_DOSAR_EXECUTARE", ResourceType = typeof(socisaV2.Resources.ProceseResx))]
        public string NR_DOSAR_EXECUTARE { get; set; }

        [JsonProperty(NullValueHandling = NullValueHandling.Include)]
        [Display(Name = "DATA_EXECUTARE", ResourceType = typeof(socisaV2.Resources.ProceseResx))]
        public DateTime? DATA_EXECUTARE { get; set; }

        [DefaultValue(0)]
        [JsonProperty(NullValueHandling = NullValueHandling.Include)]
        [Display(Name = "ONORARIU_AVOCAT_EXECUTARE", ResourceType = typeof(socisaV2.Resources.ProceseResx))]
        public double? ONORARIU_AVOCAT_EXECUTARE { get; set; }

        [DefaultValue(0)]
        [JsonProperty(NullValueHandling = NullValueHandling.Include)]
        [Display(Name = "CHELTUIELI_EXECUTARE", ResourceType = typeof(socisaV2.Resources.ProceseResx))]
        public double? CHELTUIELI_EXECUTARE { get; set; }

        [DefaultValue(0)]
        [JsonProperty(NullValueHandling = NullValueHandling.Include)]
        [Display(Name = "DESPAGUBIRE_ACORDATA", ResourceType = typeof(socisaV2.Resources.ProceseResx))]
        public double? DESPAGUBIRE_ACORDATA { get; set; }

        [DefaultValue(0)]
        [JsonProperty(NullValueHandling = NullValueHandling.Include)]
        [Display(Name = "CHELTUIELI_JUDECATA_ACORDATE", ResourceType = typeof(socisaV2.Resources.ProceseResx))]
        public double? CHELTUIELI_JUDECATA_ACORDATE { get; set; }

        [JsonProperty(NullValueHandling = NullValueHandling.Include)]
        [Display(Name = "MONITORIZARE", ResourceType = typeof(socisaV2.Resources.ProceseResx))]
        public bool? MONITORIZARE { get; set; }

        [JsonProperty(NullValueHandling = NullValueHandling.Include)]
        [Display(Name = "ID_TIP_PROCES", ResourceType = typeof(socisaV2.Resources.ProceseResx))]
        public int? ID_TIP_PROCES { get; set; }

        [JsonProperty(NullValueHandling = NullValueHandling.Include)]
        [Display(Name = "ID_DOSAR", ResourceType = typeof(socisaV2.Resources.ProceseResx))]
        public int? ID_DOSAR { get; set; }

        [JsonProperty(NullValueHandling = NullValueHandling.Include)]
        [Display(Name = "ID_CONTRACT", ResourceType = typeof(socisaV2.Resources.ProceseResx))]
        public int? ID_CONTRACT { get; set; }

        [JsonProperty(NullValueHandling = NullValueHandling.Include)]
        [Display(Name = "ID_PROCES_STADIU", ResourceType = typeof(socisaV2.Resources.ProceseResx))]
        public int? ID_PROCES_STADIU { get; set; }

        [JsonProperty(NullValueHandling = NullValueHandling.Include)]
        [Display(Name = "ID_RECLAMANT", ResourceType = typeof(socisaV2.Resources.ProceseResx))]
        public int? ID_RECLAMANT { get; set; }

        [JsonProperty(NullValueHandling = NullValueHandling.Include)]
        [Display(Name = "ID_PARAT", ResourceType = typeof(socisaV2.Resources.ProceseResx))]
        public int? ID_PARAT { get; set; }

        [JsonProperty(NullValueHandling = NullValueHandling.Include)]
        [Display(Name = "ID_TERT", ResourceType = typeof(socisaV2.Resources.ProceseResx))]
        public int? ID_TERT { get; set; }

        [JsonProperty(NullValueHandling = NullValueHandling.Include)]
        [Display(Name = "CALITATE_TERT", ResourceType = typeof(socisaV2.Resources.ProceseResx))]
        public string CALITATE_TERT { get; set; }
        /*
        [JsonProperty(NullValueHandling = NullValueHandling.Include)]
        [Display(Name = "CALITATE", ResourceType = typeof(socisaV2.Resources.ProceseResx))]
        public string CALITATE { get; set; }
        */

        /// <summary>
        /// Constructorul default
        /// </summary>
        public Proces() { }

        public Proces(int _authenticatedUserId, string _connectionString)
        {
            authenticatedUserId = _authenticatedUserId;
            connectionString = _connectionString;
        }

        public Proces(int _authenticatedUserId, string _connectionString, int _ID)
        {
            authenticatedUserId = _authenticatedUserId;
            connectionString = _connectionString;
            DataAccess da = new DataAccess(authenticatedUserId, connectionString, CommandType.StoredProcedure, "PROCESEsp_GetById", new object[] { new MySqlParameter("_ID", _ID) });
            MySqlDataReader r = da.ExecuteSelectQuery();
            while (r.Read())
            {
                IDataRecord item = (IDataRecord)r;
                ProcesConstructor(item);
                break;
            }
            r.Close(); r.Dispose(); da.CloseConnection();
        }

        public Proces(int _authenticatedUserId, string _connectionString, IDataRecord item)
        {
            authenticatedUserId = _authenticatedUserId;
            connectionString = _connectionString;
            ProcesConstructor(item);
        }

        /// <summary>
        /// Functie pentru popularea obiectului Proces, folosta de diferiti constructori
        /// </summary>
        /// <param name="dosarInstanta">Inregistrare din DB cu informatiile procesului de instanta curent</param>
        public void ProcesConstructor(IDataRecord dosarInstanta)
        {
            try { this.ID = Convert.ToInt32(dosarInstanta["ID"]); }
            catch { }
            try { this.ID_DOSAR = Convert.ToInt32(dosarInstanta["ID_DOSAR"]); }
            catch { }
            try { this.NR_SCA = dosarInstanta["NR_SCA"].ToString(); }
            catch { }
            try { this.DATA_SCA = CommonFunctions.IsNullable(dosarInstanta["DATA_SCA"]) ? null : (DateTime?)Convert.ToDateTime(dosarInstanta["DATA_SCA"]); }
            catch { }
            try { this.NR_DOSAR_CASCO = dosarInstanta["NR_DOSAR_CASCO"].ToString(); }
            catch { }
            try { this.NR_DOSAR_INSTANTA = dosarInstanta["NR_DOSAR_INSTANTA"].ToString(); }
            catch { }
            try { this.DATA_DEPUNERE = CommonFunctions.IsNullable(dosarInstanta["DATA_DEPUNERE"]) ? null : (DateTime?)Convert.ToDateTime(dosarInstanta["DATA_DEPUNERE"]); }
            catch { }
            try { this.OBSERVATII = dosarInstanta["OBSERVATII"].ToString(); }
            catch { }
            try { this.SUMA_SOLICITATA = Convert.ToDouble(dosarInstanta["SUMA_SOLICITATA"]); }
            catch { }
            try { this.PENALITATI = Convert.ToDouble(dosarInstanta["PENALITATI"]); }
            catch { }
            try { this.TAXA_TIMBRU = Convert.ToDouble(dosarInstanta["TAXA_TIMBRU"]); }
            catch { }
            try { this.TIMBRU_JUDICIAR = Convert.ToDouble(dosarInstanta["TIMBRU_JUDICIAR"]); }
            catch { }
            try { this.ONORARIU_EXPERT = Convert.ToDouble(dosarInstanta["ONORARIU_EXPERT"]); }
            catch { }
            try { this.ONORARIU_AVOCAT = Convert.ToDouble(dosarInstanta["ONORARIU_AVOCAT"]); }
            catch { }
            try { this.ID_INSTANTA = Convert.ToInt32(dosarInstanta["ID_INSTANTA"]); }
            catch { }
            try { this.ID_COMPLET = Convert.ToInt32(dosarInstanta["ID_COMPLET"]); }
            catch { }
            try { this.ZILE_PENALIZARI = Convert.ToInt32(dosarInstanta["ZILE_PENALIZARI"]); }
            catch { }
            try { this.CHELTUIELI_MICA_PUBLICITATE = Convert.ToDouble(dosarInstanta["CHELTUIELI_MICA_PUBLICITATE"]); }
            catch { }
            try { this.ONORARIU_CURATOR = Convert.ToDouble(dosarInstanta["ONORARIU_CURATOR"]); }
            catch { }
            try { this.ALTE_CHELTUIELI_JUDECATA = Convert.ToDouble(dosarInstanta["ALTE_CHELTUIELI_JUDECATA"]); }
            catch { }
            try { this.TAXA_TIMBRU_REEXAMINARE = Convert.ToDouble(dosarInstanta["TAXA_TIMBRU_REEXAMINARE"]); }
            catch { }
            try { this.NR_DOSAR_EXECUTARE = dosarInstanta["NR_DOSAR_EXECUTARE"].ToString(); }
            catch { }
            try { this.DATA_EXECUTARE = CommonFunctions.IsNullable(dosarInstanta["DATA_EXECUTARE"]) ? null : (DateTime?)Convert.ToDateTime(dosarInstanta["DATA_EXECUTARE"]); }
            catch { }
            try { this.ONORARIU_AVOCAT_EXECUTARE = Convert.ToDouble(dosarInstanta["ONORARIU_AVOCAT_EXECUTARE"]); }
            catch { }
            try { this.CHELTUIELI_EXECUTARE = Convert.ToDouble(dosarInstanta["CHELTUIELI_EXECUTARE"]); }
            catch { }
            try { this.DESPAGUBIRE_ACORDATA = Convert.ToDouble(dosarInstanta["DESPAGUBIRE_ACORDATA"]); }
            catch { }
            try { this.CHELTUIELI_JUDECATA_ACORDATE = Convert.ToDouble(dosarInstanta["CHELTUIELI_JUDECATA_ACORDATE"]); }
            catch { }
            try { this.MONITORIZARE = Convert.ToBoolean(dosarInstanta["MONITORIZARE"]); }
            catch { }
            try { this.ID_TIP_PROCES = Convert.ToInt32(dosarInstanta["ID_TIP_PROCES"]); }
            catch { }
            try { this.ID_CONTRACT = Convert.ToInt32(dosarInstanta["ID_CONTRACT"]); }
            catch { }
            try { this.ID_PROCES_STADIU = Convert.ToInt32(dosarInstanta["ID_PROCES_STADIU"]); }
            catch { }
            try { this.ID_RECLAMANT = Convert.ToInt32(dosarInstanta["ID_RECLAMANT"]); }
            catch { }
            try { this.ID_PARAT = Convert.ToInt32(dosarInstanta["ID_PARAT"]); }
            catch { }
            try { this.ID_TERT = Convert.ToInt32(dosarInstanta["ID_TERT"]); }
            catch { }
            try { this.CALITATE_TERT = dosarInstanta["CALITATE_TERT"].ToString(); }
            catch { }
            /*
            try { this.CALITATE = dosarInstanta["CALITATE"].ToString(); }
            catch { }
            */
            /*
            try { this.Instanta = GetInstanta(); }
            catch { }
            try { this.Complet = GetComplet(); }
            catch { }
            try { this.Contract = GetContract(); }
            catch { }
            try { this.TipProces = GetTipProces(); }
            catch { }
            try { this.PlatiTaxaTimbru = GetPlatiTaxaTimbru(); }
            catch { }
            */
        }

        public response GetReclamant()
        {
            return GetReclamant(null);
        }

        public response GetReclamant(int? ID_SOCIETATE)
        {
            try
            {
                if (this.ID_DOSAR != null)
                {
                    Dosar d = new Dosar(authenticatedUserId, connectionString, Convert.ToInt32(this.ID_DOSAR));
                    SocietateAsigurare reclamant = new SocietateAsigurare(authenticatedUserId, connectionString, Convert.ToInt32(d.ID_SOCIETATE_CASCO));
                    return new response(true, JsonConvert.SerializeObject(reclamant, CommonFunctions.JsonSerializerSettings), reclamant, null, null);
                }
                else
                {
                    if (this.ID_RECLAMANT != null)
                    {
                        string calitate = "";
                        try
                        {
                            calitate = ((Nomenclator)this.GetCalitate(Convert.ToInt32(ID_SOCIETATE)).Result).DENUMIRE;
                        }
                        catch { }
                        if (calitate == "RECLAMANT")
                        {
                            SocietateAsigurare sa = new SocietateAsigurare(authenticatedUserId, connectionString, Convert.ToInt32(this.ID_RECLAMANT));
                            return new response(true, JsonConvert.SerializeObject(sa, CommonFunctions.JsonSerializerSettings), sa, null, null);
                        }
                        else
                        {
                            Parte p = new Parte(authenticatedUserId, connectionString, Convert.ToInt32(this.ID_RECLAMANT));
                            return new response(true, JsonConvert.SerializeObject(p, CommonFunctions.JsonSerializerSettings), p, null, null);
                        }
                    }
                    else
                    {
                        //return new response(true, null, null, null, null);
                        Parte p = new Parte(authenticatedUserId, connectionString);
                        return new response(true, JsonConvert.SerializeObject(p, CommonFunctions.JsonSerializerSettings), p, null, null);
                    }
                }
            }
            catch (Exception exp) { LogWriter.Log(exp); return new response(false, exp.ToString(), null, null, new List<Error>() { new Error(exp) }); }
        }

        public response GetParat()
        {
            return GetParat(null);
        }

        public response GetParat(int? ID_SOCIETATE)
        {
            try
            {
                if (this.ID_DOSAR != null)
                {
                    Dosar d = new Dosar(authenticatedUserId, connectionString, Convert.ToInt32(this.ID_DOSAR));
                    SocietateAsigurare parat = new SocietateAsigurare(authenticatedUserId, connectionString, Convert.ToInt32(d.ID_SOCIETATE_RCA));
                    return new response(true, JsonConvert.SerializeObject(parat, CommonFunctions.JsonSerializerSettings), parat, null, null);
                }
                else
                {
                    if (this.ID_PARAT != null)
                    {
                        string calitate = "";
                        try
                        {
                            calitate = ((Nomenclator)this.GetCalitate(Convert.ToInt32(ID_SOCIETATE)).Result).DENUMIRE;
                        }
                        catch { }
                        if (calitate == "PARAT")
                        {
                            SocietateAsigurare sa = new SocietateAsigurare(authenticatedUserId, connectionString, Convert.ToInt32(this.ID_PARAT));
                            return new response(true, JsonConvert.SerializeObject(sa, CommonFunctions.JsonSerializerSettings), sa, null, null);
                        }
                        else
                        {
                            Parte p = new Parte(authenticatedUserId, connectionString, Convert.ToInt32(this.ID_PARAT));
                            return new response(true, JsonConvert.SerializeObject(p, CommonFunctions.JsonSerializerSettings), p, null, null);
                        }
                    }
                    else
                    {
                        //return new response(true, null, null, null, null);
                        Parte p = new Parte(authenticatedUserId, connectionString);
                        return new response(true, JsonConvert.SerializeObject(p, CommonFunctions.JsonSerializerSettings), p, null, null);
                    }
                }
            }
            catch (Exception exp) { LogWriter.Log(exp); return new response(false, exp.ToString(), null, null, new List<Error>() { new Error(exp) }); }
        }

        public response GetTert(int? ID_SOCIETATE)
        {
            try
            {
                if (this.ID_TERT != null)
                {
                    string calitate = "";
                    try
                    {
                        calitate = ((Nomenclator)this.GetCalitate(Convert.ToInt32(ID_SOCIETATE)).Result).DENUMIRE;
                    }
                    catch { }
                    if (calitate == "TERT")
                    {
                        SocietateAsigurare sa = new SocietateAsigurare(authenticatedUserId, connectionString, Convert.ToInt32(this.ID_TERT));
                        return new response(true, JsonConvert.SerializeObject(sa, CommonFunctions.JsonSerializerSettings), sa, null, null);
                    }
                    else
                    {
                        Parte p = new Parte(authenticatedUserId, connectionString, Convert.ToInt32(this.ID_TERT));
                        return new response(true, JsonConvert.SerializeObject(p, CommonFunctions.JsonSerializerSettings), p, null, null);
                    }
                }
                else
                {
                    Parte p = new Parte(authenticatedUserId, connectionString);
                    return new response(true, JsonConvert.SerializeObject(p, CommonFunctions.JsonSerializerSettings), p, null, null);
                }
            }
            catch (Exception exp) { LogWriter.Log(exp); return new response(false, exp.ToString(), null, null, new List<Error>() { new Error(exp) }); }
        }

        public response GetCalitate(int ID_SOCIETATE)
        {
            try
            {
                Nomenclator toReturn = null;
                if (this.ID_DOSAR != null)
                {
                    Dosar d = new Dosar(authenticatedUserId, connectionString, Convert.ToInt32(this.ID_DOSAR));
                    if (d.ID_SOCIETATE_CASCO == ID_SOCIETATE)
                    {
                        toReturn = new Nomenclator(authenticatedUserId, connectionString, "calitati", "RECLAMANT");
                    }
                    else
                    {
                        if (d.ID_SOCIETATE_RCA == ID_SOCIETATE)
                        {
                            toReturn = new Nomenclator(authenticatedUserId, connectionString, "calitati", "PARAT");
                        }
                        else
                        {
                            toReturn = new Nomenclator(authenticatedUserId, connectionString, "calitati", "TERT");
                        }
                    }
                }
                else
                {
                    if (this.ID_RECLAMANT == ID_SOCIETATE)
                    {
                        toReturn = new Nomenclator(authenticatedUserId, connectionString, "calitati", "RECLAMANT");
                    }
                    else
                    {
                        if (this.ID_PARAT == ID_SOCIETATE)
                        {
                            toReturn = new Nomenclator(authenticatedUserId, connectionString, "calitati", "PARAT");
                        }
                        else
                        {
                            toReturn = new Nomenclator(authenticatedUserId, connectionString, "calitati", "TERT");
                        }
                    }
                }
                return new response(true, JsonConvert.SerializeObject(toReturn, CommonFunctions.JsonSerializerSettings), toReturn, null, null);

            }
            catch (Exception exp) { LogWriter.Log(exp); return new response(false, exp.ToString(), null, null, new List<Error>() { new Error(exp) }); }
        }

        /// <summary>
        /// Metoda pt. popularea Instantei din dosar
        /// </summary>
        /// <returns>SOCISA.NomenclatorJson</returns>
        public response GetInstanta()
        {
            try
            {
                Nomenclator toReturn = new Nomenclator(authenticatedUserId, connectionString, "instante", Convert.ToInt32(this.ID_INSTANTA));
                return new response(true, Newtonsoft.Json.JsonConvert.SerializeObject(toReturn, CommonFunctions.JsonSerializerSettings), toReturn, null, null);
            }
            catch (Exception exp) { LogWriter.Log(exp); return new response(false, exp.ToString(), null, null, new List<Error>() { new Error(exp) }); }
        }

        /// <summary>
        /// Metoda pt. popularea Completului din dosar
        /// </summary>
        /// <returns>SOCISA.NomenclatorJson</returns>
        public response GetComplet()
        {
            try
            {
                Nomenclator toReturn = new Nomenclator(authenticatedUserId, connectionString, "complete", Convert.ToInt32(this.ID_COMPLET));
                return new response(true, Newtonsoft.Json.JsonConvert.SerializeObject(toReturn, CommonFunctions.JsonSerializerSettings), toReturn, null, null);
            }
            catch (Exception exp) { LogWriter.Log(exp); return new response(false, exp.ToString(), null, null, new List<Error>() { new Error(exp) }); }
        }

        /// <summary>
        /// Metoda pt. popularea Tipului de proces
        /// </summary>
        /// <returns>SOCISA.NomenclatorJson</returns>
        public response GetTipProces()
        {
            try
            {
                Nomenclator toReturn = new Nomenclator(authenticatedUserId, connectionString, "tip_procese", Convert.ToInt32(this.ID_TIP_PROCES));
                return new response(true, JsonConvert.SerializeObject(toReturn, CommonFunctions.JsonSerializerSettings), toReturn, null, null);
            }
            catch (Exception exp) { LogWriter.Log(exp); return new response(false, exp.ToString(), null, null, new List<Error>() { new Error(exp) }); }
        }

        /// <summary>
        /// Metoda pt. popularea Contractului de asistenta juridica atasat procesului curent
        /// </summary>
        /// <returns>SOCISA.ContracteJson</returns>
        public response GetContract()
        {
            try
            {
                Contract toReturn = new Contract(authenticatedUserId, connectionString, Convert.ToInt32(this.ID_CONTRACT));
                return new response(true, JsonConvert.SerializeObject(toReturn, CommonFunctions.JsonSerializerSettings), toReturn, null, null);
            }
            catch (Exception exp) { LogWriter.Log(exp); return new response(false, exp.ToString(), null, null, new List<Error>() { new Error(exp) }); }
        }

        public response GetStadiuCurent()
        {
            try
            {
                
                DataAccess da = new DataAccess(authenticatedUserId, connectionString, CommandType.StoredProcedure, "PROCESEsp_GetStadiuCurent", new object[] { new MySqlParameter("_ID_PROCES", this.ID) });
                MySqlDataReader r = da.ExecuteSelectQuery();
                ProcesStadiu toReturn = new ProcesStadiu();
                while (r.Read())
                {
                    toReturn = new ProcesStadiu(authenticatedUserId, connectionString, Convert.ToInt32(r["ID"]));
                    break;
                }
                r.Close(); r.Dispose(); da.CloseConnection();
                return new response(true, JsonConvert.SerializeObject(toReturn, CommonFunctions.JsonSerializerSettings), toReturn, null, null);
                
                /*
                ProcesStadiu toReturn = new ProcesStadiu(authenticatedUserId, connectionString, Convert.ToInt32(this.ID_PROCES_STADIU));
                return new response(true, JsonConvert.SerializeObject(toReturn, CommonFunctions.JsonSerializerSettings), toReturn, null, null);                
                */
            }
            catch (Exception exp) { LogWriter.Log(exp); return new response(false, exp.ToString(), null, null, new List<Error>() { new Error(exp) }); }
        }

        /// <summary>
        /// Metoda pt. popularea Stadiilor Dosarului
        /// </summary>
        /// <returns>vector de SOCISA.StadiiJson</returns>
        public response GetStadii()
        {
            try
            {
                DataAccess da = new DataAccess(authenticatedUserId, connectionString, CommandType.StoredProcedure, "PROCESE_STADIIsp_GetByIdProces", new object[] { new MySqlParameter("_ID_PROCES", this.ID) });
                MySqlDataReader r = da.ExecuteSelectQuery();
                List<ProcesStadiu> aList = new List<ProcesStadiu>();
                while (r.Read())
                {
                    aList.Add(new ProcesStadiu(authenticatedUserId, connectionString, Convert.ToInt32(r["ID"])));
                }
                r.Close(); r.Dispose(); da.CloseConnection();
                return new response(true, Newtonsoft.Json.JsonConvert.SerializeObject(aList.ToArray(), CommonFunctions.JsonSerializerSettings), aList.ToArray(), null, null);
            }
            catch (Exception exp) { LogWriter.Log(exp); return new response(false, exp.ToString(), null, null, new List<Error>() { new Error(exp) }); }
        }

        public response GetDocumente()
        {
            try
            {
                DataAccess da = new DataAccess(authenticatedUserId, connectionString, CommandType.StoredProcedure, "DOCUMENTE_SCANATE_PROCESEsp_GetByIdProces", new object[] { new MySqlParameter("_ID_PROCES", this.ID) });
                MySqlDataReader r = da.ExecuteSelectQuery();

                List<DocumentScanatProces> aList = new List<DocumentScanatProces>();
                while (r.Read())
                {
                    aList.Add(new DocumentScanatProces(authenticatedUserId, connectionString, Convert.ToInt32(r["ID"])));
                }
                r.Close(); r.Dispose(); da.CloseConnection();
                return new response(true, JsonConvert.SerializeObject(aList.ToArray(), CommonFunctions.JsonSerializerSettings), aList.ToArray(), null, null);
            }
            catch (Exception exp) { LogWriter.Log(exp); return new response(false, exp.ToString(), null, null, new List<Error>() { new Error(exp) }); }
        }

        /*
        /// <summary>
        /// Metoda pt. popularea platilor pentru taxa de timbru
        /// </summary>
        /// <returns>SOCISA.PlatiTaxaTimbruJson</returns>
        public response GetPlatiTaxaTimbru()
        {
            try
            {
                DataAccess da = new DataAccess(CommandType.StoredProcedure, "PROCESE_PLATI_TAXA_TIMBRUsp_GetByIdDosar", new object[] { new MySqlParameter("_ID_PROCES", this.ID) });
                DataTable procesePlatiTaxaTimbru = da.ExecuteSelectQuery().Tables[0];
                // this.ProcesePlatiTaxaTimbru = SOCISA.ProcesePlatiTaxaTimbru.GetProcesePlatiTaxaTimbru(procesePlatiTaxaTimbru); 

                PlatiTaxaTimbruJson[] toReturn = new PlatiTaxaTimbruJson[procesePlatiTaxaTimbru.Rows.Count];
                for (int i = 0; i < procesePlatiTaxaTimbru.Rows.Count; i++)
                {
                    toReturn[i] = new PlatiTaxaTimbruJson(Convert.ToInt32(procesePlatiTaxaTimbru.Rows[i]["ID_PLATA_TAXA_TIMBRU"]));
                }
                return new response(true, Newtonsoft.Json.JsonConvert.SerializeObject(toReturn, CommonFunctions.JsonSerializerSettings), toReturn, null, null);
            }
            catch (Exception exp) { LogWriter.Log(exp); return new response(false, exp.ToString(), null, null, new List<Error>() { new Error(exp) }); }
        }
        */

        public response ChangeStadiuCurent(int _ID_PROCES_STATUS)
        {
            try
            {
                DataAccess da = new DataAccess(authenticatedUserId, connectionString, CommandType.StoredProcedure, "PROCESEsp_ChangeStadiuCurent", new object[] { new MySqlParameter("_ID", this.ID), new MySqlParameter("_ID_PROCES_STATUS", _ID_PROCES_STATUS) });
                response r = da.ExecuteUpdateQuery();
                return r;
            }
            catch (Exception exp) { LogWriter.Log(exp); return new response(false, exp.ToString(), null, null, new List<Error>() { new Error(exp) }); }
        }

        /// <summary>
        /// Metoda pentru inserarea procesului curent
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
            /* -- insert informatii externe (instanta, complet, contract etc.) -- */
            /*
            if (this.Instanta != null)
            {
                response toReturnPi = this.Instanta.Insert();
                if (toReturnPi.Status && toReturnPi.InsertedId != null)
                    this.ID_INSTANTA = toReturnPi.InsertedId;
            }
            if (this.Complet != null)
            {
                response toReturnPc = this.Complet.Insert();
                if (toReturnPc.Status && toReturnPc.InsertedId != null)
                    this.ID_COMPLET = toReturnPc.InsertedId;
            }
            if (this.Contract != null)
            {
                response toReturnPct = this.Contract.Insert();
                if (toReturnPct.Status && toReturnPct.InsertedId != null)
                    this.ID_CONTRACT = toReturnPct.InsertedId;
            }
            if (this.TipProces != null)
            {
                response toReturnPtp = this.TipProces.Insert();
                if (toReturnPtp.Status && toReturnPtp.InsertedId != null)
                    this.ID_TIP_PROCES = toReturnPtp.InsertedId;
            }
            */
            /* -- end insert informatii externe (instanta, complet, contract etc.) -- */
            #endregion 

            try
            {
                if (this.ID_DOSAR != null && this.NR_SCA == null)
                {
                    Dosar d = new Dosar(authenticatedUserId, connectionString, Convert.ToInt32(this.ID_DOSAR));
                    if(d.NR_SCA != null)
                    {
                        this.NR_SCA = d.NR_SCA;
                        this.DATA_SCA = d.DATA_SCA;
                    }
                }
            }
            catch { }

            PropertyInfo[] props = this.GetType().GetProperties();
            ArrayList _parameters = new ArrayList();
            var col = CommonFunctions.table_columns(authenticatedUserId, connectionString, "procese");
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
            DataAccess da = new DataAccess(authenticatedUserId, connectionString, CommandType.StoredProcedure, "PROCESEsp_insert", _parameters.ToArray());
            toReturn = da.ExecuteInsertQuery();
            if (toReturn.Status)
            {
                this.ID = toReturn.InsertedId;

                try
                {
                    Dosar d = new Dosar(authenticatedUserId, connectionString, Convert.ToInt32(this.ID_DOSAR));
                    d.UpdateCounterProcese(1);
                }
                catch (Exception exp) { LogWriter.Log(exp); }

                ProcesStadiu ps = new ProcesStadiu(authenticatedUserId, connectionString);
                ps.DATA = DateTime.Now.Date;
                ps.ID_DOSAR = this.ID_DOSAR;
                ps.ID_PROCES = this.ID;
                Stadiu s = new Stadiu(authenticatedUserId, connectionString, "Preluat de la Asigurator");
                ps.ID_STADIU = s.ID;
                response r = ps.Insert();
                if (r.Status)
                {
                    this.ChangeStadiuCurent(Convert.ToInt32(r.InsertedId));
                }
            }
            /*
            if (this.PlatiTaxaTimbru != null && this.PlatiTaxaTimbru.Length > 0)
            {
                foreach (PlatiTaxaTimbruJson pttj in this.PlatiTaxaTimbru)
                {
                    response toReturnPttj = pttj.Insert();
                    if (toReturnPttj.Status)
                    {
                        ProcesePlatiTaxaTimbruJson ppttj = new ProcesePlatiTaxaTimbruJson();
                        ppttj.ID_PROCES = Convert.ToInt32(this.ID);
                        ppttj.ID_PLATA_TAXA_TIMBRU = Convert.ToInt32(toReturnPttj.InsertedId);
                        response toReturnPpttj = ppttj.Insert();
                    }
                }
            }
            */
            return toReturn;
        }

        /*
        public response Insert(int _ID_DOSAR)
        {
            response toReturn = Insert();
            if (toReturn.Status)
            {
                this.ID = toReturn.InsertedId;

                ProcesStadiu ps = new ProcesStadiu(authenticatedUserId, connectionString);
                ps.DATA = DateTime.Now.Date;
                ps.ID_DOSAR = this.ID_DOSAR;
                ps.ID_PROCES = this.ID;
                Stadiu s = new Stadiu(authenticatedUserId, connectionString, "Preluat de la Asigurator");
                ps.ID_STADIU = s.ID;
                ps.Insert();
                
                try
                {
                        DosarProces dpj = new DosarProces() { ID = null, ID_DOSAR = _ID_DOSAR, ID_PROCES = Convert.ToInt32(this.ID) };
                        response r = dpj.Insert();
                }
                catch { }
            }
            return toReturn;
        }
        */

        /// <summary>
        /// Metoda pentru modificarea procesului curent
        /// </summary>
        /// <returns>SOCISA.response = new object(bool = status, string = error message, int = id-ul cheie returnat)</returns>
        public response Update()
        {
            response toReturn = Validare();
            if (!toReturn.Status)
            {
                return toReturn;
            }
            PropertyInfo[] props = this.GetType().GetProperties();
            ArrayList _parameters = new ArrayList();
            var col = CommonFunctions.table_columns(authenticatedUserId, connectionString, "procese");
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
            DataAccess da = new DataAccess(authenticatedUserId, connectionString, CommandType.StoredProcedure, "PROCESEsp_update", _parameters.ToArray());
            toReturn = da.ExecuteUpdateQuery();
            return toReturn;
        }

        public response Update(int _ID_DOSAR)
        {
            response toReturn = Update();
            if (toReturn.Status)
            {
                try
                {
                    DosarProces dpj = new DosarProces() { ID = null, ID_DOSAR = _ID_DOSAR, ID_PROCES = Convert.ToInt32(this.ID) };
                    response r = dpj.Insert();
                }
                catch { }
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
                        if (fieldName.ToUpper() == prop.Name.ToUpper())
                        {
                            var tmpVal = prop.PropertyType.FullName.IndexOf("System.Nullable") > -1 && changes[fieldName] == null ? null : prop.PropertyType.FullName.IndexOf("System.String") > -1 ? changes[fieldName] : prop.PropertyType.FullName.IndexOf("System.DateTime") > -1 ? CommonFunctions.SwitchBackFormatedDate(changes[fieldName]) : ((prop.PropertyType.FullName.IndexOf("Double") > -1) ? CommonFunctions.BackDoubleValue(changes[fieldName]) : Newtonsoft.Json.JsonConvert.DeserializeObject(changes[fieldName], prop.PropertyType));
                            prop.SetValue(this, tmpVal);
                            break;
                        }
                    }

                }
                return this.Update();
            }
        }

        /// <summary>
        /// Metoda pentru stergerea procesului curent
        /// </summary>
        /// <returns>SOCISA.response = new object(bool = status, string = error message, int = id-ul cheie returnat)</returns>
        public response Delete()
        {
            response toReturn = new response(true, "", null, null, new List<Error>());
            ProcesStadiu[] pss = (ProcesStadiu[])this.GetStadii().Result;
            foreach(ProcesStadiu ps in pss)
            {
                toReturn = ps.Delete();
                if (!toReturn.Status)
                    break;
            }
            if (toReturn.Status)
            {
                ArrayList _parameters = new ArrayList();
                _parameters.Add(new MySqlParameter("_ID", this.ID));
                DataAccess da = new DataAccess(authenticatedUserId, connectionString, CommandType.StoredProcedure, "PROCESEsp_soft_delete", _parameters.ToArray());
                toReturn = da.ExecuteDeleteQuery();
                //TO DO: update plati

                if (toReturn.Status)
                {
                    try
                    {
                        Dosar d = new Dosar(authenticatedUserId, connectionString, Convert.ToInt32(this.ID_DOSAR));
                        d.UpdateCounterProcese(-1);
                    }
                    catch (Exception exp) { LogWriter.Log(exp); }
                }
            }
            return toReturn;
        }

        public response Delete(int _ID_DOSAR)
        {
            response toReturn = new response(false, "", null, null, new List<Error>());
            DosarProces dp = new DosarProces(authenticatedUserId, connectionString);
            dp.ID_DOSAR = _ID_DOSAR;
            dp.ID_PROCES = Convert.ToInt32(this.ID);
            toReturn = dp.Delete();
            if (toReturn.Status)
            {
                toReturn = Delete();

                if (toReturn.Status)
                {
                    try
                    {
                        Dosar d = new Dosar(authenticatedUserId, connectionString, Convert.ToInt32(this.ID_DOSAR));
                        d.UpdateCounterProcese(-1);
                    }
                    catch (Exception exp) { LogWriter.Log(exp); }
                }
            }
            return toReturn;
        }

        /// <summary>
        /// Metoda pentru validarea procesului curent
        /// </summary>
        /// <returns>SOCISA.response = new object(bool = status, string = error message, int = id-ul cheie returnat)</returns>
        public response Validare()
        {
            bool succes;
            response toReturn = Validator.Validate(authenticatedUserId, connectionString, this, _TABLE_NAME, out succes);
            Error err = new Error();
            if (!succes) // daca nu s-au putut citi validarile din fisier, sau nu sunt definite in fisier, mergem pe varianta hardcodata
            {
                toReturn = new response(true, "", null, null, new List<Error>()); ;
                if (String.IsNullOrWhiteSpace(this.NR_DOSAR_INSTANTA))
                {
                    toReturn.Status = false;
                    err = ErrorParser.ErrorMessage("emptyNrDosarInstantaProcese");
                    toReturn.Message = string.Format("{0}{1};", toReturn.Message ?? "", err.ERROR_MESSAGE);
                    toReturn.InsertedId = null;
                    toReturn.Error.Add(err);
                }
                if (this.DATA_DEPUNERE == null)
                {
                    toReturn.Status = false;
                    err = ErrorParser.ErrorMessage("emptyDataDepunereProcese");
                    toReturn.Message = string.Format("{0}{1};", toReturn.Message ?? "", err.ERROR_MESSAGE);
                    toReturn.InsertedId = null;
                    toReturn.Error.Add(err);
                }
                if (this.SUMA_SOLICITATA == null)
                {
                    toReturn.Status = false;
                    err = ErrorParser.ErrorMessage("emptySumaSolicitataProcese");
                    toReturn.Message = string.Format("{0}{1};", toReturn.Message ?? "", err.ERROR_MESSAGE);
                    toReturn.InsertedId = null;
                    toReturn.Error.Add(err);
                }
                if (this.PENALITATI == null)
                {
                    toReturn.Status = false;
                    err = ErrorParser.ErrorMessage("emptyPenalitatiProcese");
                    toReturn.Message = string.Format("{0}{1};", toReturn.Message ?? "", err.ERROR_MESSAGE);
                    toReturn.InsertedId = null;
                    toReturn.Error.Add(err);
                }
            }
            if (this.ID_DOSAR != null && !((Dosar)this.GetDosar().Result).IsAvizat())
            {
                toReturn.Status = false;
                err = ErrorParser.ErrorMessage("dosarNeavizat");
                toReturn.Message = string.Format("{0}{1};", toReturn.Message ?? "", err.ERROR_MESSAGE);
                toReturn.InsertedId = null;
                toReturn.Error.Add(err);
            }
            return toReturn;
        }

        public response GetDosar()
        {
            try
            {
                Dosar toReturn = new Dosar(authenticatedUserId, connectionString, Convert.ToInt32(this.ID_DOSAR));
                return new response(true, Newtonsoft.Json.JsonConvert.SerializeObject(toReturn, CommonFunctions.JsonSerializerSettings), toReturn, null, null);
            }
            catch (Exception exp) { LogWriter.Log(exp); return new response(false, exp.ToString(), null, null, new List<Error>() { new Error(exp) }); }
        }

        public response ValidareColoane(string fieldValueCollection)
        {
            return CommonFunctions.ValidareColoane(this, fieldValueCollection);
        }

        public string GenerateFilterFromJsonObject()
        {
            return Filtering.GenerateFilterFromJsonObject(this);
        }

        public response HasChildrens(string tableName)
        {
            return CommonFunctions.HasChildrens(authenticatedUserId, connectionString, this, "procese", tableName);
        }

        public response HasChildren(string tableName, int childrenId)
        {
            return CommonFunctions.HasChildren(authenticatedUserId, connectionString, this, "procese", tableName, childrenId);
        }

        public response GetChildrens(string tableName)
        {
            return CommonFunctions.GetChildrens(this, tableName);
        }

        public response GetChildren(string tableName, int childrenId)
        {
            return CommonFunctions.GetChildren(this, tableName, childrenId);
        }
    }
}