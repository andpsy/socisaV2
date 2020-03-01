using MySql.Data.MySqlClient;
using System;
using System.Collections;
using System.Data;
using System.Data.Common;
using Newtonsoft.Json;
using System.Collections.Generic;
using Newtonsoft.Json.Linq;

namespace SOCISA.Models
{
    public interface ICompensariRepository
    {
        response GetAll(); response CountAll();
        response GetFiltered(string _sort, string _order, string _filter, string _limit);
        response GetFiltered(string _json);
        response GetFiltered(JObject _json);

        response Find(int _id);
        response Insert(Compensare item);
        response Update(Compensare item);
        response Update(int id, string fieldValueCollection);
        response Update(string fieldValueCollection);

        response Delete(Compensare item);
        response HasChildrens(Compensare item, string tableName);
        response HasChildren(Compensare item, string tableName, int childrenId);
        response GetChildrens(Compensare item, string tableName);
        response GetChildren(Compensare item, string tableName, int childrenId);
        response Delete(int _id);
        response HasChildrens(int _id, string tableName);
        response HasChildren(int _id, string tableName, int childrenId);
        response GetChildrens(int _id, string tableName);
        response GetChildren(int _id, string tableName, int childrenId);

        response GetBucketList(int _idGiver, int _idReceiver, DateTime _data);
        response GetRaportCompensareCascoRcaAll(DateTime _data);
        response GetRaportCompensareRcaCascoAll(DateTime _data);
        response GetRaportSintezaCompensare(DateTime _data);
        response GetRaportCompensareCascoRcaDesfasurat(DateTime _data, int _ID_SOCIETATE_CASCO);
        response GetRaportCompensareRcaCascoDesfasurat(DateTime _data, int _ID_SOCIETATE_RCA);
        response GetDateCompensari();
    }

    public class CompensariRepository : ICompensariRepository
    {
        private string connectionString;
        private int authenticatedUserId;

        public CompensariRepository(int _authenticatedUserId, string _connectionString)
        {
            authenticatedUserId = _authenticatedUserId;
            connectionString = _connectionString;
        }

        public response GetAll()
        {
            try
            {
                DataAccess da = new DataAccess(authenticatedUserId, connectionString, CommandType.StoredProcedure, "COMPENSARIsp_select", new object[] {
                new MySqlParameter("_SORT", null),
                new MySqlParameter("_ORDER", null),
                new MySqlParameter("_FILTER", null),
                new MySqlParameter("_LIMIT", null) });
                /*
                ArrayList aList = new ArrayList();
                MySqlDataReader r = da.ExecuteSelectQuery();
                while (r.Read())
                {
                    Compensare c = new Compensare(authenticatedUserId, connectionString, (IDataRecord)r);
                    aList.Add(c);
                }
                r.Close(); r.Dispose(); da.CloseConnection();
                Compensare[] toReturn = new Compensare[aList.Count];
                for (int i = 0; i < aList.Count; i++)
                    toReturn[i] = (Compensare)aList[i];
                return new response(true, JsonConvert.SerializeObject(toReturn, CommonFunctions.JsonSerializerSettings), toReturn, null, null); 
                */
                List<Compensare> aList = new List<Compensare>();
                MySqlDataReader r = da.ExecuteSelectQuery();
                while (r.Read())
                {
                    Compensare c = new Compensare(authenticatedUserId, connectionString, (IDataRecord)r);
                    aList.Add(c);
                }
                r.Close(); r.Dispose(); da.CloseConnection();
                return new response(true, JsonConvert.SerializeObject(aList.ToArray(), CommonFunctions.JsonSerializerSettings), aList.ToArray(), null, null);
            }
            catch (Exception exp) { LogWriter.Log(exp); return new response(false, exp.ToString(), null, null, new System.Collections.Generic.List<Error>() { new Error(exp) }); }
        }

        public response CountAll()
        {
            try
            {
                DataAccess da = new DataAccess(authenticatedUserId, connectionString, CommandType.StoredProcedure, "COMPENSARIsp_count");
                object count = da.ExecuteScalarQuery().Result;
                if (count == null)
                    return new response(true, "0", 0, null, null);
                return new response(true, count.ToString(), Convert.ToInt32(count), null, null);
            }
            catch (Exception exp) { LogWriter.Log(exp); return new response(false, exp.ToString(), null, null, new List<Error>() { new Error(exp) }); }
        }

        public response GetFiltered(string _json)
        {
            JObject jObj = JObject.Parse(_json);
            return GetFiltered(jObj);
        }

        public response GetFiltered(JObject _json)
        {
            try
            {
                Filter f = new Filter();
                foreach (var t in _json)
                {
                    JToken j = t.Value;
                    switch (t.Key.ToLower())
                    {
                        case "sort":
                            f.Sort = CommonFunctions.IsNullOrEmpty(j) ? null : JsonConvert.SerializeObject(j, CommonFunctions.JsonSerializerSettings);
                            break;
                        case "order":
                            f.Order = CommonFunctions.IsNullOrEmpty(j) ? null : JsonConvert.SerializeObject(j, CommonFunctions.JsonSerializerSettings);
                            break;
                        case "filter":
                            f.Filtru = CommonFunctions.IsNullOrEmpty(j) ? null : JsonConvert.SerializeObject(j, CommonFunctions.JsonSerializerSettings);
                            break;
                        case "limit":
                            f.Limit = CommonFunctions.IsNullOrEmpty(j) ? null : JsonConvert.SerializeObject(j, CommonFunctions.JsonSerializerSettings);
                            break;
                    }
                }
                return GetFiltered(f.Sort, f.Order, f.Filtru, f.Limit);
            }
            catch (Exception exp) { LogWriter.Log(exp); return new response(false, exp.ToString(), null, null, new List<Error>() { new Error(exp) }); }
        }
        public response GetFiltered(string _sort, string _order, string _filter, string _limit)
        {
            try
            {
                try
                {
                    string newFilter = Filtering.GenerateFilterFromJsonObject(typeof(Auto), _filter, authenticatedUserId, connectionString);
                    _filter = newFilter == null ? _filter : newFilter;
                }
                catch { }
                DataAccess da = new DataAccess(authenticatedUserId, connectionString, CommandType.StoredProcedure, "COMPENSARIsp_select", new object[] {
                new MySqlParameter("_SORT", _sort),
                new MySqlParameter("_ORDER", _order),
                new MySqlParameter("_FILTER", _filter),
                new MySqlParameter("_LIMIT", _limit) });
                /*
                ArrayList aList = new ArrayList();
                MySqlDataReader r = da.ExecuteSelectQuery();
                while (r.Read())
                {
                    Compensare c = new Compensare(authenticatedUserId, connectionString, (IDataRecord)r);
                    aList.Add(c);
                }
                r.Close(); r.Dispose(); da.CloseConnection();
                Compensare[] toReturn = new Compensare[aList.Count];
                for (int i = 0; i < aList.Count; i++)
                    toReturn[i] = (Compensare)aList[i];
                return new response(true, JsonConvert.SerializeObject(toReturn, CommonFunctions.JsonSerializerSettings), toReturn, null, null); 
                */
                List<Compensare> aList = new List<Compensare>();
                MySqlDataReader r = da.ExecuteSelectQuery();
                while (r.Read())
                {
                    Compensare c = new Compensare(authenticatedUserId, connectionString, (IDataRecord)r);
                    aList.Add(c);
                }
                r.Close(); r.Dispose(); da.CloseConnection();
                return new response(true, JsonConvert.SerializeObject(aList.ToArray(), CommonFunctions.JsonSerializerSettings), aList.ToArray(), null, null);
            }
            catch (Exception exp) { LogWriter.Log(exp); return new response(false, exp.ToString(), null, null, new System.Collections.Generic.List<Error>() { new Error(exp) }); }
        }

        public response Find(int _id)
        {
            try
            {
                Compensare item = new Compensare(authenticatedUserId, connectionString, _id);
                return new response(true, JsonConvert.SerializeObject(item, CommonFunctions.JsonSerializerSettings), item, null, null); ;
            }
            catch (Exception exp) { LogWriter.Log(exp); return new response(false, exp.ToString(), null, null, new System.Collections.Generic.List<Error>() { new Error(exp) }); }
        }

        public response Insert(Compensare item)
        {
            return item.Insert();
        }

        public response Update(Compensare item)
        {
            return item.Update();
        }

        public response Update(int id, string fieldValueCollection)
        {
            //Compensare item = JsonConvert.DeserializeObject<Auto>( Find(id).Message);
            Compensare item = (Compensare)(Find(id).Result);
            return item.Update(fieldValueCollection);
        }
        public response Update(string fieldValueCollection)
        {
            Compensare tmpItem = JsonConvert.DeserializeObject<Compensare>(fieldValueCollection); // sa vedem daca merge asa sau trebuie cu JObject
            //return JsonConvert.DeserializeObject<Auto>(Find(Convert.ToInt32(tmpItem.ID)).Message).Update(fieldValueCollection);
            return ((Compensare)(Find(Convert.ToInt32(tmpItem.ID)).Result)).Update(fieldValueCollection);
        }

        public response Delete(Compensare item)
        {
            return item.Delete();
        }

        public response HasChildrens(Compensare item, string tableName)
        {
            return item.HasChildrens(tableName);
        }

        public response HasChildren(Compensare item, string tableName, int childrenId)
        {
            return item.HasChildren(tableName, childrenId);
        }

        public response GetChildrens(Compensare item, string tableName)
        {
            return item.GetChildrens(tableName);
        }

        public response GetChildren(Compensare item, string tableName, int childrenId)
        {
            return item.GetChildren(tableName, childrenId);
        }
        public response Delete(int _id)
        {
            var obj = Find(_id);
            return ((Compensare)obj.Result).Delete();
        }

        public response HasChildrens(int _id, string tableName)
        {
            var obj = Find(_id);
            return ((Compensare)obj.Result).HasChildrens(tableName);
        }
        public response HasChildren(int _id, string tableName, int childrenId)
        {
            var obj = Find(_id);
            return ((Compensare)obj.Result).HasChildren(tableName, childrenId);
        }
        public response GetChildrens(int _id, string tableName)
        {
            var obj = Find(_id);
            return ((Compensare)obj.Result).GetChildrens(tableName);
        }
        public response GetChildren(int _id, string tableName, int childrenId)
        {
            var obj = Find(_id);
            return ((Compensare)obj.Result).GetChildren(tableName, childrenId);
        }

        public response GetBucketList(int _idGiver, int _idReceiver, DateTime _data) // Giver = societatea RCA / Receiver = societatea CASCO
        {
            try
            {
                DataAccess da = new DataAccess(authenticatedUserId, connectionString, CommandType.StoredProcedure, "COMPENSARIsp_GetBucketDosare", new object[] {new MySqlParameter("_ID_SOCIETATE_CASCO", _idReceiver), new MySqlParameter("_ID_SOCIETATE_RCA", _idGiver), new MySqlParameter("_DATA", _data) });
                List<BucketListItem> BucketList = new List<BucketListItem>();
                MySqlDataReader r = da.ExecuteSelectQuery();
                while (r.Read())
                {
                    Dosar d = new Dosar(authenticatedUserId, connectionString, Convert.ToInt32(r["ID_DOSAR"]));
                    double suma = Convert.ToDouble(r["SUMA"]);
                    BucketListItem bli = new BucketListItem(d, suma);
                    BucketList.Add(bli);
                }
                r.Close(); r.Dispose(); da.CloseConnection();
                return new response(true, JsonConvert.SerializeObject(BucketList, CommonFunctions.JsonSerializerSettings), BucketList, null, null);
            }
            catch (Exception exp) { LogWriter.Log(exp); return new response(false, exp.ToString(), null, null, new List<Error>() { new Error(exp) }); }
        }

        public response GetRaportCompensareCascoRcaAll(DateTime _data)
        {
            try
            {
                object[] tmp = new object[3];
                DataAccess da = new DataAccess(authenticatedUserId, connectionString, CommandType.StoredProcedure, "RAPORTsp_GetDosareCompensareCascoRcaAll", new object[] { new MySqlParameter("_DATA", _data) });
                List<object[]> lstToReturn = new List<object[]>();
                MySqlDataReader r = da.ExecuteSelectQuery();
                while (r.Read())
                {
                    int id_societate_casco = Convert.ToInt32(r["GROUP_ID"].ToString().Split('_')[0]);
                    int id_societate_rca = Convert.ToInt32(r["GROUP_ID"].ToString().Split('_')[1]);
                    double suma = Convert.ToDouble(r["SUMA"]);
                    object[] objToAdd = new object[] { id_societate_casco, id_societate_rca, suma };
                    lstToReturn.Add(objToAdd);
                }
                r.Close(); r.Dispose(); da.CloseConnection();
                return new response(true, JsonConvert.SerializeObject(lstToReturn, CommonFunctions.JsonSerializerSettings), lstToReturn, null, null);
            }
            catch (Exception exp) { LogWriter.Log(exp); return new response(false, exp.ToString(), null, null, new List<Error>() { new Error(exp) }); }
        }

        public response GetRaportCompensareRcaCascoAll(DateTime _data)
        {
            try
            {
                object[] tmp = new object[3];
                DataAccess da = new DataAccess(authenticatedUserId, connectionString, CommandType.StoredProcedure, "RAPORTsp_GetDosareCompensareRcaCascoAll", new object[] { new MySqlParameter("_DATA", _data) });
                List<object[]> lstToReturn = new List<object[]>();
                MySqlDataReader r = da.ExecuteSelectQuery();
                while (r.Read())
                {
                    int id_societate_rca = Convert.ToInt32(r["GROUP_ID"].ToString().Split('_')[0]);
                    int id_societate_casco = Convert.ToInt32(r["GROUP_ID"].ToString().Split('_')[1]);
                    double suma = Convert.ToDouble(r["SUMA"]);
                    object[] objToAdd = new object[] { id_societate_rca, id_societate_casco, suma };
                    lstToReturn.Add(objToAdd);
                }
                r.Close(); r.Dispose(); da.CloseConnection();
                return new response(true, JsonConvert.SerializeObject(lstToReturn, CommonFunctions.JsonSerializerSettings), lstToReturn, null, null);
            }
            catch (Exception exp) { LogWriter.Log(exp); return new response(false, exp.ToString(), null, null, new List<Error>() { new Error(exp) }); }
        }

        public response GetRaportSintezaCompensare(DateTime _data)
        {
            try
            {
                object[] tmp = new object[3];
                DataAccess da = new DataAccess(authenticatedUserId, connectionString, CommandType.StoredProcedure, "RAPORTsp_compensari", new object[] { new MySqlParameter("_DATA", _data) });
                List<SintezaCompensare> lstToReturn = new List<SintezaCompensare>();
                MySqlDataReader r = da.ExecuteSelectQuery();
                while (r.Read())
                {
                    SintezaCompensare sc = new SintezaCompensare(
                        Convert.ToInt32(r["ID"]),
                        r["DENUMIRE_SCURTA"].ToString(), 
                        r["DENUMIRE"].ToString(),
                        Convert.ToInt32(r["TOTAL_DOSARE_CASCO"]),
                        Convert.ToInt32(r["COMPENSATE_TOTAL_CASCO"]),
                        Convert.ToInt32(r["COMPENSATE_PARTIAL_CASCO"]),
                        Convert.ToInt32(r["NECOMPENSATE_CASCO"]), 
                        Convert.ToDouble(r["SUMA_COMPENSATA_CASCO"]),
                        Convert.ToDouble(r["REST_NECOMPENSAT_CASCO"]),
                        Convert.ToDouble(r["TOTAL_CASCO"]),
                        Convert.ToInt32(r["TOTAL_DOSARE_RCA"]),
                        Convert.ToInt32(r["COMPENSATE_TOTAL_RCA"]),
                        Convert.ToInt32(r["COMPENSATE_PARTIAL_RCA"]),
                        Convert.ToInt32(r["NECOMPENSATE_RCA"]),
                        Convert.ToDouble(r["SUMA_COMPENSATA_RCA"]),
                        Convert.ToDouble(r["REST_NECOMPENSAT_RCA"]),
                        Convert.ToDouble(r["TOTAL_RCA"])
                        );
                    lstToReturn.Add(sc);
                }
                r.Close(); r.Dispose(); da.CloseConnection();
                return new response(true, JsonConvert.SerializeObject(lstToReturn, CommonFunctions.JsonSerializerSettings), lstToReturn, null, null);
            }
            catch (Exception exp) { LogWriter.Log(exp); return new response(false, exp.ToString(), null, null, new List<Error>() { new Error(exp) }); }
        }

        public response GetRaportCompensareCascoRcaDesfasurat(DateTime _data, int _ID_SOCIETATE_CASCO)
        {
            try
            {
                DataAccess da = new DataAccess(authenticatedUserId, connectionString, CommandType.StoredProcedure, "RAPORTsp_GetDosareCompensareCascoRcaDesfasurat", new object[] { new MySqlParameter("_DATA", _data), new MySqlParameter("_ID_SOCIETATE_CASCO", _ID_SOCIETATE_CASCO) });
                List<Compensare> lstToReturn = new List<Compensare>();
                MySqlDataReader r = da.ExecuteSelectQuery();
                while (r.Read())
                {
                    Compensare c = new Compensare();
                    c.DATA = _data;
                    c.ID_DOSAR = Convert.ToInt32(r["ID_DOSAR"]);
                    c.SUMA = Convert.ToDouble(r["SUMA"]);
                    c.REST = Convert.ToDouble(r["REST"]);
                    lstToReturn.Add(c);
                }
                r.Close(); r.Dispose(); da.CloseConnection();
                return new response(true, JsonConvert.SerializeObject(lstToReturn, CommonFunctions.JsonSerializerSettings), lstToReturn, null, null);
            }
            catch (Exception exp) { LogWriter.Log(exp); return new response(false, exp.ToString(), null, null, new List<Error>() { new Error(exp) }); }
        }

        public response GetRaportCompensareRcaCascoDesfasurat(DateTime _data, int _ID_SOCIETATE_RCA)
        {
            try
            {
                DataAccess da = new DataAccess(authenticatedUserId, connectionString, CommandType.StoredProcedure, "RAPORTsp_GetDosareCompensareRcaCascoDesfasurat", new object[] { new MySqlParameter("_DATA", _data), new MySqlParameter("_ID_SOCIETATE_RCA", _ID_SOCIETATE_RCA) });
                List<Compensare> lstToReturn = new List<Compensare>();
                MySqlDataReader r = da.ExecuteSelectQuery();
                while (r.Read())
                {
                    Compensare c = new Compensare();
                    c.DATA = _data;
                    c.ID_DOSAR = Convert.ToInt32(r["ID_DOSAR"]);
                    c.SUMA = Convert.ToDouble(r["SUMA"]);
                    c.REST = Convert.ToDouble(r["REST"]);
                    lstToReturn.Add(c);
                }
                r.Close(); r.Dispose(); da.CloseConnection();
                return new response(true, JsonConvert.SerializeObject(lstToReturn, CommonFunctions.JsonSerializerSettings), lstToReturn, null, null);
            }
            catch (Exception exp) { LogWriter.Log(exp); return new response(false, exp.ToString(), null, null, new List<Error>() { new Error(exp) }); }
        }

        public response GetDateCompensari()
        {
            try
            {
                DataAccess da = new DataAccess(authenticatedUserId, connectionString, CommandType.StoredProcedure, "COMPENSARIsp_GetDates");
                IDataReader r = da.ExecuteSelectQuery();
                List<string> dates = new List<string>();
                while (r.Read())
                {
                    dates.Add(Convert.ToDateTime(r["DATA"]).ToString("dd.MM.yyyy"));
                }
                r.Close(); r.Dispose(); da.CloseConnection();
                return new response(true, JsonConvert.SerializeObject(dates, CommonFunctions.JsonSerializerSettings), dates, null, null);
            }
            catch (Exception exp)
            {
                LogWriter.Log(exp);
                return new response(false, exp.Message, null, null, new List<Error>() { new Error(exp) });
            }
        }
    }
}
