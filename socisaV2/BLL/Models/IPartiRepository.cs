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
    public interface IPartiRepository
    {
        response GetAll(); response CountAll();
        response GetFiltered(string _sort, string _order, string _filter, string _limit);
        response GetFiltered(string _json);
        response GetFiltered(JObject _json);

        response Find(int _id);
        response Find(string _denumire);
        response Insert(Parte item);
        response Update(Parte item);
        response Update(int id, string fieldValueCollection);
        response Update(string fieldValueCollection);

        response Delete(Parte item);
        response HasChildrens(Parte item, string tableName);
        response HasChildren(Parte item, string tableName, int childrenId);
        response GetChildrens(Parte item, string tableName);
        response GetChildren(Parte item, string tableName, int childrenId);
        response Delete(int _id);
        response HasChildrens(int _id, string tableName);
        response HasChildren(int _id, string tableName, int childrenId);
        response GetChildrens(int _id, string tableName);
        response GetChildren(int _id, string tableName, int childrenId);
    }

    public class PartiRepository : IPartiRepository
    {
        private string connectionString;
        private int authenticatedUserId;

        public PartiRepository(int _authenticatedUserId, string _connectionString)
        {
            authenticatedUserId = _authenticatedUserId;
            connectionString = _connectionString;
        }

        public response GetAll()
        {
            try
            {
                DataAccess da = new DataAccess(authenticatedUserId, connectionString, CommandType.StoredProcedure, "PARTIsp_select", new object[] {
                new MySqlParameter("_SORT", null),
                new MySqlParameter("_ORDER", null),
                new MySqlParameter("_FILTER", null),
                new MySqlParameter("_LIMIT", null) });
                /*
                ArrayList aList = new ArrayList();
                MySqlDataReader r = da.ExecuteSelectQuery();
                while (r.Read())
                {
                    Parte a = new Parte(authenticatedUserId, connectionString, (IDataRecord)r);
                    aList.Add(a);
                }
                r.Close(); r.Dispose(); da.CloseConnection();
                Parte[] toReturn = new Parte[aList.Count];
                for (int i = 0; i < aList.Count; i++)
                    toReturn[i] = (Parte)aList[i];
                return new response(true, JsonConvert.SerializeObject(toReturn, CommonFunctions.JsonSerializerSettings), toReturn, null, null);
                */
                List<Parte> aList = new List<Parte>();
                MySqlDataReader r = da.ExecuteSelectQuery();
                while (r.Read())
                {
                    Parte a = new Parte(authenticatedUserId, connectionString, (IDataRecord)r);
                    aList.Add(a);
                }
                r.Close(); r.Dispose(); da.CloseConnection();
                return new response(true, JsonConvert.SerializeObject(aList.ToArray(), CommonFunctions.JsonSerializerSettings), aList.ToArray(), null, null);
            }
            catch (Exception exp) { LogWriter.Log(exp); return new response(false, exp.Message, null, null, new System.Collections.Generic.List<Error>() { new Error(exp) }); }
        }

        public response CountAll()
        {
            try
            {
                DataAccess da = new DataAccess(authenticatedUserId, connectionString, CommandType.StoredProcedure, "PARTIsp_count");
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
                    string newFilter = Filtering.GenerateFilterFromJsonObject(typeof(Asigurat), _filter, authenticatedUserId, connectionString);
                    _filter = newFilter == null ? _filter : newFilter;
                }
                catch { }
                DataAccess da = new DataAccess(authenticatedUserId, connectionString, CommandType.StoredProcedure, "PARTIsp_select", new object[] {
                new MySqlParameter("_SORT", _sort),
                new MySqlParameter("_ORDER", _order),
                new MySqlParameter("_FILTER", _filter),
                new MySqlParameter("_LIMIT", _limit) });
                /*
                ArrayList aList = new ArrayList();
                MySqlDataReader r = da.ExecuteSelectQuery();
                while (r.Read())
                {
                    Parte a = new Parte(authenticatedUserId, connectionString, (IDataRecord)r);
                    aList.Add(a);
                }
                r.Close(); r.Dispose(); da.CloseConnection();
                Parte[] toReturn = new Parte[aList.Count];
                for (int i = 0; i < aList.Count; i++)
                    toReturn[i] = (Parte)aList[i];
                return new response(true, JsonConvert.SerializeObject(toReturn, CommonFunctions.JsonSerializerSettings), toReturn, null, null);
                */
                List<Parte> aList = new List<Parte>();
                MySqlDataReader r = da.ExecuteSelectQuery();
                while (r.Read())
                {
                    Parte a = new Parte(authenticatedUserId, connectionString, (IDataRecord)r);
                    aList.Add(a);
                }
                r.Close(); r.Dispose(); da.CloseConnection();
                return new response(true, JsonConvert.SerializeObject(aList.ToArray(), CommonFunctions.JsonSerializerSettings), aList.ToArray(), null, null);
            }
            catch (Exception exp) { LogWriter.Log(exp); return new response(false, exp.Message, null, null, new System.Collections.Generic.List<Error>() { new Error(exp) }); }
        }

        public response Find(int _id)
        {
            try
            {
                Parte item = new Parte(authenticatedUserId, connectionString, _id);
                return new response(true, JsonConvert.SerializeObject(item, CommonFunctions.JsonSerializerSettings), item, null, null); ;
            }
            catch (Exception exp) { LogWriter.Log(exp); return new response(false, exp.ToString(), null, null, new System.Collections.Generic.List<Error>() { new Error(exp) }); }
        }
        public response Find(string _denumire)
        {
            try
            {
                Parte item = new Parte(authenticatedUserId, connectionString, _denumire);
                return new response(true, JsonConvert.SerializeObject(item, CommonFunctions.JsonSerializerSettings), item, null, null); ;
            }
            catch (Exception exp) { LogWriter.Log(exp); return new response(false, exp.ToString(), null, null, new System.Collections.Generic.List<Error>() { new Error(exp) }); }
        }

        public response Insert(Parte item)
        {
            return item.Insert();
        }

        public response Update(Parte item)
        {
            return item.Update();
        }

        public response Update(int id, string fieldValueCollection)
        {
            //Parte item = JsonConvert.DeserializeObject<Parte>(Find(id).Message);
            Parte item = (Parte)(Find(id).Result);
            return item.Update(fieldValueCollection);
        }
        public response Update(string fieldValueCollection)
        {
            Parte tmpItem = JsonConvert.DeserializeObject<Parte>(fieldValueCollection); // sa vedem daca merge asa sau trebuie cu JObject
            //return JsonConvert.DeserializeObject<Parte>(Find(Convert.ToInt32(tmpItem.ID)).Message).Update(fieldValueCollection);
            return ((Parte)(Find(Convert.ToInt32(tmpItem.ID)).Result)).Update(fieldValueCollection);
        }

        public response Delete(Parte item)
        {
            return item.Delete();
        }

        public response HasChildrens(Parte item, string tableName)
        {
            return item.HasChildrens(tableName);
        }

        public response HasChildren(Parte item, string tableName, int childrenId)
        {
            return item.HasChildren(tableName, childrenId);
        }

        public response GetChildrens(Parte item, string tableName)
        {
            return item.GetChildrens(tableName);
        }

        public response GetChildren(Parte item, string tableName, int childrenId)
        {
            return item.GetChildren(tableName, childrenId);
        }
        public response Delete(int _id)
        {
            var obj = Find(_id);
            return ((Parte)obj.Result).Delete();
        }

        public response HasChildrens(int _id, string tableName)
        {
            var obj = Find(_id);
            return ((Parte)obj.Result).HasChildrens(tableName);
        }
        public response HasChildren(int _id, string tableName, int childrenId)
        {
            var obj = Find(_id);
            return ((Parte)obj.Result).HasChildren(tableName, childrenId);
        }
        public response GetChildrens(int _id, string tableName)
        {
            var obj = Find(_id);
            return ((Parte)obj.Result).GetChildrens(tableName);
        }
        public response GetChildren(int _id, string tableName, int childrenId)
        {
            var obj = Find(_id);
            return ((Parte)obj.Result).GetChildren(tableName, childrenId);
        }
    }
}
