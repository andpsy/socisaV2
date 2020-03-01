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
    public class Plata
    {
        const string _TABLE_NAME = "plati";
        private int authenticatedUserId { get; set; }
        private string connectionString { get; set; }

        public int? ID { get; set; }
        [JsonProperty(NullValueHandling = NullValueHandling.Include)]
        [Required(ErrorMessageResourceName = "emptyNrDocumentPlata", ErrorMessageResourceType = typeof(socisaV2.Resources.ErrorMessagesResx))]
        [Display(Name = "NR_DOCUMENT", ResourceType = typeof(socisaV2.Resources.PlatiResx))]
        public string NR_DOCUMENT { get; set; }
        [JsonProperty(NullValueHandling = NullValueHandling.Include)]
        [Required(ErrorMessageResourceName = "emptyDataDocumentPlata", ErrorMessageResourceType = typeof(socisaV2.Resources.ErrorMessagesResx))]
        [Display(Name = "DATA_DOCUMENT", ResourceType = typeof(socisaV2.Resources.PlatiResx))]
        public DateTime? DATA_DOCUMENT { get; set; }
        [JsonProperty(NullValueHandling = NullValueHandling.Include)]
        [Required(ErrorMessageResourceName = "emptySumaPlata", ErrorMessageResourceType = typeof(socisaV2.Resources.ErrorMessagesResx))]
        [Display(Name = "SUMA", ResourceType = typeof(socisaV2.Resources.PlatiResx))]
        public double? SUMA { get; set; }
        [JsonProperty(NullValueHandling = NullValueHandling.Include)]
        [Required(ErrorMessageResourceName = "emptyIdDosarPlata", ErrorMessageResourceType = typeof(socisaV2.Resources.ErrorMessagesResx))]
        [Display(Name = "ID_DOSAR", ResourceType = typeof(socisaV2.Resources.PlatiResx))]
        public int? ID_DOSAR { get; set; }
        [JsonProperty(NullValueHandling = NullValueHandling.Include)]
        [Required(ErrorMessageResourceName = "emptyIdTipPlata", ErrorMessageResourceType = typeof(socisaV2.Resources.ErrorMessagesResx))]
        [Display(Name = "ID_TIP_PLATA", ResourceType = typeof(socisaV2.Resources.PlatiResx))]
        public int? ID_TIP_PLATA { get; set; }
        [JsonProperty(NullValueHandling = NullValueHandling.Include)]
        [Display(Name = "OBSERVATII", ResourceType = typeof(socisaV2.Resources.PlatiResx))]
        public string OBSERVATII { get; set; }


        public Plata() { }

        public Plata(int _authenticatedUserId, string _connectionString)
        {
            authenticatedUserId = _authenticatedUserId;
            connectionString = _connectionString;
        }

        public Plata(int _authenticatedUserId, string _connectionString, int _ID)
        {
            authenticatedUserId = _authenticatedUserId;
            connectionString = _connectionString;
            DataAccess da = new DataAccess(authenticatedUserId, connectionString, CommandType.StoredProcedure, "PLATIsp_GetById", new object[] { new MySqlParameter("_ID", _ID) });
            MySqlDataReader r = da.ExecuteSelectQuery();
            while (r.Read())
            {
                IDataRecord item = (IDataRecord)r;
                PlataConstructor(item);
                break;
            }
            r.Close(); r.Dispose(); da.CloseConnection();
        }

        public Plata(int _authenticatedUserId, string _connectionString, Plata _plata)
        {
            authenticatedUserId = _authenticatedUserId;
            connectionString = _connectionString;
            PropertyInfo[] props = this.GetType().GetProperties();
            ArrayList _parameters = new ArrayList();

            var col = CommonFunctions.table_columns(authenticatedUserId, connectionString, "plati");
            foreach (PropertyInfo prop in props)
            {
                if (col != null && col.ToUpper().IndexOf(prop.Name.ToUpper()) > -1) // ca sa includem in Array-ul de parametri doar coloanele tabelei, nu si campurile externe si/sau alte proprietati
                {
                    string propName = prop.Name;
                    string propType = prop.PropertyType.ToString();
                    object propValue = prop.GetValue(this, null);
                    propValue = propValue ?? DBNull.Value;
                    if (propType != null)
                    {
                        if (propName.ToUpper() != "ID" && propName.ToUpper() != "OBSERVATII")
                            _parameters.Add(new MySqlParameter(String.Format("_{0}", propName.ToUpper()), propValue));
                    }
                }
            }
            DataAccess da = new DataAccess(authenticatedUserId, connectionString, CommandType.StoredProcedure, "PLATIsp_GetByFields", _parameters.ToArray());
            MySqlDataReader r = da.ExecuteSelectQuery();
            while (r.Read())
            {
                IDataRecord item = (IDataRecord)r;
                PlataConstructor(item);
                break;
            }
            r.Close(); r.Dispose(); da.CloseConnection();
        }

        public Plata(int _authenticatedUserId, string _connectionString, IDataRecord item)
        {
            authenticatedUserId = _authenticatedUserId;
            connectionString = _connectionString;
            PlataConstructor(item);
        }

        public Plata(int _auhenticatedUserId, string _connectionString, int _ID, bool _hasErrors)
        {
            authenticatedUserId = _auhenticatedUserId;
            connectionString = _connectionString;
            DataAccess da = new DataAccess(authenticatedUserId, connectionString, CommandType.StoredProcedure, _hasErrors ? "PENDING_IMPORT_ERRORS_PLATIsp_GetById" : "PLATIsp_GetById", new object[] { new MySqlParameter("_ID", _ID) });
            MySqlDataReader r = da.ExecuteSelectQuery();
            while (r.Read())
            {
                IDataRecord item = (IDataRecord)r;
                PlataConstructor(item);
                break;
            }
            r.Close(); r.Dispose(); da.CloseConnection();
        }

        public void PlataConstructor(IDataRecord item)
        {
            try { this.ID = Convert.ToInt32(item["ID"]); }
            catch { }
            try { this.NR_DOCUMENT = item["NR_DOCUMENT"].ToString(); }
            catch { }
            try { this.DATA_DOCUMENT = Convert.ToDateTime( item["DATA_DOCUMENT"]); }
            catch { }
            try { this.SUMA = Convert.ToDouble(item["SUMA"]); }
            catch { }
            try { this.ID_DOSAR = Convert.ToInt32(item["ID_DOSAR"]); }
            catch { }
            try { this.ID_TIP_PLATA = Convert.ToInt32(item["ID_TIP_PLATA"]); }
            catch { }
            try { this.OBSERVATII = item["OBSERVATII"].ToString(); }
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

            var col = CommonFunctions.table_columns(authenticatedUserId, connectionString, "plati");
            foreach (PropertyInfo prop in props)
            {
                if (col != null && col.ToUpper().IndexOf(prop.Name.ToUpper()) > -1) // ca sa includem in Array-ul de parametri doar coloanele tabelei, nu si campurile externe si/sau alte proprietati
                {
                    string propName = prop.Name;
                    string propType = prop.PropertyType.ToString();
                    object propValue = prop.GetValue(this, null);
                    propValue = propValue ?? DBNull.Value;
                    if (propType != null)
                    {
                        if (propName.ToUpper() != "ID") // il vom folosi doar la Edit!
                            _parameters.Add(new MySqlParameter(String.Format("_{0}", propName.ToUpper()), propValue));
                    }
                }
            }
            DataAccess da = new DataAccess(authenticatedUserId, connectionString, CommandType.StoredProcedure, "PLATIsp_insert", _parameters.ToArray());
            toReturn = da.ExecuteInsertQuery();
            if (toReturn.Status)
            {
                this.ID = toReturn.InsertedId;

                if (toReturn.Status)
                {
                    try
                    {
                        Dosar d = new Dosar(authenticatedUserId, connectionString, Convert.ToInt32(this.ID_DOSAR));
                        d.UpdateCounterPlati(1);
                    }
                    catch (Exception exp) { LogWriter.Log(exp); }
                }

                if (toReturn.Status)
                {
                    try
                    {
                        Dosar d = new Dosar(this.authenticatedUserId, this.connectionString, Convert.ToInt32(this.ID_DOSAR));
                        d.REZERVA_DAUNA -= this.SUMA;
                        d.GetNewStatus(false);
                        response r = d.Update();
                        if (!r.Status)
                        {
                            toReturn = r;
                        }
                    }
                    catch (Exception exp)
                    {
                        toReturn = new response(false, exp.ToString(), null, null, new List<Error>() { new Error(exp) });
                        LogWriter.Log(exp);
                    }
                }
            }
            return toReturn;
        }

        public response InsertWithErrors()
        {
            response toReturn = new response(true, "", null, null, new List<Error>());
            PropertyInfo[] props = this.GetType().GetProperties();
            ArrayList _parameters = new ArrayList();
            var col = CommonFunctions.table_columns(authenticatedUserId, connectionString, "plati");
            foreach (PropertyInfo prop in props)
            {
                if (col != null && col.ToUpper().IndexOf(prop.Name.ToUpper()) > -1) // ca sa includem in Array-ul de parametri doar coloanele tabelei, nu si campurile externe si/sau alte proprietati
                {
                    string propName = prop.Name;
                    string propType = prop.PropertyType.ToString();
                    object propValue = prop.GetValue(this, null);
                    propValue = propValue ?? DBNull.Value;
                    if (propType != null)
                    {
                        if (propName.ToUpper() != "ID") // il vom folosi doar la Edit!
                            _parameters.Add(new MySqlParameter(String.Format("_{0}", propName.ToUpper()), propValue));
                    }
                }
            }
            DataAccess da = new DataAccess(authenticatedUserId, connectionString, CommandType.StoredProcedure, "PENDING_IMPORT_ERRORS_PLATIsp_insert", _parameters.ToArray());
            toReturn = da.ExecuteInsertQuery();
            if (toReturn.Status)
            {
                this.ID = toReturn.InsertedId;
                toReturn.Message = JsonConvert.SerializeObject(this, Formatting.None, new Newtonsoft.Json.Converters.IsoDateTimeConverter() { DateTimeFormat = CommonFunctions.DATE_FORMAT });
                toReturn.Result = this; // pt. ID-uri externe generate !!!
            }
            return toReturn;
        }

        public response Update()
        {
            Plata originalPlata = new Plata(this.authenticatedUserId, this.connectionString, Convert.ToInt32(this.ID)); // ne trebuie ca sa actualizam rezerva dauna din dosar
            response toReturn = Validare();
            if (!toReturn.Status)
            {
                return toReturn;
            }
            PropertyInfo[] props = this.GetType().GetProperties();
            ArrayList _parameters = new ArrayList();
            var col = CommonFunctions.table_columns(authenticatedUserId, connectionString, "plati");
            foreach (PropertyInfo prop in props)
            {
                if (col != null && col.ToUpper().IndexOf(prop.Name.ToUpper()) > -1) // ca sa includem in Array-ul de parametri doar coloanele tabelei, nu si campurile externe si/sau alte proprietati
                {
                    string propName = prop.Name;
                    string propType = prop.PropertyType.ToString();
                    object propValue = prop.GetValue(this, null);
                    propValue = propValue ?? DBNull.Value;
                    if (propType != null)
                    {
                        _parameters.Add(new MySqlParameter(String.Format("_{0}", propName.ToUpper()), propValue));
                    }
                }
            }
            DataAccess da = new DataAccess(authenticatedUserId, connectionString, CommandType.StoredProcedure, "PLATIsp_update", _parameters.ToArray());
            toReturn = da.ExecuteUpdateQuery();
            if (toReturn.Status)
            {
                try
                {
                    Dosar d = new Dosar(this.authenticatedUserId, this.connectionString, Convert.ToInt32(this.ID_DOSAR));
                    d.REZERVA_DAUNA -= (this.SUMA - originalPlata.SUMA);
                    d.GetNewStatus(false);
                    response r = d.Update();
                    if (!r.Status)
                    {
                        toReturn = r;
                    }
                }
                catch (Exception exp)
                {
                    toReturn = new response(false, exp.ToString(), null, null, new List<Error>() { new Error(exp) });
                    LogWriter.Log(exp);
                }
            }
            return toReturn;
        }

        public response UpdateWithErrors()
        {
            response toReturn = new response(true, "", null, null, new List<Error>());
            PropertyInfo[] props = this.GetType().GetProperties();
            ArrayList _parameters = new ArrayList();
            var col = CommonFunctions.table_columns(authenticatedUserId, connectionString, "plati");
            foreach (PropertyInfo prop in props)
            {
                if (col != null && col.ToUpper().IndexOf(prop.Name.ToUpper()) > -1) // ca sa includem in Array-ul de parametri doar coloanele tabelei, nu si campurile externe si/sau alte proprietati
                {
                    string propName = prop.Name;
                    string propType = prop.PropertyType.ToString();
                    object propValue = prop.GetValue(this, null);
                    propValue = propValue ?? DBNull.Value;
                    if (propType != null)
                    {
                        _parameters.Add(new MySqlParameter(String.Format("_{0}", propName.ToUpper()), propValue));
                    }
                }
            }
            DataAccess da = new DataAccess(authenticatedUserId, connectionString, CommandType.StoredProcedure, "PENDING_IMPORT_ERRORS_PLATIsp_update", _parameters.ToArray());
            toReturn = da.ExecuteUpdateQuery();
            if (toReturn.Status)
            {
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
            DataAccess da = new DataAccess(authenticatedUserId, connectionString, CommandType.StoredProcedure, "PLATIsp_soft_delete", _parameters.ToArray());
            toReturn = da.ExecuteDeleteQuery();
            if (toReturn.Status)
            {
                try
                {
                    Dosar d = new Dosar(authenticatedUserId, connectionString, Convert.ToInt32(this.ID_DOSAR));
                    d.UpdateCounterPlati(-1);
                }
                catch (Exception exp) { LogWriter.Log(exp); }

                try
                {
                    Dosar d = new Dosar(this.authenticatedUserId, this.connectionString, Convert.ToInt32(this.ID_DOSAR));
                    d.REZERVA_DAUNA += this.SUMA;
                    d.GetNewStatus(false);
                    response r = d.Update();
                    if (!r.Status)
                    {
                        toReturn = r;
                    }
                }
                catch (Exception exp)
                {
                    toReturn = new response(false, exp.ToString(), null, null, new List<Error>() { new Error(exp) });
                    LogWriter.Log(exp);
                }
            }
            return toReturn;
        }

        public response Validare()
        {
            bool succes;
            response toReturn = Validator.Validate(authenticatedUserId, connectionString, this, _TABLE_NAME, out succes);
            Error err = new Error();
            if (!succes) // daca nu s-au putut citi validarile din fisier, sau nu sunt definite in fisier, mergem pe varianta hardcodata
            {
                toReturn = new response(true, "", null, null, new List<Error>()); ;
                if (this.NR_DOCUMENT == null || this.NR_DOCUMENT.Trim() == "")
                {
                    toReturn.Status = false;
                    err = ErrorParser.ErrorMessage("emptyNrDocumentPlata");
                    toReturn.Message = string.Format("{0}{1};", toReturn.Message ?? "", err.ERROR_MESSAGE);
                    toReturn.InsertedId = null;
                    toReturn.Error.Add(err);
                }
                if (this.DATA_DOCUMENT == null)
                {
                    toReturn.Status = false;
                    err = ErrorParser.ErrorMessage("emptyDataDocumentPlata");
                    toReturn.Message = string.Format("{0}{1};", toReturn.Message ?? "", err.ERROR_MESSAGE);
                    toReturn.InsertedId = null;
                    toReturn.Error.Add(err);
                }
                if (this.SUMA == null)
                {
                    toReturn.Status = false;
                    err = ErrorParser.ErrorMessage("emptySumaPlata");
                    toReturn.Message = string.Format("{0}{1};", toReturn.Message ?? "", err.ERROR_MESSAGE);
                    toReturn.InsertedId = null;
                    toReturn.Error.Add(err);
                }
                if (this.ID_DOSAR == null)
                {
                    toReturn.Status = false;
                    err = ErrorParser.ErrorMessage("emptyIdDosarPlata");
                    toReturn.Message = string.Format("{0}{1};", toReturn.Message ?? "", err.ERROR_MESSAGE);
                    toReturn.InsertedId = null;
                    toReturn.Error.Add(err);
                }
                if (this.ID_TIP_PLATA == null)
                {
                    toReturn.Status = false;
                    err = ErrorParser.ErrorMessage("emptyIdTipPlata");
                    toReturn.Message = string.Format("{0}{1};", toReturn.Message ?? "", err.ERROR_MESSAGE);
                    toReturn.InsertedId = null;
                    toReturn.Error.Add(err);
                }
            }
            if(this.ID_DOSAR != null && !((Dosar)this.GetDosar().Result).IsAvizat())
            {
                toReturn.Status = false;
                err = ErrorParser.ErrorMessage("dosarNeavizat");
                toReturn.Message = string.Format("{0}{1};", toReturn.Message ?? "", err.ERROR_MESSAGE);
                toReturn.InsertedId = null;
                toReturn.Error.Add(err);
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
            return CommonFunctions.HasChildrens(authenticatedUserId, connectionString, this, "plati", tableName);
        }

        public response HasChildren(string tableName, int childrenId)
        {
            return CommonFunctions.HasChildren(authenticatedUserId, connectionString, this, "plati", tableName, childrenId);
        }

        public response GetChildrens(string tableName)
        {
            return CommonFunctions.GetChildrens(this, tableName);
        }

        public response GetChildren(string tableName, int childrenId)
        {
            return CommonFunctions.GetChildren(this, tableName, childrenId);
        }

        public response GetTipPlata()
        {
            try
            {
                Nomenclator toReturn = new Nomenclator(authenticatedUserId, connectionString, "tip_plata", Convert.ToInt32(this.ID_TIP_PLATA));
                return new response(true, Newtonsoft.Json.JsonConvert.SerializeObject(toReturn, CommonFunctions.JsonSerializerSettings), toReturn, null, null);
            }
            catch (Exception exp) { LogWriter.Log(exp); return new response(false, exp.ToString(), null, null, new List<Error>() { new Error(exp) }); }
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
            DataAccess da = new DataAccess(authenticatedUserId, connectionString, CommandType.StoredProcedure, "PLATIsp_import_log", new object[] {
                new MySqlParameter("_STATUS", r.Status),
                new MySqlParameter("_MESSAGE", r.Message),
                new MySqlParameter("_INSERTED_ID", r.InsertedId),
                new MySqlParameter("_ERRORS", Newtonsoft.Json.JsonConvert.SerializeObject(r.Error, CommonFunctions.JsonSerializerSettings)),
                new MySqlParameter("_IMPORT_TYPE", _import_type),
                new MySqlParameter("_DATA_IMPORT", _data_import) });
            da.ExecuteInsertQuery();
        }

        public response MovePendingToOk()
        {
            response toReturn = new response(false, "", null, null, new List<Error>()); ;
            try
            {
                DataAccess da = new DataAccess(authenticatedUserId, connectionString, CommandType.StoredProcedure, "PLATIsp_MovePendingToOk", new object[] { new MySqlParameter("_PENDING_ID", ID) });
                toReturn = da.ExecuteInsertQuery();
                if (toReturn.Status && Convert.ToInt32(toReturn.InsertedId) > 0)
                {
                    Plata newPlata = new Plata(authenticatedUserId, connectionString, Convert.ToInt32(toReturn.InsertedId));
                    Dosar d = new Dosar(authenticatedUserId, connectionString, Convert.ToInt32( newPlata.ID_DOSAR));
                    d.REZERVA_DAUNA -= this.SUMA;
                    d.GetNewStatus(false);
                    response r = d.Update();
                }
            }
            catch { }
            return toReturn;
        }
    }
}