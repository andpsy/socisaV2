using MySql.Data.MySqlClient;
using System;
using System.Collections;
using System.Data;
using System.Data.Common;
using Newtonsoft.Json;
using System.Collections.Generic;
using Newtonsoft.Json.Linq;
using System.IO;
using OfficeOpenXml;

namespace SOCISA.Models
{
    public interface IPlatiRepository
    {
        response GetAll(); response CountAll();
        response GetFiltered(string _sort, string _order, string _filter, string _limit);
        response GetFiltered(string _json);
        response GetFiltered(JObject _json);
        response Find(int _id);
        response Insert(Plata item);
        response Update(Plata item);
        response Update(int id, string fieldValueCollection);
        response Update(string fieldValueCollection);

        response Delete(Plata item);
        response HasChildrens(Plata item, string tableName);
        response HasChildren(Plata item, string tableName, int childrenId);
        response GetChildrens(Plata item, string tableName);
        response GetChildren(Plata item, string tableName, int childrenId);
        response Delete(int _id);
        response HasChildrens(int _id, string tableName);
        response HasChildren(int _id, string tableName, int childrenId);
        response GetChildrens(int _id, string tableName);
        response GetChildren(int _id, string tableName, int childrenId);
        response GetTipPlata(Plata item);
        response MovePendingToOk(int _pending_id);
    }

    public class PlatiRepository : IPlatiRepository
    {
        private string connectionString;
        private int authenticatedUserId;

        public PlatiRepository(int _authenticatedUserId, string _connectionString)
        {
            authenticatedUserId = _authenticatedUserId;
            connectionString = _connectionString;
        }

        public response GetAll()
        {
            try
            {
                DataAccess da = new DataAccess(authenticatedUserId, connectionString, CommandType.StoredProcedure, "PLATIsp_select", new object[] {
                new MySqlParameter("_SORT", null),
                new MySqlParameter("_ORDER", null),
                new MySqlParameter("_FILTER", null),
                new MySqlParameter("_LIMIT", null) });
                /*
                ArrayList aList = new ArrayList();
                MySqlDataReader r = da.ExecuteSelectQuery();
                while (r.Read())
                {
                    Plata a = new Plata(authenticatedUserId, connectionString, (IDataRecord)r);
                    aList.Add(a);
                }
                r.Close(); r.Dispose(); da.CloseConnection();
                Plata[] toReturn = new Plata[aList.Count];
                for (int i = 0; i < aList.Count; i++)
                    toReturn[i] = (Plata)aList[i];
                return new response(true, JsonConvert.SerializeObject(toReturn, CommonFunctions.JsonSerializerSettings), toReturn, null, null);
                */
                List<Plata> aList = new List<Plata>();
                MySqlDataReader r = da.ExecuteSelectQuery();
                while (r.Read())
                {
                    Plata a = new Plata(authenticatedUserId, connectionString, (IDataRecord)r);
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
                DataAccess da = new DataAccess(authenticatedUserId, connectionString, CommandType.StoredProcedure, "PLATIsp_count");
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
                    string newFilter = Filtering.GenerateFilterFromJsonObject(typeof(Proces), _filter, authenticatedUserId, connectionString);
                    _filter = newFilter ?? _filter;
                }
                catch { }
                DataAccess da = new DataAccess(authenticatedUserId, connectionString, CommandType.StoredProcedure, "PLATIsp_select", new object[] {
                new MySqlParameter("_SORT", _sort),
                new MySqlParameter("_ORDER", _order),
                new MySqlParameter("_FILTER", _filter),
                new MySqlParameter("_LIMIT", _limit) });
                /*
                ArrayList aList = new ArrayList();
                MySqlDataReader r = da.ExecuteSelectQuery();
                while (r.Read())
                {
                    Plata a = new Plata(authenticatedUserId, connectionString, (IDataRecord)r);
                    aList.Add(a);
                }
                r.Close(); r.Dispose(); da.CloseConnection();
                Plata[] toReturn = new Plata[aList.Count];
                for (int i = 0; i < aList.Count; i++)
                    toReturn[i] = (Plata)aList[i];
                return new response(true, JsonConvert.SerializeObject(toReturn, CommonFunctions.JsonSerializerSettings), toReturn, null, null);
                */
                List<Plata> aList = new List<Plata>();
                MySqlDataReader r = da.ExecuteSelectQuery();
                while (r.Read())
                {
                    Plata a = new Plata(authenticatedUserId, connectionString, (IDataRecord)r);
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
                Plata item = new Plata(authenticatedUserId, connectionString, _id);
                return new response(true, JsonConvert.SerializeObject(item, CommonFunctions.JsonSerializerSettings), item, null, null); ;
            }
            catch (Exception exp) { LogWriter.Log(exp); return new response(false, exp.ToString(), null, null, new System.Collections.Generic.List<Error>() { new Error(exp) }); }
        }

        public response Insert(Plata item)
        {
            return item.Insert();
        }

        public response Update(Plata item)
        {
            return item.Update();
        }

        public response Update(int id, string fieldValueCollection)
        {
            //Plata item = JsonConvert.DeserializeObject<Plata>(Find(id).Message);
            Plata item = (Plata)(Find(id).Result);
            return item.Update(fieldValueCollection);
        }

        public response Update(string fieldValueCollection)
        {
            Plata tmpItem = JsonConvert.DeserializeObject<Plata>(fieldValueCollection); // sa vedem daca merge asa sau trebuie cu JObject
            //return JsonConvert.DeserializeObject<Proces>(Find(Convert.ToInt32(tmpItem.ID)).Message).Update(fieldValueCollection);
            return ((Plata)(Find(Convert.ToInt32(tmpItem.ID)).Result)).Update(fieldValueCollection);
        }

        public response Delete(Plata item)
        {
            return item.Delete();
        }

        public response HasChildrens(Plata item, string tableName)
        {
            return item.HasChildrens(tableName);
        }

        public response HasChildren(Plata item, string tableName, int childrenId)
        {
            return item.HasChildren(tableName, childrenId);
        }

        public response GetChildrens(Plata item, string tableName)
        {
            return item.GetChildrens(tableName);
        }

        public response GetChildren(Plata item, string tableName, int childrenId)
        {
            return item.GetChildren(tableName, childrenId);
        }

        public response GetTipPlata(Plata item)
        {
            return item.GetTipPlata();
        }

        public response Delete(int _id)
        {
            response obj = Find(_id);
            //return JsonConvert.DeserializeObject<Plata>(obj.Message).Delete();
            return ((Plata)obj.Result).Delete();
        }

        public response HasChildrens(int _id, string tableName)
        {
            var obj = Find(_id);
            //return JsonConvert.DeserializeObject<Plata>(obj.Message).HasChildrens(tableName);
            return ((Plata)obj.Result).HasChildrens(tableName);
        }
        public response HasChildren(int _id, string tableName, int childrenId)
        {
            var obj = Find(_id);
            //return JsonConvert.DeserializeObject<Plata>(obj.Message).HasChildren(tableName, childrenId);
            return ((Plata)obj.Result).HasChildren(tableName, childrenId);
        }
        public response GetChildrens(int _id, string tableName)
        {
            var obj = Find(_id);
            //return JsonConvert.DeserializeObject<Plata>(obj.Message).GetChildrens(tableName);
            return ((Plata)obj.Result).GetChildrens(tableName);
        }
        public response GetChildren(int _id, string tableName, int childrenId)
        {
            var obj = Find(_id);
            //return JsonConvert.DeserializeObject<Plata>(obj.Message).GetChildren(tableName, childrenId);
            return ((Plata)obj.Result).GetChildren(tableName, childrenId);
        }

        public response GetPlatiFromExcel(string sheet, string fileName)
        {
            try
            {
                FileInfo fi = new FileInfo(File.Exists(fileName) ? fileName : Path.Combine(CommonFunctions.GetImportsFolder(), fileName));
                ExcelPackage ep = new ExcelPackage(fi);
                ExcelWorksheet ews = ep.Workbook.Worksheets[sheet];

                Dictionary<string, int> columnNames = new Dictionary<string, int>();
                int colIndex = 1;
                foreach (var firstRowCell in ews.Cells[1, 1, 1, ews.Dimension.End.Column])
                {
                    columnNames.Add(firstRowCell.Text, colIndex);
                    colIndex++;
                }
                List<object[]> toReturnList = new List<object[]>();
                //TO DO: trebuie stabilita maparea exacta cu coloanele din Excel !!!

                Nomenclator TipPlata = new Nomenclator(authenticatedUserId, connectionString, "tip_plata", "DIRECTA");

                Dosar dosar = null;

                for (var rowNumber = 2; rowNumber <= ews.Dimension.End.Row; rowNumber++)
                {
                    try
                    {
                        response toReturn = new response(true, "", null, null, new List<Error>()); ;
                        response r = new response();
                        List<PlataExtended> plati = new List<PlataExtended>();

                        try
                        {
                            dosar = new Dosar(authenticatedUserId, connectionString, ews.Cells[rowNumber, columnNames["DOSAR"]].Text.Trim());
                            if (dosar == null || dosar.ID == null)
                            {
                                Error err = ErrorParser.ErrorMessage("dosarInexistent");
                                List<Error> errs = new List<Error>();
                                errs.Add(err);
                                r = new response(false, err.ERROR_MESSAGE, null, null, errs);
                                toReturn.AddResponse(r);
                            }
                            else
                            {
                                if (!dosar.IsAvizat())
                                {
                                    Error err = ErrorParser.ErrorMessage("dosarNeavizat");
                                    List<Error> errs = new List<Error>();
                                    errs.Add(err);
                                    r = new response(false, err.ERROR_MESSAGE, null, null, errs);
                                    toReturn.AddResponse(r);
                                }
                            }
                        }
                        catch (Exception exp)
                        {
                            LogWriter.Log(exp);
                        }

                        for(int i = 1; i < 6; i++) // platile in Excel sunt pe coloane si consideram maxim 5 plati
                        {
                            try
                            {
                                if(!String.IsNullOrWhiteSpace(ews.Cells[rowNumber, columnNames["DOCUMENT_PLATA"+i.ToString()]].Text.Trim()) && Double.TryParse(ews.Cells[rowNumber, columnNames["SUMA_RECUPERATA" + i.ToString()]].Text.Trim(), out double tmpSuma) && CommonFunctions.SwitchBackFormatedDate(ews.Cells[rowNumber, columnNames["DATA_PLATA"+i.ToString()]].Text.Trim()) != null)
                                {
                                    Plata plata = new Plata(authenticatedUserId, connectionString);
                                    try { plata.NR_DOCUMENT = ews.Cells[rowNumber, columnNames["DOCUMENT_PLATA"+i.ToString()]].Text.Trim(); }
                                    catch { }
                                    try { plata.DATA_DOCUMENT = CommonFunctions.SwitchBackFormatedDate(ews.Cells[rowNumber, columnNames["DATA_PLATA"+i.ToString()]].Text.Trim()); }
                                    catch { }
                                    try { plata.SUMA = Convert.ToDouble(ews.Cells[rowNumber, columnNames["SUMA_RECUPERATA"+i.ToString()]].Text.Trim()); }
                                    catch { }
                                    try { plata.ID_DOSAR = dosar.ID; }
                                    catch { }
                                    try { plata.ID_TIP_PLATA = TipPlata.ID; }
                                    catch { }
                                    plati.Add(new PlataExtended(plata));
                                }
                            }
                            catch { }
                        }

                        foreach(PlataExtended plataExtended in plati)
                        {
                            Plata tmpPlata = new Plata(authenticatedUserId, connectionString, plataExtended.Plata);
                            if (tmpPlata != null && tmpPlata.ID != null)
                            {
                                Error err = ErrorParser.ErrorMessage("plataExistenta");
                                List<Error> errs = new List<Error>();
                                errs.Add(err);
                                r = new response(false, err.ERROR_MESSAGE, null, null, errs);
                                toReturn.AddResponse(r);
                            }
                            r = plataExtended.Plata.Validare();
                            if (!r.Status)
                            {
                                toReturn.AddResponse(r);
                            }
                            //pt. cazul in care avem duplicate in excel si platile nu sunt inca in baza de date !
                            for (int i = 0; i < toReturnList.Count; i++)
                            {
                                tmpPlata = ((PlataExtended)toReturnList[i][1]).Plata;
                                if (tmpPlata.NR_DOCUMENT == plataExtended.Plata.NR_DOCUMENT && tmpPlata.DATA_DOCUMENT == plataExtended.Plata.DATA_DOCUMENT && tmpPlata.SUMA == plataExtended.Plata.SUMA && tmpPlata.ID_DOSAR == plataExtended.Plata.ID_DOSAR)
                                {
                                    Error err = new Error();
                                    response nr = new response(false, null, null, null, new List<Error>());
                                    nr.Status = false;
                                    err = ErrorParser.ErrorMessage("plataExistenta");
                                    nr.Message = string.Format("{0}{1};", nr.Message ?? "", err.ERROR_MESSAGE);
                                    nr.InsertedId = null;
                                    nr.Error.Add(err);
                                    toReturn.AddResponse(nr);
                                    break;
                                }
                            }
                            toReturnList.Add(new object[] { toReturn, plataExtended });
                        }
                    }
                    catch (Exception exp)
                    {
                        LogWriter.Log(exp);
                    }
                }
                return new response(true, JsonConvert.SerializeObject(toReturnList.ToArray(), CommonFunctions.JsonSerializerSettings), toReturnList.ToArray(), null, null);
            }
            catch (Exception exp)
            {
                LogWriter.Log(exp);
                return new response(false, exp.Message, null, null, new List<Error>() { new Error(exp) });
            }
        }

        public response GetPlatiFromExcel(JObject _json)
        {
            try
            {
                string sheet = null, fileName = null;
                foreach (var t in _json)
                {
                    JToken j = t.Value;
                    switch (t.Key.ToLower())
                    {
                        case "sheet":
                            sheet = CommonFunctions.IsNullOrEmpty(j) ? null : j.ToString();
                            break;
                        case "filename":
                            fileName = CommonFunctions.IsNullOrEmpty(j) ? null : j.ToString();
                            break;
                    }
                }
                return GetPlatiFromExcel(sheet, fileName);
            }
            catch (Exception exp)
            {
                LogWriter.Log(exp);
                return new response(false, exp.Message, null, null, new List<Error>() { new Error(exp) });
            }
        }

        public response ImportAll(response responsesPlati, DateTime _date, int _import_type)
        {
            try
            {
                List<object[]> toReturnList = new List<object[]>();
                foreach (object[] responsePlata in (object[])responsesPlati.Result)
                {
                    PlataExtended plataExtended = (PlataExtended)responsePlata[1];
                    response response = (response)responsePlata[0];
                    response r = new response();
                    if (response.Status)
                    {
                        r = plataExtended.Plata.Insert();
                        if (!r.Status)
                            response.Status = false;
                    }
                    else
                    {
                        r = plataExtended.Plata.InsertWithErrors();
                        response.Status = false;
                    }
                    response.InsertedId = r.InsertedId;
                    plataExtended.Plata.Log(response, _date, _import_type);
                    toReturnList.Add(new object[] { response, plataExtended });
                }
                return new response(true, JsonConvert.SerializeObject(toReturnList.ToArray(), CommonFunctions.JsonSerializerSettings), toReturnList.ToArray(), null, null);
            }
            catch (Exception exp)
            {
                LogWriter.Log(exp);
                return new response(false, exp.Message, null, null, new List<Error>() { new Error(exp) });
            }
        }

        public response GetImportDates()
        {
            try
            {
                DataAccess da = new DataAccess(authenticatedUserId, connectionString, CommandType.StoredProcedure, "PLATIsp_GetImportDates");
                IDataReader r = da.ExecuteSelectQuery();
                List<string> dates = new List<string>();
                while (r.Read())
                {
                    dates.Add(Convert.ToDateTime(r["DATA_IMPORT"]).ToString("dd.MM.yyyy HH:mm:ss"));
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

        public response GetPlatiFromLog(DateTime? data)
        {
            try
            {
                List<object[]> toReturnList = new List<object[]>();
                DataAccess da = new DataAccess(authenticatedUserId, connectionString, CommandType.StoredProcedure, "IMPORT_LOG_PLATIsp_GetPlati", new object[] { new MySqlParameter("_DATA_IMPORT", data) });
                IDataReader dr = da.ExecuteSelectQuery();
                while (dr.Read())
                {
                    try
                    {
                        response r = new response();
                        r.Status = Convert.ToBoolean(dr["STATUS"]);
                        r.Message = dr["MESSAGE"].ToString();
                        r.InsertedId = Convert.ToInt32(dr["INSERTED_ID"]);
                        r.Error = JsonConvert.DeserializeObject<List<Error>>(dr["ERRORS"].ToString(), CommonFunctions.JsonDeserializerSettings);

                        Plata plata = r.Status ? new Plata(authenticatedUserId, connectionString, Convert.ToInt32(r.InsertedId)) : new Plata(authenticatedUserId, connectionString, Convert.ToInt32(r.InsertedId), true);
                        PlataExtended pe = new PlataExtended(plata);

                        toReturnList.Add(new object[] { r, pe });
                    }
                    catch (Exception exp)
                    {
                        LogWriter.Log(exp);
                    }
                }
                dr.Close(); dr.Dispose();
                return new response(true, JsonConvert.SerializeObject(toReturnList.ToArray(), CommonFunctions.JsonSerializerSettings), toReturnList.ToArray(), null, null);
            }
            catch (Exception exp)
            {
                LogWriter.Log(exp);
                return new response(false, exp.Message, null, null, new List<Error>() { new Error(exp) });
            }
        }

        public response ImportPlatiDirect(string sheet, string fileName, int _import_type)
        {
            response r = GetPlatiFromExcel(sheet, fileName);
            return ImportAll(r, DateTime.Now, _import_type);
        }

        public response ImportPlatiDirect(JObject _json, int _import_type)
        {
            response r = GetPlatiFromExcel(_json);
            return ImportAll(r, DateTime.Now, _import_type);
        }

        public response MovePendingToOk(int _pending_id)
        {
            Plata p = new Plata(authenticatedUserId, connectionString, _pending_id, true);
            response r = p.MovePendingToOk();
            // -- to do - generate message ???
            return r;
        }
    }
}
