﻿using MySql.Data.MySqlClient;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Reflection;
using System.Security.Cryptography;
using Newtonsoft.Json;
using System.ComponentModel.DataAnnotations;

namespace SOCISA.Models
{
    /// <summary>
    /// Clasa care contine definitia obiectului ce mapeaza tabela cu Utilizatori din baza de date
    /// </summary>
    public class Utilizator
    {
        const string _TABLE_NAME = "utilizatori";
        private int authenticatedUserId { get; set; }
        private string connectionString { get; set; }
        public int? ID {get;set;}
        [Required(ErrorMessageResourceName = "emptyUserName", ErrorMessageResourceType = typeof(socisaV2.Resources.ErrorMessagesResx))]
        [Display(Name = "USER_NAME", ResourceType = typeof(socisaV2.Resources.UtilizatoriResx))]
        [JsonProperty(NullValueHandling = NullValueHandling.Include)]
        public string USER_NAME { get; set; }
        [Required(ErrorMessageResourceName = "emptyUserPassword", ErrorMessageResourceType = typeof(socisaV2.Resources.ErrorMessagesResx))]
        [Display(Name = "PASSWORD", ResourceType = typeof(socisaV2.Resources.UtilizatoriResx))]
        [JsonProperty(NullValueHandling = NullValueHandling.Include)]
        public string PASSWORD { get; set; }
        [Display(Name = "NUME_COMPLET", ResourceType = typeof(socisaV2.Resources.UtilizatoriResx))]
        [JsonProperty(NullValueHandling = NullValueHandling.Include)]
        public string NUME_COMPLET { get; set; }
        [Display(Name = "DETALII", ResourceType = typeof(socisaV2.Resources.UtilizatoriResx))]
        [JsonProperty(NullValueHandling = NullValueHandling.Include)]
        public string DETALII { get; set; }
        [Display(Name = "IS_ONLINE", ResourceType = typeof(socisaV2.Resources.UtilizatoriResx))]
        [JsonProperty(NullValueHandling = NullValueHandling.Include)]
        public bool IS_ONLINE { get; set; }
        [Display(Name = "EMAIL", ResourceType = typeof(socisaV2.Resources.UtilizatoriResx))]
        [JsonProperty(NullValueHandling = NullValueHandling.Include)]
        public string EMAIL { get; set; }
        [Display(Name = "IP", ResourceType = typeof(socisaV2.Resources.UtilizatoriResx))]
        [JsonProperty(NullValueHandling = NullValueHandling.Include)]
        public string IP { get; set; }
        [Display(Name = "MAC", ResourceType = typeof(socisaV2.Resources.UtilizatoriResx))]
        [JsonProperty(NullValueHandling = NullValueHandling.Include)]
        public string MAC { get; set; }
        [Required(ErrorMessageResourceName = "emptyUserType", ErrorMessageResourceType = typeof(socisaV2.Resources.ErrorMessagesResx))]
        [Display(Name = "ID_TIP_UTILIZATOR", ResourceType = typeof(socisaV2.Resources.UtilizatoriResx))]
        [JsonProperty(NullValueHandling = NullValueHandling.Include)]
        public int ID_TIP_UTILIZATOR { get; set; }
        [Display(Name = "DEPARTAMENT", ResourceType = typeof(socisaV2.Resources.UtilizatoriResx))]
        [JsonProperty(NullValueHandling = NullValueHandling.Include)]
        public string DEPARTAMENT { get; set; }
        [Display(Name = "LAST_REFRESH", ResourceType = typeof(socisaV2.Resources.UtilizatoriResx))]
        [JsonProperty(NullValueHandling = NullValueHandling.Include)]
        public DateTime? LAST_REFRESH { get; set; }
        [Display(Name = "ID_SOCIETATE", ResourceType = typeof(socisaV2.Resources.UtilizatoriResx))]
        [JsonProperty(NullValueHandling = NullValueHandling.Include)]
        public int? ID_SOCIETATE { get; set; }
        [Display(Name = "LAST_LOGIN", ResourceType = typeof(socisaV2.Resources.UtilizatoriResx))]
        [JsonProperty(NullValueHandling = NullValueHandling.Include)]
        public DateTime? LAST_LOGIN { get; set; }
        [Display(Name = "CURRENT_LOGIN", ResourceType = typeof(socisaV2.Resources.UtilizatoriResx))]
        [JsonProperty(NullValueHandling = NullValueHandling.Include)]
        public DateTime? CURRENT_LOGIN { get; set; }

        /// <summary>
        /// Constructorul default
        /// </summary>
        public Utilizator() { }

        public Utilizator(int _authenticatedUserId, string _connectionString)
        {
            authenticatedUserId = _authenticatedUserId;
            connectionString = _connectionString;
        }

        public Utilizator(int _authenticatedUserId, string _connectionString, int _ID)
        {
            authenticatedUserId = _authenticatedUserId;
            connectionString = _connectionString;
            DataAccess da = new DataAccess(authenticatedUserId, connectionString, CommandType.StoredProcedure, "UTILIZATORIsp_GetById", new object[] { new MySqlParameter("_ID", _ID) });
            MySqlDataReader r = da.ExecuteSelectQuery();
            while (r.Read())
            {
                IDataRecord utilizator = (IDataRecord)r;
                UtilizatorConstructor(utilizator);
                break;
            }
            r.Close(); r.Dispose(); da.CloseConnection();
        }

        public Utilizator(int _authenticatedUserId, string _connectionString, string _USER_NAME)
        {
            authenticatedUserId = _authenticatedUserId;
            connectionString = _connectionString;
            DataAccess da = new DataAccess(authenticatedUserId, connectionString, CommandType.StoredProcedure, "UTILIZATORIsp_GetByUserName", new object[] { new MySqlParameter("_USER_NAME", _USER_NAME) });
            MySqlDataReader r = da.ExecuteSelectQuery();
            while (r.Read())
            {
                IDataRecord utilizator = (IDataRecord)r;
                UtilizatorConstructor(utilizator);
                break;
            }
            r.Close(); r.Dispose(); da.CloseConnection();
        }

        public Utilizator(int _authenticatedUserId, string _connectionString, IDataRecord utilizator)
        {
            authenticatedUserId = _authenticatedUserId;
            connectionString = _connectionString;
            UtilizatorConstructor(utilizator);
        }

        /// <summary>
        /// Functie pentru popularea obiectului Utilizator, folosita de diferiti constructori
        /// </summary>
        /// <param name="utilizator">Inregistrare din DB cu informatiile Utilizatorului curent</param>
        public void UtilizatorConstructor(IDataRecord utilizator)
        {
            try { this.ID = Convert.ToInt32(utilizator["ID"]); }
            catch { }
            try { this.USER_NAME = utilizator["USER_NAME"].ToString(); }
            catch { }
            
            try { this.PASSWORD = utilizator["PASSWORD"].ToString(); }
            catch { }
            
            try { this.NUME_COMPLET = utilizator["NUME_COMPLET"].ToString(); }
            catch { }
            try { this.DETALII = utilizator["DETALII"].ToString(); }
            catch { }
            try { this.IS_ONLINE = Convert.ToBoolean( utilizator["IS_ONLINE"]); }
            catch { }
            try { this.EMAIL = utilizator["EMAIL"].ToString(); }
            catch { }
            try { this.IP = utilizator["IP"].ToString(); }
            catch { }
            try { this.MAC = utilizator["MAC"].ToString(); }
            catch { }
            try { this.ID_TIP_UTILIZATOR = Convert.ToInt32(utilizator["ID_TIP_UTILIZATOR"]); }
            catch { }
            try { this.DEPARTAMENT = utilizator["DEPARTAMENT"].ToString(); }
            catch { }
            try { this.LAST_REFRESH = CommonFunctions.IsNullable(utilizator["LAST_REFRESH"]) ? null : (DateTime?)Convert.ToDateTime(utilizator["LAST_REFRESH"]); }
            catch { }
            try { this.ID_SOCIETATE = Convert.ToInt32(utilizator["ID_SOCIETATE"]); }
            catch { }
            try { this.LAST_LOGIN = CommonFunctions.IsNullable(utilizator["LAST_LOGIN"]) ? null : (DateTime?)Convert.ToDateTime(utilizator["LAST_LOGIN"]); }
            catch { }
            try { this.CURRENT_LOGIN = CommonFunctions.IsNullable(utilizator["CURRENT_LOGIN"]) ? null : (DateTime?)Convert.ToDateTime(utilizator["CURRENT_LOGIN"]); }
            catch { }
        }

        /// <summary>
        /// Metoda pentru inserarea Utilizatorului curent
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
            var col = CommonFunctions.table_columns(authenticatedUserId, connectionString, "utilizatori");
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
                        if (propName.ToUpper() == "PASSWORD")
                        {
                            MD5 md5h = MD5.Create();
                            string md5p = CommonFunctions.GetMd5Hash(md5h, propValue.ToString());
                            _parameters.Add(new MySqlParameter("_PASSWORD", md5p));
                        }
                        else if (propName.ToUpper() != "ID") // il vom folosi doar la Edit!
                            _parameters.Add(new MySqlParameter(String.Format("_{0}", propName.ToUpper()), propValue));
                    }
                }
            }
            DataAccess da = new DataAccess(authenticatedUserId, connectionString, CommandType.StoredProcedure, "UTILIZATORIsp_insert", _parameters.ToArray());
            toReturn = da.ExecuteInsertQuery();
            if (toReturn.Status) this.ID = toReturn.InsertedId;

            return toReturn;
        }

        /// <summary>
        /// Metoda pentru actualizarea Utilizatorului curent
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
            var col = CommonFunctions.table_columns(authenticatedUserId, connectionString, "utilizatori");
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
                        /*
                        if (propName.ToUpper() == "PASSWORD")
                        {
                            MD5 md5h = MD5.Create();
                            string md5p = CommonFunctions.GetMd5Hash(md5h, propValue.ToString());
                            _parameters.Add(new MySqlParameter("_PASSWORD", md5p));
                        }
                        else
                        */
                        {
                            _parameters.Add(new MySqlParameter(String.Format("_{0}", propName.ToUpper()), propValue));
                        }
                    }
                    
                }
            }
            DataAccess da = new DataAccess(authenticatedUserId, connectionString, CommandType.StoredProcedure, "UTILIZATORIsp_update", _parameters.ToArray());
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

        public response SetPassword(string password)
        {
            response toReturn = new response();
            ArrayList _parameters = new ArrayList();
            _parameters.Add(new MySqlParameter("_ID_UTILIZATOR", this.ID));
            MD5 md5h = MD5.Create();
            string md5p = CommonFunctions.GetMd5Hash(md5h, password);
            _parameters.Add(new MySqlParameter("_PASSWORD", md5p));
            DataAccess da = new DataAccess(authenticatedUserId, connectionString, CommandType.StoredProcedure, "UTILIZATORIsp_SetPassword", _parameters.ToArray());
            toReturn = da.ExecuteUpdateQuery();
            return toReturn;
        }

        /// <summary>
        /// Metoda pentru stergerea utilizatorului curent
        /// </summary>
        /// <returns>SOCISA.response = new object(bool = status, string = error message, int = id-ul cheie returnat)</returns>
        public response Delete()
        {
            try
            {
                foreach (Action a in (Action[])this.GetActions().Result)
                {
                    UtilizatorAction ua = new UtilizatorAction(authenticatedUserId, connectionString);
                    ua.ID_UTILIZATOR = Convert.ToInt32(this.ID); ua.ID_ACTION = Convert.ToInt32(a.ID);
                    ua.Delete();
                }
            }
            catch (Exception exp) { LogWriter.Log(exp); }

            try
            {
                foreach (Drept d in (Drept[])this.GetDrepturi().Result)
                {
                    UtilizatorDrept ud = new UtilizatorDrept(authenticatedUserId, connectionString);
                    ud.ID_UTILIZATOR = Convert.ToInt32(this.ID); ud.ID_DREPT = Convert.ToInt32(d.ID);
                    ud.Delete();
                }
            }
            catch (Exception exp) { LogWriter.Log(exp); }

            try
            {
                foreach (Dosar d in (Dosar[])this.GetDosare().Result)
                {
                    UtilizatorDosar ud = new UtilizatorDosar(authenticatedUserId, connectionString);
                    ud.ID_UTILIZATOR = Convert.ToInt32(this.ID); ud.ID_DOSAR = Convert.ToInt32(d.ID);
                    ud.Delete();
                }
            }
            catch (Exception exp) { LogWriter.Log(exp); }

            try
            {
                foreach (SocietateAsigurare sa in (SocietateAsigurare[])this.GetSocietatiAdministrate().Result)
                {
                    UtilizatorSocietateAdministrata usa = new UtilizatorSocietateAdministrata(authenticatedUserId, connectionString);
                    usa.ID_UTILIZATOR = Convert.ToInt32(this.ID); usa.ID_SOCIETATE = Convert.ToInt32(sa.ID);
                    usa.Delete();
                }
            }
            catch (Exception exp) { LogWriter.Log(exp); }

            try
            {
                foreach (Setare s in (Setare[])this.GetSetari().Result)
                {
                    UtilizatorSetare us = new UtilizatorSetare(authenticatedUserId, connectionString);
                    us.ID_UTILIZATOR = Convert.ToInt32(this.ID); us.ID_SETARE = Convert.ToInt32(s.ID);
                    us.Delete();
                }
            }
            catch (Exception exp) { LogWriter.Log(exp); }

            response toReturn = new response(false, "", null, null, new List<Error>());;
            ArrayList _parameters = new ArrayList();
            _parameters.Add(new MySqlParameter("_ID", this.ID));
            DataAccess da = new DataAccess(authenticatedUserId, connectionString, CommandType.StoredProcedure, "UTILIZATORIsp_soft_delete", _parameters.ToArray());
            toReturn = da.ExecuteDeleteQuery();
            return toReturn;
        }

        /// <summary>
        /// Metoda pentru validarea Utilizatorului curent
        /// </summary>
        /// <returns>SOCISA.response = new object(bool = status, string = error message, int = id-ul cheie returnat)</returns>
        public response Validare()
        {
            response toReturn = new response(true, "", null, null, new List<Error>());;
            Error err = new Error();
            if (this.USER_NAME == null || this.USER_NAME.Trim() == "")
            {
                toReturn.Status = false;
                err = ErrorParser.ErrorMessage("emptyUserName");
                toReturn.Message = string.Format("{0}{1};", toReturn.Message == null ? "" : toReturn.Message, err.ERROR_MESSAGE);
                toReturn.InsertedId = null;
                toReturn.Error.Add(err);
            }
            
            if (this.PASSWORD == null || this.PASSWORD.Trim() == "")
            {
                toReturn.Status = false;
                err = ErrorParser.ErrorMessage("emptyUserPassword");
                toReturn.Message = string.Format("{0}{1};", toReturn.Message == null ? "" : toReturn.Message, err.ERROR_MESSAGE);
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
            return CommonFunctions.HasChildrens(authenticatedUserId, connectionString, this, "utilizatori", tableName);
        }

        public response HasChildren(string tableName, int childrenId)
        {
            return CommonFunctions.HasChildren(authenticatedUserId, connectionString, this, "utilizatori", tableName, childrenId);
        }

        public response GetChildrens(string tableName)
        {
            return CommonFunctions.GetChildrens(this, tableName);
        }

        public response GetChildren(string tableName, int childrenId)
        {
            return CommonFunctions.GetChildren(this, tableName, childrenId);
        }

        /// <summary>
        /// Metoda pt. popularea dosarelor care sunt assignate utilizatorului curent
        /// </summary>
        /// <returns>vector de SOCISA.DosareJson</returns>
        public response GetDosare()
        {
            try
            {
                DataAccess da = new DataAccess(authenticatedUserId, connectionString, CommandType.StoredProcedure, "UTILIZATORI_DOSAREsp_GetByIdUtilizator", new object[] { new MySqlParameter("_ID_UTILIZATOR", this.ID) });
                MySqlDataReader r = da.ExecuteSelectQuery();
                /*
                ArrayList aList = new ArrayList();
                while (r.Read())
                {
                    Dosar d = new Dosar(authenticatedUserId, connectionString, Convert.ToInt32(r["ID_DOSAR"]));
                    aList.Add(d);
                }
                r.Close(); r.Dispose(); da.CloseConnection();
                Dosar[] toReturn = new Dosar[aList.Count];
                for (int i = 0; i < aList.Count; i++)
                {
                    toReturn[i] = (Dosar)aList[i];
                }
                return new response(true, Newtonsoft.Json.JsonConvert.SerializeObject(toReturn, CommonFunctions.JsonSerializerSettings), toReturn, null, null);
                */
                List<Dosar> aList = new List<Dosar>();
                while (r.Read())
                {
                    aList.Add(new Dosar(authenticatedUserId, connectionString, Convert.ToInt32(r["ID_DOSAR"])));
                }
                r.Close(); r.Dispose(); da.CloseConnection();

                return new response(true, Newtonsoft.Json.JsonConvert.SerializeObject(aList.ToArray(), CommonFunctions.JsonSerializerSettings), aList.ToArray(), null, null);
            }
            catch (Exception exp) { LogWriter.Log(exp); return new response(false, exp.ToString(), null, null, new List<Error>() { new Error(exp) }); }
        }

        public response GetDosareNoi(int id_societate)
        {
            try
            {
                DataAccess da = new DataAccess(authenticatedUserId, connectionString, CommandType.StoredProcedure, "DOSAREsp_GetAllFromLastLogin", new object[] { new MySqlParameter("_ID_SOCIETATE", id_societate) });
                MySqlDataReader r = da.ExecuteSelectQuery();
                /*
                ArrayList aList = new ArrayList();
                while (r.Read())
                {
                    Dosar d = new Dosar(authenticatedUserId, connectionString, Convert.ToInt32(r["ID"]));
                    aList.Add(d);
                }
                r.Close(); r.Dispose(); da.CloseConnection();
                Dosar[] toReturn = new Dosar[aList.Count];
                for (int i = 0; i < aList.Count; i++)
                {
                    toReturn[i] = (Dosar)aList[i];
                }
                return new response(true, Newtonsoft.Json.JsonConvert.SerializeObject(toReturn, CommonFunctions.JsonSerializerSettings), toReturn, null, null);
                */
                List<Dosar> aList = new List<Dosar>();
                while (r.Read())
                {
                    aList.Add(new Dosar(authenticatedUserId, connectionString, Convert.ToInt32(r["ID"])));
                }
                r.Close(); r.Dispose(); da.CloseConnection();
                return new response(true, Newtonsoft.Json.JsonConvert.SerializeObject(aList.ToArray(), CommonFunctions.JsonSerializerSettings), aList.ToArray(), null, null);
            }
            catch (Exception exp) { LogWriter.Log(exp); return new response(false, exp.ToString(), null, null, new List<Error>() { new Error(exp) }); }
        }

        public response GetDosareNeasignate(int id_societate)
        {
            try
            {
                DataAccess da = new DataAccess(authenticatedUserId, connectionString, CommandType.StoredProcedure, "DOSAREsp_GetAllNeasignate", new object[] { new MySqlParameter("_ID_SOCIETATE", id_societate), new MySqlParameter("_EXPIRATION_DAYS", 15) });
                MySqlDataReader r = da.ExecuteSelectQuery();
                /*
                ArrayList aList = new ArrayList();
                while (r.Read())
                {
                    Dosar d = new Dosar(authenticatedUserId, connectionString, Convert.ToInt32(r["ID"]));
                    aList.Add(d);
                }
                r.Close(); r.Dispose(); da.CloseConnection();
                Dosar[] toReturn = new Dosar[aList.Count];
                for (int i = 0; i < aList.Count; i++)
                {
                    toReturn[i] = (Dosar)aList[i];
                }
                return new response(true, Newtonsoft.Json.JsonConvert.SerializeObject(toReturn, CommonFunctions.JsonSerializerSettings), toReturn, null, null);
                */
                List<Dosar> aList = new List<Dosar>();
                while (r.Read())
                {
                    aList.Add(new Dosar(authenticatedUserId, connectionString, Convert.ToInt32(r["ID"])));
                }
                r.Close(); r.Dispose(); da.CloseConnection();
                return new response(true, Newtonsoft.Json.JsonConvert.SerializeObject(aList.ToArray(), CommonFunctions.JsonSerializerSettings), aList.ToArray(), null, null);

            }
            catch (Exception exp) { LogWriter.Log(exp); return new response(false, exp.ToString(), null, null, new List<Error>() { new Error(exp) }); }
        }

        public response GetDosareNeoperate(int id_societate)
        {
            try
            {
                DataAccess da = new DataAccess(authenticatedUserId, connectionString, CommandType.StoredProcedure, "DOSAREsp_GetAllNeoperate", new object[] { new MySqlParameter("_ID_SOCIETATE", id_societate), new MySqlParameter("_EXPIRATION_DAYS", 15) });
                MySqlDataReader r = da.ExecuteSelectQuery();
                /*
                ArrayList aList = new ArrayList();
                while (r.Read())
                {
                    Dosar d = new Dosar(authenticatedUserId, connectionString, Convert.ToInt32(r["ID"]));
                    aList.Add(d);
                }
                r.Close(); r.Dispose(); da.CloseConnection();
                Dosar[] toReturn = new Dosar[aList.Count];
                for (int i = 0; i < aList.Count; i++)
                {
                    toReturn[i] = (Dosar)aList[i];
                }
                return new response(true, Newtonsoft.Json.JsonConvert.SerializeObject(toReturn, CommonFunctions.JsonSerializerSettings), toReturn, null, null);
                */
                List<Dosar> aList = new List<Dosar>();
                while (r.Read())
                {
                    aList.Add(new Dosar(authenticatedUserId, connectionString, Convert.ToInt32(r["ID"])));
                }
                r.Close(); r.Dispose(); da.CloseConnection();
                return new response(true, Newtonsoft.Json.JsonConvert.SerializeObject(aList.ToArray(), CommonFunctions.JsonSerializerSettings), aList.ToArray(), null, null);
            }
            catch (Exception exp) { LogWriter.Log(exp); return new response(false, exp.ToString(), null, null, new List<Error>() { new Error(exp) }); }
        }

        /// <summary>
        /// Metoda pt. popularea relatiilor dintre utilizatori si dosarele asignate utilizatorului curent
        /// </summary>
        /// <returns>vector de SOCISA.UtilizatoriDosareJson</returns>
        public response GetUtilizatoriDosare()
        {
            try
            {
                DataAccess da = new DataAccess(authenticatedUserId, connectionString, CommandType.StoredProcedure, "UTILIZATORI_DOSAREsp_GetByIdUtilizator", new object[] { new MySqlParameter("_ID_UTILIZATOR", this.ID) });
                MySqlDataReader r = da.ExecuteSelectQuery();
                /*
                ArrayList aList = new ArrayList();
                while (r.Read())
                {
                    UtilizatorDosar d = new UtilizatorDosar(authenticatedUserId, connectionString, Convert.ToInt32(r["ID_DREPT"]));
                    aList.Add(d);
                }
                r.Close(); r.Dispose(); da.CloseConnection();
                UtilizatorDosar[] toReturn = new UtilizatorDosar[aList.Count];
                for (int i = 0; i < aList.Count; i++)
                {
                    toReturn[i] = (UtilizatorDosar)aList[i];
                }
                return new response(true, Newtonsoft.Json.JsonConvert.SerializeObject(toReturn, CommonFunctions.JsonSerializerSettings), toReturn, null, null);
                */
                List<UtilizatorDosar> aList = new List<UtilizatorDosar>();
                while (r.Read())
                {
                    aList.Add(new UtilizatorDosar(authenticatedUserId, connectionString, Convert.ToInt32(r["ID_DREPT"])));
                }
                r.Close(); r.Dispose(); da.CloseConnection();
                return new response(true, Newtonsoft.Json.JsonConvert.SerializeObject(aList.ToArray(), CommonFunctions.JsonSerializerSettings), aList.ToArray(), null, null);
            }
            catch (Exception exp) { LogWriter.Log(exp); return new response(false, exp.ToString(), null, null, new List<Error>() { new Error(exp) }); }
        }

        /// <summary>
        /// Metoda pt. popularea drepturilor care sunt asignate utilizatorului curent
        /// </summary>
        /// <returns>SOCISA.DrepturiJson</returns>
        public response GetDrepturi()
        {
            try
            {
                DataAccess da = new DataAccess(authenticatedUserId, connectionString, CommandType.StoredProcedure, "UTILIZATORI_DREPTURIsp_GetByIdUtilizator", new object[] { new MySqlParameter("_ID_UTILIZATOR", this.ID) });
                MySqlDataReader r = da.ExecuteSelectQuery();
                /*
                ArrayList aList = new ArrayList();
                while (r.Read())
                {
                    Drept d = new Drept(authenticatedUserId, connectionString, Convert.ToInt32(r["ID_DREPT"]));
                    aList.Add(d);
                }
                r.Close(); r.Dispose(); da.CloseConnection();
                Drept[] toReturn = new Drept[aList.Count];
                for (int i = 0; i < aList.Count; i++)
                {
                    toReturn[i] = (Drept)aList[i];
                }
                return new response(true, Newtonsoft.Json.JsonConvert.SerializeObject(toReturn, CommonFunctions.JsonSerializerSettings), toReturn, null, null);
                */
                List<Drept> aList = new List<Drept>();
                while (r.Read())
                {
                    aList.Add(new Drept(authenticatedUserId, connectionString, Convert.ToInt32(r["ID_DREPT"])));
                }
                r.Close(); r.Dispose(); da.CloseConnection();
                return new response(true, Newtonsoft.Json.JsonConvert.SerializeObject(aList.ToArray(), CommonFunctions.JsonSerializerSettings), aList.ToArray(), null, null);
            }
            catch (Exception exp) { LogWriter.Log(exp); return new response(false, exp.ToString(), null, null, new List<Error>() { new Error(exp) }); }
        }

        /// <summary>
        /// Metoda pt. popularea relatiilor dintre utilizatori si drepturile asignate utilizatorului curent
        /// </summary>
        /// <returns>vector de SOCISA.UtilizatoriDrepturiJson</returns>
        public response GetUtilizatoriDrepturi()
        {
            try
            {
                DataAccess da = new DataAccess(authenticatedUserId, connectionString, CommandType.StoredProcedure, "UTILIZATORI_DREPTURIsp_GetByIdUtilizator", new object[] { new MySqlParameter("_ID_UTILIZATOR", this.ID) });
                MySqlDataReader r = da.ExecuteSelectQuery();
                /*
                ArrayList aList = new ArrayList();
                while (r.Read())
                {
                    UtilizatorDrept d = new UtilizatorDrept(authenticatedUserId, connectionString, Convert.ToInt32(r["ID"]));
                    aList.Add(d);
                }
                r.Close(); r.Dispose(); da.CloseConnection();
                UtilizatorDrept[] toReturn = new UtilizatorDrept[aList.Count];
                for (int i = 0; i < aList.Count; i++)
                {
                    toReturn[i] = (UtilizatorDrept)aList[i];
                }
                return new response(true, Newtonsoft.Json.JsonConvert.SerializeObject(toReturn, CommonFunctions.JsonSerializerSettings), toReturn, null, null);
                */
                List<UtilizatorDrept> aList = new List<UtilizatorDrept>();
                while (r.Read())
                {
                    aList.Add(new UtilizatorDrept(authenticatedUserId, connectionString, Convert.ToInt32(r["ID"])));
                }
                r.Close(); r.Dispose(); da.CloseConnection();
                return new response(true, Newtonsoft.Json.JsonConvert.SerializeObject(aList.ToArray(), CommonFunctions.JsonSerializerSettings), aList.ToArray(), null, null);
            }
            catch (Exception exp) { LogWriter.Log(exp); return new response(false, exp.ToString(), null, null, new List<Error>() { new Error(exp) }); }
        }

        /// <summary>
        /// Metoda pt. popularea actiunilor care sunt assignate utilizatorului curent
        /// </summary>
        /// <returns>vector de SOCISA.ActionsJson</returns>
        public response GetActions()
        {
            try
            {
                DataAccess da = new DataAccess(authenticatedUserId, connectionString, CommandType.StoredProcedure, "UTILIZATORI_ACTIONSsp_GetByIdUtilizator", new object[] { new MySqlParameter("_ID_UTILIZATOR", this.ID) });
                MySqlDataReader r = da.ExecuteSelectQuery();
                /*
                ArrayList aList = new ArrayList();
                while (r.Read())
                {
                    Action a = new Action(authenticatedUserId, connectionString, Convert.ToInt32(r["ID_ACTION"]));
                    aList.Add(a);
                }
                r.Close(); r.Dispose(); da.CloseConnection();
                Action[] toReturn = new Action[aList.Count];
                for (int i = 0; i < aList.Count; i++)
                {
                    toReturn[i] = (Action)aList[i];
                }
                return new response(true, Newtonsoft.Json.JsonConvert.SerializeObject(toReturn, CommonFunctions.JsonSerializerSettings), toReturn, null, null);
                */

                List<Action> aList = new List<Action>();
                while (r.Read())
                {
                    aList.Add(new Action(authenticatedUserId, connectionString, Convert.ToInt32(r["ID_ACTION"])));
                }
                r.Close(); r.Dispose(); da.CloseConnection();

                return new response(true, Newtonsoft.Json.JsonConvert.SerializeObject(aList.ToArray(), CommonFunctions.JsonSerializerSettings), aList.ToArray(), null, null);
            }
            catch (Exception exp) { LogWriter.Log(exp); return new response(false, exp.ToString(), null, null, new List<Error>() { new Error(exp) }); }
        }

        /// <summary>
        /// Metoda pt. popularea relatiilor dintre utilizatori si actiunile asignate utilizatorului curent
        /// </summary>
        /// <returns>vector de SOCISA.UtilizatoriActionsJson</returns>
        public response GetUtilizatoriActions()
        {
            try
            {
                DataAccess da = new DataAccess(authenticatedUserId, connectionString, CommandType.StoredProcedure, "UTILIZATORI_ACTIONSsp_GetByIdUtilizator", new object[] { new MySqlParameter("_ID_UTILIZATOR", this.ID) });
                MySqlDataReader r = da.ExecuteSelectQuery();
                /*
                ArrayList aList = new ArrayList();
                while (r.Read())
                {
                    UtilizatorAction d = new UtilizatorAction(authenticatedUserId, connectionString, Convert.ToInt32(r["ID"]));
                    aList.Add(d);
                }
                r.Close(); r.Dispose(); da.CloseConnection();
                UtilizatorAction[] toReturn = new UtilizatorAction[aList.Count];
                for (int i = 0; i < aList.Count; i++)
                {
                    toReturn[i] = (UtilizatorAction)aList[i];
                }
                return new response(true, Newtonsoft.Json.JsonConvert.SerializeObject(toReturn, CommonFunctions.JsonSerializerSettings), toReturn, null, null);
                */
                List<UtilizatorAction> aList = new List<UtilizatorAction>();
                while (r.Read())
                {
                    aList.Add(new UtilizatorAction(authenticatedUserId, connectionString, Convert.ToInt32(r["ID"])));
                }
                r.Close(); r.Dispose(); da.CloseConnection();
                return new response(true, Newtonsoft.Json.JsonConvert.SerializeObject(aList.ToArray(), CommonFunctions.JsonSerializerSettings), aList.ToArray(), null, null);
            }
            catch (Exception exp) { LogWriter.Log(exp); return new response(false, exp.ToString(), null, null, new List<Error>() { new Error(exp) }); }
        }

        /// <summary>
        /// Metoda pt. popularea setarilor care sunt asignate utilizatorului curent
        /// </summary>
        /// <returns>vector de SOCISA.SetariJson</returns>
        public response GetSetari()
        {
            try
            {
                DataAccess da = new DataAccess(authenticatedUserId, connectionString, CommandType.StoredProcedure, "UTILIZATORI_SETARIsp_GetByIdUtilizator", new object[] { new MySqlParameter("_ID_UTILIZATOR", this.ID) });
                MySqlDataReader r = da.ExecuteSelectQuery();
                /*
                ArrayList aList = new ArrayList();
                while (r.Read())
                {
                    Setare a = new Setare(authenticatedUserId, connectionString, Convert.ToInt32(r["ID_SETARE"]));
                    aList.Add(a);
                }
                r.Close(); r.Dispose(); da.CloseConnection();
                Setare[] toReturn = new Setare[aList.Count];
                for (int i = 0; i < aList.Count; i++)
                {
                    toReturn[i] = (Setare)aList[i];
                }
                return new response(true, Newtonsoft.Json.JsonConvert.SerializeObject(toReturn, CommonFunctions.JsonSerializerSettings), toReturn, null, null);
                */
                List<Setare> aList = new List<Setare>();
                while (r.Read())
                {
                    aList.Add(new Setare(authenticatedUserId, connectionString, Convert.ToInt32(r["ID_SETARE"])));
                }
                r.Close(); r.Dispose(); da.CloseConnection();
                return new response(true, Newtonsoft.Json.JsonConvert.SerializeObject(aList.ToArray(), CommonFunctions.JsonSerializerSettings), aList.ToArray(), null, null);
            }
            catch (Exception exp) { LogWriter.Log(exp); return new response(false, exp.ToString(), null, null, new List<Error>() { new Error(exp) }); }
        }

        /// <summary>
        /// Metoda pt. popularea relatiilor dintre utilizatori si setarile asignate utilizatorului curent
        /// </summary>
        /// <returns>vector de SOCISA.UtilizatoriSetariJson</returns>
        public response GetUtilizatoriSetari()
        {
            try
            {
                DataAccess da = new DataAccess(authenticatedUserId, connectionString, CommandType.StoredProcedure, "UTILIZATORI_SETARIsp_GetByIdUtilizator", new object[] { new MySqlParameter("_ID_UTILIZATOR", this.ID) });
                MySqlDataReader r = da.ExecuteSelectQuery();
                /*
                ArrayList aList = new ArrayList();
                while (r.Read())
                {
                    UtilizatorSetare a = new UtilizatorSetare(authenticatedUserId, connectionString, Convert.ToInt32(r["ID_SETARE"]));
                    aList.Add(a);
                }
                UtilizatorSetare[] toReturn = new UtilizatorSetare[aList.Count];
                for (int i = 0; i < aList.Count; i++)
                {
                    toReturn[i] = (UtilizatorSetare)aList[i];
                }
                return new response(true, Newtonsoft.Json.JsonConvert.SerializeObject(toReturn, CommonFunctions.JsonSerializerSettings), toReturn, null, null);
                */
                List<UtilizatorSetare> aList = new List<UtilizatorSetare>();
                while (r.Read())
                {
                    aList.Add(new UtilizatorSetare(authenticatedUserId, connectionString, Convert.ToInt32(r["ID_SETARE"])));
                }
                return new response(true, Newtonsoft.Json.JsonConvert.SerializeObject(aList.ToArray(), CommonFunctions.JsonSerializerSettings), aList.ToArray(), null, null);
            }
            catch (Exception exp) { LogWriter.Log(exp); return new response(false, exp.ToString(), null, null, new List<Error>() { new Error(exp) }); }
        }

        /// <summary>
        /// Metoda pt. popularea societatilor care sunt asignate utilizatorului curent
        /// </summary>
        /// <returns>vector de SOCISA.SocietatiAsigurareJson</returns>
        public response GetSocietatiAsigurare()
        {
            try
            {
                SocietateAsigurare s = new SocietateAsigurare(authenticatedUserId, connectionString, Convert.ToInt32(this.ID_SOCIETATE));
                return new response(true, Newtonsoft.Json.JsonConvert.SerializeObject(s), s, null, null);
            }
            catch (Exception exp) { LogWriter.Log(exp); return new response(false, exp.ToString(), null, null, new List<Error>() { new Error(exp) }); }
        }

        public response GetUtilizatoriSocietatiAdministrate()
        {
            try
            {
                DataAccess da = new DataAccess(authenticatedUserId, connectionString, CommandType.StoredProcedure, "UTILIZATORI_SOCIETATI_ADMINISTRATEsp_GetByIdUtilizator", new object[] { new MySqlParameter("_ID_UTILIZATOR", this.ID) });
                MySqlDataReader r = da.ExecuteSelectQuery();
                /*
                ArrayList aList = new ArrayList();
                while (r.Read())
                {
                    UtilizatorSocietateAdministrata d = new UtilizatorSocietateAdministrata(authenticatedUserId, connectionString, Convert.ToInt32(r["ID"]));
                    aList.Add(d);
                }
                r.Close(); r.Dispose(); da.CloseConnection();
                UtilizatorSocietateAdministrata[] toReturn = new UtilizatorSocietateAdministrata[aList.Count];
                for (int i = 0; i < aList.Count; i++)
                {
                    toReturn[i] = (UtilizatorSocietateAdministrata)aList[i];
                }
                return new response(true, Newtonsoft.Json.JsonConvert.SerializeObject(toReturn, CommonFunctions.JsonSerializerSettings), toReturn, null, null);
                */
                List<UtilizatorSocietateAdministrata> aList = new List<UtilizatorSocietateAdministrata>();
                while (r.Read())
                {
                    aList.Add(new UtilizatorSocietateAdministrata(authenticatedUserId, connectionString, Convert.ToInt32(r["ID"])));
                }
                r.Close(); r.Dispose(); da.CloseConnection();
                return new response(true, Newtonsoft.Json.JsonConvert.SerializeObject(aList.ToArray(), CommonFunctions.JsonSerializerSettings), aList.ToArray(), null, null);
            }
            catch (Exception exp) { LogWriter.Log(exp); return new response(false, exp.ToString(), null, null, new List<Error>() { new Error(exp) }); }
        }

        /// <summary>
        /// Metoda pt. popularea societatilor care sunt asignate utilizatorului curent
        /// </summary>
        /// <returns>vector de SOCISA.SocietatiAsigurareJson</returns>
        public response GetSocietatiAdministrate()
        {
            try
            {
                DataAccess da = new DataAccess(authenticatedUserId, connectionString, CommandType.StoredProcedure, "UTILIZATORI_SOCIETATI_ADMINISTRATEsp_GetByIdUtilizator", new object[] { new MySqlParameter("_ID_UTILIZATOR", this.ID) });
                MySqlDataReader r = da.ExecuteSelectQuery();
                /*
                ArrayList aList = new ArrayList();
                while (r.Read())
                {
                    SocietateAsigurare a = new SocietateAsigurare(authenticatedUserId, connectionString, Convert.ToInt32(r["ID_SOCIETATE"]));
                    aList.Add(a);
                }
                r.Close(); r.Dispose(); da.CloseConnection();
                SocietateAsigurare[] toReturn = new SocietateAsigurare[aList.Count];
                for (int i = 0; i < aList.Count; i++)
                {
                    toReturn[i] = (SocietateAsigurare)aList[i];
                }
                return new response(true, Newtonsoft.Json.JsonConvert.SerializeObject(toReturn, CommonFunctions.JsonSerializerSettings), toReturn, null, null);
                */
                List<SocietateAsigurare> aList = new List<SocietateAsigurare>();
                while (r.Read())
                {
                    aList.Add(new SocietateAsigurare(authenticatedUserId, connectionString, Convert.ToInt32(r["ID_SOCIETATE"])));
                }
                r.Close(); r.Dispose(); da.CloseConnection();
                return new response(true, Newtonsoft.Json.JsonConvert.SerializeObject(aList.ToArray(), CommonFunctions.JsonSerializerSettings), aList.ToArray(), null, null);
            }
            catch (Exception exp) { LogWriter.Log(exp); return new response(false, exp.ToString(), null, null, new List<Error>() { new Error(exp) }); }
        }

        public response GetUtilizatoriSubordonati()
        {
            try
            {
                DataAccess da = new DataAccess(authenticatedUserId, connectionString, CommandType.StoredProcedure, "UTILIZATORIsp_GetSubordonati", new object[] { new MySqlParameter("_ID_UTILIZATOR", this.ID) });
                MySqlDataReader r = da.ExecuteSelectQuery();
                /*
                ArrayList aList = new ArrayList();
                while (r.Read())
                {
                    Utilizator u = new Utilizator(authenticatedUserId, connectionString, r);
                    aList.Add(u);
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
                    aList.Add(new Utilizator(authenticatedUserId, connectionString, r));
                }
                r.Close(); r.Dispose(); da.CloseConnection();
                return new response(true, Newtonsoft.Json.JsonConvert.SerializeObject(aList.ToArray(), CommonFunctions.JsonSerializerSettings), aList.ToArray(), null, null);
            }
            catch (Exception exp) { LogWriter.Log(exp); return new response(false, exp.ToString(), null, null, new List<Error>() { new Error(exp) }); }
        }

        /// <summary>
        /// Metoda pt. popularea tipului utilizatorului curent
        /// </summary>
        /// <returns>SOCISA.NomenclatorJson</returns>
        public response GetTipUtilizator()
        {
            try
            {
                Nomenclator toReturn = new Nomenclator(authenticatedUserId, connectionString, "tip_utilizatori", this.ID_TIP_UTILIZATOR);
                return new response(true, Newtonsoft.Json.JsonConvert.SerializeObject(toReturn, CommonFunctions.JsonSerializerSettings), toReturn, null, null);
            }
            catch (Exception exp) { LogWriter.Log(exp); return new response(false, exp.ToString(), null, null, new List<Error>() { new Error(exp) }); }
        }

        /// <summary>
        /// Metoda pt. returnarea datei ultimului refresh pt. un utilizator (pt. refresh dashboard automat)
        /// </summary>
        /// <param name="_ID_UTILIZATOR">ID-ul unic al utilizatorului</param>
        /// <returns>System.DateTime sau null</returns>
        public response GetLastRefresh()
        {
            DateTime? toReturn = null;
            try
            {
                DataAccess da = new DataAccess( authenticatedUserId, connectionString, CommandType.StoredProcedure, "UTILIZATORIsp_GetLastRefresh", new object[] { new MySqlParameter("_ID_UTILIZATOR", Convert.ToInt32(ID)) });
                toReturn = Convert.ToDateTime(da.ExecuteScalarQuery().Result);
                return new response(true, Newtonsoft.Json.JsonConvert.SerializeObject(toReturn, CommonFunctions.JsonSerializerSettings), toReturn, null, null);
            }
            catch (Exception exp) { LogWriter.Log(exp); return new response(false, exp.ToString(), null, null, new List<Error>() { new Error(exp) }); }
        }

        /// <summary>
        /// Metoda pt. setarea datei ultimului refresh al unui utilizator (pt. refresh dashboard automat)
        /// </summary>
        /// <param name="_ID_UTILIZATOR">ID-ul unic al utilizatorului</param>
        /// <param name="_LAST_REFRESH">Data ultimului refresh</param>
        /// <returns>SOCISA.response = new object(bool = status, string = error message, int = id-ul cheie returnat)</returns>
        public response SetLastRefresh(DateTime _LAST_REFRESH)
        {
            try
            {
                DataAccess da = new DataAccess(authenticatedUserId, connectionString, CommandType.StoredProcedure, "UTILIZATORIsp_SetLastRefresh", new object[] { new MySqlParameter("_ID_UTILIZATOR", Convert.ToInt32(ID)), new MySqlParameter("_LAST_REFRESH", _LAST_REFRESH) });
                return da.ExecuteUpdateQuery();
            }
            catch (Exception exp) { LogWriter.Log(exp); return new response(false, exp.ToString(), null, null, new List<Error>() { new Error(exp) }); }
        }

        /*
        public response CountNewMessages()
        {
            object[] toReturn = null;
            try
            {
                List<object[]> dtList = new List<object[]>();
                DataAccess da = new DataAccess(authenticatedUserId, connectionString, CommandType.StoredProcedure, "UTILIZATORIsp_CountUnreadMessages", new object[] { new MySqlParameter("_ID_UTILIZATOR", Convert.ToInt32(ID)) });
                MySqlDataReader r = da.ExecuteSelectQuery();
                while (r.Read())
                {
                    dtList.Add(new object[] { new Nomenclator(authenticatedUserId, connectionString, "tip_mesaje", Convert.ToInt32(r["ID_TIP_MESAJ"])), Convert.ToInt32(r["MESAJE_NOI"]) });
                }
                r.Close(); r.Dispose(); da.CloseConnection();
                toReturn = dtList.ToArray();
                return new response(true, Newtonsoft.Json.JsonConvert.SerializeObject(toReturn, CommonFunctions.JsonSerializerSettings), toReturn, null, null);
            }
            catch (Exception exp) { LogWriter.Log(exp); return new response(false, exp.ToString(), null, null, new List<Error>() { new Error(exp) }); }
        }

        public response GetNewMesaje()
        {
            object[] toReturn = null;
            try
            {
                List<Mesaj> dtList = new List<Mesaj>();
                DataAccess da = new DataAccess(authenticatedUserId, connectionString, CommandType.StoredProcedure, "UTILIZATORIsp_GetNewMessages");
                MySqlDataReader r = da.ExecuteSelectQuery();
                while (r.Read())
                {
                    dtList.Add(new Mesaj(authenticatedUserId, connectionString, r));
                }
                r.Close(); r.Dispose(); da.CloseConnection();
                toReturn = dtList.ToArray();
                return new response(true, JsonConvert.SerializeObject(toReturn, CommonFunctions.JsonSerializerSettings), toReturn, null, null);
            }
            catch (Exception exp) { LogWriter.Log(exp); return new response(false, exp.ToString(), null, null, new List<Error>() { new Error(exp) }); }
        }
        */

        public response GetNewMesaje(DateTime _LAST_REFRESH, int? _START_LIMIT, int? _END_LIMIT)
        {
            try
            {
                DataAccess da = new DataAccess(authenticatedUserId, connectionString, CommandType.StoredProcedure, "MESAJEsp_GetByIdDosarNew", new object[] { new MySqlParameter("_ID_DOSAR", null), new MySqlParameter("_LAST_REFRESH", _LAST_REFRESH), new MySqlParameter("_START_LIMIT", _START_LIMIT), new MySqlParameter("_END_LIMIT", _END_LIMIT) });
                response r = da.ExecuteScalarQuery();
                return r;
            }
            catch (Exception exp) { LogWriter.Log(exp); return new response(false, exp.ToString(), null, null, new List<Error>() { new Error(exp) }); }
        }

        public response GetMesaje(int? _START_LIMIT, int? _END_LIMIT)
        {
            //object[] toReturn = null;
            try
            {
                List<Mesaj> dtList = new List<Mesaj>();
                DataAccess da = new DataAccess(authenticatedUserId, connectionString, CommandType.StoredProcedure, "UTILIZATORIsp_GetMessages", new object[] { new MySqlParameter("_START_LIMIT", _START_LIMIT), new MySqlParameter("_END_LIMIT", _END_LIMIT) });
                MySqlDataReader r = da.ExecuteSelectQuery();
                while (r.Read())
                {
                    dtList.Add(new Mesaj(authenticatedUserId, connectionString, r));
                }
                r.Close(); r.Dispose(); da.CloseConnection();
                //toReturn = dtList.ToArray();
                return new response(true, JsonConvert.SerializeObject(dtList.ToArray(), CommonFunctions.JsonSerializerSettings), dtList.ToArray(), null, null);
            }
            catch (Exception exp) { LogWriter.Log(exp); return new response(false, exp.ToString(), null, null, new List<Error>() { new Error(exp) }); }
        }

        public response GetSentMesaje(int? _START_LIMIT, int? _END_LIMIT)
        {
            //object[] toReturn = null;
            try
            {
                List<Mesaj> dtList = new List<Mesaj>();
                DataAccess da = new DataAccess(authenticatedUserId, connectionString, CommandType.StoredProcedure, "UTILIZATORIsp_GetSentMessages", new object[] { new MySqlParameter("_START_LIMIT", _START_LIMIT), new MySqlParameter("_END_LIMIT", _END_LIMIT) });
                MySqlDataReader r = da.ExecuteSelectQuery();
                while (r.Read())
                {
                    dtList.Add(new Mesaj(authenticatedUserId, connectionString, r));
                }
                r.Close(); r.Dispose(); da.CloseConnection();
                //toReturn = dtList.ToArray();
                return new response(true, JsonConvert.SerializeObject(dtList.ToArray(), CommonFunctions.JsonSerializerSettings), dtList.ToArray(), null, null);
            }
            catch (Exception exp) { LogWriter.Log(exp); return new response(false, exp.ToString(), null, null, new List<Error>() { new Error(exp) }); }
        }

    }
}