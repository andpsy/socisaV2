﻿using MySql.Data.MySqlClient;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Reflection;
using System.IO;
using Newtonsoft.Json;
using System.ComponentModel.DataAnnotations;

namespace SOCISA.Models
{
    /// <summary>
    /// Clasa care contine definitia obiectului ce mapeaza tabela cu Documente scanate din baza de date
    /// </summary>
    public class DocumentScanat
    {
        const string _TABLE_NAME = "documente_scanate";
        private int authenticatedUserId { get; set; }
        private string connectionString { get; set; }
        public int? ID { get; set; }
        [JsonProperty(NullValueHandling = NullValueHandling.Include)]
        public string DENUMIRE_FISIER { get; set; }
        [JsonProperty(NullValueHandling = NullValueHandling.Include)]
        public string EXTENSIE_FISIER { get; set; }
        [JsonProperty(NullValueHandling = NullValueHandling.Include)]
        public DateTime? DATA_INCARCARE { get; set; }
        [JsonProperty(NullValueHandling = NullValueHandling.Include)]
        public long DIMENSIUNE_FISIER { get; set; }
        [JsonProperty(NullValueHandling = NullValueHandling.Include)]
        public int ID_TIP_DOCUMENT { get; set; }
        [JsonProperty(NullValueHandling = NullValueHandling.Include)]
        public int ID_DOSAR { get; set; }
        [JsonProperty(NullValueHandling = NullValueHandling.Include)]
        public bool VIZA_CASCO { get; set; }
        [JsonProperty(NullValueHandling = NullValueHandling.Include)]
        [Display(Name = "DETALII", ResourceType = typeof(socisaV2.Resources.DocumenteResx))]
        public string DETALII { get; set; }
        [JsonProperty(NullValueHandling = NullValueHandling.Include)]
        public byte[] FILE_CONTENT { get; set; }
        [JsonProperty(NullValueHandling = NullValueHandling.Include)]
        public byte[] SMALL_ICON { get; set; }
        [JsonProperty(NullValueHandling = NullValueHandling.Include)]
        public byte[] MEDIUM_ICON { get; set; }
        [JsonProperty(NullValueHandling = NullValueHandling.Include)]
        public string CALE_FISIER { get; set; }

        /// <summary>
        /// Constructorul default
        /// </summary>
        public DocumentScanat() { }

        public DocumentScanat(int _authenticatedUserId, string _connectionString)
        {
            authenticatedUserId = _authenticatedUserId;
            connectionString = _connectionString;
        }

        /// <summary>
        /// Constructor pentru crearea unui obiect pe baza ID-ului unic
        /// </summary>
        /// <param name="_ID">ID-ul unic din baza de date</param>
        public DocumentScanat(int _authenticatedUserId, string _connectionString, int _ID)
        {
            authenticatedUserId = _authenticatedUserId;
            connectionString = _connectionString;
            DataAccess da = new DataAccess(authenticatedUserId, connectionString, CommandType.StoredProcedure, "DOCUMENTE_SCANATEsp_GetById", new object[] { new MySqlParameter("_ID", _ID) });
            MySqlDataReader r = da.ExecuteSelectQuery();
            while (r.Read())
            {
                IDataRecord document_scanat = (IDataRecord)r;
                DocumentScanatConstructor(document_scanat);
                break;
            }
            r.Close(); r.Dispose(); da.CloseConnection();
        }

        public DocumentScanat(int _authenticatedUserId, string _connectionString, string _FILE_NAME)
        {
            authenticatedUserId = _authenticatedUserId;
            connectionString = _connectionString;
            DataAccess da = new DataAccess(authenticatedUserId, connectionString, CommandType.StoredProcedure, "DOCUMENTE_SCANATEsp_GetByFileName", new object[] { new MySqlParameter("_FILE_NAME", _FILE_NAME) });
            MySqlDataReader r = da.ExecuteSelectQuery();
            while (r.Read())
            {
                IDataRecord document_scanat = (IDataRecord)r;
                DocumentScanatConstructor(document_scanat);
                break;
            }
            r.Close(); r.Dispose(); da.CloseConnection();
        }

        public DocumentScanat(int _authenticatedUserId, string _connectionString, string _FILE_NAME, int _ID_DOSAR)
        {
            authenticatedUserId = _authenticatedUserId;
            connectionString = _connectionString;
            DataAccess da = new DataAccess(authenticatedUserId, connectionString, CommandType.StoredProcedure, "DOCUMENTE_SCANATEsp_GetByFileName_IdDosar", new object[] { new MySqlParameter("_FILE_NAME", _FILE_NAME), new MySqlParameter("_ID_DOSAR", _ID_DOSAR) });
            MySqlDataReader r = da.ExecuteSelectQuery();
            while (r.Read())
            {
                IDataRecord document_scanat = (IDataRecord)r;
                DocumentScanatConstructor(document_scanat);
                break;
            }
            r.Close(); r.Dispose(); da.CloseConnection();
        }

        /// <summary>
        /// Constructor cu valorile coloanelor
        /// </summary>
        /// <param name="_ID">ID-ul unic</param>
        /// <param name="_DENUMIRE_FISIER">denumirea unica a fisierului (de pe server - GUID)</param>
        /// <param name="_EXTENSIE_FISIER">extensia fisierului</param>
        /// <param name="_CALE_FISIER">calea fisierului (de pe server)</param>
        /// <param name="_DATA_INCARCARE">data uploadarii fisierului = creation date</param>
        /// <param name="_DENUMIRE_INITIALA">denumirea initiala a fisierului (de la client)</param>
        /// <param name="_DIMENSIUNE_FISIER">dimensiunea in bytes a fisierului</param>
        /// <param name="_ID_TIP_DOCUMENT">id-ul de legatura cu tabela cu tipurile de documente</param>
        public DocumentScanat(int? _ID, string _DENUMIRE_FISIER, string _EXTENSIE_FISIER, DateTime? _DATA_INCARCARE, long _DIMENSIUNE_FISIER, int _ID_TIP_DOCUMENT, int _ID_DOSAR, bool _VIZA_CASCO, string _DETALII, byte[] _FILE_CONTENT, byte[] _SMALL_ICON, byte[] _MEDIUM_ICON, string _CALE_FISIER)
        {
            this.ID = _ID;
            this.DENUMIRE_FISIER = _DENUMIRE_FISIER;
            this.EXTENSIE_FISIER = _EXTENSIE_FISIER;
            this.DATA_INCARCARE = _DATA_INCARCARE;
            this.DIMENSIUNE_FISIER = _DIMENSIUNE_FISIER;
            this.ID_TIP_DOCUMENT = _ID_TIP_DOCUMENT;
            this.ID_DOSAR = _ID_DOSAR;
            this.VIZA_CASCO = _VIZA_CASCO;
            this.DETALII = _DETALII;
            this.SMALL_ICON = _SMALL_ICON;
            this.MEDIUM_ICON = _MEDIUM_ICON;
            this.CALE_FISIER = _CALE_FISIER;
        }

        public DocumentScanat(int _authenticatedUserId, string _connectionString, IDataRecord document_scanat)
        {
            authenticatedUserId = _authenticatedUserId;
            connectionString = _connectionString;
            DocumentScanatConstructor(document_scanat);
        }

        public void DocumentScanatConstructor(IDataRecord documentScanat)
        {
            try { this.ID = Convert.ToInt32(documentScanat["ID"]); }
            catch { }
            try { this.DENUMIRE_FISIER = documentScanat["DENUMIRE_FISIER"].ToString(); }
            catch { }
            try { this.EXTENSIE_FISIER = documentScanat["EXTENSIE_FISIER"].ToString(); }
            catch { }
            try { this.DATA_INCARCARE = CommonFunctions.IsNullable(documentScanat["DATA_INCARCARE"]) ? null : (DateTime?)Convert.ToDateTime(documentScanat["DATA_INCARCARE"]); }
            catch { }
            try { this.DIMENSIUNE_FISIER = Convert.ToInt32(documentScanat["DIMENSIUNE_FISIER"]); }
            catch { }
            try { this.ID_TIP_DOCUMENT = Convert.ToInt32(documentScanat["ID_TIP_DOCUMENT"]); }
            catch { }
            try { this.ID_DOSAR = Convert.ToInt32(documentScanat["ID_DOSAR"]); }
            catch { }
            try { this.VIZA_CASCO = Convert.ToBoolean(documentScanat["VIZA_CASCO"]); }
            catch { }
            try { this.DETALII = documentScanat["DETALII"].ToString(); }
            catch { }
            try{ this.FILE_CONTENT = (byte[])documentScanat["FILE_CONTENT"]; }
            catch { }
            try { this.SMALL_ICON = (byte[])documentScanat["SMALL_ICON"]; }
            catch { }
            try { this.MEDIUM_ICON = (byte[])documentScanat["MEDIUM_ICON"]; }
            catch { }
            try { this.CALE_FISIER = documentScanat["CALE_FISIER"].ToString(); }
            catch { }
        }
        public response GetTipDocument()
        {
            try
            {
                //Nomenclator toReturn = new Nomenclator(authenticatedUserId, connectionString, "tip_document", (Convert.ToInt32(this.ID_TIP_DOCUMENT)));
                TipDocument toReturn = new TipDocument(authenticatedUserId, connectionString, (Convert.ToInt32(this.ID_TIP_DOCUMENT)));
                return new response(true, Newtonsoft.Json.JsonConvert.SerializeObject(toReturn, CommonFunctions.JsonSerializerSettings), toReturn, null, null);
            }
            catch (Exception exp) { LogWriter.Log(exp); return new response(false, exp.ToString(), null, null, new List<Error>() { new Error(exp) }); }
        }

        public response Avizare(bool _avizat)
        {
            try
            {
                DataAccess da = new DataAccess(authenticatedUserId, connectionString, CommandType.StoredProcedure, "DOCUMENTE_SCANATEsp_Avizare", new object[] { new MySqlParameter("_ID", this.ID), new MySqlParameter("_AVIZAT", _avizat) });
                response r = da.ExecuteUpdateQuery();
                if (r.Status)
                {
                    try
                    {
                        MesajeRepository mr = new MesajeRepository(authenticatedUserId, connectionString);
                        string partial_sub = String.Format("DOCUMENT {0}", _avizat ? "NOU" : "ELIMINAT DIN DOSAR");
                        string subiect = String.Format("{0} ({1})", partial_sub, ((Nomenclator)new NomenclatoareRepository(authenticatedUserId, connectionString).Find("tip_document", Convert.ToInt32(this.ID_TIP_DOCUMENT)).Result).DENUMIRE);
                        Dosar d = new Dosar(authenticatedUserId, connectionString, Convert.ToInt32(this.ID_DOSAR));
                        if (d.IsAvizat())
                        {
                            mr.GenerateAndSendMessage(this.ID_DOSAR, DateTime.Now, subiect, subiect, partial_sub, authenticatedUserId, (int)Importanta.Low);
                        }
                    }
                    catch { }
                }
                return new response(true, null, r, null, null);
            }
            catch (Exception exp) { LogWriter.Log(exp); return new response(false, exp.ToString(), null, null, new List<Error>() { new Error(exp) }); }
        }

        /// <summary>
        /// Metoda pentru inserarea Documentului scanat curent
        /// </summary>
        /// <returns>SOCISA.response = new object(bool = status, string = error message, int = id-ul cheie returnat)</returns>
        public response Insert()
        {
            //try { if (this.DATA_INCARCARE == new DateTime() || this.DATA_INCARCARE == null) this.DATA_INCARCARE = GetFileCreationDate(); }
            try { if (this.DATA_INCARCARE == new DateTime() || this.DATA_INCARCARE == null) this.DATA_INCARCARE = DateTime.Now; }
            catch { }
            try
            {
                if (this.FILE_CONTENT == null && this.CALE_FISIER != null)
                {
                    //this.FILE_CONTENT = FileManager.GetFileContentFromFile(this.CALE_FISIER);
                    this.FILE_CONTENT = FileManager.UploadFile(this.CALE_FISIER);
                    this.SMALL_ICON = (byte[])ThumbNails.GenerateByteThumbNail(this.CALE_FISIER, CommonFunctions.GetThumbNailSizes(ThumbNailType.Small)).Result;
                    this.MEDIUM_ICON = (byte[])ThumbNails.GenerateByteThumbNail(this.CALE_FISIER, CommonFunctions.GetThumbNailSizes(ThumbNailType.Custom)).Result;
                    this.DIMENSIUNE_FISIER = this.FILE_CONTENT.Length;
                    this.EXTENSIE_FISIER = this.CALE_FISIER.Substring(this.CALE_FISIER.LastIndexOf('.'));
                    //File.Delete(this.CALE_FISIER); // nu mai stergem, ca ne trebuie si in File Storage !
                }
                if(this.FILE_CONTENT != null && this.CALE_FISIER != null)
                {
                    this.SMALL_ICON = (byte[])ThumbNails.GenerateByteThumbNail(this.CALE_FISIER, CommonFunctions.GetThumbNailSizes(ThumbNailType.Small)).Result;
                    this.MEDIUM_ICON = (byte[])ThumbNails.GenerateByteThumbNail(this.CALE_FISIER, CommonFunctions.GetThumbNailSizes(ThumbNailType.Custom)).Result;
                }
            }
            catch(Exception exp) { LogWriter.Log(exp); return new response(false, exp.Message, null, null, new List<Error>() {new Error(exp) }); }
            response toReturn = Validare();
            if (!toReturn.Status)
            {
                return toReturn;
            }
            PropertyInfo[] props = this.GetType().GetProperties();
            ArrayList _parameters = new ArrayList();
            var col = CommonFunctions.table_columns(authenticatedUserId, connectionString, "documente_scanate");
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
            DataAccess da = new DataAccess(authenticatedUserId, connectionString, CommandType.StoredProcedure, "DOCUMENTE_SCANATEsp_insert", _parameters.ToArray());
            toReturn = da.ExecuteInsertQuery();
            if (toReturn.Status)
            {
                this.ID = toReturn.InsertedId;
                /*
                try
                {
                    if (System.Web.HttpContext.Current.Request.Params["SEND_MESSAGE"] != null && Convert.ToBoolean(System.Web.HttpContext.Current.Request.Params["SEND_MESSAGE"]))
                        Mesaje.GenerateAndSendMessage(this.ID, DateTime.Now, "Document nou", Convert.ToInt32(System.Web.HttpContext.Current.Session["AUTHENTICATED_ID"]), (int)Mesaje.Importanta.Low);
                }
                catch { }
                */
                try
                {
                    Dosar d = new Dosar(authenticatedUserId, connectionString, this.ID_DOSAR);
                    d.UpdateCounterDocumente(1);
                }catch(Exception exp) { LogWriter.Log(exp); }
            }

            return toReturn;
        }

        public response Insert(ThumbNailSizes[] tSizes)
        {
            response toReturn = this.Insert();
            if(toReturn.Status && toReturn.InsertedId != null)
                toReturn = this.GenerateImgThumbNails(tSizes);
            return toReturn;
        }

        public response InsertWithErrors()
        {
            //try { if (this.DATA_INCARCARE == new DateTime() || this.DATA_INCARCARE == null) this.DATA_INCARCARE = GetFileCreationDate(); }
            try { if (this.DATA_INCARCARE == new DateTime() || this.DATA_INCARCARE == null) this.DATA_INCARCARE = DateTime.Now; }
            catch { }
            try
            {
                if (this.FILE_CONTENT == null && this.CALE_FISIER != null)
                {
                    //this.FILE_CONTENT = FileManager.GetFileContentFromFile(this.CALE_FISIER);
                    this.FILE_CONTENT = FileManager.UploadFile(this.CALE_FISIER);
                    this.SMALL_ICON = (byte[])ThumbNails.GenerateByteThumbNail(this.CALE_FISIER, CommonFunctions.GetThumbNailSizes(ThumbNailType.Small)).Result;
                    this.MEDIUM_ICON = (byte[])ThumbNails.GenerateByteThumbNail(this.CALE_FISIER, CommonFunctions.GetThumbNailSizes(ThumbNailType.Custom)).Result;
                    this.DIMENSIUNE_FISIER = this.FILE_CONTENT.Length;
                    this.EXTENSIE_FISIER = this.CALE_FISIER.Substring(this.CALE_FISIER.LastIndexOf('.'));
                    //File.Delete(this.CALE_FISIER); // nu mai stergem, ca ne trebuie si in File Storage !
                }
                if (this.FILE_CONTENT != null && this.CALE_FISIER != null)
                {
                    this.SMALL_ICON = (byte[])ThumbNails.GenerateByteThumbNail(this.CALE_FISIER, CommonFunctions.GetThumbNailSizes(ThumbNailType.Small)).Result;
                    this.MEDIUM_ICON = (byte[])ThumbNails.GenerateByteThumbNail(this.CALE_FISIER, CommonFunctions.GetThumbNailSizes(ThumbNailType.Custom)).Result;
                }
            }
            catch (Exception exp) { LogWriter.Log(exp); return new response(false, exp.Message, null, null, new List<Error>() { new Error(exp) }); }
            response toReturn = Validare();
            if (!toReturn.Status)
            {
                return toReturn;
            }
            PropertyInfo[] props = this.GetType().GetProperties();
            ArrayList _parameters = new ArrayList();
            var col = CommonFunctions.table_columns(authenticatedUserId, connectionString, "documente_scanate");
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
            DataAccess da = new DataAccess(authenticatedUserId, connectionString, CommandType.StoredProcedure, "PENDING_DOCUMENTE_SCANATE_IMPORTSsp_insert", _parameters.ToArray());
            toReturn = da.ExecuteInsertQuery();
            if (toReturn.Status)
            {
                this.ID = toReturn.InsertedId;
                /*
                try
                {
                    if (System.Web.HttpContext.Current.Request.Params["SEND_MESSAGE"] != null && Convert.ToBoolean(System.Web.HttpContext.Current.Request.Params["SEND_MESSAGE"]))
                        Mesaje.GenerateAndSendMessage(this.ID, DateTime.Now, "Document nou", Convert.ToInt32(System.Web.HttpContext.Current.Session["AUTHENTICATED_ID"]), (int)Mesaje.Importanta.Low);
                }
                catch { }
                */
            }

            return toReturn;
        }

        public void Log(response r, int _import_type)
        {
            Log(r, DateTime.Now.Date, _import_type);
        }

        public void Log(response r, DateTime _data_import, int _import_type)
        {
            DataAccess da = new DataAccess(authenticatedUserId, connectionString, CommandType.StoredProcedure, "DOCUMENTE_SCANATEsp_import_log", new object[] {
                new MySqlParameter("_STATUS", r.Status),
                new MySqlParameter("_MESSAGE", r.Message),
                new MySqlParameter("_INSERTED_ID", r.InsertedId),
                new MySqlParameter("_ERRORS", Newtonsoft.Json.JsonConvert.SerializeObject(r.Error, CommonFunctions.JsonSerializerSettings)),
                new MySqlParameter("_IMPORT_TYPE", _import_type),
                new MySqlParameter("_DATA_IMPORT", _data_import) });
            da.ExecuteInsertQuery();
        }

        /// <summary>
        /// Metoda pentru modificarea Documentului scanat curent
        /// </summary>
        /// <returns>SOCISA.response = new object(bool = status, string = error message, int = id-ul cheie returnat)</returns>
        public response Update()
        {
            //try { if (this.DATA_INCARCARE == new DateTime() || this.DATA_INCARCARE == null) this.DATA_INCARCARE = GetFileCreationDate(); }
            try { if (this.DATA_INCARCARE == new DateTime() || this.DATA_INCARCARE == null) this.DATA_INCARCARE = DateTime.Now; }
            catch { }
            try
            {
                if ((this.FILE_CONTENT == null || this.DIMENSIUNE_FISIER == 0) && this.CALE_FISIER != null)
                {
                    //this.FILE_CONTENT = FileManager.GetFileContentFromFile(this.CALE_FISIER);
                    this.FILE_CONTENT = FileManager.UploadFile(this.CALE_FISIER);
                    this.SMALL_ICON = (byte[])ThumbNails.GenerateByteThumbNail(this.CALE_FISIER, CommonFunctions.GetThumbNailSizes(ThumbNailType.Small)).Result;
                    this.MEDIUM_ICON = (byte[])ThumbNails.GenerateByteThumbNail(this.CALE_FISIER, CommonFunctions.GetThumbNailSizes(ThumbNailType.Custom)).Result;
                    this.DIMENSIUNE_FISIER = this.FILE_CONTENT.Length;
                    this.EXTENSIE_FISIER = this.CALE_FISIER.Substring(this.CALE_FISIER.LastIndexOf('.'));
                    //File.Delete(this.CALE_FISIER);
                }
                if (this.FILE_CONTENT != null && this.CALE_FISIER != null)
                {
                    this.SMALL_ICON = (byte[])ThumbNails.GenerateByteThumbNail(this.CALE_FISIER, CommonFunctions.GetThumbNailSizes(ThumbNailType.Small)).Result;
                    this.MEDIUM_ICON = (byte[])ThumbNails.GenerateByteThumbNail(this.CALE_FISIER, CommonFunctions.GetThumbNailSizes(ThumbNailType.Custom)).Result;
                }
            }
            catch (Exception exp) { LogWriter.Log(exp); return new response(false, exp.Message, null, null, new List<Error>() { new Error(exp) }); }
            response toReturn = Validare();
            if (!toReturn.Status)
            {
                return toReturn;
            }
            PropertyInfo[] props = this.GetType().GetProperties();
            ArrayList _parameters = new ArrayList();
            var col = CommonFunctions.table_columns(authenticatedUserId, connectionString, "documente_scanate");
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
            DataAccess da = new DataAccess(authenticatedUserId, connectionString, CommandType.StoredProcedure, "DOCUMENTE_SCANATEsp_update", _parameters.ToArray());
            toReturn = da.ExecuteUpdateQuery();
            /*
            try
            {
                if (System.Web.HttpContext.Current.Request.Params["SEND_MESSAGE"] != null && Convert.ToBoolean(System.Web.HttpContext.Current.Request.Params["SEND_MESSAGE"]))
                    Mesaje.GenerateAndSendMessage(this.ID, DateTime.Now, "Document modificat", Convert.ToInt32(System.Web.HttpContext.Current.Session["AUTHENTICATED_ID"]), (int)Mesaje.Importanta.Low);
            }
            catch { }
            */
            return toReturn;
        }

        public response Update(ThumbNailSizes[] tSizes)
        {
            response toReturn = this.Update();
            if (toReturn.Status && toReturn.InsertedId != null)
                toReturn = this.GenerateImgThumbNails(tSizes);
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
                            var tmpVal = (prop.PropertyType.FullName.IndexOf("System.Nullable") > -1 || prop.PropertyType.FullName.IndexOf("System.Byte[]") > -1) && changes[fieldName] == null ? null : prop.PropertyType.FullName.IndexOf("System.Nullable") > -1 || prop.PropertyType.FullName.IndexOf("System.Byte[]") > -1 ? Convert.FromBase64String(changes[fieldName]) :  prop.PropertyType.FullName.IndexOf("System.String") > -1 ? changes[fieldName] : prop.PropertyType.FullName.IndexOf("System.DateTime") > -1 ? CommonFunctions.SwitchBackFormatedDate(changes[fieldName]) : ((prop.PropertyType.FullName.IndexOf("Double") > -1) ? CommonFunctions.BackDoubleValue(changes[fieldName]) : Newtonsoft.Json.JsonConvert.DeserializeObject(changes[fieldName], prop.PropertyType));
                            prop.SetValue(this, tmpVal);
                            break;
                        }
                    }

                }
                return this.Update();
            }
        }

        /// <summary>
        /// Metoda pentru stergerea Documentului scanat curent
        /// </summary>
        /// <returns>SOCISA.response = new object(bool = status, string = error message, int = id-ul cheie returnat)</returns>
        public response Delete()
        {

            DocumentScanat tmp = new DocumentScanat(authenticatedUserId, connectionString, Convert.ToInt32(this.ID));

            response toReturn = new response(false, "", null, null, new List<Error>());;
            ArrayList _parameters = new ArrayList();
            _parameters.Add(new MySqlParameter("_ID", this.ID));
            DataAccess da = new DataAccess(authenticatedUserId, connectionString, CommandType.StoredProcedure, "DOCUMENTE_SCANATEsp_soft_delete", _parameters.ToArray());
            toReturn = da.ExecuteDeleteQuery();
            /*
            if (toReturn.Status && _deleteFile)
                FileManager.DeleteFile(this.CALE_FISIER, this.DENUMIRE_FISIER, this.EXTENSIE_FISIER);
            */
            if (toReturn.Status)
            {
                try
                {
                    ThumbNails.DeleteThumbNail(tmp);
                    tmp = null;
                }
                catch { }
            }
            if (toReturn.Status)
            {
                /*
                try
                {
                    if (System.Web.HttpContext.Current.Request.Params["SEND_MESSAGE"] != null && Convert.ToBoolean(System.Web.HttpContext.Current.Request.Params["SEND_MESSAGE"]))
                        Mesaje.GenerateAndSendMessage(this.ID, DateTime.Now, "Document sters", Convert.ToInt32(System.Web.HttpContext.Current.Session["AUTHENTICATED_ID"]), (int)Mesaje.Importanta.Low);
                }
                catch { }
                */
                try
                {
                    Dosar d = new Dosar(authenticatedUserId, connectionString, this.ID_DOSAR);
                    d.UpdateCounterDocumente(-1);
                }
                catch (Exception exp) { LogWriter.Log(exp); }
            }
            return toReturn;
        }

        /// <summary>
        /// Metoda pentru validarea Documentului scanat curent
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
                if (this.DENUMIRE_FISIER == null || this.DENUMIRE_FISIER.Trim() == "")
                {
                    toReturn.Status = false;
                    err = ErrorParser.ErrorMessage("emptyDenumireFisier");
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

        public DateTime GetFileCreationDate(string fileName)
        {
            DateTime toReturn = new DateTime();
            FileInfo fi = new FileInfo(fileName);
            toReturn = fi.CreationTime;
            //File.Delete(fileName);
            return toReturn;
        }

        public DateTime GetFileCreationDate()
        {
            FileStream fs = new FileStream(this.DENUMIRE_FISIER, FileMode.Create, FileAccess.ReadWrite);
            fs.Write(this.FILE_CONTENT, 0, this.FILE_CONTENT.Length);
            fs.Flush();fs.Close();fs.Dispose();
            return GetFileCreationDate(this.DENUMIRE_FISIER);
        }

        public response HasChildrens(string tableName)
        {
            return CommonFunctions.HasChildrens(authenticatedUserId, connectionString, this, "actions", tableName);
        }

        public response HasChildren(string tableName, int childrenId)
        {
            return CommonFunctions.HasChildren(authenticatedUserId, connectionString, this, "actions", tableName, childrenId);
        }

        public response GetChildrens(string tableName)
        {
            return CommonFunctions.GetChildrens(this, tableName);
        }

        public response GetChildren(string tableName, int childrenId)
        {
            return CommonFunctions.GetChildren(this, tableName, childrenId);
        }

        public response GenerateImgThumbNails(ThumbNailSizes[] tSizes)
        {
            response toReturn = new response(true, "", null, null, new List<Error>());
            foreach(ThumbNailSizes tSize in tSizes)
            {
                if (tSize.thumbNailType == ThumbNailType.Small)
                    this.SMALL_ICON = ThumbNails.GenerateImgThumbNail(this, tSize);
                if (tSize.thumbNailType == ThumbNailType.Medium)
                    this.MEDIUM_ICON = ThumbNails.GenerateImgThumbNail(this, tSize);
            }
            toReturn = this.Update();
            return toReturn;
        }

        public void GetFileContent()
        {
            ArrayList _parameters = new ArrayList();
            _parameters.Add(new MySqlParameter("_ID", this.ID));
            DataAccess da = new DataAccess(authenticatedUserId, connectionString, CommandType.StoredProcedure, "DOCUMENTE_SCANATEsp_GetFileContent", _parameters.ToArray());
            this.FILE_CONTENT = (byte[])da.ExecuteScalarQuery().Result;
        }

        public response UpdateTipDocument(int _ID_TIP_DOCUMENT)
        {
            try
            {
                DataAccess da = new DataAccess(authenticatedUserId, connectionString, CommandType.StoredProcedure, "DOCUMENTE_SCANATEsp_update_tip", new object[] { new MySqlParameter("_ID", this.ID), new MySqlParameter("_ID_TIP_DOCUMENT", _ID_TIP_DOCUMENT) });
                return da.ExecuteUpdateQuery();
            }
            catch (Exception exp) { LogWriter.Log(exp); return new response(false, exp.Message, null, null, new List<Error>() { new Error(exp) }); }
        }
    }
}