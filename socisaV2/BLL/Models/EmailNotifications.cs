using MySql.Data.MySqlClient;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.ComponentModel.DataAnnotations;
using System.Reflection;
using Newtonsoft.Json;

namespace SOCISA.Models
{
    public class FilterNotificari
    {
        public DateTime? TimeStampStartFilter { get; set; }
        public DateTime? TimeStampEndFilter { get; set; }
        public string NrDosarCascoFilter { get; set; }
    }

    /// <summary>
    /// Clasa care contine definitia obiectului ce mapeaza tabela cu notificari din baza de date
    /// </summary>
    public class EmailNotification
    {
        //const string _TABLE_NAME = "email_notifications";
        const string _TABLE_NAME = "email_notifications_new";
        private int authenticatedUserId { get; set; }
        private string connectionString { get; set; }
        public int? ID { get; set; }
        /*
        [JsonProperty(NullValueHandling = NullValueHandling.Include)]
        public string MESSAGE_ID { get; set; }
        [JsonProperty(NullValueHandling = NullValueHandling.Include)]
        public string MESSAGE_TEXT { get; set; }
        [JsonProperty(NullValueHandling = NullValueHandling.Include)]
        public bool? SEND { get; set; }
        [JsonProperty(NullValueHandling = NullValueHandling.Include)]
        public DateTime? SEND_TIMESTAMP { get; set; }
        public bool? DELIVERY { get; set; }
        [JsonProperty(NullValueHandling = NullValueHandling.Include)]
        public DateTime? DELIVERY_TIMESTAMP { get; set; }
        public bool? REJECT { get; set; }
        [JsonProperty(NullValueHandling = NullValueHandling.Include)]
        public DateTime? REJECT_TIMESTAMP { get; set; }
        public bool? BOUNCE { get; set; }
        [JsonProperty(NullValueHandling = NullValueHandling.Include)]
        public DateTime? BOUNCE_TIMESTAMP { get; set; }
        public bool? COMPLAINT { get; set; }
        [JsonProperty(NullValueHandling = NullValueHandling.Include)]
        public DateTime? COMPLAINT_TIMESTAMP { get; set; }
        public bool? OPEN { get; set; }
        [JsonProperty(NullValueHandling = NullValueHandling.Include)]
        public DateTime? OPEN_TIMESTAMP { get; set; }
        public bool? CLICK { get; set; }
        [JsonProperty(NullValueHandling = NullValueHandling.Include)]
        public DateTime? CLICK_TIMESTAMP { get; set; }
        [JsonProperty(NullValueHandling = NullValueHandling.Include)]
        public int? ID_DOSAR { get; set; }
        [JsonProperty(NullValueHandling = NullValueHandling.Include)]
        public string DELIVERY_MESSAGE_TEXT { get; set; }
        [JsonProperty(NullValueHandling = NullValueHandling.Include)]
        public string REJECT_MESSAGE_TEXT { get; set; }
        [JsonProperty(NullValueHandling = NullValueHandling.Include)]
        public string BOUNCE_MESSAGE_TEXT { get; set; }
        [JsonProperty(NullValueHandling = NullValueHandling.Include)]
        public string OPEN_MESSAGE_TEXT { get; set; }
        [JsonProperty(NullValueHandling = NullValueHandling.Include)]
        public string CLICK_MESSAGE_TEXT { get; set; }
        [JsonProperty(NullValueHandling = NullValueHandling.Include)]
        public string COMPLAINT_MESSAGE_TEXT { get; set; }
        */
        /* -- din 10.01.2020 -- */
        [JsonProperty(NullValueHandling = NullValueHandling.Include)]
        [Display(Name = "MESSAGE_ID", ResourceType = typeof(socisaV2.Resources.NotificariEmailResx))]
        public string MESSAGE_ID { get; set; }
        [JsonProperty(NullValueHandling = NullValueHandling.Include)]
        [Display(Name = "MESSAGE_TEXT", ResourceType = typeof(socisaV2.Resources.NotificariEmailResx))]
        public string MESSAGE_TEXT { get; set; }
        [JsonProperty(NullValueHandling = NullValueHandling.Include)]
        [Display(Name = "EVENT_TYPE", ResourceType = typeof(socisaV2.Resources.NotificariEmailResx))]
        public string EVENT_TYPE { get; set; }
        [JsonProperty(NullValueHandling = NullValueHandling.Include)]
        [Display(Name = "TIMESTAMP", ResourceType = typeof(socisaV2.Resources.NotificariEmailResx))]
        public DateTime? TIMESTAMP { get; set; }
        [JsonProperty(NullValueHandling = NullValueHandling.Include)]
        [Display(Name = "ID_DOSAR", ResourceType = typeof(socisaV2.Resources.NotificariEmailResx))]
        public int? ID_DOSAR { get; set; }
        [JsonProperty(NullValueHandling = NullValueHandling.Include)]
        [Display(Name = "TIME_CHECKED", ResourceType = typeof(socisaV2.Resources.NotificariEmailResx))]
        public DateTime? TIME_CHECKED { get; set; }
        [JsonProperty(NullValueHandling = NullValueHandling.Include)]
        [Display(Name = "RECIPIENTS", ResourceType = typeof(socisaV2.Resources.NotificariEmailResx))]
        public string RECIPIENTS { get; set; }

        /// <summary>
        /// Constructorul default
        /// </summary>
        public EmailNotification() { }

        [JsonConstructor]
        public EmailNotification(int? ID, string MESSAGE_ID, string MESSAGE_TEXT, string EVENT_TYPE, DateTime? TIMESTAMP, int? ID_DOSAR, DateTime? TIME_CHECKED, string RECIPIENTS) {
            this.ID = ID;
            this.MESSAGE_ID = MESSAGE_ID;
            this.MESSAGE_TEXT = MESSAGE_TEXT;
            this.EVENT_TYPE = EVENT_TYPE;
            this.TIMESTAMP = TIMESTAMP;
            this.ID_DOSAR = ID_DOSAR;
            this.TIME_CHECKED = TIME_CHECKED;
            this.RECIPIENTS = RECIPIENTS;
        }

        public EmailNotification(int _authenticatedUserId, string _connectionString)
        {
            authenticatedUserId = _authenticatedUserId;
            connectionString = _connectionString;
        }

        public EmailNotification(int _authenticatedUserId, string _connectionString, int _ID)
        {
            authenticatedUserId = _authenticatedUserId;
            connectionString = _connectionString;
            //DataAccess da = new DataAccess(authenticatedUserId, connectionString, CommandType.StoredProcedure, "EMAIL_NOTIFICATIONSsp_GetById", new object[] { new MySqlParameter("_ID", _ID) });
            DataAccess da = new DataAccess(authenticatedUserId, connectionString, CommandType.StoredProcedure, "EMAIL_NOTIFICATIONS_NEWsp_GetById", new object[] { new MySqlParameter("_ID", _ID) });
            MySqlDataReader r = da.ExecuteSelectQuery();
            while (r.Read())
            {
                IDataRecord email_notification = (IDataRecord)r;
                EmailNotificationConstructor(email_notification);
                break;
            }
            r.Close(); r.Dispose(); da.CloseConnection();
        }

        public EmailNotification(int _authenticatedUserId, string _connectionString, string _MESSAGE_ID)
        {
            authenticatedUserId = _authenticatedUserId;
            connectionString = _connectionString;
            //DataAccess da = new DataAccess(authenticatedUserId, connectionString, CommandType.StoredProcedure, "EMAIL_NOTIFICATIONSsp_GetByMessageId", new object[] { new MySqlParameter("_MESSAGE_ID", _MESSAGE_ID) });
            DataAccess da = new DataAccess(authenticatedUserId, connectionString, CommandType.StoredProcedure, "EMAIL_NOTIFICATIONS_NEWsp_GetByMessageId", new object[] { new MySqlParameter("_MESSAGE_ID", _MESSAGE_ID) });
            MySqlDataReader r = da.ExecuteSelectQuery();
            while (r.Read())
            {
                IDataRecord email_notification = (IDataRecord)r;
                EmailNotificationConstructor(email_notification);
                break;
            }
            r.Close(); r.Dispose(); da.CloseConnection();
        }

        public EmailNotification(int _authenticatedUserId, string _connectionString, IDataRecord email_notification)
        {
            authenticatedUserId = _authenticatedUserId;
            connectionString = _connectionString;
            EmailNotificationConstructor(email_notification);
        }

        public void EmailNotificationConstructor(IDataRecord email_notification)
        {
            try { this.ID = Convert.ToInt32(email_notification["ID"]); }
            catch { }
            /*
            try { this.MESSAGE_ID = email_notification["MESSAGE_ID"].ToString(); }
            catch { }
            try { this.MESSAGE_TEXT = email_notification["MESSAGE_TEXT"].ToString(); }
            catch { }
            try { this.SEND = Convert.ToBoolean( email_notification["SEND"]); }
            catch { }
            try { this.SEND_TIMESTAMP = Convert.ToDateTime( email_notification["SEND_TIMESTAMP"]); }
            catch { }
            try { this.DELIVERY = Convert.ToBoolean(email_notification["DELIVERY"]); }
            catch { }
            try { this.DELIVERY_TIMESTAMP = Convert.ToDateTime(email_notification["DELIVERY_TIMESTAMP"]); }
            catch { }
            try { this.REJECT = Convert.ToBoolean(email_notification["REJECT"]); }
            catch { }
            try { this.REJECT_TIMESTAMP = Convert.ToDateTime(email_notification["REJECT_TIMESTAMP"]); }
            catch { }
            try { this.BOUNCE = Convert.ToBoolean(email_notification["BOUNCE"]); }
            catch { }
            try { this.BOUNCE_TIMESTAMP = Convert.ToDateTime(email_notification["BOUNCE_TIMESTAMP"]); }
            catch { }
            try { this.COMPLAINT = Convert.ToBoolean(email_notification["COMPLAINT"]); }
            catch { }
            try { this.COMPLAINT_TIMESTAMP = Convert.ToDateTime(email_notification["COMPLAINT_TIMESTAMP"]); }
            catch { }
            try { this.OPEN = Convert.ToBoolean(email_notification["OPEN"]); }
            catch { }
            try { this.OPEN_TIMESTAMP = Convert.ToDateTime(email_notification["OPEN_TIMESTAMP"]); }
            catch { }
            try { this.CLICK = Convert.ToBoolean(email_notification["CLICK"]); }
            catch { }
            try { this.CLICK_TIMESTAMP = Convert.ToDateTime(email_notification["CLICK_TIMESTAMP"]); }
            catch { }
            try { this.ID_DOSAR = Convert.ToInt32(email_notification["ID_DOSAR"]); }
            catch { }
            try { this.DELIVERY_MESSAGE_TEXT = email_notification["DELIVERY_MESSAGE_TEXT"].ToString(); }
            catch { }
            try { this.REJECT_MESSAGE_TEXT = email_notification["REJECT_MESSAGE_TEXT"].ToString(); }
            catch { }
            try { this.BOUNCE_MESSAGE_TEXT = email_notification["BOUNCE_MESSAGE_TEXT"].ToString(); }
            catch { }
            try { this.OPEN_MESSAGE_TEXT = email_notification["OPEN_MESSAGE_TEXT"].ToString(); }
            catch { }
            try { this.CLICK_MESSAGE_TEXT = email_notification["CLICK_MESSAGE_TEXT"].ToString(); }
            catch { }
            try { this.COMPLAINT_MESSAGE_TEXT = email_notification["COMPLAINT_MESSAGE_TEXT"].ToString(); }
            catch { }
            */
            /* -- DIN 10.01.2020 -- */
            try { this.MESSAGE_ID = email_notification["MESSAGE_ID"].ToString(); }
            catch { }
            try { this.MESSAGE_TEXT = email_notification["MESSAGE_TEXT"].ToString(); }
            catch { }
            try { this.TIMESTAMP = Convert.ToDateTime(email_notification["TIMESTAMP"]); }
            catch { }
            try { this.EVENT_TYPE = email_notification["EVENT_TYPE"].ToString(); }
            catch { }
            try { this.TIME_CHECKED = Convert.ToDateTime(email_notification["TIME_CHECKED"]); }
            catch { }
            try { this.ID_DOSAR = Convert.ToInt32(email_notification["ID_DOSAR"]); }
            catch { }
            try { this.RECIPIENTS = email_notification["RECIPIENTS"].ToString(); }
            catch { }
        }

        /// <summary>
        /// Metoda pentru inserarea notificarii curent
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
            //var col = CommonFunctions.table_columns(authenticatedUserId, connectionString, "email_notifications");
            var col = CommonFunctions.table_columns(authenticatedUserId, connectionString, _TABLE_NAME);
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
            //DataAccess da = new DataAccess(authenticatedUserId, connectionString, CommandType.StoredProcedure, "EMAIL_NOTIFICATIONSsp_insert", _parameters.ToArray());
            DataAccess da = new DataAccess(authenticatedUserId, connectionString, CommandType.StoredProcedure, "EMAIL_NOTIFICATIONS_NEWsp_insert", _parameters.ToArray());
            toReturn = da.ExecuteInsertQuery();
            if (toReturn.Status) this.ID = toReturn.InsertedId;

            return toReturn;
        }

        /// <summary>
        /// Metoda pentru modificarea Notificarii curente
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
            //var col = CommonFunctions.table_columns(authenticatedUserId, connectionString, "email_notifications");
            var col = CommonFunctions.table_columns(authenticatedUserId, connectionString, _TABLE_NAME);
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
            //DataAccess da = new DataAccess(authenticatedUserId, connectionString, CommandType.StoredProcedure, "EMAIL_NOTIFICATIONSsp_update", _parameters.ToArray());
            DataAccess da = new DataAccess(authenticatedUserId, connectionString, CommandType.StoredProcedure, "EMAIL_NOTIFICATIONS_NEWsp_update", _parameters.ToArray());
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
                        //var col = CommonFunctions.table_columns(authenticatedUserId, connectionString, "email_notifications");
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
        /// Metoda pentru stergerea Notificarii curente
        /// </summary>
        /// <returns>SOCISA.response = new object(bool = status, string = error message, int = id-ul cheie returnat)</returns>
        public response Delete()
        {
            response toReturn = new response(false, "", null, null, new List<Error>());
            ArrayList _parameters = new ArrayList();
            _parameters.Add(new MySqlParameter("_ID", this.ID));
            //DataAccess da = new DataAccess(authenticatedUserId, connectionString, CommandType.StoredProcedure, "EMAIL_NOTIFICATIONSsp_soft_delete", _parameters.ToArray());
            DataAccess da = new DataAccess(authenticatedUserId, connectionString, CommandType.StoredProcedure, "EMAIL_NOTIFICATIONS_NEWsp_soft_delete", _parameters.ToArray());
            toReturn = da.ExecuteDeleteQuery();
            return toReturn;
        }

        /// <summary>
        /// Metoda pentru validarea Notificarii curente
        /// </summary>
        /// <returns>SOCISA.response = new object(bool = status, string = error message, int = id-ul cheie returnat)</returns>
        public response Validare()
        {
            bool succes;
            response toReturn = Validator.Validate(authenticatedUserId, connectionString, this, _TABLE_NAME, out succes);
            if (!succes) // daca nu s-au putut citi validarile din fisier, sau nu sunt definite in fisier, mergem pe varianta hardcodata
            {
                toReturn = new response(true, "", null, null, new List<Error>()); ;
                Error err = new Error();
                if (this.MESSAGE_ID == null || this.MESSAGE_ID.Trim() == "")
                {
                    toReturn.Status = false;
                    err = ErrorParser.ErrorMessage("emptyNotificareId");
                    toReturn.Message = string.Format("{0}{1};", toReturn.Message == null ? "" : toReturn.Message, err.ERROR_MESSAGE);
                    toReturn.InsertedId = null;
                    toReturn.Error.Add(err);
                }
                if (this.MESSAGE_TEXT == null || this.MESSAGE_TEXT.Trim() == "")
                {
                    toReturn.Status = false;
                    err = ErrorParser.ErrorMessage("emptyNotificareText");
                    toReturn.Message = string.Format("{0}{1};", toReturn.Message == null ? "" : toReturn.Message, err.ERROR_MESSAGE);
                    toReturn.InsertedId = null;
                    toReturn.Error.Add(err);
                }
                //TO DO: Error empty other fields
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
            //return CommonFunctions.HasChildrens(authenticatedUserId, connectionString, this, "email_notifications", tableName);
            return CommonFunctions.HasChildrens(authenticatedUserId, connectionString, this, _TABLE_NAME, tableName);
        }

        public response HasChildren(string tableName, int childrenId)
        {
            //return CommonFunctions.HasChildren(authenticatedUserId, connectionString, this, "email_notifications", tableName, childrenId);
            return CommonFunctions.HasChildren(authenticatedUserId, connectionString, this, _TABLE_NAME, tableName, childrenId);
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