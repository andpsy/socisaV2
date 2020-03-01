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
    public class SedintaPortal
    {
        const string _TABLE_NAME = "sedinte_portal";
        private int authenticatedUserId { get; set; }
        private string connectionString { get; set; }

        [Key]
        [JsonProperty(NullValueHandling = NullValueHandling.Include)]
        public int? ID { get; set; }

        [JsonProperty(NullValueHandling = NullValueHandling.Include)]
        public int? ID_DOSAR { get; set; }

        //[Display(Name = "NR_DOSAR_CASCO")]
        [Display(Name = "NR_DOSAR_CASCO", ResourceType = typeof(socisaV2.Resources.SedintePortalResx))]
        [JsonProperty(NullValueHandling = NullValueHandling.Include)]
        public string NR_DOSAR_CASCO { get; set; }

        [JsonProperty(NullValueHandling = NullValueHandling.Include)]
        public int? ID_PROCES { get; set; }

        //[Display(Name = "NR_DOSAR_INSTANTA")]
        [Display(Name = "NR_DOSAR_INSTANTA", ResourceType = typeof(socisaV2.Resources.SedintePortalResx))]
        [JsonProperty(NullValueHandling = NullValueHandling.Include)]
        public string NR_DOSAR_INSTANTA { get; set; }

        //[Display(Name = "Data")]
        [Display(Name = "DATA", ResourceType = typeof(socisaV2.Resources.SedintePortalResx))]
        [DataType(DataType.Date)]
        [JsonProperty(NullValueHandling = NullValueHandling.Include)]
        public DateTime? DATA { get; set; }

        //[Display(Name = "Data sedinta")]
        [Display(Name = "DATA_SEDINTA", ResourceType = typeof(socisaV2.Resources.SedintePortalResx))]
        [DataType(DataType.Date)]
        [JsonProperty(NullValueHandling = NullValueHandling.Include)]
        public DateTime? DATA_SEDINTA { get; set; }

        //[Display(Name = "Instanta")]
        [Display(Name = "INSTANTA", ResourceType = typeof(socisaV2.Resources.SedintePortalResx))]
        [JsonProperty(NullValueHandling = NullValueHandling.Include)]
        public string INSTANTA { get; set; }

        //[Display(Name = "Complet")]
        [Display(Name = "COMPLET", ResourceType = typeof(socisaV2.Resources.SedintePortalResx))]
        [JsonProperty(NullValueHandling = NullValueHandling.Include)]
        public string COMPLET { get; set; }

        //[Display(Name = "oRA")]
        [Display(Name = "ORA", ResourceType = typeof(socisaV2.Resources.SedintePortalResx))]
        [JsonProperty(NullValueHandling = NullValueHandling.Include)]
        public string ORA { get; set; }

        //[Display(Name = "Monitorizare")]
        [Display(Name = "MONITORIZARE", ResourceType = typeof(socisaV2.Resources.SedintePortalResx))]
        [JsonProperty(NullValueHandling = NullValueHandling.Include)]
        public bool? MONITORIZARE { get; set; }

        /// <summary>
        /// Constructorul default
        /// </summary>
        public SedintaPortal() { }

        public SedintaPortal(int _authenticatedUserId, string _connectionString)
        {
            authenticatedUserId = _authenticatedUserId;
            connectionString = _connectionString;
        }

        /// <summary>
        /// Constructor pentru crearea unui obiect pe baza ID-ului unic
        /// </summary>
        /// <param name="_ID">ID-ul unic din baza de date</param>
        public SedintaPortal(int _auhenticatedUserId, string _connectionString, int _ID) {
            authenticatedUserId = _auhenticatedUserId;
            connectionString = _connectionString;
            DataAccess da = new DataAccess(authenticatedUserId, connectionString, CommandType.StoredProcedure, "SEDINTE_PORTALsp_GetById", new object[] { new MySqlParameter("_ID", _ID) });
            MySqlDataReader r = da.ExecuteSelectQuery();
            while (r.Read())
            {
                IDataRecord item = (IDataRecord)r;
                SedintaPortalConstructor(item);
                break;
            }
            r.Close(); r.Dispose(); da.CloseConnection();
        }

        /// <summary>
        /// Constructor pentru crearea unui obiect pe baza unei inregistrari din baza de date
        /// </summary>
        /// <param name="_dosar">Inregistrare din baza de date</param>
        public SedintaPortal(int _authenticatedUserId, string _connectionString, IDataRecord item)
        {
            authenticatedUserId = _authenticatedUserId;
            connectionString = _connectionString;
            SedintaPortalConstructor(item);
        }

        /// <summary>
        /// Functie pt. popularea Dosarului curent, folosita de mai multi constructori
        /// </summary>
        /// <param name="_dosar">Inregistrare din DB cu informatiile dosarului curent</param>
        public void SedintaPortalConstructor(IDataRecord _dosar)
        {
            try { this.ID = Convert.ToInt32(_dosar["ID"]); }
            catch { }
            try { this.ID_DOSAR = Convert.ToInt32( _dosar["ID_DOSAR"]); }
            catch { }
            try { this.NR_DOSAR_CASCO = _dosar["NR_DOSAR_CASCO"].ToString(); }
            catch { }
            try { this.ID_PROCES = Convert.ToInt32(_dosar["ID_PROCES"]); }
            catch { }
            try { this.NR_DOSAR_INSTANTA = _dosar["NR_DOSAR_INSTANTA"].ToString(); }
            catch { }
            try { this.DATA = CommonFunctions.IsNullable(_dosar["DATA"]) ? null : (DateTime?)Convert.ToDateTime(_dosar["DATA"]); }
            catch { }
            try { this.DATA_SEDINTA = CommonFunctions.IsNullable(_dosar["DATA_SEDINTA"]) ? null : (DateTime?)Convert.ToDateTime(_dosar["DATA_SEDINTA"]); }
            catch { }
            try { this.INSTANTA = _dosar["INSTANTA"].ToString(); }
            catch { }
            try { this.COMPLET = _dosar["COMPLET"].ToString(); }
            catch { }
            try { this.ORA = _dosar["ORA"].ToString(); }
            catch { }
            try { this.MONITORIZARE = Convert.ToBoolean(_dosar["MONITORIZARE"]); }
            catch { }
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

            PropertyInfo[] props = this.GetType().GetProperties();
            ArrayList _parameters = new ArrayList();
            var col = CommonFunctions.table_columns(authenticatedUserId, connectionString, "sedinte_portal");
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
            DataAccess da = new DataAccess(authenticatedUserId, connectionString, CommandType.StoredProcedure, "SEDINTE_PORTALsp_insert", _parameters.ToArray());
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
            response toReturn = Validare();
            if (!toReturn.Status)
            {
                return toReturn;
            }

            PropertyInfo[] props = this.GetType().GetProperties();
            ArrayList _parameters = new ArrayList();
            var col = CommonFunctions.table_columns(authenticatedUserId, connectionString, "sedinte_portal");
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
            DataAccess da = new DataAccess(authenticatedUserId, connectionString, CommandType.StoredProcedure, "SEDINTE_PORTALsp_update", _parameters.ToArray());
            toReturn = da.ExecuteUpdateQuery();
            
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
                            break;
                        }
                    }

                }
                return this.Update();
            }
        }

        /// <summary>
        /// Metoda pentru stergerea Dosarului curent
        /// </summary>
        /// <returns>SOCISA.response = new object(bool = status, string = error message, int = id-ul cheie returnat)</returns>
        public response Delete()
        {
            response toReturn = new response(false, "", null, null, new List<Error>());;
            ArrayList _parameters = new ArrayList();
            _parameters.Add(new MySqlParameter("_ID", this.ID));
            DataAccess da = new DataAccess(authenticatedUserId, connectionString, CommandType.StoredProcedure, "SEDINTE_PORTALsp_soft_delete", _parameters.ToArray());
            toReturn = da.ExecuteDeleteQuery();
            return toReturn;
        }

        /// <summary>
        /// Metoda pentru validarea Dosarului curent
        /// </summary>
        /// <returns>SOCISA.response = new object(bool = status, string = error message, int = id-ul cheie returnat)</returns>
        public response Validare()
        {
            bool succes;
            response toReturn = Validator.Validate(authenticatedUserId, connectionString, this, _TABLE_NAME, out succes);
            if(!succes) // daca nu s-au putut citi validarile din fisier, sau nu sunt definite in fisier, mergem pe varianta hardcodata
            {
                toReturn = new response(true, "", null, null, new List<Error>());
                Error err = new Error();

                if (this.ID_DOSAR == null || this.ID_DOSAR <= 0)
                {
                    toReturn.Status = false;
                    err = ErrorParser.ErrorMessage("emptyIdDosar");
                    toReturn.Message = string.Format("{0}{1};", toReturn.Message == null ? "" : toReturn.Message, err.ERROR_MESSAGE);
                    toReturn.InsertedId = null;
                    toReturn.Error.Add(err);
                }
            }
            return toReturn;
        }

        public response ValidareColoane(string fieldValueCollection)
        {
            return CommonFunctions.ValidareColoane(this, fieldValueCollection);
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
    }
}