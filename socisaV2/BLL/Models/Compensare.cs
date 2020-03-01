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
    public class SintezaCompensare
    {
        public int ID { get; set; }
        public string DENUMIRE_SCURTA { get; set; }
        public string DENUMIRE { get; set; }
        public int TOTAL_DOSARE_CASCO { get; set; }
        public int COMPENSATE_TOTAL_CASCO { get; set; }
        public int COMPENSATE_PARTIAL_CASCO { get; set; }
        public int NECOMPENSATE_CASCO { get; set; }
        public double SUMA_COMPENSATA_CASCO { get; set; }
        public double REST_NECOMPENSAT_CASCO { get; set; }
        public double TOTAL_CASCO { get; set; }
        public int TOTAL_DOSARE_RCA { get; set; }
        public int COMPENSATE_TOTAL_RCA { get; set; }
        public int COMPENSATE_PARTIAL_RCA { get; set; }
        public int NECOMPENSATE_RCA { get; set; }
        public double SUMA_COMPENSATA_RCA { get; set; }
        public double REST_NECOMPENSAT_RCA { get; set; }
        public double TOTAL_RCA { get; set; }

        public SintezaCompensare() { }
        public SintezaCompensare(int ID, string DENUMIRE_SCURTA, string DENUMIRE, 
            int TOTAL_DOSARE_CASCO, int COMPENSATE_TOTAL_CASCO, int COMPENSATE_PARTIAL_CASCO, int NECOMPENSATE_CASCO, double SUMA_COMPENSATA_CASCO, double REST_NECOMPENSAT_CASCO, double TOTAL_CASCO,
            int TOTAL_DOSARE_RCA, int COMPENSATE_TOTAL_RCA, int COMPENSATE_PARTIAL_RCA, int NECOMPENSATE_RCA, double SUMA_COMPENSATA_RCA, double REST_NECOMPENSAT_RCA, double TOTAL_RCA)
        {
            this.ID = ID;
            this.DENUMIRE_SCURTA = DENUMIRE_SCURTA;
            this.DENUMIRE = DENUMIRE;
            this.TOTAL_DOSARE_CASCO = TOTAL_DOSARE_CASCO;
            this.COMPENSATE_TOTAL_CASCO = COMPENSATE_TOTAL_CASCO;
            this.COMPENSATE_PARTIAL_CASCO = COMPENSATE_PARTIAL_CASCO;
            this.NECOMPENSATE_CASCO = NECOMPENSATE_CASCO;
            this.SUMA_COMPENSATA_CASCO = SUMA_COMPENSATA_CASCO;
            this.REST_NECOMPENSAT_CASCO = REST_NECOMPENSAT_CASCO;
            this.TOTAL_CASCO = TOTAL_CASCO;
            this.TOTAL_DOSARE_RCA = TOTAL_DOSARE_RCA;
            this.COMPENSATE_TOTAL_RCA = COMPENSATE_TOTAL_RCA;
            this.COMPENSATE_PARTIAL_RCA = COMPENSATE_PARTIAL_RCA;
            this.NECOMPENSATE_RCA = NECOMPENSATE_RCA;
            this.SUMA_COMPENSATA_RCA = SUMA_COMPENSATA_RCA;
            this.REST_NECOMPENSAT_RCA = REST_NECOMPENSAT_RCA;
            this.TOTAL_RCA = TOTAL_RCA;
        }

    }

    public class BucketListItem
    {
        public Dosar Dosar { get; set; }
        public double Suma { get; set; }

        public BucketListItem(Dosar _d, double _suma)
        {
            this.Dosar = _d;
            this.Suma = _suma;
        }
    }

    /// <summary>
    /// Clasa statica cu diferite metode pentru selectia Compensarilor din baza de date
    /// </summary>
    public class Compensare
    {
        const string _TABLE_NAME = "compensari";
        private int authenticatedUserId { get; set; }
        private string connectionString { get; set; }

        public int? ID { get; set; }

        [JsonProperty(NullValueHandling = NullValueHandling.Include)]
        [Required(ErrorMessageResourceName = "emptyDosarCompensari", ErrorMessageResourceType = typeof(socisaV2.Resources.ErrorMessagesResx))]
        [Display(Name = "ID_DOSAR", ResourceType = typeof(socisaV2.Resources.CompensariResx))]
        public int? ID_DOSAR { get; set; }

        [JsonProperty(NullValueHandling = NullValueHandling.Include)]
        [Required(ErrorMessageResourceName = "emptyDataCompensari", ErrorMessageResourceType = typeof(socisaV2.Resources.ErrorMessagesResx))]
        [Display(Name = "DATA", ResourceType = typeof(socisaV2.Resources.CompensariResx))]
        public DateTime? DATA { get; set; }

        [JsonProperty(NullValueHandling = NullValueHandling.Include)]
        [Required(ErrorMessageResourceName = "emptySumaCompensari", ErrorMessageResourceType = typeof(socisaV2.Resources.ErrorMessagesResx))]
        [Display(Name = "SUMA", ResourceType = typeof(socisaV2.Resources.CompensariResx))]
        public double? SUMA { get; set; }

        [JsonProperty(NullValueHandling = NullValueHandling.Include)]
        [Required(ErrorMessageResourceName = "emptyRestCompensari", ErrorMessageResourceType = typeof(socisaV2.Resources.ErrorMessagesResx))]
        [Display(Name = "REST", ResourceType = typeof(socisaV2.Resources.CompensariResx))]
        public double? REST { get; set; }

        public Compensare() { }

        public Compensare(int _authenticatedUserId, string _connectionString)
        {
            authenticatedUserId = _authenticatedUserId;
            connectionString = _connectionString;
        }

        public Compensare(int _authenticatedUserId, string _connectionString, int _ID)
        {
            authenticatedUserId = _authenticatedUserId;
            connectionString = _connectionString;
            DataAccess da = new DataAccess(authenticatedUserId, connectionString, CommandType.StoredProcedure, "COMPENSARIsp_GetById", new object[] { new MySqlParameter("_ID", _ID) });
            MySqlDataReader r = da.ExecuteSelectQuery();
            while (r.Read())
            {
                IDataRecord compensare = (IDataRecord)r;
                CompensareConstructor(compensare);
                break;
            }
            r.Close(); r.Dispose(); da.CloseConnection();
        }

        public Compensare(int _authenticatedUserId, string _connectionString, IDataRecord compensare)
        {
            authenticatedUserId = _authenticatedUserId;
            connectionString = _connectionString;
            CompensareConstructor(compensare);
        }

        public void CompensareConstructor(IDataRecord compensare)
        {
            try { this.ID = Convert.ToInt32(compensare["ID"]); }
            catch { }
            try { this.ID_DOSAR = Convert.ToInt32( compensare["ID_DOSAR"]); }
            catch { }
            try { this.DATA = Convert.ToDateTime(compensare["DATA"]); }
            catch { }
            try { this.SUMA = Convert.ToDouble(compensare["SUMA"]); }
            catch { }
            try { this.REST = Convert.ToDouble(compensare["REST"]); }
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

            var col = CommonFunctions.table_columns(authenticatedUserId, connectionString, "compensari");
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
            DataAccess da = new DataAccess(authenticatedUserId, connectionString, CommandType.StoredProcedure, "COMPENSARIsp_insert", _parameters.ToArray());
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
            var col = CommonFunctions.table_columns(authenticatedUserId, connectionString, "compensari");
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
            DataAccess da = new DataAccess(authenticatedUserId, connectionString, CommandType.StoredProcedure, "COMPENSARIsp_update", _parameters.ToArray());
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
                        //var col = CommonFunctions.table_columns(authenticatedUserId, connectionString, "asigurati");
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
            response toReturn = new response(false, "", null, null, new List<Error>());
            ArrayList _parameters = new ArrayList();
            _parameters.Add(new MySqlParameter("_ID", this.ID));
            DataAccess da = new DataAccess(authenticatedUserId, connectionString, CommandType.StoredProcedure, "COMPENSARIsp_soft_delete", _parameters.ToArray());
            toReturn = da.ExecuteDeleteQuery();
            return toReturn;
        }

        public response Validare()
        {
            bool succes;
            response toReturn = Validator.Validate(authenticatedUserId, connectionString, this, _TABLE_NAME, out succes);
            if (!succes) // daca nu s-au putut citi validarile din fisier, sau nu sunt definite in fisier, mergem pe varianta hardcodata
            {
                toReturn = new response(true, "", null, null, new List<Error>());
                Error err = new Error();
                if (this.ID_DOSAR == null)
                {
                    toReturn.Status = false;
                    err = ErrorParser.ErrorMessage("emptyDosarCompensari");
                    toReturn.Message = string.Format("{0}{1};", toReturn.Message == null ? "" : toReturn.Message, err.ERROR_MESSAGE);
                    toReturn.InsertedId = null;
                    toReturn.Error.Add(err);
                }
                if (this.DATA == null)
                {
                    toReturn.Status = false;
                    err = ErrorParser.ErrorMessage("emptyDataCompensari");
                    toReturn.Message = string.Format("{0}{1};", toReturn.Message == null ? "" : toReturn.Message, err.ERROR_MESSAGE);
                    toReturn.InsertedId = null;
                    toReturn.Error.Add(err);
                }
                if (this.SUMA == null)
                {
                    toReturn.Status = false;
                    err = ErrorParser.ErrorMessage("emptySumaCompensari");
                    toReturn.Message = string.Format("{0}{1};", toReturn.Message == null ? "" : toReturn.Message, err.ERROR_MESSAGE);
                    toReturn.InsertedId = null;
                    toReturn.Error.Add(err);
                }
                if (this.REST == null)
                {
                    toReturn.Status = false;
                    err = ErrorParser.ErrorMessage("emptyRestCompensari");
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

        public string GenerateFilterFromJsonObject()
        {
            return Filtering.GenerateFilterFromJsonObject(this);
        }

        public response HasChildrens(string tableName)
        {
            return CommonFunctions.HasChildrens(authenticatedUserId, connectionString, this, "compensari", tableName);
        }

        public response HasChildren(string tableName, int childrenId)
        {
            return CommonFunctions.HasChildren(authenticatedUserId, connectionString, this, "compensari", tableName, childrenId);
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