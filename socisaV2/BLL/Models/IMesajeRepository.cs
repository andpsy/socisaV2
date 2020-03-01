﻿using MySql.Data.MySqlClient;
using System;
using System.Collections;
using System.Data;
using System.Data.Common;
using Newtonsoft.Json;
using System.Collections.Generic;
using Newtonsoft.Json.Linq;

namespace SOCISA.Models
{
    public interface IMesajeRepository
    {
        response GetAll(); response CountAll();
        response GetFiltered(string _sort, string _order, string _filter, string _limit);
        response GetFiltered(string _json);
        response GetFiltered(JObject _json);

        response Find(int _id);
        response Insert(Mesaj item);
        response Update(Mesaj item);
        response Update(int id, string fieldValueCollection);
        response Update(string fieldValueCollection);

        response Delete(Mesaj item);
        response HasChildrens(Mesaj item, string tableName);
        response HasChildren(Mesaj item, string tableName, int childrenId);
        response GetChildrens(Mesaj item, string tableName);
        response GetChildren(Mesaj item, string tableName, int childrenId);

        response GenerateAndSendMessage(int? IdDosar, DateTime Data, string Subiect, string Body, string TipMesaj, int IdSender, int Importanta);
        response GetReceiversByIdDosar(Mesaj item);
        response SendToInvolvedParties(Mesaj item);
        response GetDosar(Mesaj item);
        response GetTipMesaj(Mesaj item);
        response SetMessageReadDate(Mesaj item, int idUtilizator, DateTime ReadDate);
        response GetReceivers(Mesaj item);
        response GetSender(Mesaj item);

        response Delete(int _id);
        response HasChildrens(int _id, string tableName);
        response HasChildren(int _id, string tableName, int childrenId);
        response GetChildrens(int _id, string tableName);
        response GetChildren(int _id, string tableName, int childrenId);
    }

    public class MesajeRepository : IMesajeRepository
    {
        private string connectionString;
        private int authenticatedUserId;

        //public MesajeRepository(int _authenticatedUserId, string _connectionString)
        public MesajeRepository(int _authenticatedUserId, string _connectionString)
        {
            authenticatedUserId = _authenticatedUserId;
            connectionString = _connectionString;
        }

        public response GetAll()
        {
            try
            {
                DataAccess da = new DataAccess(authenticatedUserId, connectionString, CommandType.StoredProcedure, "MESAJEsp_select", new object[] {
                new MySqlParameter("_SORT", null),
                new MySqlParameter("_ORDER", null),
                new MySqlParameter("_FILTER", null),
                new MySqlParameter("_LIMIT", null) });
                /*
                ArrayList aList = new ArrayList();
                MySqlDataReader r = da.ExecuteSelectQuery();
                while (r.Read())
                {
                    Mesaj a = new Mesaj(authenticatedUserId, connectionString, (IDataRecord)r);
                    aList.Add(a);
                }
                r.Close(); r.Dispose(); da.CloseConnection();
                Mesaj[] toReturn = new Mesaj[aList.Count];
                for (int i = 0; i < aList.Count; i++)
                    toReturn[i] = (Mesaj)aList[i];
                return new response(true, JsonConvert.SerializeObject(toReturn, CommonFunctions.JsonSerializerSettings), toReturn, null, null); 
                */
                List<Mesaj> aList = new List<Mesaj>();
                MySqlDataReader r = da.ExecuteSelectQuery();
                while (r.Read())
                {
                    Mesaj a = new Mesaj(authenticatedUserId, connectionString, (IDataRecord)r);
                    aList.Add(a);
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
                DataAccess da = new DataAccess(authenticatedUserId, connectionString, CommandType.StoredProcedure, "MESAJEsp_count");
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
                    string newFilter = Filtering.GenerateFilterFromJsonObject(typeof(Mesaj), _filter, authenticatedUserId, connectionString);
                    _filter = newFilter == null ? _filter : newFilter;
                }
                catch { }
                DataAccess da = new DataAccess(authenticatedUserId, connectionString, CommandType.StoredProcedure, "MESAJEsp_select", new object[] {
                new MySqlParameter("_SORT", _sort),
                new MySqlParameter("_ORDER", _order),
                new MySqlParameter("_FILTER", _filter),
                new MySqlParameter("_LIMIT", _limit) });
                /*
                ArrayList aList = new ArrayList();
                MySqlDataReader r = da.ExecuteSelectQuery();
                while (r.Read())
                {
                    Mesaj a = new Mesaj(authenticatedUserId, connectionString, (IDataRecord)r);
                    aList.Add(a);
                }
                r.Close(); r.Dispose(); da.CloseConnection();
                Mesaj[] toReturn = new Mesaj[aList.Count];
                for (int i = 0; i < aList.Count; i++)
                    toReturn[i] = (Mesaj)aList[i];
                return new response(true, JsonConvert.SerializeObject(toReturn, CommonFunctions.JsonSerializerSettings), toReturn, null, null); 
                */
                List<Mesaj> aList = new List<Mesaj>();
                MySqlDataReader r = da.ExecuteSelectQuery();
                while (r.Read())
                {
                    Mesaj a = new Mesaj(authenticatedUserId, connectionString, (IDataRecord)r);
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
                Mesaj item = new Mesaj(authenticatedUserId, connectionString, _id);
                return new response(true, JsonConvert.SerializeObject(item, CommonFunctions.JsonSerializerSettings), item, null, null); ;
            }
            catch (Exception exp) { LogWriter.Log(exp); return new response(false, exp.ToString(), null, null, new System.Collections.Generic.List<Error>() { new Error(exp) }); }
        }

        public response Insert(Mesaj item)
        {
            return item.Insert();
        }

        public response Update(Mesaj item)
        {
            return item.Update();
        }

        public response Update(int id, string fieldValueCollection)
        {
            //Mesaj item = JsonConvert.DeserializeObject<Mesaj>(Find(id).Message);
            Mesaj item = (Mesaj)(Find(id).Result);
            return item.Update(fieldValueCollection);
        }
        public response Update(string fieldValueCollection)
        {
            Mesaj tmpItem = JsonConvert.DeserializeObject<Mesaj>(fieldValueCollection); // sa vedem daca merge asa sau trebuie cu JObject
            //return JsonConvert.DeserializeObject<Mesaj>(Find(Convert.ToInt32(tmpItem.ID)).Message).Update(fieldValueCollection);
            return ((Mesaj)(Find(Convert.ToInt32(tmpItem.ID)).Result)).Update(fieldValueCollection);
        }

        public response Delete(Mesaj item)
        {
            return item.Delete();
        }

        public response HasChildrens(Mesaj item, string tableName)
        {
            return item.HasChildrens(tableName);
        }

        public response HasChildren(Mesaj item, string tableName, int childrenId)
        {
            return item.HasChildren(tableName, childrenId);
        }

        public response GetChildrens(Mesaj item, string tableName)
        {
            return item.GetChildrens(tableName);
        }

        public response GetChildren(Mesaj item, string tableName, int childrenId)
        {
            return item.GetChildren(tableName, childrenId);
        }

        public response GenerateAndSendMessage(int? IdDosar, DateTime Data, string Subiect, string Body, string TipMesaj, int IdSender, int Importanta)
        {
            Mesaj mesaj = new Mesaj(authenticatedUserId, connectionString, IdDosar, Data, Subiect, Body, TipMesaj, IdSender, Importanta);
            response r = mesaj.Insert();
            if (r.Status && r.InsertedId != null)
            {
                mesaj.ID = r.InsertedId;
                r.AddResponse(mesaj.SendToInvolvedParties());
            }
            return r;
        }

        public response GetReceiversByIdDosar(Mesaj item)
        {
            return item.GetReceiversByIdDosar();
        }

        public response SendToInvolvedParties(Mesaj item)
        {
            return item.SendToInvolvedParties();
        }

        public response GetDosar(Mesaj item)
        {
            return item.GetDosar();
        }
        public response GetTipMesaj(Mesaj item)
        {
            return item.GetTipMesaj();
        }
        public response SetMessageReadDate(Mesaj item, int idUtilizator, DateTime ReadDate)
        {
            return item.SetMessageReadDate(idUtilizator, ReadDate);
        }
        public response GetReceivers(Mesaj item)
        {
            return item.GetReceivers();
        }
        public response GetSender(Mesaj item)
        {
            return item.GetSender();
        }

        public response Delete(int _id)
        {
            response obj = Find(_id);
            //return JsonConvert.DeserializeObject<Mesaj>(obj.Message).Delete();
            return ((Mesaj)obj.Result).Delete();
        }

        public response HasChildrens(int _id, string tableName)
        {
            var obj = Find(_id);
            //return JsonConvert.DeserializeObject<Mesaj>(obj.Message).HasChildrens(tableName);
            return ((Mesaj)obj.Result).HasChildrens(tableName);
        }
        public response HasChildren(int _id, string tableName, int childrenId)
        {
            var obj = Find(_id);
            //return JsonConvert.DeserializeObject<Mesaj>(obj.Message).HasChildren(tableName, childrenId);
            return ((Mesaj)obj.Result).HasChildren(tableName, childrenId);
        }
        public response GetChildrens(int _id, string tableName)
        {
            var obj = Find(_id);
            //return JsonConvert.DeserializeObject<Mesaj>(obj.Message).GetChildrens(tableName);
            return ((Mesaj)obj.Result).GetChildrens(tableName);
        }
        public response GetChildren(int _id, string tableName, int childrenId)
        {
            var obj = Find(_id);
            //return JsonConvert.DeserializeObject<Mesaj>(obj.Message).GetChildren(tableName, childrenId);
            return ((Mesaj)obj.Result).GetChildren(tableName, childrenId);
        }
    }
}
