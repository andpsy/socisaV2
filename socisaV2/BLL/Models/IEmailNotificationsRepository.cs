using MySql.Data.MySqlClient;
using System;
using System.Collections;
using System.Data;
using System.Data.Common;
//using System.Reflection;
using Newtonsoft.Json;
using System.Collections.Generic;
using Newtonsoft.Json.Linq;

namespace SOCISA.Models
{
    public interface IEmailNotificationsRepository
    {
        //EmailNotification[] GetAll();
        response GetAll(); response CountAll();
        //EmailNotification[] GetFiltered(string _sort, string _order, string _filter, string _limit);
        response GetFiltered(string _sort, string _order, string _filter, string _limit);
        response GetFiltered(string _json);
        response GetFiltered(JObject _json);

        //EmailNotification Find(int _id);
        response Find(int _id);
        response Insert(EmailNotification item);
        response Update(EmailNotification item);
        response Update(int id, string fieldValueCollection);
        response Update(string fieldValueCollection);

        response Delete(EmailNotification item);
        //bool HasChildrens(EmailNotification item, string tableName);
        response HasChildrens(EmailNotification item, string tableName);
        //bool HasChildren(EmailNotification item, string tableName, int childrenId);
        response HasChildren(EmailNotification item, string tableName, int childrenId);
        //object[] GetChildrens(EmailNotification item, string tableName);
        response GetChildrens(EmailNotification item, string tableName);
        //object GetChildren(EmailNotification item, string tableName, int childrenId);
        response GetChildren(EmailNotification item, string tableName, int childrenId);

        response Delete(int _id);
        //bool HasChildrens(int _id, string tableName);
        response HasChildrens(int _id, string tableName);
        //bool HasChildren(int _id, string tableName, int childrenId);
        response HasChildren(int _id, string tableName, int childrenId);
        //object[] GetChildrens(int _id, string tableName);
        response GetChildrens(int _id, string tableName);
        //object GetChildren(int _id, string tableName, int childrenId);
        response GetChildren(int _id, string tableName, int childrenId);

        response UpdateCheckedTimes(DateTime _timestamp, DateTime _data);
    }

    public class EmailNotificationsRepository : IEmailNotificationsRepository
    {
        private string connectionString;
        private int authenticatedUserId;

        public EmailNotificationsRepository(int _authenticatedUserId, string _connectionString)
        {
            authenticatedUserId = _authenticatedUserId;
            connectionString = _connectionString;
        }

        public response UpdateCheckedTimes(DateTime _timestamp, DateTime _data)
        {
            ArrayList _parameters = new ArrayList();
            _parameters.Add(new MySqlParameter("_TIMESTAMP", _timestamp));
            _parameters.Add(new MySqlParameter("_DATA", _data));

            DataAccess da = new DataAccess(authenticatedUserId, connectionString, CommandType.StoredProcedure, "EMAIL_NOTIFICATIONS_NEWsp_updateCheckTimes", _parameters.ToArray());
            response toReturn = da.ExecuteUpdateQuery();
            return toReturn;
        }

        public response GetAll()
        {
            try
            {
                DataAccess da = new DataAccess(authenticatedUserId, connectionString, CommandType.StoredProcedure, "EMAIL_NOTIFICATIONS_NEWsp_select", new object[] {
                new MySqlParameter("_SORT", null),
                new MySqlParameter("_ORDER", null),
                new MySqlParameter("_FILTER", null),
                new MySqlParameter("_LIMIT", null) });
                /*
                ArrayList aList = new ArrayList();
                MySqlDataReader r = da.ExecuteSelectQuery();
                while (r.Read())
                {
                    EmailNotification a = new EmailNotification(authenticatedUserId, connectionString, (IDataRecord)r);
                    aList.Add(a);
                }
                r.Close(); r.Dispose(); da.CloseConnection();
                EmailNotification[] toReturn = new EmailNotification[aList.Count];
                for (int i = 0; i < aList.Count; i++)
                    toReturn[i] = (EmailNotification)aList[i];
                return new response(true, JsonConvert.SerializeObject(toReturn, CommonFunctions.JsonSerializerSettings), toReturn, null, null);
                */
                List<EmailNotification> aList = new List<EmailNotification>();
                MySqlDataReader r = da.ExecuteSelectQuery();
                while (r.Read())
                {
                    EmailNotification a = new EmailNotification(authenticatedUserId, connectionString, (IDataRecord)r);
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
                DataAccess da = new DataAccess(authenticatedUserId, connectionString, CommandType.StoredProcedure, "EMAIL_NOTIFICATIONS_NEWsp_count");
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
                #region -- initial --
                /*
                string newFilter = null;
                try
                {
                    try
                    {
                        EmailNotification x = Newtonsoft.Json.JsonConvert.DeserializeObject<EmailNotification>(_filter);
                        newFilter = x.GenerateFilterFromJsonObject();
                    }
                    catch
                    {
                        try
                        {
                            dynamic jObj = Newtonsoft.Json.JsonConvert.DeserializeObject(_filter);
                            EmailNotification x = new EmailNotification(authenticatedUserId, connectionString);
                            PropertyInfo[] pisX = x.GetType().GetProperties();
                            PropertyInfo[] pisJObj = jObj.GetType().GetProperties();
                            foreach (PropertyInfo piX in pisX)
                            {
                                foreach (PropertyInfo piJObj in pisJObj)
                                {
                                    if (piX.Name == piJObj.Name)
                                    {
                                        piX.SetValue(x, piJObj.GetValue(jObj));
                                        break;
                                    }
                                }
                            }
                            newFilter = x.GenerateFilterFromJsonObject();
                        }
                        catch { }
                    }
                }
                catch { }
                if (newFilter != null) _filter = newFilter;
                */
                #endregion
                try
                {
                    string newFilter = Filtering.GenerateFilterFromJsonObject(typeof(EmailNotification), _filter, authenticatedUserId, connectionString);
                    _filter = (newFilter == null || newFilter.Trim() == "") && !_filter.IsValidJson() ? _filter : String.IsNullOrWhiteSpace(newFilter) ? null : newFilter;
                }
                catch { }
                DataAccess da = new DataAccess(authenticatedUserId, connectionString, CommandType.StoredProcedure, "EMAIL_NOTIFICATIONS_NEWsp_select", new object[] {
                new MySqlParameter("_SORT", _sort),
                new MySqlParameter("_ORDER", _order),
                new MySqlParameter("_FILTER", _filter),
                new MySqlParameter("_LIMIT", _limit) });
                /*
                ArrayList aList = new ArrayList();
                MySqlDataReader r = da.ExecuteSelectQuery();
                while (r.Read())
                {
                    EmailNotification a = new EmailNotification(authenticatedUserId, connectionString, (IDataRecord)r);
                    aList.Add(a);
                }
                r.Close(); r.Dispose(); da.CloseConnection();
                EmailNotification[] toReturn = new EmailNotification[aList.Count];
                for (int i = 0; i < aList.Count; i++)
                    toReturn[i] = (EmailNotification)aList[i];
                return new response(true, JsonConvert.SerializeObject(toReturn, CommonFunctions.JsonSerializerSettings), toReturn, null, null); 
                */
                List<EmailNotification> aList = new List<EmailNotification>();
                MySqlDataReader r = da.ExecuteSelectQuery();
                while (r.Read())
                {
                    EmailNotification a = new EmailNotification(authenticatedUserId, connectionString, (IDataRecord)r);
                    aList.Add(a);
                }
                r.Close(); r.Dispose(); da.CloseConnection();
                return new response(true, JsonConvert.SerializeObject(aList.ToArray(), CommonFunctions.JsonSerializerSettings), aList.ToArray(), null, null);
            }
            catch(Exception exp) { LogWriter.Log(exp); return new response(false, exp.ToString(), null, null, new System.Collections.Generic.List<Error>() { new Error(exp) }); }
        }

        public response Find(int _id)
        {
            try
            {
                EmailNotification item = new EmailNotification(authenticatedUserId, connectionString, _id);
                return new response(true, JsonConvert.SerializeObject(item, CommonFunctions.JsonSerializerSettings), item, null, null); ;
            }
            catch (Exception exp) { LogWriter.Log(exp); return new response(false, exp.ToString(), null, null, new System.Collections.Generic.List<Error>() { new Error(exp) }); }
        }

        public response Insert(EmailNotification item)
        {
            return item.Insert();
        }

        public response Update(EmailNotification item)
        {
            return item.Update();
        }

        public response Update(int id, string fieldValueCollection)
        {
            //EmailNotification item = JsonConvert.DeserializeObject<EmailNotification>(Find(id).Message);
            EmailNotification item = (EmailNotification)(Find(id).Result);
            return item.Update(fieldValueCollection);
        }
        public response Update(string fieldValueCollection)
        {
            EmailNotification tmpItem = JsonConvert.DeserializeObject<EmailNotification>(fieldValueCollection); // sa vedem daca merge asa sau trebuie cu JObject
            //return JsonConvert.DeserializeObject<EmailNotification>(Find(Convert.ToInt32(tmpItem.ID)).Message).Update(fieldValueCollection);
            return ((EmailNotification)(Find(Convert.ToInt32(tmpItem.ID)).Result)).Update(fieldValueCollection);
        }
        public response Delete(EmailNotification item)
        {
            return item.Delete();
        }

        public response HasChildrens(EmailNotification item, string tableName)
        {
            return item.HasChildrens(tableName);
        }

        public response HasChildren(EmailNotification item, string tableName, int childrenId)
        {
            return item.HasChildren(tableName, childrenId);
        }

        public response GetChildrens(EmailNotification item, string tableName)
        {
            return item.GetChildrens(tableName);
        }

        public response GetChildren(EmailNotification item, string tableName, int childrenId)
        {
            return item.GetChildren(tableName, childrenId);
        }

        public response Delete(int _id)
        {
            response obj = Find(_id);
            //return JsonConvert.DeserializeObject<EmailNotification>(obj.Message).Delete();
            return ((EmailNotification)obj.Result).Delete();
        }

        public response HasChildrens(int _id, string tableName)
        {
            var obj = Find(_id);
            //return JsonConvert.DeserializeObject<EmailNotification>(obj.Message).HasChildrens(tableName);
            return ((EmailNotification)obj.Result).HasChildrens(tableName);
        }
        public response HasChildren(int _id, string tableName, int childrenId)
        {
            var obj = Find(_id);
            //return JsonConvert.DeserializeObject<EmailNotification>(obj.Message).HasChildren(tableName, childrenId);
            return ((EmailNotification)obj.Result).HasChildren(tableName, childrenId);
        }
        public response GetChildrens(int _id, string tableName)
        {
            var obj = Find(_id);
            //return JsonConvert.DeserializeObject<EmailNotification>(obj.Message).GetChildrens(tableName);
            return ((EmailNotification)obj.Result).GetChildrens(tableName);
        }
        public response GetChildren(int _id, string tableName, int childrenId)
        {
            var obj = Find(_id);
            //return JsonConvert.DeserializeObject<EmailNotification>(obj.Message).GetChildren(tableName, childrenId);
            return ((EmailNotification)obj.Result).GetChildren(tableName, childrenId);
        }
    }
} 
