﻿using MySql.Data.MySqlClient;
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
    /// <summary>
    /// Clasa statica cu diferite metode pentru selectia Partilor din baza de date
    /// </summary>
    public class Parte
    {
        const string _TABLE_NAME = "parti";
        private int authenticatedUserId { get; set; }
        private string connectionString { get; set; }

        public int? ID { get; set; }

        [JsonProperty(NullValueHandling = NullValueHandling.Include)]
        [Required(ErrorMessageResourceName = "emptyDenumireParte", ErrorMessageResourceType = typeof(socisaV2.Resources.ErrorMessagesResx))]
        [Display(Name = "DENUMIRE", ResourceType = typeof(socisaV2.Resources.AsiguratiResx))]
        public string DENUMIRE { get; set; }

        [JsonProperty(NullValueHandling = NullValueHandling.Include)]
        [Display(Name = "DETALII", ResourceType = typeof(socisaV2.Resources.AsiguratiResx))]
        public string DETALII { get; set; }

        public Parte() { }

        public Parte(int _authenticatedUserId, string _connectionString)
        {
            authenticatedUserId = _authenticatedUserId;
            connectionString = _connectionString;
        }

        public Parte(int _authenticatedUserId, string _connectionString, int _ID)
        {
            authenticatedUserId = _authenticatedUserId;
            connectionString = _connectionString;
            DataAccess da = new DataAccess(authenticatedUserId, connectionString, CommandType.StoredProcedure, "PARTIsp_GetById", new object[] { new MySqlParameter("_ID", _ID) });
            MySqlDataReader r = da.ExecuteSelectQuery();
            while (r.Read())
            {
                IDataRecord parte = (IDataRecord)r;
                ParteConstructor(parte);
                break;
            }
            r.Close(); r.Dispose(); da.CloseConnection();
        }

        public Parte(int _authenticatedUserId, string _connectionString, string _DENUMIRE)
        {
            authenticatedUserId = _authenticatedUserId;
            connectionString = _connectionString;
            DataAccess da = new DataAccess(authenticatedUserId, connectionString, CommandType.StoredProcedure, "PARTIsp_GetByDenumire", new object[] { new MySqlParameter("_DENUMIRE", _DENUMIRE) });
            MySqlDataReader r = da.ExecuteSelectQuery();
            while (r.Read())
            {
                IDataRecord parte = (IDataRecord)r;
                ParteConstructor(parte);
                break;
            }
            r.Close(); r.Dispose(); da.CloseConnection();
        }

        public Parte(int _authenticatedUserId, string _connectionString, IDataRecord parte)
        {
            authenticatedUserId = _authenticatedUserId;
            connectionString = _connectionString;
            ParteConstructor(parte);
        }

        public void ParteConstructor(IDataRecord parte)
        {
            try { this.ID = Convert.ToInt32(parte["ID"]); }
            catch { }
            try { this.DENUMIRE = parte["DENUMIRE"].ToString(); }
            catch { }
            try { this.DETALII = parte["DETALII"].ToString(); }
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

            var col = CommonFunctions.table_columns(authenticatedUserId, connectionString, "parti");
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
            DataAccess da = new DataAccess(authenticatedUserId, connectionString, CommandType.StoredProcedure, "PARTIsp_insert", _parameters.ToArray());
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
            var col = CommonFunctions.table_columns(authenticatedUserId, connectionString, "parti");
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
            DataAccess da = new DataAccess(authenticatedUserId, connectionString, CommandType.StoredProcedure, "PARTIsp_update", _parameters.ToArray());
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
            DataAccess da = new DataAccess(authenticatedUserId, connectionString, CommandType.StoredProcedure, "PARTIsp_soft_delete", _parameters.ToArray());
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
                if (this.DENUMIRE == null || this.DENUMIRE.Trim() == "")
                {
                    toReturn.Status = false;
                    err = ErrorParser.ErrorMessage("emptyDenumireParte");
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
            return CommonFunctions.HasChildrens(authenticatedUserId, connectionString, this, "parti", tableName);
        }

        public response HasChildren(string tableName, int childrenId)
        {
            return CommonFunctions.HasChildren(authenticatedUserId, connectionString, this, "parti", tableName, childrenId);
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