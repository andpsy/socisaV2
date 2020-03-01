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
    public interface ISedintePortalRepository
    {
        response GetAll(); response CountAll();
        response GetByDate(DateTime data);
        response GetByDate(DateTime data, int? id_societate);
        response GetFiltered(string _sort, string _order, string _filter, string _limit);
        response GetFiltered(string _json);
        response GetFiltered(JObject _json);

        response Find(int _id);
        response Insert(SedintaPortal item);
        response Update(SedintaPortal item);
        response Update(int id, string fieldValueCollection);
        response Update(string fieldValueCollection);

        response Delete(SedintaPortal item);
        response HasChildrens(SedintaPortal item, string tableName);
        response HasChildren(SedintaPortal item, string tableName, int childrenId);
        response GetChildrens(SedintaPortal item, string tableName);
        response GetChildren(SedintaPortal item, string tableName, int childrenId);
        response Delete(int _id);
        response HasChildrens(int _id, string tableName);
        response HasChildren(int _id, string tableName, int childrenId);
        response GetChildrens(int _id, string tableName);
        response GetChildren(int _id, string tableName, int childrenId);
    }

    public class SedintePortalRepository : ISedintePortalRepository
    {
        private string connectionString;
        private int authenticatedUserId;

        public SedintePortalRepository(int _authenticatedUserId, string _connectionString)
        {
            authenticatedUserId = _authenticatedUserId;
            connectionString = _connectionString;
        }

        public response GetAll()
        {
            try
            {
                DataAccess da = new DataAccess(authenticatedUserId, connectionString, CommandType.StoredProcedure, "SEDINTE_PORTALsp_select", new object[] {
                new MySqlParameter("_SORT", null),
                new MySqlParameter("_ORDER", null),
                new MySqlParameter("_FILTER", null),
                new MySqlParameter("_LIMIT", null) });
                List<SedintaPortal> aList = new List<SedintaPortal>();
                MySqlDataReader r = da.ExecuteSelectQuery();
                while (r.Read())
                {
                    aList.Add(new SedintaPortal(authenticatedUserId, connectionString, r));
                }
                r.Close(); r.Dispose(); da.CloseConnection();
                return new response(true, JsonConvert.SerializeObject(aList.ToArray(), CommonFunctions.JsonSerializerSettings), aList.ToArray(), null, null);
            }
            catch (Exception exp) { LogWriter.Log(exp); return new response(false, exp.ToString(), null, null, new System.Collections.Generic.List<Error>() { new Error(exp) }); }
        }

        public response GetByDate(DateTime data)
        {
            return GetByDate(data, null);
        }

        public response GetByDate(DateTime data, int? id_societate)
        {
            try
            {
                DataAccess da = new DataAccess(authenticatedUserId, connectionString, CommandType.StoredProcedure, "SEDINTE_PORTALsp_GetByDate", new object[] {
                    new MySqlParameter("_DATA", data),
                    new MySqlParameter("_ID_SOCIETATE", id_societate)
                });
                List<SedintaPortal> aList = new List<SedintaPortal>();
                MySqlDataReader r = da.ExecuteSelectQuery();
                while (r.Read())
                {
                    aList.Add(new SedintaPortal(authenticatedUserId, connectionString, r));
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
                DataAccess da = new DataAccess(authenticatedUserId, connectionString, CommandType.StoredProcedure, "SEDINTE_PORTALsp_count");
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
                    string newFilter = Filtering.GenerateFilterFromJsonObject(typeof(SedintaPortal), _filter, authenticatedUserId, connectionString);
                    _filter = newFilter == null ? _filter : newFilter;
                }
                catch { }
                DataAccess da = new DataAccess(authenticatedUserId, connectionString, CommandType.StoredProcedure, "SEDINTE_PORTALsp_select", new object[] {
                new MySqlParameter("_SORT", _sort),
                new MySqlParameter("_ORDER", _order),
                new MySqlParameter("_FILTER", _filter),
                new MySqlParameter("_LIMIT", _limit) });
                List<SedintaPortal> aList = new List<SedintaPortal>();
                MySqlDataReader r = da.ExecuteSelectQuery();
                while (r.Read())
                {
                    SedintaPortal a = new SedintaPortal(authenticatedUserId, connectionString, (IDataRecord)r);
                    aList.Add(a);
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
                SedintaPortal item = new SedintaPortal(authenticatedUserId, connectionString, _id);
                return new response(true, JsonConvert.SerializeObject(item, CommonFunctions.JsonSerializerSettings), item, null, null); ;
            }
            catch (Exception exp) { LogWriter.Log(exp); return new response(false, exp.ToString(), null, null, new System.Collections.Generic.List<Error>() { new Error(exp) }); }
        }

        public response Insert(SedintaPortal item)
        {
            return item.Insert();
        }

        public response Update(SedintaPortal item)
        {
            return item.Update();
        }

        public response Update(int id, string fieldValueCollection)
        {
            //SedintaPortal item = JsonConvert.DeserializeObject<SedintaPortal>(Find(id).Message);
            SedintaPortal item = (SedintaPortal)(Find(id).Result);
            return item.Update(fieldValueCollection);
        }
        public response Update(string fieldValueCollection)
        {
            SedintaPortal tmpItem = JsonConvert.DeserializeObject<SedintaPortal>(fieldValueCollection); // sa vedem daca merge asa sau trebuie cu JObject
            //return JsonConvert.DeserializeObject<SedintaPortal>(Find(Convert.ToInt32(tmpItem.ID)).Message).Update(fieldValueCollection);
            return ((SedintaPortal)(Find(Convert.ToInt32(tmpItem.ID)).Result)).Update(fieldValueCollection);
        }

        public response Delete(SedintaPortal item)
        {
            return item.Delete();
        }

        public response HasChildrens(SedintaPortal item, string tableName)
        {
            return item.HasChildrens(tableName);
        }

        public response HasChildren(SedintaPortal item, string tableName, int childrenId)
        {
            return item.HasChildren(tableName, childrenId);
        }

        public response GetChildrens(SedintaPortal item, string tableName)
        {
            return item.GetChildrens(tableName);
        }

        public response GetChildren(SedintaPortal item, string tableName, int childrenId)
        {
            return item.GetChildren(tableName, childrenId);
        }
        public response Delete(int _id)
        {
            response obj = Find(_id);
            //return JsonConvert.DeserializeObject<SedintaPortal>(obj.Message).Delete();
            return ((SedintaPortal)obj.Result).Delete();
        }

        public response HasChildrens(int _id, string tableName)
        {
            var obj = Find(_id);
            //return JsonConvert.DeserializeObject<SedintaPortal>(obj.Message).HasChildrens(tableName);
            return ((SedintaPortal)obj.Result).HasChildrens(tableName);
        }
        public response HasChildren(int _id, string tableName, int childrenId)
        {
            var obj = Find(_id);
            //return JsonConvert.DeserializeObject<SedintaPortal>(obj.Message).HasChildren(tableName, childrenId);
            return ((SedintaPortal)obj.Result).HasChildren(tableName, childrenId);
        }
        public response GetChildrens(int _id, string tableName)
        {
            var obj = Find(_id);
            //return JsonConvert.DeserializeObject<SedintaPortal>(obj.Message).GetChildrens(tableName);
            return ((SedintaPortal)obj.Result).GetChildrens(tableName);
        }
        public response GetChildren(int _id, string tableName, int childrenId)
        {
            var obj = Find(_id);
            //return JsonConvert.DeserializeObject<SedintaPortal>(obj.Message).GetChildren(tableName, childrenId);
            return ((SedintaPortal)obj.Result).GetChildren(tableName, childrenId);
        }
    }
}
