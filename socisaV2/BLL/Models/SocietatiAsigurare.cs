using MySql.Data.MySqlClient;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Reflection;
using Newtonsoft.Json;
using System.ComponentModel.DataAnnotations;

namespace SOCISA.Models
{
    public class SocietateAsigurare
    {
        const string _TABLE_NAME = "societati_asigurare";
        private int authenticatedUserId { get; set; }
        private string connectionString { get; set; }

        public int? ID { get; set; }

        [JsonProperty(NullValueHandling = NullValueHandling.Include)]
        [Required(ErrorMessageResourceName = "emptyDenumireSocietate", ErrorMessageResourceType = typeof(socisaV2.Resources.ErrorMessagesResx))]
        [Display(Name = "DENUMIRE", ResourceType = typeof(socisaV2.Resources.SocietatiAsigurareResx))]
        public string DENUMIRE { get; set; }

        [JsonProperty(NullValueHandling = NullValueHandling.Include)]
        [Required(ErrorMessageResourceName = "emptyDenumireScurtaSocietate", ErrorMessageResourceType = typeof(socisaV2.Resources.ErrorMessagesResx))]
        [Display(Name = "DENUMIRE_SCURTA", ResourceType = typeof(socisaV2.Resources.SocietatiAsigurareResx))]
        public string DENUMIRE_SCURTA { get; set; }

        [JsonProperty(NullValueHandling = NullValueHandling.Include)]
        [Display(Name = "DETALII", ResourceType = typeof(socisaV2.Resources.SocietatiAsigurareResx))]
        public string DETALII { get; set; }

        [JsonProperty(NullValueHandling = NullValueHandling.Include)]
        [Required(ErrorMessageResourceName = "emptyCuiSocietate", ErrorMessageResourceType = typeof(socisaV2.Resources.ErrorMessagesResx))]
        [Display(Name = "CUI", ResourceType = typeof(socisaV2.Resources.SocietatiAsigurareResx))]
        public string CUI { get; set; }

        [JsonProperty(NullValueHandling = NullValueHandling.Include)]
        [Display(Name = "NR_REG_COM", ResourceType = typeof(socisaV2.Resources.SocietatiAsigurareResx))]
        public string NR_REG_COM { get; set; }

        [JsonProperty(NullValueHandling = NullValueHandling.Include)]
        [Display(Name = "ADRESA", ResourceType = typeof(socisaV2.Resources.SocietatiAsigurareResx))]
        public string ADRESA { get; set; }

        [JsonProperty(NullValueHandling = NullValueHandling.Include)]
        [Display(Name = "BANCA", ResourceType = typeof(socisaV2.Resources.SocietatiAsigurareResx))]
        public string BANCA { get; set; }

        [JsonProperty(NullValueHandling = NullValueHandling.Include)]
        [Display(Name = "IBAN", ResourceType = typeof(socisaV2.Resources.SocietatiAsigurareResx))]
        public string IBAN { get; set; }

        [JsonProperty(NullValueHandling = NullValueHandling.Include)]
        [Display(Name = "SOLD", ResourceType = typeof(socisaV2.Resources.SocietatiAsigurareResx))]
        public double SOLD { get; set; }

        [JsonProperty(NullValueHandling = NullValueHandling.Include)]
        [Display(Name = "DATA_ULTIMEI_PLATI", ResourceType = typeof(socisaV2.Resources.SocietatiAsigurareResx))]
        public DateTime? DATA_ULTIMEI_PLATI { get; set; }

        [JsonProperty(NullValueHandling = NullValueHandling.Include)]
        [Display(Name = "TELEFON", ResourceType = typeof(socisaV2.Resources.SocietatiAsigurareResx))]
        public string TELEFON { get; set; }

        [JsonProperty(NullValueHandling = NullValueHandling.Include)]
        [Display(Name = "REPREZENTANT_FISCAL", ResourceType = typeof(socisaV2.Resources.SocietatiAsigurareResx))]
        public string REPREZENTANT_FISCAL { get; set; }

        [JsonProperty(NullValueHandling = NullValueHandling.Include)]
        [Display(Name = "EMAIL_NOTIFICARI", ResourceType = typeof(socisaV2.Resources.SocietatiAsigurareResx))]
        public string EMAIL_NOTIFICARI { get; set; }

        [JsonProperty(NullValueHandling = NullValueHandling.Include)]
        [Display(Name = "ID_TEMPLATE_NOTIFICARI", ResourceType = typeof(socisaV2.Resources.SocietatiAsigurareResx))]
        public int? ID_TEMPLATE_NOTIFICARI { get; set; }

        [JsonProperty(NullValueHandling = NullValueHandling.Include)]
        [Display(Name = "EMAIL", ResourceType = typeof(socisaV2.Resources.SocietatiAsigurareResx))]
        public string EMAIL { get; set; }

        [JsonProperty(NullValueHandling = NullValueHandling.Include)]
        [Display(Name = "EMAIL_NOTIFICARI_CONFIRMAT", ResourceType = typeof(socisaV2.Resources.SocietatiAsigurareResx))]
        public bool? EMAIL_NOTIFICARI_CONFIRMAT { get; set; }

        [JsonProperty(NullValueHandling = NullValueHandling.Include)]
        [Display(Name = "EMAIL_CONFIRMAT", ResourceType = typeof(socisaV2.Resources.SocietatiAsigurareResx))]
        public bool? EMAIL_CONFIRMAT { get; set; }

        public SocietateAsigurare() { }

        public SocietateAsigurare(int _authenticatedUserId, string _connectionString)
        {
            authenticatedUserId = _authenticatedUserId;
            connectionString = _connectionString;
        }

        public SocietateAsigurare(int _authenticatedUserId, string _connectionString, int _ID)
        {
            authenticatedUserId = _authenticatedUserId;
            connectionString = _connectionString;
            DataAccess da = new DataAccess(authenticatedUserId, connectionString, CommandType.StoredProcedure, "SOCIETATI_ASIGURAREsp_GetById", new object[] { new MySqlParameter("_ID", _ID) });
            MySqlDataReader r = da.ExecuteSelectQuery();
            while (r.Read())
            {
                IDataRecord item = (IDataRecord)r;
                SocietateAsigurareConstructor(item);
                break;
            }
            r.Close(); r.Dispose(); da.CloseConnection();
        }

        public SocietateAsigurare(int _authenticatedUserId, string _connectionString, string _DENUMIRE, bool? _DENUMIRE_SCURTA)
        {
            authenticatedUserId = _authenticatedUserId;
            connectionString = _connectionString;
            DataAccess da = new DataAccess(authenticatedUserId, connectionString, CommandType.StoredProcedure, "SOCIETATI_ASIGURAREsp_GetByDenumire", new object[] {new MySqlParameter("_DENUMIRE", _DENUMIRE),  new MySqlParameter("_DENUMIRE_SCURTA", _DENUMIRE_SCURTA) });
            MySqlDataReader r = da.ExecuteSelectQuery();
            while (r.Read())
            {
                IDataRecord item = (IDataRecord)r;
                SocietateAsigurareConstructor(item);
                break;
            }
            r.Close(); r.Dispose(); da.CloseConnection();
        }

        public SocietateAsigurare(int _authenticatedUserId, string _connectionString, IDataRecord item)
        {
            authenticatedUserId = _authenticatedUserId;
            connectionString = _connectionString;
            SocietateAsigurareConstructor(item);
        }

        public void SocietateAsigurareConstructor(IDataRecord societateAsigurare)
        {
            try { this.ID = Convert.ToInt32(societateAsigurare["ID"]); }
            catch { }
            try { this.DENUMIRE = societateAsigurare["DENUMIRE"].ToString(); }
            catch { }
            try { this.DENUMIRE_SCURTA = societateAsigurare["DENUMIRE_SCURTA"].ToString(); }
            catch { }
            try { this.DETALII = societateAsigurare["DETALII"].ToString(); }
            catch { }
            try { this.CUI = societateAsigurare["CUI"].ToString(); }
            catch { }
            try { this.NR_REG_COM = societateAsigurare["NR_REG_COM"].ToString(); }
            catch { }
            try { this.ADRESA = societateAsigurare["ADRESA"].ToString(); }
            catch { }
            try { this.BANCA = societateAsigurare["BANCA"].ToString(); }
            catch { }
            try { this.IBAN = societateAsigurare["IBAN"].ToString(); }
            catch { }
            try { this.SOLD = Convert.ToDouble(societateAsigurare["SOLD"]); }
            catch { }
            try { this.DATA_ULTIMEI_PLATI = CommonFunctions.IsNullable(societateAsigurare["DATA_ULTIMEI_PLATI"]) ? null : (DateTime?)Convert.ToDateTime(societateAsigurare["DATA_ULTIMEI_PLATI"]); }
            catch { }
            try { this.REPREZENTANT_FISCAL = societateAsigurare["REPREZENTANT_FISCAL"].ToString(); }
            catch { }
            try { this.TELEFON = societateAsigurare["TELEFON"].ToString(); }
            catch { }
            try { this.EMAIL_NOTIFICARI = societateAsigurare["EMAIL_NOTIFICARI"].ToString(); }
            catch { }
            try { this.EMAIL = societateAsigurare["EMAIL"].ToString(); }
            catch { }
            try { this.ID_TEMPLATE_NOTIFICARI = Convert.ToInt32(societateAsigurare["ID_TEMPLATE_NOTIFICARI"]); }
            catch { }
            try { this.EMAIL_NOTIFICARI_CONFIRMAT = Convert.ToBoolean(societateAsigurare["EMAIL_NOTIFICARI_CONFIRMAT"]); }
            catch { }
            try { this.EMAIL_CONFIRMAT = Convert.ToBoolean(societateAsigurare["EMAIL_CONFIRMAT"]); }
            catch { }
        }

        public response Insert()
        {
            response toReturn = Validare();
            if (!toReturn.Status)
            {
                return toReturn;
            }
            PropertyInfo[] props = this.GetType().GetProperties();
            ArrayList _parameters = new ArrayList();

            var col = CommonFunctions.table_columns(authenticatedUserId, connectionString, "societati_asigurare");
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
            DataAccess da = new DataAccess(authenticatedUserId, connectionString, CommandType.StoredProcedure, "SOCIETATI_ASIGURAREsp_insert", _parameters.ToArray());
            toReturn = da.ExecuteInsertQuery();
            if (toReturn.Status) this.ID = toReturn.InsertedId;

            return toReturn;
        }

        public response Update()
        {
            response toReturn = Validare();
            if (!toReturn.Status)
            {
                return toReturn;
            }
            PropertyInfo[] props = this.GetType().GetProperties();
            ArrayList _parameters = new ArrayList();
            var col = CommonFunctions.table_columns(authenticatedUserId, connectionString, "societati_asigurare");
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
            DataAccess da = new DataAccess(authenticatedUserId, connectionString, CommandType.StoredProcedure, "SOCIETATI_ASIGURAREsp_update", _parameters.ToArray());
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

        public response Delete()
        {
            response toReturn = new response(false, "", null, null, new List<Error>()); ;
            ArrayList _parameters = new ArrayList();
            _parameters.Add(new MySqlParameter("_ID", this.ID));
            DataAccess da = new DataAccess(authenticatedUserId, connectionString, CommandType.StoredProcedure, "SOCIETATI_ASIGURAREsp_soft_delete", _parameters.ToArray());
            toReturn = da.ExecuteDeleteQuery();
            return toReturn;
        }

        public response Validare()
        {
            return Validare(false);
        }

        /// <summary>
        /// Metoda pentru validarea societatii de asigurare curente
        /// </summary>
        /// <param name="_validareSimpla">Pt. validari din import</param>
        /// <returns>SOCISA.response = new object(bool = status, string = error message, int = id-ul cheie returnat)</returns>
        public response Validare(bool _validareSimpla)
        {
            bool succes;
            response toReturn = Validator.Validate(authenticatedUserId, connectionString, this, _TABLE_NAME, out succes);
            if (!succes) // daca nu s-au putut citi validarile din fisier, sau nu sunt definite in fisier, mergem pe varianta hardcodata
            {
                toReturn = new response(true, "", null, null, new List<Error>()); ;
                Error err = new Error();
                if (this.DENUMIRE_SCURTA == null || this.DENUMIRE_SCURTA.Trim() == "")
                {
                    toReturn.Status = false;
                    err = ErrorParser.ErrorMessage("emptyDenumireScurtaSocietate");
                    toReturn.Message = string.Format("{0}{1};", toReturn.Message == null ? "" : toReturn.Message, err.ERROR_MESSAGE);
                    toReturn.InsertedId = null;
                    toReturn.Error.Add(err);
                }
                if (!_validareSimpla)
                {
                    if (this.DENUMIRE == null || this.DENUMIRE.Trim() == "")
                    {
                        toReturn.Status = false;
                        err = ErrorParser.ErrorMessage("emptyDenumireSocietate");
                        toReturn.Message = string.Format("{0}{1};", toReturn.Message == null ? "" : toReturn.Message, err.ERROR_MESSAGE);
                        toReturn.InsertedId = null;
                        toReturn.Error.Add(err);
                    }
                    /*
                    if (this.CUI == null || this.CUI.Trim() == "")
                    {
                        toReturn.Status = false;
                        err = ErrorParser.ErrorMessage("emptyCuiSocietate");
                        toReturn.Message = string.Format("{0}{1};", toReturn.Message == null ? "" : toReturn.Message, err.ERROR_MESSAGE);
                        toReturn.InsertedId = null;
                        toReturn.Error.Add(err);
                    }
                    */
                }
            }
            return toReturn;
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
            return CommonFunctions.HasChildrens(authenticatedUserId, connectionString, this, "societati_asigurare", tableName);
        }

        public response HasChildren(string tableName, int childrenId)
        {
            return CommonFunctions.HasChildren(authenticatedUserId, connectionString, this, "societati_asigurare", tableName, childrenId);
        }

        public response GetChildrens(string tableName)
        {
            return CommonFunctions.GetChildrens(this, tableName);
        }

        public response GetChildren(string tableName, int childrenId)
        {
            return CommonFunctions.GetChildren(this, tableName, childrenId);
        }

        public response GetTemplateNotificari()
        {
            response toReturn = new response(false, "", null, null, new List<Error>()); ;
            ArrayList _parameters = new ArrayList();
            _parameters.Add(new MySqlParameter("_ID", this.ID));
            DataAccess da = new DataAccess(authenticatedUserId, connectionString, CommandType.StoredProcedure, "SOCIETATI_ASIGURAREso_GetTemplateNotificari", _parameters.ToArray());
            toReturn = da.ExecuteScalarQuery();
            return toReturn;

        }
    }
}