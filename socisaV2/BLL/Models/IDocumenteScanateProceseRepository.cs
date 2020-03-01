using MySql.Data.MySqlClient;
using System;
using System.Collections;
using System.Data;
using System.Data.Common;
using Newtonsoft.Json;
using System.Collections.Generic;
using Newtonsoft.Json.Linq;
using System.IO;

namespace SOCISA.Models
{
    public interface IDocumenteScanateProceseRepository
    {
        response GetAll(); response CountAll();
        response GetFiltered(string _sort, string _order, string _filter, string _limit);
        response GetFiltered(string _json);
        response GetFiltered(JObject _json);

        response Find(int _id);
        response Insert(DocumentScanatProces item);
        response Insert(DocumentScanatProces item, object file);
        response Insert(DocumentScanatProces item, ThumbNailSizes[] tSizes);
        response Insert(DocumentScanatProces item, object file, ThumbNailSizes[] tSizes);
        response GenerateThumbNails(DocumentScanatProces item, ThumbNailSizes[] tSizes);
        response Update(DocumentScanatProces item);
        response Update(DocumentScanatProces item, object file);
        response Update(DocumentScanatProces item, ThumbNailSizes[] tSizes);
        response Update(DocumentScanatProces item, object file, ThumbNailSizes[] tSizes);
        response Update(int id, string fieldValueCollection);
        response Update(string fieldValueCollection);
        response Update(int id, string fieldValueCollection, object file);
        response Update(string fieldValueCollection, object file);
        response Update(int id, string fieldValueCollection, object file, ThumbNailSizes[] tSizes);
        response Update(string fieldValueCollection, object file, ThumbNailSizes[] tSizes);
        response Delete(DocumentScanatProces item);
        response HasChildrens(DocumentScanatProces item, string tableName);
        response HasChildren(DocumentScanatProces item, string tableName, int childrenId);
        response GetChildrens(DocumentScanatProces item, string tableName);
        response GetChildren(DocumentScanatProces item, string tableName, int childrenId);
        response Delete(int _id);
        response HasChildrens(int _id, string tableName);
        response HasChildren(int _id, string tableName, int childrenId);
        response GetChildrens(int _id, string tableName);
        response GetChildren(int _id, string tableName, int childrenId);

        bool LoadTemplateFileIntoDb(string filePath, string _DETALII);
        response GetOrphanFiles();
        response GetOrphanDocumentsProcese();
        response DeleteOrphanFile(string fileName);
        response RestoreOrphanDocument(int _id);
    }

    public class DocumenteScanateProceseRepository : IDocumenteScanateProceseRepository
    {
        private string connectionString;
        private int authenticatedUserId;

        public DocumenteScanateProceseRepository(int _authenticatedUserId, string _connectionString)
        {
            authenticatedUserId = _authenticatedUserId;
            connectionString = _connectionString;
        }

        public bool LoadTemplateFileIntoDb(string filePath, string _DETALII)
        {
            return FileManager.LoadTemplateFileIntoDb(authenticatedUserId, connectionString, filePath, _DETALII);
        }

        public response GetAll()
        {
            try
            {
                DataAccess da = new DataAccess(authenticatedUserId, connectionString, CommandType.StoredProcedure, "DOCUMENTE_SCANATE_PROCESEsp_select", new object[] {
                new MySqlParameter("_SORT", null),
                new MySqlParameter("_ORDER", null),
                new MySqlParameter("_FILTER", null),
                new MySqlParameter("_LIMIT", null) });
                /*
                ArrayList aList = new ArrayList();
                MySqlDataReader r = da.ExecuteSelectQuery();
                while (r.Read())
                {
                    DocumentScanatProces a = new DocumentScanatProces(authenticatedUserId, connectionString, (IDataRecord)r);
                    aList.Add(a);
                }
                r.Close(); r.Dispose(); da.CloseConnection();
                DocumentScanatProces[] toReturn = new DocumentScanatProces[aList.Count];
                for (int i = 0; i < aList.Count; i++)
                    toReturn[i] = (DocumentScanatProces)aList[i];
                return new response(true, JsonConvert.SerializeObject(toReturn, CommonFunctions.JsonSerializerSettings), toReturn, null, null); 
                */
                List<DocumentScanatProces> aList = new List<DocumentScanatProces>();
                MySqlDataReader r = da.ExecuteSelectQuery();
                while (r.Read())
                {
                    DocumentScanatProces a = new DocumentScanatProces(authenticatedUserId, connectionString, (IDataRecord)r);
                    aList.Add(a);
                }
                r.Close(); r.Dispose(); da.CloseConnection();
                return new response(true, JsonConvert.SerializeObject(aList.ToArray(), CommonFunctions.JsonSerializerSettings), aList.ToArray(), null, null);
            }
            catch (Exception exp) { LogWriter.Log(exp); return new response(false, exp.ToString(), null, null, new List<Error>() { new Error(exp) }); }
        }

        public response GetOrphanFiles()
        {
            try
            {
                string[] fs = FileManager.GetOrphanFiles(authenticatedUserId, connectionString);
                return new response(true, "", fs, null, null);
            }catch(Exception exp)
            {
                LogWriter.Log(exp);
                return new response(false, exp.ToString(), null, null, new List<Error>() { new Error(exp) });
            }
        }

        public response GetOrphanDocumentsProcese()
        {
            try
            {
                return new response(true, "", FileManager.GetOrphanDocuments(authenticatedUserId, connectionString), null, null);
            }catch(Exception exp)
            {
                LogWriter.Log(exp);
                return new response(false, exp.ToString(), null, null, new List<Error>() { new Error(exp) });
            }
        }

        public response DeleteOrphanFile(string fileName)
        {
            bool toReturn = FileManager.DeleteOrphan(Path.Combine(CommonFunctions.GetScansFolder(), fileName));
            return new response(toReturn, "", toReturn, null, null);
        }
        public response RestoreOrphanDocument(int _id)
        {
            DocumentScanatProces item = (DocumentScanatProces)(Find(_id).Result);
            return FileManager.RestoreFileFromDb(item);
        }

        public response CountAll()
        {
            try
            {
                DataAccess da = new DataAccess(authenticatedUserId, connectionString, CommandType.StoredProcedure, "DOCUMENTE_SCANATE_PROCESEsp_count");
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
                    string newFilter = Filtering.GenerateFilterFromJsonObject(typeof(DocumentScanatProces), _filter, authenticatedUserId, connectionString);
                    _filter = newFilter == null ? _filter : newFilter;
                }
                catch { }
                DataAccess da = new DataAccess(authenticatedUserId, connectionString, CommandType.StoredProcedure, "DOCUMENTE_SCANATE_PROCESEsp_select", new object[] {
                new MySqlParameter("_SORT", _sort),
                new MySqlParameter("_ORDER", _order),
                new MySqlParameter("_FILTER", _filter),
                new MySqlParameter("_LIMIT", _limit) });
                /*
                ArrayList aList = new ArrayList();
                MySqlDataReader r = da.ExecuteSelectQuery();
                while (r.Read())
                {
                    DocumentScanatProces a = new DocumentScanatProces(authenticatedUserId, connectionString, (IDataRecord)r);
                    aList.Add(a);
                }
                r.Close(); r.Dispose(); da.CloseConnection();
                DocumentScanatProces[] toReturn = new DocumentScanatProces[aList.Count];
                for (int i = 0; i < aList.Count; i++)
                    toReturn[i] = (DocumentScanatProces)aList[i];
                return new response(true, JsonConvert.SerializeObject(toReturn, CommonFunctions.JsonSerializerSettings), toReturn, null, null); 
                */
                List<DocumentScanatProces> aList = new List<DocumentScanatProces>();
                MySqlDataReader r = da.ExecuteSelectQuery();
                while (r.Read())
                {
                    DocumentScanatProces a = new DocumentScanatProces(authenticatedUserId, connectionString, (IDataRecord)r);
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
                DocumentScanatProces item = new DocumentScanatProces(authenticatedUserId, connectionString, _id);
                return new response(true, JsonConvert.SerializeObject(item, CommonFunctions.JsonSerializerSettings), item, null, null); ;
            }
            catch (Exception exp) { LogWriter.Log(exp); return new response(false, exp.ToString(), null, null, new System.Collections.Generic.List<Error>() { new Error(exp) }); }
        }

        public response Insert(DocumentScanatProces item)
        {
            return item.Insert();
        }
        public response Insert(DocumentScanatProces item, ThumbNailSizes[] tSizes)
        {
            return item.Insert(tSizes);
        }
        public response Insert(DocumentScanatProces item, object file)
        {
            item.FILE_CONTENT = GetBytesFromParameter(file);
            item.DIMENSIUNE_FISIER = item.FILE_CONTENT.Length;
            return item.Insert();
        }
        public response Insert(DocumentScanatProces item, object file, ThumbNailSizes[] tSizes)
        {
            item.FILE_CONTENT = GetBytesFromParameter(file);
            return item.Insert(tSizes);
        }

        public response Update(DocumentScanatProces item)
        {
            return item.Update();
        }
        public response Update(DocumentScanatProces item, ThumbNailSizes[] tSizes)
        {
            return item.Update(tSizes);
        }
        public response Update(DocumentScanatProces item, object file)
        {
            item.FILE_CONTENT = GetBytesFromParameter(file);
            item.DIMENSIUNE_FISIER = item.FILE_CONTENT.Length;
            return item.Update();
        }
        public response Update(DocumentScanatProces item, object file, ThumbNailSizes[] tSizes)
        {
            item.FILE_CONTENT = GetBytesFromParameter(file);
            item.DIMENSIUNE_FISIER = item.FILE_CONTENT.Length;
            return item.Update(tSizes);
        }

        public response Update(int id, string fieldValueCollection)
        {
            //DocumentScanatProces item = JsonConvert.DeserializeObject<DocumentScanatProces>(Find(id).Message);
            DocumentScanatProces item = (DocumentScanatProces)(Find(id).Result);
            return item.Update(fieldValueCollection);
        }
        public response Update(string fieldValueCollection)
        {
            DocumentScanatProces tmpItem = JsonConvert.DeserializeObject<DocumentScanatProces>(fieldValueCollection);
            //return JsonConvert.DeserializeObject<DocumentScanatProces>(Find(Convert.ToInt32(tmpItem.ID)).Message).Update(fieldValueCollection);
            return ((DocumentScanatProces)(Find(Convert.ToInt32(tmpItem.ID)).Result)).Update(fieldValueCollection);
        }
        public response Update(int id, string fieldValueCollection, object file)
        {
            DocumentScanatProces item = JsonConvert.DeserializeObject<DocumentScanatProces>(Find(id).Message);
            byte[] f = GetBytesFromParameter(file);
            item.FILE_CONTENT = f;
            item.DIMENSIUNE_FISIER = item.FILE_CONTENT.Length;
            return item.Update(fieldValueCollection);
        }
        public response Update(string fieldValueCollection, object file)
        {
            DocumentScanatProces tmpItem = JsonConvert.DeserializeObject<DocumentScanatProces>(fieldValueCollection);
            //DocumentScanatProces item = JsonConvert.DeserializeObject<DocumentScanatProces>(Find(Convert.ToInt32(tmpItem.ID)).Message);
            DocumentScanatProces item = (DocumentScanatProces)(Find(Convert.ToInt32(tmpItem.ID)).Result);
            byte[] f = GetBytesFromParameter(file);
            item.FILE_CONTENT = f;
            item.DIMENSIUNE_FISIER = item.FILE_CONTENT.Length;
            return item.Update(fieldValueCollection);
        }
        public response Update(int id, string fieldValueCollection, object file, ThumbNailSizes[] tSizes)
        {
            //DocumentScanatProces item = JsonConvert.DeserializeObject<DocumentScanatProces>(Find(id).Message);
            DocumentScanatProces item = (DocumentScanatProces)(Find(id).Result);
            byte[] f = GetBytesFromParameter(file);
            item.FILE_CONTENT = f;
            item.DIMENSIUNE_FISIER = item.FILE_CONTENT.Length;
            response r = item.Update(fieldValueCollection);
            if (r.Status)
            {
                r = item.Update(tSizes);
                return r;
            }
            else return r;
        }
        public response Update(string fieldValueCollection, object file, ThumbNailSizes[] tSizes)
        {
            DocumentScanatProces tmpItem = JsonConvert.DeserializeObject<DocumentScanatProces>(fieldValueCollection);
            //DocumentScanatProces item = JsonConvert.DeserializeObject<DocumentScanatProces>(Find(Convert.ToInt32(tmpItem.ID)).Message);
            DocumentScanatProces item = (DocumentScanatProces)(Find(Convert.ToInt32(tmpItem.ID)).Result);
            byte[] f = GetBytesFromParameter(file);
            item.FILE_CONTENT = f;
            item.DIMENSIUNE_FISIER = item.FILE_CONTENT.Length;
            response r = item.Update(fieldValueCollection);
            if (r.Status)
            {
                r = item.Update(tSizes);
                return r;
            }
            else return r;
        }
        public response Delete(DocumentScanatProces item)
        {
            return item.Delete();
        }
        public response Delete(int _id)
        {
            //DocumentScanatProces item = JsonConvert.DeserializeObject<DocumentScanatProces>(Find(_id).Message);
            DocumentScanatProces item = (DocumentScanatProces)(Find(_id).Result);
            return item.Delete();
        }

        public response HasChildrens(DocumentScanatProces item, string tableName)
        {
            return item.HasChildrens(tableName);
        }

        public response HasChildren(DocumentScanatProces item, string tableName, int childrenId)
        {
            return item.HasChildren(tableName, childrenId);
        }

        public response GetChildrens(DocumentScanatProces item, string tableName)
        {
            return item.GetChildrens(tableName);
        }

        public response GetChildren(DocumentScanatProces item, string tableName, int childrenId)
        {
            return item.GetChildren(tableName, childrenId);
        }

        public response HasChildrens(int _id, string tableName)
        {
            var obj = Find(_id);
            return ((DocumentScanatProces)obj.Result).HasChildrens(tableName);
        }
        public response HasChildren(int _id, string tableName, int childrenId)
        {
            var obj = Find(_id);
            return ((DocumentScanatProces)obj.Result).HasChildren(tableName, childrenId);
        }
        public response GetChildrens(int _id, string tableName)
        {
            var obj = Find(_id);
            return ((DocumentScanatProces)obj.Result).GetChildrens(tableName);
        }
        public response GetChildren(int _id, string tableName, int childrenId)
        {
            var obj = Find(_id);
            return ((DocumentScanatProces)obj.Result).GetChildren(tableName, childrenId);
        }
        public response GenerateThumbNails(DocumentScanatProces item, ThumbNailSizes[] tSizes)
        {
            return item.GenerateImgThumbNails(tSizes);
        }
        public byte[] GetBytesFromParameter(object file)
        {
            byte[] f = null;
            if (file is byte[]) f = (byte[])file;
            if (file is string) f = FileManager.UploadFile(Convert.ToString(file));
            //if (file is Microsoft.AspNetCore.Http.IFormFile) f = FileManager.UploadFile((Microsoft.AspNetCore.Http.IFormFile)file);
            return f;
        }
    }
}
