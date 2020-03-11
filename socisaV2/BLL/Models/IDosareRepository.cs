﻿using MySql.Data.MySqlClient;
using OfficeOpenXml;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.IO;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;

namespace SOCISA.Models
{
    public interface IDosareRepository
    {
        response GetAll();
        response CountAll();
        response CountFiltered(string _sort, string _order, string _filter, string _limit);
        response CountFiltered(string _json);
        response CountFiltered(JObject _json);

        response CountFromLastLogin();
        response GetFiltered(string _sort, string _order, string _filter, string _limit);
        response GetFiltered(string _json);
        response GetFiltered(JObject _json);
        response Find(int _id);
        response Insert(Dosar item);
        response InsertWithErrors(Dosar item);
        response Update(Dosar item);
        response UpdateWithErrors(Dosar item);
        response Update(int id, string fieldValueCollection);
        response Update(string fieldValueCollection);
        response Delete(Dosar item);
        response DeleteWithErrors(Dosar item);
        response HasChildrens(Dosar item, string tableName);
        response HasChildren(Dosar item, string tableName, int childrenId);
        response GetChildrens(Dosar item, string tableName);
        response GetChildren(Dosar item, string tableName, int childrenId);

        response Delete(int _id);
        response HasChildrens(int _id, string tableName);
        response HasChildren(int _id, string tableName, int childrenId);
        response GetChildrens(int _id, string tableName);
        response GetChildren(int _id, string tableName, int childrenId);

        response GetMesaje(Dosar item);
        response GetUtilizatori(Dosar item);
        response GetSocietateCasco(Dosar item);
        response GetSocietateRca(Dosar item);
        response GetAutoCasco(Dosar item);
        response GetAutoRca(Dosar item);
        response GetAsiguratCasco(Dosar item);
        response GetAsiguratRca(Dosar item);
        response GetIntervenient(Dosar item);
        response GetDocumente(Dosar item);
        response GetProcese(Dosar item);
        response GetTipDosar(Dosar item);
        response GetInvolvedParties(Dosar item);
        response GetMaxNrSca();
        response ExportDocumenteDosarToPdf(Dosar item);
        response ExportDocumenteDosarToPdf(int _id);
        response ExportDosarToPdf(string templateFileName, Dosar item);
        response ExportDosarToPdf(string templateFileName, int _id);
        response ExportDosarToPdf(int _id);
        response ExportDosarCompletToPdf(string templateFileName, Dosar item);
        response ExportDosarCompletToPdf(string templateFileName, int _id);
        response ExportDosarCompletToPdf(Dosar item);
        response ExportDosarCompletToPdf(int _id);
        void Import(Dosar item, int _import_type);
        response SetDataUltimeiModificari(DateTime data, Dosar item);
        response GetDataUltimeiModificari(Dosar item);
        response GetDosareFromExcel(string sheet, string fileName);
        response GetDosareFromExcel(JObject _json);
        response ImportDosare(response responsesDosare, DateTime _date, int _import_type);
        response ImportDosareDirect(string sheet, string fileName, int _import_type);
        response ImportDosareDirect(JObject _json, int _import_type);
        response ImportDosareWithErrors(response responsesDosareWithErrors, DateTime _date, int _import_type);
        response GetDosareFromLog(DateTime? data);
        response GetImportDates();
        response MovePendingToOk(int _pending_id);
        response UpdateRestPlata(int _id, double? _rest_plata);
        response UpdateSendStatus(int _id, string _send_status);
    }

    public class DosareRepository : IDosareRepository
    {
        private string connectionString;
        private int authenticatedUserId;

        public DosareRepository(int _authenticatedUserId, string _connectionString)
        {
            authenticatedUserId = _authenticatedUserId;
            connectionString = _connectionString;
        }

        public response GetAll()
        {
            try
            {
                DataAccess da = new DataAccess(authenticatedUserId, connectionString, CommandType.StoredProcedure, "DOSAREsp_select", new object[] {
                new MySqlParameter("_SORT", null),
                new MySqlParameter("_ORDER", null),
                new MySqlParameter("_FILTER", null),
                new MySqlParameter("_LIMIT", null) });
                MySqlDataReader r = da.ExecuteSelectQuery();
                /*
                ArrayList aList = new ArrayList();
                while (r.Read())
                {
                    Dosar a = new Dosar(authenticatedUserId, connectionString, (IDataRecord)r);
                    aList.Add(a);
                }
                r.Close(); r.Dispose(); da.CloseConnection();
                Dosar[] toReturn = new Dosar[aList.Count];
                for (int i = 0; i < aList.Count; i++)
                    toReturn[i] = (Dosar)aList[i];
                return new response(true, JsonConvert.SerializeObject(toReturn, CommonFunctions.JsonSerializerSettings), toReturn, null, null);
                */
                List<Dosar> aList = new List<Dosar>();
                while (r.Read())
                {
                    /*
                    Dosar a = new Dosar(authenticatedUserId, connectionString, (IDataRecord)r);
                    aList.Add(a);
                    */
                    aList.Add(new Dosar(authenticatedUserId, connectionString, r));
                }
                r.Close(); r.Dispose(); da.CloseConnection();
                return new response(true, JsonConvert.SerializeObject(aList.ToArray(), CommonFunctions.JsonSerializerSettings), aList.ToArray(), null, null);
            }
            catch (Exception exp) { LogWriter.Log(exp); return new response(false, exp.ToString(), null, null, new List<Error>() { new Error(exp) }); }
        }

        public response CountAll()
        {
            try
            {
                DataAccess da = new DataAccess(authenticatedUserId, connectionString, CommandType.StoredProcedure, "DOSAREsp_count");
                object count = da.ExecuteScalarQuery().Result;
                if(count == null)
                    return new response(true, "0", 0, null, null);
                return new response(true, count.ToString(), Convert.ToInt32(count), null, null);
            }
            catch (Exception exp) { LogWriter.Log(exp); return new response(false, exp.ToString(), null, null, new List<Error>() { new Error(exp) }); }
        }

        public response CountFromLastLogin()
        {
            try
            {
                DataAccess da = new DataAccess(authenticatedUserId, connectionString, CommandType.StoredProcedure, "DOSAREsp_CountFromLastLogin");
                object count = da.ExecuteScalarQuery().Result;
                if (count == null)
                    return new response(true, "0", 0, null, null);
                return new response(true, count.ToString(), Convert.ToInt32(count), null, null);
            }
            catch (Exception exp) { LogWriter.Log(exp); return new response(false, exp.ToString(), null, null, new List<Error>() { new Error(exp) }); }
        }

        public response CountFiltered(string _json)
        {
            JObject jObj = JObject.Parse(_json);
            return CountFiltered(jObj);
        }

        public response CountFiltered(JObject _json)
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
                            //f.Sort = CommonFunctions.IsNullOrEmpty(j) ? null : JsonConvert.SerializeObject(j, CommonFunctions.JsonSerializerSettings);
                            f.Sort = CommonFunctions.IsNullOrEmpty(j) ? null : j.ToString();
                            break;
                        case "order":
                            //f.Order = CommonFunctions.IsNullOrEmpty(j) ? null : JsonConvert.SerializeObject(j, CommonFunctions.JsonSerializerSettings);
                            f.Order = CommonFunctions.IsNullOrEmpty(j) ? null : j.ToString();
                            break;
                        case "filter":
                            f.Filtru = CommonFunctions.IsNullOrEmpty(j) ? null : JsonConvert.SerializeObject(j, CommonFunctions.JsonSerializerSettings);
                            break;
                        case "limit":
                            //f.Limit = CommonFunctions.IsNullOrEmpty(j) ? null : JsonConvert.SerializeObject(j, CommonFunctions.JsonSerializerSettings);
                            f.Limit = CommonFunctions.IsNullOrEmpty(j) ? null : j.ToString();
                            break;
                    }
                }
                return CountFiltered(f.Sort, f.Order, f.Filtru, f.Limit);
            }
            catch (Exception exp) { LogWriter.Log(exp); return new response(false, exp.ToString(), null, null, new List<Error>() { new Error(exp) }); }
        }

        public response CountFiltered(string _sort, string _order, string _filter, string _limit)
        {
            try
            {
                try
                {
                    string newFilter = Filtering.GenerateFilterFromJsonObject(typeof(Dosar), _filter, authenticatedUserId, connectionString);
                    _filter = (newFilter == null || newFilter.Trim() == "") && !_filter.IsValidJson() ? _filter : String.IsNullOrWhiteSpace(newFilter) ? null : newFilter;
                }
                catch { }
                DataAccess da = new DataAccess(authenticatedUserId, connectionString, CommandType.StoredProcedure, "DOSAREsp_CountFiltered", new object[] {
                new MySqlParameter("_SORT", _sort),
                new MySqlParameter("_ORDER", _order),
                new MySqlParameter("_FILTER", _filter),
                new MySqlParameter("_LIMIT", _limit) });
                return da.ExecuteScalarQuery();
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
                foreach(var t in _json)
                {
                    JToken j = t.Value;
                    switch (t.Key.ToLower())
                    {
                        case "sort":
                            //f.Sort = CommonFunctions.IsNullOrEmpty(j) ? null : JsonConvert.SerializeObject(j, CommonFunctions.JsonSerializerSettings);
                            f.Sort = CommonFunctions.IsNullOrEmpty(j) ? null : j.ToString();
                            break;
                        case "order":
                            //f.Order = CommonFunctions.IsNullOrEmpty(j) ? null : JsonConvert.SerializeObject(j, CommonFunctions.JsonSerializerSettings);
                            f.Order = CommonFunctions.IsNullOrEmpty(j) ? null : j.ToString();
                            break;
                        case "filter":
                            f.Filtru = CommonFunctions.IsNullOrEmpty(j) ? null : JsonConvert.SerializeObject(j, CommonFunctions.JsonSerializerSettings);
                            break;
                        case "limit":
                            //f.Limit = CommonFunctions.IsNullOrEmpty(j) ? null : JsonConvert.SerializeObject(j, CommonFunctions.JsonSerializerSettings);
                            f.Limit = CommonFunctions.IsNullOrEmpty(j) ? null : j.ToString();
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
                    string newFilter = Filtering.GenerateFilterFromJsonObject(typeof(Dosar), _filter, authenticatedUserId, connectionString);
                    _filter = (newFilter == null || newFilter.Trim() == "") && !_filter.IsValidJson() ? _filter : String.IsNullOrWhiteSpace(newFilter) ? null : newFilter;
                }
                catch { }
                DataAccess da = new DataAccess(authenticatedUserId, connectionString, CommandType.StoredProcedure, "DOSAREsp_select", new object[] {
                new MySqlParameter("_SORT", _sort),
                new MySqlParameter("_ORDER", _order),
                new MySqlParameter("_FILTER", _filter),
                new MySqlParameter("_LIMIT", _limit) });
                MySqlDataReader r = da.ExecuteSelectQuery();
                /*
                ArrayList aList = new ArrayList();
                while (r.Read())
                {
                    Dosar a = new Dosar(authenticatedUserId, connectionString, (IDataRecord)r);
                    aList.Add(a);
                }
                r.Close(); r.Dispose(); da.CloseConnection();
                Dosar[] toReturn = new Dosar[aList.Count];
                for (int i = 0; i < aList.Count; i++)
                    toReturn[i] = (Dosar)aList[i];
                return new response(true, JsonConvert.SerializeObject(toReturn, CommonFunctions.JsonSerializerSettings), toReturn, null, null);
                */
                List<Dosar> aList = new List<Dosar>();
                while (r.Read())
                {
                    Dosar a = new Dosar(authenticatedUserId, connectionString, (IDataRecord)r);
                    aList.Add(a);
                }
                r.Close(); r.Dispose(); da.CloseConnection();
                return new response(true, JsonConvert.SerializeObject(aList.ToArray(), CommonFunctions.JsonSerializerSettings), aList.ToArray(), null, null);
            }
            catch (Exception exp) { LogWriter.Log(exp); return new response(false, exp.ToString(), null, null, new List<Error>() { new Error(exp) }); }
        }

        public response Find(int _id)
        {
            try
            {
                Dosar item = new Dosar(authenticatedUserId, connectionString, _id);
                return new response(true, JsonConvert.SerializeObject(item, CommonFunctions.JsonSerializerSettings), item, null, null); ;
            }
            catch (Exception exp) { LogWriter.Log(exp); return new response(false, exp.ToString(), null, null, new List<Error>() { new Error(exp) }); }

        }

        public response Insert(Dosar item)
        {
            return item.Insert();
        }

        public response InsertWithErrors(Dosar item)
        {
            return item.InsertWithErrors();
        }

        public response Update(Dosar item)
        {
            return item.Update();
        }

        public response UpdateWithErrors(Dosar item)
        {
            return item.UpdateWithErrors();
        }

        public response Update(int id, string fieldValueCollection)
        {
            //Dosar item = JsonConvert.DeserializeObject<Dosar>(Find(id).Message);
            Dosar item = (Dosar)(Find(id).Result);
            return item.Update(fieldValueCollection);
        }

        public response Update(string fieldValueCollection)
        {
            Dosar tmpItem = JsonConvert.DeserializeObject<Dosar>(fieldValueCollection, CommonFunctions.JsonDeserializerSettings); // sa vedem daca merge asa sau trebuie cu JObject
            //return JsonConvert.DeserializeObject<Dosar>(Find(Convert.ToInt32(tmpItem.ID)).Message).Update(fieldValueCollection);
            return ((Dosar)(Find(Convert.ToInt32(tmpItem.ID)).Result)).Update(fieldValueCollection);
        }

        public response Avizare(Dosar item, string _avizat)
        {
            return item.Avizare(_avizat);
        }

        public response Avizare(int _id, string _avizat)
        {
            Dosar item = (Dosar)(Find(_id).Result);
            return item.Avizare(_avizat);
        }

        public response Delete(Dosar item)
        {
            return item.Delete();
        }

        public response DeleteWithErrors(Dosar item)
        {
            return item.DeleteWithErrors();
        }
        public response HasChildrens(Dosar item, string tableName)
        {
            return item.HasChildrens(tableName);
        }

        public response HasChildren(Dosar item, string tableName, int childrenId)
        {
            return item.HasChildren(tableName, childrenId);
        }

        public response GetChildrens(Dosar item, string tableName)
        {
            return item.GetChildrens(tableName);
        }

        public response GetChildren(Dosar item, string tableName, int childrenId)
        {
            return item.GetChildren(tableName, childrenId);
        }

        public response Delete(int _id)
        {
            response obj = Find(_id);
            //return JsonConvert.DeserializeObject<Dosar>(obj.Message).Delete();
            return ((Dosar)obj.Result).Delete();
        }

        public response HasChildrens(int _id, string tableName)
        {
            var obj = Find(_id);
            //return JsonConvert.DeserializeObject<Dosar>(obj.Message).HasChildrens(tableName);
            return ((Dosar)obj.Result).HasChildrens(tableName);
        }
        public response HasChildren(int _id, string tableName, int childrenId)
        {
            var obj = Find(_id);
            //return JsonConvert.DeserializeObject<Dosar>(obj.Message).HasChildren(tableName, childrenId);
            return ((Dosar)obj.Result).HasChildren(tableName, childrenId);
        }
        public response GetChildrens(int _id, string tableName)
        {
            var obj = Find(_id);
            //return JsonConvert.DeserializeObject<Dosar>(obj.Message).GetChildrens(tableName);
            return ((Dosar)obj.Result).GetChildrens(tableName);
        }
        public response GetChildren(int _id, string tableName, int childrenId)
        {
            var obj = Find(_id);
            //return JsonConvert.DeserializeObject<Dosar>(obj.Message).GetChildren(tableName, childrenId);
            return ((Dosar)obj.Result).GetChildren(tableName, childrenId);
        }

        public response GetMesaje(Dosar item)
        {
            return item.GetMesaje();
        }
        public response GetUtilizatori(Dosar item)
        {
            return item.GetUtilizatori();
        }
        public response GetSocietateCasco(Dosar item)
        {
            return item.GetSocietateCasco();
        }
        public response GetSocietateRca(Dosar item)
        {
            return item.GetSocietateRca();
        }
        public response GetAutoCasco(Dosar item)
        {
            return item.GetAutoCasco();
        }
        public response GetAutoRca(Dosar item)
        {
            return item.GetAutoRca();
        }
        public response GetAsiguratCasco(Dosar item)
        {
            return item.GetAsiguratCasco();
        }
        public response GetAsiguratRca(Dosar item)
        {
            return item.GetAsiguratRca();
        }
        public response GetIntervenient(Dosar item)
        {
            return item.GetIntervenient();
        }
        public response GetDocumente(Dosar item)
        {
            return item.GetDocumente();
        }

        public response GetProcese(Dosar item)
        {
            return item.GetProcese();
        }

        public response GetTipDosar(Dosar item)
        {
            return item.GetTipDosar();
        }

        public response ExportDocumenteDosarToPdf(Dosar item)
        {
            return item.ExportDocumenteDosarToPdf();
        }
        public response ExportDocumenteDosarToPdf(int _id)
        {
            //return JsonConvert.DeserializeObject<Dosar>(Find(_id).Message).ExportDocumenteDosarToPdf();
            return ((Dosar)(Find(_id).Result)).ExportDocumenteDosarToPdf();
        }
        public response ExportDosarToPdf(string templateFileName, Dosar item)
        {
            return item.ExportDosarToPdf(templateFileName);
        }
        public response ExportDosarToPdf(string templateFileName, int _id)
        {
            //return JsonConvert.DeserializeObject<Dosar>(Find(_id).Message).ExportDosarToPdf(templateFileName);
            return ((Dosar)(Find(_id).Result)).ExportDosarToPdf(templateFileName);
        }
        public response ExportDosarToPdf(int _id)
        {
            Dosar item = (Dosar)Find(_id).Result;
            string template = item.GetTemplateName();
            return item.ExportDosarToPdf(template);
        }

        public response ExportDosarCompletToPdf(string templateFileName, Dosar item)
        {
            return item.ExportDosarCompletToPdf(templateFileName);
        }
        public response ExportDosarCompletToPdf(Dosar item)
        {
            string template = item.GetTemplateName();
            return item.ExportDosarCompletToPdf(template);
        }

        public response ExportDosarCompletToPdf(string templateFileName, int _id)
        {
            //return JsonConvert.DeserializeObject<Dosar>(Find(_id).Message).ExportDosarCompletToPdf(templateFileName);
            return ((Dosar)(Find(_id).Result)).ExportDosarCompletToPdf(templateFileName);
        }
        public response ExportDosarCompletToPdf(int _id)
        {
            Dosar d = (Dosar)(Find(_id).Result);
            string template = d.GetTemplateName();
            return d.ExportDosarCompletToPdf(template);
        }
        public void Import(Dosar item, int _import_type)
        {
            item.Import(_import_type);
        }
        public response SetDataUltimeiModificari(DateTime data, Dosar item)
        {
            return item.SetDataUltimeiModificari(data);
        }
        public response GetDataUltimeiModificari(Dosar item)
        {
            return item.GetDataUltimeiModificari();
        }
        public response GetInvolvedParties(Dosar item)
        {
            return item.GetInvolvedParties();
        }
        public response GetMaxNrSca()
        {
            try
            {
                DataAccess da = new DataAccess(authenticatedUserId, connectionString, CommandType.StoredProcedure, "DOSAREsp_GetMaxNrSca");
                /*
                int curMax = Convert.ToInt32(da.ExecuteScalarQuery().Result);
                return new response(true, (curMax + 1).ToString(), curMax + 1, null, null);
                */
                return da.ExecuteScalarQuery();
            }
            catch (Exception exp) { LogWriter.Log(exp); return new response(false, exp.ToString(), null, null, new List<Error>() { new Error(exp) }); }
        }

        public response ImportDosareDirect(string sheet, string fileName, int _import_type)
        {
            response r = GetDosareFromExcel(sheet, fileName);
            return ImportAll(r, DateTime.Now, _import_type);
        }

        public response ImportDosareDirect (JObject _json, int _import_type)
        {
            response r = GetDosareFromExcel(_json);
            return ImportAll(r, DateTime.Now, _import_type);
        }

        /// <summary>
        /// Metoda pentru incarcarea vectorului de Dosare din fisierul Excel de importat
        /// </summary>
        /// <param name="sheet">Denumirea Sheet-ului din fisierul Excel in care se gasesc Dosarele de importat</param>
        /// <param name="fileName">Denumirea completa a fisierului cu Dosarele de importat</param>
        /// <returns>vector de {SOCISA.response, SOCISA.DosareJson}</returns>
        public response GetDosareFromExcel(string sheet, string fileName)
        {
            try
            {
                DosareRepository dr = new DosareRepository(authenticatedUserId, connectionString);
                int _MAX_NR_SCA = Convert.ToInt32(dr.GetMaxNrSca().Result.ToString());

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
                for (var rowNumber = 2; rowNumber <= ews.Dimension.End.Row; rowNumber++)
                {
                    try
                    {
                        response toReturn = new response(true, "", null, null, new List<Error>()); ;
                        response r = new response();

                        Asigurat asigCasco = new Asigurat(authenticatedUserId, connectionString);
                        Asigurat asigRca = new Asigurat(authenticatedUserId, connectionString);
                        SocietateAsigurare sCasco = new SocietateAsigurare(authenticatedUserId, connectionString);
                        SocietateAsigurare sRca = new SocietateAsigurare(authenticatedUserId, connectionString);
                        Intervenient intervenient = new Intervenient(authenticatedUserId, connectionString);
                        Auto autoCasco = new Auto(authenticatedUserId, connectionString);
                        Auto autoRca = new Auto(authenticatedUserId, connectionString);
                        Nomenclator tipDosar = new Nomenclator(authenticatedUserId, connectionString, "tip_dosare");
                        Dosar dosar = new Dosar(authenticatedUserId, connectionString);
                        DosarExtended dosarExtended = new DosarExtended();
                        Nomenclator tipCaz = new Nomenclator(authenticatedUserId, connectionString, "tip_caz");

                        try
                        {
                            try
                            {
                                asigCasco = new Asigurat(authenticatedUserId, connectionString, ews.Cells[rowNumber, columnNames["Asigurat CASCO"]].Text.Trim());
                                asigCasco = asigCasco.ID == null ? null : asigCasco;
                            }
                            catch { asigCasco = null; }
                            if ((asigCasco == null || asigCasco.ID == null) && columnNames.ContainsKey("Asigurat CASCO"))
                            {
                                asigCasco = new Asigurat(authenticatedUserId, connectionString);
                                asigCasco.DENUMIRE = ews.Cells[rowNumber, columnNames["Asigurat CASCO"]].Text.Trim();
                                r = asigCasco.Insert();
                                if (r.Status && r.InsertedId != null)
                                {
                                    asigCasco.ID = r.InsertedId;
                                }
                                else
                                {
                                    toReturn.AddResponse(r);
                                }
                            }
                            dosar.ID_ASIGURAT_CASCO = asigCasco.ID;
                        }
                        catch
                        {
                            Error err = ErrorParser.ErrorMessage("couldNotInsertAsiguratCasco");
                            List<Error> errs = new List<Error>();
                            errs.Add(err);
                            r = new response(false, err.ERROR_MESSAGE, null, null, errs);
                            toReturn.AddResponse(r);
                        }
                        dosarExtended.AsiguratCasco = asigCasco;

                        try
                        {
                            try
                            {
                                asigRca = new Asigurat(authenticatedUserId, connectionString, ews.Cells[rowNumber, columnNames["Asigurat RCA"]].Text.Trim());
                                asigRca = asigRca.ID == null ? null : asigRca;
                            }
                            catch { asigRca = null; }
                            if ((asigRca == null || asigRca.ID == null) && columnNames.ContainsKey("Asigurat RCA"))
                            {
                                asigRca = new Asigurat(authenticatedUserId, connectionString);
                                asigRca.DENUMIRE = ews.Cells[rowNumber, columnNames["Asigurat RCA"]].Text.Trim();
                                r = asigRca.Insert();
                                /*
                                if (r.Status && r.InsertedId != null)
                                {
                                    asigRca.ID = r.InsertedId;
                                }
                                else
                                {
                                    toReturn.AddResponse(r);
                                }
                                */
                                asigRca.ID = r.InsertedId;
                            }
                            dosar.ID_ASIGURAT_RCA = asigRca.ID;
                        }
                        catch
                        {
                            /*
                            Error err = ErrorParser.ErrorMessage("couldNotInsertAsiguratRca");
                            List<Error> errs = new List<Error>();
                            errs.Add(err);
                            r = new response(false, err.ERROR_MESSAGE, null, null, errs);
                            toReturn.AddResponse(r);
                            */
                        }
                        dosarExtended.AsiguratRca = asigRca;

                        try
                        {
                            if (String.IsNullOrWhiteSpace(ews.Cells[rowNumber, columnNames["Asigurator CASCO"]].Text.Trim()))
                            {
                                dosar.ID_SOCIETATE_CASCO = null;
                            }
                            else
                            {
                                try
                                {
                                    //sCasco = new SocietateAsigurare(authenticatedUserId, connectionString, ews.Cells[rowNumber, columnNames["Asigurator CASCO"]].Text.Trim(), true);
                                    sCasco = new SocietateAsigurare(authenticatedUserId, connectionString, ews.Cells[rowNumber, columnNames["Asigurator CASCO"]].Text.Trim(), null);
                                    sCasco = sCasco.ID == null ? null : sCasco;
                                }
                                catch { sCasco = null; }
                                if ((sCasco == null || sCasco.ID == null) && columnNames.ContainsKey("Asigurator CASCO"))
                                {
                                    if (!dosarExtended.selected) { // folosim campul "selected" pentru confiormarea erorilor)
                                        /* aici trebuie sa confirme ca vrea sa adauge societatea noua */
                                        Error err = ErrorParser.ErrorMessage("newAsiguratorCasco");
                                        List<Error> errs = new List<Error>();
                                        errs.Add(err);
                                        r = new response(false, err.ERROR_MESSAGE, null, null, errs);
                                        toReturn.AddResponse(r);
                                        sCasco = new SocietateAsigurare(authenticatedUserId, connectionString);
                                        sCasco.DENUMIRE_SCURTA = sCasco.DENUMIRE = ews.Cells[rowNumber, columnNames["Asigurator CASCO"]].Text.Trim();
                                        /**/
                                    }
                                    else {
                                        sCasco = new SocietateAsigurare(authenticatedUserId, connectionString);
                                        sCasco.DENUMIRE_SCURTA = sCasco.DENUMIRE = ews.Cells[rowNumber, columnNames["Asigurator CASCO"]].Text.Trim();
                                        r = sCasco.Insert();
                                        if (r.Status && r.InsertedId != null)
                                        {
                                            sCasco.ID = r.InsertedId;
                                        }
                                        else
                                        {
                                            toReturn.AddResponse(r);
                                        }
                                    }
                                }
                                dosar.ID_SOCIETATE_CASCO = sCasco.ID;
                            }
                        }
                        catch
                        {
                            Error err = ErrorParser.ErrorMessage("couldNotInsertAsiguratorCasco");
                            List<Error> errs = new List<Error>();
                            errs.Add(err);
                            r = new response(false, err.ERROR_MESSAGE, null, null, errs);
                            toReturn.AddResponse(r);
                        }
                        dosarExtended.SocietateCasco = sCasco;

                        try
                        {
                            if (String.IsNullOrWhiteSpace(ews.Cells[rowNumber, columnNames["Asigurator RCA"]].Text.Trim()))
                            {
                                dosar.ID_SOCIETATE_RCA = null;
                            }
                            else
                            {
                                try
                                {
                                    //sRca = new SocietateAsigurare(authenticatedUserId, connectionString, ews.Cells[rowNumber, columnNames["Asigurator RCA"]].Text.Trim(), true);
                                    sRca = new SocietateAsigurare(authenticatedUserId, connectionString, ews.Cells[rowNumber, columnNames["Asigurator RCA"]].Text.Trim(), null);
                                    sRca = sRca.ID == null ? null : sRca;
                                }
                                catch { sRca = null; }
                                if ((sRca == null || sRca.ID == null) && columnNames.ContainsKey("Asigurator RCA"))
                                {
                                    if (!dosarExtended.selected)
                                    { // folosim campul "selected" pentru confiormarea erorilor)
                                        /* aici trebuie sa confirme ca vrea sa adauge societatea noua */
                                        Error err = ErrorParser.ErrorMessage("newAsiguratorRca");
                                        List<Error> errs = new List<Error>();
                                        errs.Add(err);
                                        r = new response(false, err.ERROR_MESSAGE, null, null, errs);
                                        toReturn.AddResponse(r);
                                        sRca = new SocietateAsigurare(authenticatedUserId, connectionString);
                                        sRca.DENUMIRE_SCURTA = sRca.DENUMIRE = ews.Cells[rowNumber, columnNames["Asigurator RCA"]].Text.Trim();
                                        /**/
                                    }
                                    else
                                    {
                                        sRca = new SocietateAsigurare(authenticatedUserId, connectionString);
                                        sRca.DENUMIRE_SCURTA = sRca.DENUMIRE = ews.Cells[rowNumber, columnNames["Asigurator RCA"]].Text.Trim();
                                        r = sRca.Insert();
                                        if (r.Status && r.InsertedId != null)
                                        {
                                            sRca.ID = r.InsertedId;
                                        }
                                        else
                                        {
                                            toReturn.AddResponse(r);
                                        }
                                    }
                                }
                                dosar.ID_SOCIETATE_RCA = sRca.ID;
                            }
                        }
                        catch
                        {
                            Error err = ErrorParser.ErrorMessage("couldNotInsertAsiguratorRca");
                            List<Error> errs = new List<Error>();
                            errs.Add(err);
                            r = new response(false, err.ERROR_MESSAGE, null, null, errs);
                            toReturn.AddResponse(r);
                        }
                        dosarExtended.SocietateRca = sRca;

                        try
                        {
                            if (String.IsNullOrWhiteSpace(ews.Cells[rowNumber, columnNames["Auto CASCO"]].Text.Trim()))
                            {
                                dosar.ID_AUTO_CASCO = null;
                            }
                            else
                            {
                                try
                                {
                                    autoCasco = new Auto(authenticatedUserId, connectionString, ews.Cells[rowNumber, columnNames["Auto CASCO"]].Text.Trim());
                                    autoCasco = autoCasco.ID == null ? null : autoCasco;
                                }
                                catch { autoCasco = null; }
                                if ((autoCasco == null || autoCasco.ID == null) && columnNames.ContainsKey("Auto CASCO"))
                                {
                                    autoCasco = new Auto(authenticatedUserId, connectionString);
                                    autoCasco.NR_AUTO = ews.Cells[rowNumber, columnNames["Auto CASCO"]].Text.Trim();
                                    autoCasco.SERIE_SASIU = ews.Cells[rowNumber, columnNames["Serie sasiu CASCO"]].Text.Trim();
                                    r = autoCasco.Insert();
                                    if (r.Status && r.InsertedId != null)
                                    {
                                        autoCasco.ID = r.InsertedId;
                                    }
                                    else
                                    {
                                        toReturn.AddResponse(r);
                                    }
                                }
                                dosar.ID_AUTO_CASCO = autoCasco.ID;
                            }
                        }
                        catch
                        {
                            Error err = ErrorParser.ErrorMessage("couldNotInsertAutoCasco");
                            List<Error> errs = new List<Error>();
                            errs.Add(err);
                            r = new response(false, err.ERROR_MESSAGE, null, null, errs);
                            toReturn.AddResponse(r);
                        }
                        dosarExtended.AutoCasco = autoCasco;

                        try
                        {
                            if (String.IsNullOrWhiteSpace(ews.Cells[rowNumber, columnNames["Auto RCA"]].Text.Trim()))
                            {
                                dosar.ID_AUTO_RCA = null;
                            }
                            else
                            {
                                try
                                {
                                    autoRca = new Auto(authenticatedUserId, connectionString, ews.Cells[rowNumber, columnNames["Auto RCA"]].Text.Trim());
                                    autoRca = autoRca.ID == null ? null : autoRca;
                                }
                                catch { autoRca = null; }
                                if ((autoRca == null || autoRca.ID == null) && columnNames.ContainsKey("Auto RCA"))
                                {
                                    autoRca = new Auto(authenticatedUserId, connectionString);
                                    autoRca.NR_AUTO = ews.Cells[rowNumber, columnNames["Auto RCA"]].Text.Trim();
                                    autoRca.SERIE_SASIU = ews.Cells[rowNumber, columnNames["Serie sasiu RCA"]].Text.Trim();
                                    r = autoRca.Insert();
                                    if (r.Status && r.InsertedId != null)
                                    {
                                        autoRca.ID = r.InsertedId;
                                    }
                                    else
                                    {
                                        toReturn.AddResponse(r);
                                    }
                                }
                                dosar.ID_AUTO_RCA = autoRca.ID;
                            }
                        }
                        catch
                        {
                            Error err = ErrorParser.ErrorMessage("couldNotInsertAutoRca");
                            List<Error> errs = new List<Error>();
                            errs.Add(err);
                            r = new response(false, err.ERROR_MESSAGE, null, null, errs);
                            toReturn.AddResponse(r);
                        }
                        dosarExtended.AutoRca = autoRca;

                        try
                        {
                            if (String.IsNullOrWhiteSpace(ews.Cells[rowNumber, columnNames["Intervenient"]].Text.Trim()))
                            {
                                dosar.ID_INTERVENIENT = null;
                            }
                            else
                            {
                                try
                                {
                                    intervenient = new Intervenient(authenticatedUserId, connectionString, ews.Cells[rowNumber, columnNames["Intervenient"]].Text.Trim());
                                    intervenient = intervenient.ID == null ? null : intervenient;
                                }
                                catch { intervenient = null; }
                                if ((intervenient == null || intervenient.ID == null) && columnNames.ContainsKey("Intervenient"))
                                {
                                    intervenient = new Intervenient(authenticatedUserId, connectionString);
                                    intervenient.DENUMIRE = ews.Cells[rowNumber, columnNames["Intervenient"]].Text.Trim();
                                    r = intervenient.Insert();
                                    intervenient.ID = r.InsertedId;
                                }
                                dosar.ID_INTERVENIENT = intervenient.ID;
                            }
                        }
                        catch
                        {
                            /*
                            Error err = ErrorParser.ErrorMessage("couldNotInsertIntervenient");
                            List<Error> errs = new List<Error>();
                            errs.Add(err);
                            r = new response(false, err.ERROR_MESSAGE, null, errs);
                            toReturn.AddResponse(r);
                            */
                        }
                        dosarExtended.Intervenient = intervenient;

                        try
                        {
                            tipCaz = new Nomenclator(authenticatedUserId, connectionString, "tip_caz", ews.Cells[rowNumber, columnNames["CAZ"]].Text.Trim());
                            tipCaz = tipCaz.ID == null ? null : tipCaz;
                        }
                        catch { tipCaz = null; }

                        try
                        {
                            tipDosar = new Nomenclator(authenticatedUserId, connectionString, "tip_dosare", ews.Cells[rowNumber, columnNames["Tip dosar"]].Text.Trim());
                            tipDosar = tipDosar.ID == null ? null : tipDosar;
                        }
                        catch { tipDosar = null; }
                        dosarExtended.TipDosar = tipDosar;

                        try { dosar.NR_DOSAR_CASCO = ews.Cells[rowNumber, columnNames["Nr. CASCO"]].Text.Trim(); }
                        catch { }
                        try { dosar.INSTANTA = Convert.ToBoolean(ews.Cells[rowNumber, columnNames["Instanta"]].Text.Trim()); }
                        catch { }
                        try { dosar.NR_SCA = ews.Cells[rowNumber, columnNames["Nr. SCA"]].Text.Trim(); }
                        catch {
                            try
                            {
                                _MAX_NR_SCA += 1;
                                dosar.NR_SCA = _MAX_NR_SCA.ToString();
                            }
                            catch { }
                        }
                        try
                        {
                            //if (!String.IsNullOrWhiteSpace(ews.Cells[rowNumber, columnNames["Data SCA"]].Text))
                            if (!String.IsNullOrWhiteSpace(ews.Cells[rowNumber, columnNames["Data SCA"]].GetValue<String>().Trim().Split(' ')[0]))
                            {
                                //dosar.DATA_SCA = CommonFunctions.SwitchBackFormatedDate(ews.Cells[rowNumber, columnNames["Data SCA"]].Text.Trim());
                                dosar.DATA_SCA = CommonFunctions.SwitchBackFormatedDate(ews.Cells[rowNumber, columnNames["Data SCA"]].GetValue<String>().Trim());
                            }
                            else
                            {
                                dosar.DATA_SCA = DateTime.Now.Date;
                            }
                        }
                        catch
                        {
                            dosar.DATA_SCA = DateTime.Now.Date;
                        }
                        try { dosar.NR_POLITA_CASCO = ews.Cells[rowNumber, columnNames["Polita CASCO"]].Text.Trim(); }
                        catch { }
                        try { dosar.NR_POLITA_RCA = ews.Cells[rowNumber, columnNames["Polita RCA"]].Text.Trim(); }
                        catch { }

                        //try { dosar.DATA_EVENIMENT = CommonFunctions.SwitchBackFormatedDate(ews.Cells[rowNumber, columnNames["Data CASCO"]].Text.Trim()); }
                        try {
                            dosar.DATA_EVENIMENT = CommonFunctions.SwitchBackFormatedDate(ews.Cells[rowNumber, columnNames["Data CASCO"]].GetValue<String>().Trim().Split(' ')[0]);
                        }
                        catch { dosar.DATA_EVENIMENT = null; }
                        if (dosar.DATA_EVENIMENT == null)
                        {
                            Error err = ErrorParser.ErrorMessage("emptyDataEveniment");
                            List<Error> errs = new List<Error>();
                            errs.Add(err);
                            r = new response(false, err.ERROR_MESSAGE, null, null, errs);
                            toReturn.AddResponse(r);
                        }

                        try { dosar.VALOARE_DAUNA = CommonFunctions.BackDoubleValue(ews.Cells[rowNumber, columnNames["Valoare dauna"]].Text.Trim()); }
                        catch { }
                        try { dosar.VALOARE_REGRES = CommonFunctions.BackDoubleValue(ews.Cells[rowNumber, columnNames["Valoare Regres"]].Text.Trim()); }
                        catch { }
                        try { dosar.REZERVA_DAUNA = CommonFunctions.BackDoubleValue(ews.Cells[rowNumber, columnNames["Valoare dauna"]].Text.Trim()); }
                        catch { }
                        try { dosar.SUMA_IBNR = CommonFunctions.BackDoubleValue(ews.Cells[rowNumber, columnNames["Valoare dauna"]].Text.Trim()); }
                        catch { }
                        try { dosar.CAZ = tipCaz.DENUMIRE; }
                        catch { }
                        try { dosar.ID_TIP_DOSAR = tipDosar.ID; }
                        catch { }

                        /*
                        try { dosar.OBSERVATII = dr["OBSERVATII"].ToString(); }
                        catch { }                    
                        try { dosar.DATA_AVIZARE = CommonFunctions.SwitchBackFormatedDate(dr["DATA_AVIZARE"].ToString()); }
                        catch { }
                        try { dosar.DATA_IESIRE_CASCO = CommonFunctions.SwitchBackFormatedDate(dr["DATA_IESIRE_CASCO"].ToString()); }
                        catch { }
                        try { dosar.DATA_INTRARE_RCA = CommonFunctions.SwitchBackFormatedDate(dr["DATA_INTRARE_RCA"].ToString()); }
                        catch { }
                        try { dosar.DATA_NOTIFICARE = CommonFunctions.SwitchBackFormatedDate(dr["DATA_NOTIFICARE"].ToString()); }
                        catch { }
                        try { dosar.NR_DOSAR_CASCO = dr["NR_DOSAR_CASCO"].ToString(); }
                        catch { }
                        try { dosar.NR_IESIRE_CASCO = dr["NR_IESIRE_CASCO"].ToString(); }
                        catch { }
                        try { dosar.NR_INTRARE_RCA = dr["NR_INTRARE_RCA"].ToString(); }
                        catch { }
                        try { dosar.VMD = CommonFunctions.BackDoubleValue(dr["VMD"]); }
                        catch { }
                        */

                        // verificare daca exista dosarul in baza de date sau a mai fost importat si adaugare mesaj in errorlist ....
                        dosarExtended.Dosar = dosar;
                        r = dosar.Validare();
                        if (!r.Status)
                        {
                            toReturn.AddResponse(r);
                        }
                        //pt. cazul in care avem duplicate nr_dosar_casco in excel si dosarele nu sunt inca in baza de date !
                        for(int i = 0; i < toReturnList.Count; i++)
                        {
                            if(((DosarExtended)toReturnList[i][1]).Dosar.NR_DOSAR_CASCO == dosar.NR_DOSAR_CASCO)
                            {
                                Error err = new Error();
                                response nr = new response(false, null, null, null, new List<Error>());
                                nr.Status = false;
                                err = ErrorParser.ErrorMessage("dosarExistent");
                                nr.Message = string.Format("{0}{1};", nr.Message == null ? "" : nr.Message, err.ERROR_MESSAGE);
                                nr.InsertedId = null;
                                nr.Error.Add(err);
                                toReturn.AddResponse(nr);
                                break;
                            }
                        }

                        toReturnList.Add(new object[] { toReturn, dosarExtended });
                    }
                    catch(Exception exp) {
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

        public response GetDosareFromExcel(JObject _json)
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
                return GetDosareFromExcel(sheet, fileName);
            }
            catch (Exception exp)
            {
                LogWriter.Log(exp);
                return new response(false, exp.Message, null, null, new List<Error>() { new Error(exp) });
            }
        }

        public response ImportAll(response responsesDosare, DateTime _date, int _import_type)
        {
            try
            {
                List<object[]> toReturnList = new List<object[]>();
                foreach (object[] responseDosar in (object[])responsesDosare.Result)
                {
                    DosarExtended dosarExtended = (DosarExtended)responseDosar[1];
                    response response = (response)responseDosar[0];
                    response r = new response();
                    if (response.Status)
                    {
                        r = dosarExtended.Dosar.Insert();
                        if (!r.Status)
                            response.Status = false;
                    }
                    else
                    {
                        r = dosarExtended.Dosar.InsertWithErrors();
                        response.Status = false;
                    }
                    response.InsertedId = r.InsertedId;
                    dosarExtended.Dosar.Log(response, _date, _import_type);
                    toReturnList.Add(new object[] { response, dosarExtended });
                }
                return new response(true, JsonConvert.SerializeObject(toReturnList.ToArray(), CommonFunctions.JsonSerializerSettings), toReturnList.ToArray(), null, null);
            }
            catch (Exception exp)
            {
                LogWriter.Log(exp);
                return new response(false, exp.Message, null, null, new List<Error>() { new Error(exp) });
            }
        }

        /// <summary>
        /// Metoda pentru importul Dosarelor in baza de date
        /// </summary>
        /// <param name="dosare">vector de SOCISA.DosareJson cu Dosarele de importat</param>
        /// <returns>vector de {SOCISA.response, SOCISA.DosareJson}</returns>
        public response ImportDosare(response responsesDosare, DateTime _date, int _import_type)
        {
            try
            {
                List<object[]> toReturnList = new List<object[]>();
                foreach (object[] responseDosar in (object[])responsesDosare.Result)
                {
                    DosarExtended dosarExtended = (DosarExtended)responseDosar[1];
                    response response = (response)responseDosar[0];
                    response r = dosarExtended.Dosar.Insert();
                    response.InsertedId = r.InsertedId;
                    dosarExtended.Dosar.Log(response, _date, _import_type);
                    toReturnList.Add(new object[] { response, dosarExtended });
                }
                return new response(true, JsonConvert.SerializeObject(toReturnList.ToArray(), CommonFunctions.JsonSerializerSettings), toReturnList.ToArray(), null, null);
            }catch(Exception exp)
            {
                LogWriter.Log(exp);
                return new response(false, exp.Message, null, null, new List<Error>() { new Error(exp) });
            }
        }

        /// <summary>
        /// Metoda pentru importul Dosarelor cu erori in tabela temporara din baza de date
        /// </summary>
        /// <param name="dosare">vector de SOCISA.DosareJson cu Dosarele de importat</param>
        /// <returns>vector de {SOCISA.response, SOCISA.DosareJson}</returns>
        public response ImportDosareWithErrors(response responsesDosareWithErrors, DateTime _date, int _import_type)
        {
            try
            {
                List<object[]> toReturnList = new List<object[]>();
                foreach (object[] responseDosarWithErrors in (object[])responsesDosareWithErrors.Result)
                {
                    DosarExtended dosarExtended = (DosarExtended)responseDosarWithErrors[1];
                    response response = (response)responseDosarWithErrors[0];
                    response r = dosarExtended.Dosar.InsertWithErrors();
                    response.InsertedId = r.InsertedId;
                    response.Status = false;
                    dosarExtended.Dosar.Log(response, _date, _import_type);
                    toReturnList.Add(new object[] { response, dosarExtended });
                }
                return new response(true, JsonConvert.SerializeObject(toReturnList.ToArray(), CommonFunctions.JsonSerializerSettings), toReturnList.ToArray(), null, null);
            }
            catch (Exception exp)
            {
                LogWriter.Log(exp);
                return new response(false, exp.Message, null, null, new List<Error>() { new Error(exp) });
            }
        }

        /// <summary>
        /// Metoda pentru returnarea Dosarelor importate, din Log-ul salvat in baza de date
        /// </summary>
        /// <param name="data">Data la care s-a facut importul</param>
        /// <returns>vector de obiecte {SOCISA.response, SOCISA.DosareJson}</returns>
        public response GetDosareFromLog(DateTime? data)
        {
            try
            {
                List<object[]> toReturnList = new List<object[]>();
                DataAccess da = new DataAccess(authenticatedUserId, connectionString, CommandType.StoredProcedure, "IMPORT_LOGsp_GetDosare", new object[] { new MySqlParameter("_DATA_IMPORT", data) });
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

                        Dosar dosar = r.Status ? new Dosar(authenticatedUserId, connectionString, Convert.ToInt32(r.InsertedId)) : new Dosar(authenticatedUserId, connectionString, Convert.ToInt32(r.InsertedId), true);
                        DosarExtended de = new DosarExtended(dosar);
                        /*
                        de.Dosar = dosar;
                        de.AsiguratCasco = (Asigurat)dosar.GetAsiguratCasco().Result;
                        de.AsiguratRca = (Asigurat)dosar.GetAsiguratRca().Result;
                        de.AutoCasco = (Auto)dosar.GetAutoCasco().Result;
                        de.AutoRca = (Auto)dosar.GetAutoRca().Result;
                        de.SocietateCasco = (SocietateAsigurare)dosar.GetSocietateCasco().Result;
                        de.SocietateRca = (SocietateAsigurare)dosar.GetSocietateRca().Result;
                        de.Intervenient = (Intervenient)dosar.GetIntervenient().Result;
                        de.TipDosar = (Nomenclator)dosar.GetTipDosar().Result;
                        */
                        //toReturnList.Add(new object[] { r, dosar });
                        toReturnList.Add(new object[] { r, de });
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

        public response GetImportDates()
        {
            try
            {
                DataAccess da = new DataAccess(authenticatedUserId, connectionString, CommandType.StoredProcedure, "DOSAREsp_GetImportDates");
                IDataReader r = da.ExecuteSelectQuery();
                List<string> dates = new List<string>();
                while (r.Read())
                {
                    dates.Add(Convert.ToDateTime( r["DATA_IMPORT"]).ToString("dd.MM.yyyy HH:mm:ss"));
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

        public response MovePendingToOk(int _pending_id)
        {
            Dosar d = new Dosar(authenticatedUserId, connectionString, _pending_id, true);
            response r = d.MovePendingToOk();
            // -- to do - generate message ???
            return r;
        }

        public response UpdateRestPlata(int _id, double? _rest_plata)
        {
            Dosar d = new Dosar(authenticatedUserId, connectionString, _id);
            response r = d.UpdateRestPlata(_rest_plata);
            return r;
        }

        public response UpdateSendStatus(int _id, string _send_status)
        {
            Dosar d = new Dosar(authenticatedUserId, connectionString, _id);
            response r = d.UpdateSendStatus(_send_status);
            return r;
        }

    }
}