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
    /// <summary>
    /// Clasa care contine definitia obiectului ce mapeaza o inregistrare din tabela cu relatiile dintre Dosare si Stadiile aferente din baza de date
    /// </summary>
    public class ProcesStadiu
    {
        const string _TABLE_NAME = "procese_stadii";
        private int authenticatedUserId { get; set; }
        private string connectionString { get; set; }

        public int? ID {get;set;}

        [JsonProperty(NullValueHandling = NullValueHandling.Include)]
        [Required(ErrorMessageResourceName = "emptyProcesProceseStadii", ErrorMessageResourceType = typeof(socisaV2.Resources.ErrorMessagesResx))]
        [Display(Name = "ID_DOSAR", ResourceType = typeof(socisaV2.Resources.ProceseStadiiResx))]
        public int? ID_DOSAR { get; set; }

        [JsonProperty(NullValueHandling = NullValueHandling.Include)]
        [Required(ErrorMessageResourceName = "emptyProcesProceseStadii", ErrorMessageResourceType = typeof(socisaV2.Resources.ErrorMessagesResx))]
        [Display(Name = "ID_PROCES", ResourceType = typeof(socisaV2.Resources.ProceseStadiiResx))]
        public int? ID_PROCES {get;set;}

        [JsonProperty(NullValueHandling = NullValueHandling.Include)]
        [Required(ErrorMessageResourceName = "emptyStadiuProceseStadii", ErrorMessageResourceType = typeof(socisaV2.Resources.ErrorMessagesResx))]
        [Display(Name = "ID_STADIU", ResourceType = typeof(socisaV2.Resources.ProceseStadiiResx))]
        public int? ID_STADIU {get;set;}

        [JsonProperty(NullValueHandling = NullValueHandling.Include)]
        [Required(ErrorMessageResourceName = "emptyDataProceseStadii", ErrorMessageResourceType = typeof(socisaV2.Resources.ErrorMessagesResx))]
        [Display(Name = "DATA", ResourceType = typeof(socisaV2.Resources.ProceseStadiiResx))]
        public DateTime? DATA { get; set; }

        [JsonProperty(NullValueHandling = NullValueHandling.Include)]
        [Display(Name = "TERMEN", ResourceType = typeof(socisaV2.Resources.ProceseStadiiResx))]
        public DateTime? TERMEN {get; set;}

        [JsonProperty(NullValueHandling = NullValueHandling.Include)]
        [Display(Name = "OBSERVATII", ResourceType = typeof(socisaV2.Resources.ProceseStadiiResx))]
        public string OBSERVATII { get; set; }

        [JsonProperty(NullValueHandling = NullValueHandling.Include)]
        [Display(Name = "SCADENTA", ResourceType = typeof(socisaV2.Resources.ProceseStadiiResx))]
        public DateTime? SCADENTA {get; set;}

        [JsonProperty(NullValueHandling = NullValueHandling.Include)]
        [Display(Name = "ORA", ResourceType = typeof(socisaV2.Resources.ProceseStadiiResx))]
        public string ORA { get; set; }

        [JsonProperty(NullValueHandling = NullValueHandling.Include)]
        [Display(Name = "TERMEN_ADMINISTRATIV", ResourceType = typeof(socisaV2.Resources.ProceseStadiiResx))]
        public DateTime? TERMEN_ADMINISTRATIV { get; set; }

        [JsonProperty(NullValueHandling = NullValueHandling.Include)]
        [Display(Name = "ID_SENTINTA", ResourceType = typeof(socisaV2.Resources.ProceseStadiiResx))]
        public int? ID_SENTINTA { get; set; }
        /*
        public StadiiJson Stadiu { get; set; }
        public DosareStadiiSentinteJson[] DosareStadiiSentinte {get; set; }
        public SentinteJson[] Sentinte { get; set; }
        */

        /// <summary>
        /// Constructorul default
        /// </summary>
        public ProcesStadiu() { }

        public ProcesStadiu(int _authenticatedUserId, string _connectionString)
        {
            authenticatedUserId = _authenticatedUserId;
            connectionString = _connectionString;
        }

        public ProcesStadiu(int _authenticatedUserId, string _connectionString, int _ID)
        {
            authenticatedUserId = _authenticatedUserId;
            connectionString = _connectionString;
            DataAccess da = new DataAccess(authenticatedUserId, connectionString, CommandType.StoredProcedure, "PROCESE_STADIIsp_GetById", new object[] { new MySqlParameter("_ID", _ID) });
            MySqlDataReader r = da.ExecuteSelectQuery();
            while (r.Read())
            {
                IDataRecord item = (IDataRecord)r;
                ProcesStadiuConstructor(item);
                break;
            }
            r.Close(); r.Dispose(); da.CloseConnection();
        }

        public ProcesStadiu(int _authenticatedUserId, string _connectionString, IDataRecord item)
        {
            authenticatedUserId = _authenticatedUserId;
            connectionString = _connectionString;
            ProcesStadiuConstructor(item);
        }

        /// <summary>
        /// Functie pentru popularea obiectului Dosar-Stadiu, folosita de diferiti constructori
        /// </summary>
        /// <param name="dosarStadiu">Inregistrare din DB cu informatiile obiectului curent</param>
        public void ProcesStadiuConstructor(IDataRecord dosarStadiu)
        {
            try { this.ID = Convert.ToInt32(dosarStadiu["ID"]); }
            catch { }
            try { this.ID_DOSAR = Convert.ToInt32(dosarStadiu["ID_DOSAR"]); }
            catch { }
            try { this.ID_PROCES = Convert.ToInt32(dosarStadiu["ID_PROCES"]); }
            catch { }
            try { this.ID_STADIU = Convert.ToInt32(dosarStadiu["ID_STADIU"]); }
            catch { }
            try { this.TERMEN = Convert.ToDateTime(dosarStadiu["TERMEN"]); }
            catch { }
            try { this.OBSERVATII = dosarStadiu["OBSERVATII"].ToString(); }
            catch { }
            try { this.DATA = Convert.ToDateTime(dosarStadiu["DATA"]); }
            catch { }
            try { this.SCADENTA = Convert.ToDateTime(dosarStadiu["SCADENTA"]); }
            catch { }
            try { this.ORA = dosarStadiu["ORA"].ToString(); }
            catch { }
            try { this.TERMEN_ADMINISTRATIV = Convert.ToDateTime(dosarStadiu["TERMEN_ADMINISTRATIV"]); }
            catch { }
            try { this.ID_SENTINTA = Convert.ToInt32(dosarStadiu["ID_SENTINTA"]); }
            catch { }
            /*
            try { this.Stadiu = GetStadiu(); }
            catch { }
            try { this.Sentinte = GetSentinte(); }
            catch { }
            */
        }

        /// <summary>
        /// Metoda pt. popularea Stadiului curent
        /// </summary>
        /// <returns>SOCISA.StadiiJson</returns>
        public response GetStadiu()
        {
            try
            {
                Stadiu toReturn = new Stadiu(authenticatedUserId, connectionString, Convert.ToInt32(this.ID_STADIU));
                return new response(true, Newtonsoft.Json.JsonConvert.SerializeObject(toReturn, CommonFunctions.JsonSerializerSettings), toReturn, null, null);
            }
            catch (Exception exp) { LogWriter.Log(exp); return new response(false, exp.ToString(), null, null, new List<Error>() { new Error(exp) }); }
        }

        /// <summary>
        /// Metoda pt. popularea Sentintelor dosarului
        /// </summary>
        /// <returns>vector de SOCISA.SentinteJson</returns>
        public response GetSentinta()
        {
            try
            {
                Sentinta toReturn = new Sentinta(authenticatedUserId, connectionString, Convert.ToInt32(this.ID_SENTINTA));
                return new response(true, Newtonsoft.Json.JsonConvert.SerializeObject(toReturn, CommonFunctions.JsonSerializerSettings), toReturn, null, null);
            }
            catch (Exception exp) { LogWriter.Log(exp); return new response(false, exp.ToString(), null, null, new List<Error>() { new Error(exp) }); }
        }

        public response GetDocumente()
        {
            try
            {
                DataAccess da = new DataAccess(authenticatedUserId, connectionString, CommandType.StoredProcedure, "DOCUMENTE_SCANATE_PROCESEsp_GetByIdProcesStadiu", new object[] { new MySqlParameter("_ID_PROCES_STADIU", this.ID) });
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

        /// <summary>
        /// Metoda pentru inserarea relatiei Dosar-stadiu curenta
        /// </summary>
        /// <returns>SOCISA.response = new object(bool = status, string = error message, int = id-ul cheie returnat)</returns>
        public response Insert()
        {
            response toReturn = Validare();
            if (!toReturn.Status)
            {
                return toReturn;
            }
            /*
            if (this.Stadiu != null)
            {
                response toReturnS = this.Stadiu.Insert();
                if (toReturnS.Status && toReturnS.InsertedId != null)
                    this.ID_STADIU = Convert.ToInt32(toReturnS.InsertedId);
            }
            */

            PropertyInfo[] props = this.GetType().GetProperties();
            ArrayList _parameters = new ArrayList();
            var col = CommonFunctions.table_columns(authenticatedUserId, connectionString, "procese_stadii");
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
            DataAccess da = new DataAccess(authenticatedUserId, connectionString, CommandType.StoredProcedure, "PROCESE_STADIIsp_insert", _parameters.ToArray());
            toReturn = da.ExecuteInsertQuery();
            if (toReturn.Status)
            {
                this.ID = toReturn.InsertedId;
                try
                {
                    if (toReturn.Status)
                    {
                        Proces p = new Proces(authenticatedUserId, connectionString, Convert.ToInt32( this.ID_PROCES));
                        p.ChangeStadiuCurent(Convert.ToInt32(((ProcesStadiu)p.GetStadiuCurent().Result).ID));
                        Dosar d = new Dosar(authenticatedUserId, connectionString, Convert.ToInt32(p.ID_DOSAR));
                        d.SetDataUltimeiModificari(DateTime.Now);
                    }
                }
                catch { }
            }
            return toReturn;
        }

        /// <summary>
        /// Metoda pentru modificarea relatiei Dosar-stadiu curenta
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
            var col = CommonFunctions.table_columns(authenticatedUserId, connectionString, "procese_stadii");
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
            DataAccess da = new DataAccess(authenticatedUserId, connectionString, CommandType.StoredProcedure, "PROCESE_STADIIsp_update", _parameters.ToArray());
            toReturn = da.ExecuteUpdateQuery();
            try
            {
                if (toReturn.Status)
                {
                    Proces p = new Proces(authenticatedUserId, connectionString, Convert.ToInt32( this.ID_PROCES));
                    p.ChangeStadiuCurent(Convert.ToInt32(((ProcesStadiu)p.GetStadiuCurent().Result).ID));
                    Dosar d = new Dosar(authenticatedUserId, connectionString, Convert.ToInt32(p.ID_DOSAR));
                    d.SetDataUltimeiModificari(DateTime.Now);
                }
            }
            catch { }

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
        /// Metoda pentru stergerea relatiei Dosare-stadii curente
        /// </summary>
        /// <returns>SOCISA.response = new object(bool = status, string = error message, int = id-ul cheie returnat)</returns>
        public response Delete()
        {
            response toReturn = new response(true, "", null, null, new List<Error>());
            
            Sentinta sentinta = (Sentinta)this.GetSentinta().Result;
            if(sentinta.ID != null)
                toReturn = sentinta.Delete();

            if (toReturn.Status)
            {
                DocumentScanatProces[] dsps = (DocumentScanatProces[])this.GetDocumente().Result;
                foreach(DocumentScanatProces dsp in dsps)
                {
                    toReturn = dsp.Delete();
                    if (!toReturn.Status)
                        break;
                }
                if (toReturn.Status)
                {
                    ArrayList _parameters = new ArrayList();
                    _parameters.Add(new MySqlParameter("_ID", this.ID));
                    DataAccess da = new DataAccess(authenticatedUserId, connectionString, CommandType.StoredProcedure, "PROCESE_STADIIsp_soft_delete", _parameters.ToArray());
                    toReturn = da.ExecuteDeleteQuery();
                    if (toReturn.Status)
                    {
                        try
                        {
                            Proces p = new Proces(authenticatedUserId, connectionString, Convert.ToInt32( this.ID_PROCES));
                            p.ChangeStadiuCurent(Convert.ToInt32(((ProcesStadiu)p.GetStadiuCurent().Result).ID));
                        }
                        catch { }
                    }
                }
            }
            return toReturn;
        }

        /// <summary>
        /// Metoda pentru validarea relatiei Dosar-stadiu curenta
        /// </summary>
        /// <returns>SOCISA.response = new object(bool = status, string = error message, int = id-ul cheie returnat)</returns>
        public response Validare()
        {
            response toReturn = new response(true, "", null, null, new List<Error>());;


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
            return CommonFunctions.HasChildrens(authenticatedUserId, connectionString, this, "procese_stadii", tableName);
        }

        public response HasChildren(string tableName, int childrenId)
        {
            return CommonFunctions.HasChildren(authenticatedUserId, connectionString, this, "procese_stadii", tableName, childrenId);
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