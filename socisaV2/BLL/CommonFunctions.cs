﻿using MySql.Data.MySqlClient;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.IO;
using System.Reflection;
using System.Security.Cryptography;
using System.Text;
using Newtonsoft.Json.Linq;
using System.Globalization;
using System.Linq;
using System.ComponentModel;

namespace SOCISA
{
    public static class JsonExtensions
    {
        public static bool IsNullOrEmpty(this JToken token)
        {
            return (token == null) ||
                   (token.Type == JTokenType.Array && !token.HasValues) ||
                   (token.Type == JTokenType.Object && !token.HasValues) ||
                   (token.Type == JTokenType.String && token.ToString() == String.Empty) ||
                   (token.Type == JTokenType.Null);
        }
    }

    public class DoubleSerializerConverter : JsonConverter
    {
        public override bool CanConvert(Type objectType)
        {
            return (objectType == typeof(decimal) ||
                    objectType == typeof(decimal?) ||
                    objectType == typeof(double) ||
                    objectType == typeof(double?) ||
                    objectType == typeof(float) ||
                    objectType == typeof(float?));
        }

        public override object ReadJson(JsonReader reader, Type objectType, object existingValue, JsonSerializer serializer)
        {
            JToken token = JToken.Load(reader);
            if (token.Type == JTokenType.Float || token.Type == JTokenType.Integer)
            {
                return token.ToObject<double>();
            }
            if (token.Type == JTokenType.String)
            {
                try
                {
                    return Double.Parse(token.ToString(), CultureInfo.GetCultureInfo("EN-en"));
                }
                catch
                {
                    return Double.Parse(token.ToString(), CultureInfo.CurrentCulture);
                }
            }
            if (token.Type == JTokenType.Null && objectType == typeof(double?))
            {
                return null;
            }
            throw new JsonSerializationException("Unexpected token type: " + token.Type.ToString());
        }

        public override void WriteJson(JsonWriter writer, object value, JsonSerializer serializer)
        {
            writer.WriteValue(Convert.ToString(value, CultureInfo.CurrentCulture));
        }
    }

    public class DecimalDeserializerConverter : JsonConverter
    {
        public override bool CanConvert(Type objectType)
        {
            return (objectType == typeof(decimal) ||
                    objectType == typeof(decimal?) ||
                    //objectType == typeof(string) ||
                    objectType == typeof(double) ||
                    objectType == typeof(double?) ||
                    objectType == typeof(float) ||
                    objectType == typeof(float?));
        }

        public override object ReadJson(JsonReader reader, Type objectType, object existingValue, JsonSerializer serializer)
        {
            string ot = objectType.ToString().ToLower();
            JToken token = JToken.Load(reader);
            if (token.Type == JTokenType.Float || token.Type == JTokenType.Integer)
            {
                return token.ToObject<decimal>();
            }
            if (token.Type == JTokenType.String)
            {
                try
                {
                    if ((ot.IndexOf("double") > -1 || ot.IndexOf("float") > -1 ) && ot.IndexOf("nullable") < 0)
                    {
                        Double d;
                        d = Double.Parse(token.ToString(), CultureInfo.CurrentCulture);
                        return d;
                    }
                    if ((ot.IndexOf("double") > -1 || ot.IndexOf("float") > -1)  && ot.IndexOf("nullable") > -1)
                    {
                        Double? d;
                        d = Double.Parse(token.ToString(), CultureInfo.CurrentCulture);
                        return d;
                    }
                    if (ot.IndexOf("decimal") > -1 && ot.IndexOf("nullable") < 0)
                    {
                        Decimal d;
                        d = Decimal.Parse(token.ToString(), CultureInfo.CurrentCulture);
                        return d;
                    }
                    if (ot.IndexOf("decimal") > -1 && ot.IndexOf("nullable") > -1)
                    {
                        Decimal? d;
                        d = Decimal.Parse(token.ToString(), CultureInfo.CurrentCulture);
                        return d;
                    }
                }
                catch { return null; }
            }
            if (token.Type == JTokenType.Null && objectType == typeof(decimal?))
            {
                return null;
            }
            throw new JsonSerializationException("Unexpected token type: " + token.Type.ToString());
        }

        public override void WriteJson(JsonWriter writer, object value, JsonSerializer serializer)
        {
            writer.WriteValue(value);
        }
    }

    public struct ThumbNailSize
    {
        public int Width, Height;

        public ThumbNailSize(int _width, int _height)
        {
            Width = _width;
            Height = _height;
        }
    }

    /// <summary>
    /// Summary description for SOCISA.CommonFunctions
    /// </summary>
    public static class CommonFunctions
    {
        public static List<string> STATUS_DOSARE = new List<string>() { "INCOMPLET", "NEAVIZAT", "AVIZAT", "NEACHITAT", "ACHITAT_PARTIAL", "ACHITAT", "COMPENSAT", "PARTIAL_COMPENSAT", "NECOMPENSAT" };

        public static double GetBusinessDays(DateTime startD, DateTime endD)
        {
            double calcBusinessDays =
                1 + ((endD - startD).TotalDays * 5 -
                (startD.DayOfWeek - endD.DayOfWeek) * 2) / 7;

            if (endD.DayOfWeek == DayOfWeek.Saturday) calcBusinessDays--;
            if (startD.DayOfWeek == DayOfWeek.Sunday) calcBusinessDays--;

            return calcBusinessDays;
        }

        public static int ROWS_BLOCK_SIZE
        {
            get
            {
                try
                {
                    string settingsFile = Path.Combine(AppContext.BaseDirectory, "AppSettings.json");
                    string settings = File.ReadAllText(settingsFile);
                    dynamic result = JsonConvert.DeserializeObject(settings);
                    return Convert.ToInt32(result.RowsBlockSize);
                }
                catch (Exception exp)
                {
                    LogWriter.Log(exp);
                    return 50;
                }
            }
        }

        public static JsonSerializerSettings JsonSerializerSettings
        {
            get
            {
                JsonSerializerSettings settings = new JsonSerializerSettings
                {
                    Culture = CultureInfo.CurrentCulture,
                    NullValueHandling = NullValueHandling.Ignore,
                    MissingMemberHandling = MissingMemberHandling.Ignore,
                    Formatting = Formatting.None,
                    DateFormatHandling = DateFormatHandling.IsoDateFormat,
                    Converters = new List<JsonConverter> { new DoubleSerializerConverter() }
                };
                return settings;
            }
        }

        public static JsonSerializerSettings JsonDeserializerSettings
        {
            get
            {
                JsonSerializerSettings settings = new JsonSerializerSettings
                {
                    Culture = CultureInfo.CurrentCulture,
                    NullValueHandling = NullValueHandling.Ignore,
                    MissingMemberHandling = MissingMemberHandling.Ignore,
                    Formatting = Formatting.None,
                    //DateFormatHandling = DateFormatHandling.IsoDateFormat,
                    DateFormatString = CommonFunctions.DATE_FORMAT,
                    Converters = new List<JsonConverter> { new DecimalDeserializerConverter() }
                };
                return settings;
            }
        }

        public static string DATE_FORMAT
        {
            get
            {
                try
                {
                    string settingsFile = Path.Combine(AppContext.BaseDirectory, "AppSettings.json");
                    string settings = File.ReadAllText(settingsFile);
                    dynamic result = JsonConvert.DeserializeObject(settings);
                    return Convert.ToString(result.DateFormat);
                }catch(Exception exp)
                {
                    LogWriter.Log(exp);
                    return "dd.MM.yyyy";
                }
            }
        }

        public static string DATE_TIME_FORMAT
        {
            get
            {
                try
                {
                    string settingsFile = Path.Combine(AppContext.BaseDirectory, "AppSettings.json");
                    string settings = File.ReadAllText(settingsFile);
                    dynamic result = JsonConvert.DeserializeObject(settings);
                    return Convert.ToString(result.DateTimeFormat);
                }
                catch (Exception exp)
                {
                    LogWriter.Log(exp);
                    return "dd.MM.yyyy";
                }
            }
        }

        public static T ConvertValue<T, U>(U value) where U : IConvertible
        {
            return (T)Convert.ChangeType(value, typeof(T));
        }

        public static object ConvertValue(object value, Type T)
        {
            switch (T.Name)
            {
                case "String":
                    return Convert.ToString(value);
                case "DateTime":
                    return Convert.ToDateTime(value);
                case "Int32":
                    return Convert.ToInt32(value);
                case "Boolean":
                    return Convert.ToBoolean(value);
                case "Byte":
                    return Convert.ToByte(value);
                case "Byte[]":
                    return (byte[])value;
                case "Decimal":
                    return Convert.ToDecimal(value);
                case "Double":
                    return Convert.ToDouble(value);
                case "Int16":
                    return Convert.ToInt16(value);
                case "Int64":
                    return Convert.ToInt64(value);
                case "UInt16":
                    return Convert.ToUInt16(value);
                case "UInt32":
                    return Convert.ToUInt32(value);
                case "UInt64":
                    return Convert.ToUInt64(value);
                case "Single":
                    return Convert.ToSingle(value);
                default:
                    return value;
            }
        }

        public static Dictionary<string, string> ClassNamesTableNamesAlliases = new Dictionary<string, string>()
        {
            {"Action", "actions" },
            {"Asigurat","asigurati" },
            {"Auto","auto" },
            {"DocumentScanat","documente_scanate"},
            {"Dosar", "dosare" },
            {"DosarProces","dosare_procese" },
            {"DosarStadiu","dosare_stadii" },
            {"DosarStadiuSentinta", "dosare_stadii_sentinte" },
            {"Drept","drepturi" },
            {"Intervenient", "intervenienti" },
            {"Mesaj","mesaje" },
            {"MesajUtilizator","mesaje_utilizatori" },
            {"Nomenclator","nomenclatoare" },
            {"Proces","procese" },
            {"Sentinta", "sentinte" },
            {"Setare", "setari" },
            {"SocietateAsigurare", "societati_asigurare" },
            {"Stadiu", "stadii" },
            {"Utilizator", "utilizatori" },
            {"UtilizatorAction", "utilizatori_actions" },
            {"UtilizatorDosar", "utilizatori_dosare" },
            {"UtilizatorDrept", "utilizatori_drepturi" },
            {"UtilizatorSetare", "utilizatori_setari" },
            {"UtilizatorSocietateAdministrata", "utilizatori_societati" },
            {"UtilizatorSocietate", "utilizatori_societati" }
        };
        public static IEnumerable<Dictionary<string, object>> Serialize(MySqlDataReader reader)
        {
            var results = new List<Dictionary<string, object>>();
            var cols = new List<string>();
            for (var i = 0; i < reader.FieldCount; i++)
                cols.Add(reader.GetName(i));

            while (reader.Read())
                results.Add(SerializeRow(cols, reader));

            return results;
        }
        private static Dictionary<string, object> SerializeRow(IEnumerable<string> cols, MySqlDataReader reader)
        {
            var result = new Dictionary<string, object>();
            foreach (var col in cols)
                result.Add(col, reader[col]);
            return result;
        }

        public static string DbReaderToJson(MySqlDataReader r)
        {
            var dict = Serialize(r);
            string json = JsonConvert.SerializeObject(dict, Formatting.Indented);
            return json;
        }

        public static string GenerateJsonFromModifiedFields(object OriginalObject, object ModifiedObject)
        {
            string toReturn = "{";
            PropertyInfo[] pis = OriginalObject.GetType().GetProperties();
            foreach (PropertyInfo pi in pis)
            {
                if (pi.Name != "ID" && pi.Name != "FILE_CONTENT" && pi.Name != "SMALL_ICON" && pi.Name != "MEDIUM_ICON")
                {
                    if (pi.GetValue(OriginalObject) != null && pi.GetValue(ModifiedObject) != null)
                    {
                        if (pi.GetValue(OriginalObject).ToString() != pi.GetValue(ModifiedObject).ToString())
                        {
                            toReturn += toReturn.Length > 1 ? "," : "";
                            toReturn += "\"" + pi.Name + "\":";
                            if(pi.PropertyType.Name.ToLower().IndexOf("bool") > -1 || pi.PropertyType.Name.ToLower().IndexOf("int") > -1)
                                toReturn += pi.GetValue(ModifiedObject).ToString().ToLower();
                            else
                                toReturn += "\"" + pi.GetValue(ModifiedObject).ToString() + "\"";
                        }
                    }
                    else
                    {
                        ;
                    }
                }
            }
            toReturn += "}";
            return toReturn;
        }
        public static string ToMySqlFormatDate(DateTime? dt)
        {
            if (dt == null) return null;
            return ToMySqlFormatDate(Convert.ToDateTime(dt));
        }


        public static string ToMySqlFormatDate(DateTime dt)
        {
            return dt.Year + "-" + dt.Month + "-" + dt.Day;
        }

        public static string ToMySqlFormatDateWithTime(DateTime dt)
        {
            return dt.Year + "-" + dt.Month + "-" + dt.Day + " " + dt.Hour + ":" + dt.Minute + ":" + dt.Second;
        }
        public static DateTime FromMySqlFormatDate(string dt)
        {
            try
            {
                string[] dtVals = dt.Split('-');
                return new DateTime(Convert.ToInt32(dtVals[0]), Convert.ToInt32(dtVals[1]), Convert.ToInt32(dtVals[2]));
            }
            catch
            {
                return new DateTime();
            }
        }

        public static DateTime? SwitchBackFormatedDate(string dt)
        {
            if (dt == null) return null;
            DateTime toReturn = new DateTime();
            if (dt.IndexOf('.') > 0)
            {
                try
                {
                    string[] dly = dt.Split('.');
                    //string newDate = dly[1] + "/" + dly[0] + "/" + dly[2];
                    //return Convert.ToDateTime(newDate);
                    return new DateTime(Convert.ToInt32(dly[2]), Convert.ToInt32(dly[1]), Convert.ToInt32(dly[0]));
                }
                catch
                {
                    //return DateTime.Now.Date;
                    return new DateTime();
                }
            }
            else
            {
                try
                {
                    toReturn = Convert.ToDateTime(dt);
                    return toReturn;
                }
                catch
                {
                    //return DateTime.Now.Date;
                    return new DateTime();
                }
            }
            //return new DateTime();
        }

        public static string FromMySqlFormatDate(DateTime dt, string format)
        {
            //return dt.Day + separator + dt.Month + separator + dt.Year;
            return dt.ToString(format);
        }

        public static object DoubleParameterValue(object _value)
        {
            double toReturn = 0;
            try
            {
                if (_value.ToString().Trim() != "")
                {
                    toReturn = Convert.ToDouble(_value);
                    return toReturn;
                }
                return null;
            }
            catch { return null; }
        }

        /*
        public static MySqlParameter SetNull(DbColumn _dc, MySqlParameter _initialParam, object _initialValue)
        {
            MySqlParameter _newParam = _initialParam;
            if (Convert.ToBoolean(_dc.AllowDBNull) && _initialValue.ToString().Trim() == "")
                _newParam.Value = null;
            return _newParam;
        }
        */
        public static MySqlParameter SetNull(MySqlParameter _initialParam)
        {
            MySqlParameter _newParam = _initialParam;
            if (_initialParam.Value != null && (_initialParam.Value.ToString().Trim() == "" || _initialParam.Value.ToString() == "1-1-1"))
                _newParam.Value = null;
            return _newParam;
        }

        public static int GetDbReaderRowCount(MySqlDataReader r)
        {
            int counter = 0;
            while (r.Read())
            {
                counter++;
            }
            return counter;
        }

        public static bool HasRight(object _dictionary, string _right)
        {
            try
            {
                Dictionary<string, string> UserRights = (Dictionary<string, string>)_dictionary;
                try
                {
                    if (UserRights["administrare"] != null) return true;
                }
                catch { }
                if (UserRights[_right.ToLower()] != null) return true;
                else return false;
            }
            catch (Exception exp)
            {
                exp.ToString();
                return false;
            }
        }

        public static string DoubleValue(string _value)
        {
            //return _value.Replace(",", "");
            return Convert.ToString(_value, CultureInfo.CurrentCulture);
        }

        public static double? BackDoubleValue(string _value)
        {
            if (_value == null) return null;

            double toReturn;
            try
            {
                toReturn = Convert.ToDouble(_value, new CultureInfo("EN-en"));
                return toReturn;
            }
            catch
            {
                try
                {
                    //toReturn = Convert.ToDouble(_value.Replace(",", ""));
                    toReturn = Convert.ToDouble(_value, CultureInfo.CurrentCulture);
                    return toReturn;
                }
                catch { return Double.NaN; }
            }
        }

        public static string GetMd5Hash(MD5 md5Hash, string input)
        {

            // Convert the input string to a byte array and compute the hash.
            byte[] data = md5Hash.ComputeHash(Encoding.UTF8.GetBytes(input));

            // Create a new Stringbuilder to collect the bytes
            // and create a string.
            StringBuilder sBuilder = new StringBuilder();

            // Loop through each byte of the hashed data 
            // and format each one as a hexadecimal string.
            for (int i = 0; i < data.Length; i++)
            {
                sBuilder.Append(data[i].ToString("x2"));
            }

            // Return the hexadecimal string.
            return sBuilder.ToString();
        }

        // Verify a hash against a string.
        public static bool VerifyMd5Hash(MD5 md5Hash, string input, string hash)
        {
            // Hash the input.
            string hashOfInput = GetMd5Hash(md5Hash, input);

            // Create a StringComparer an compare the hashes.
            StringComparer comparer = StringComparer.OrdinalIgnoreCase;

            if (0 == comparer.Compare(hashOfInput, hash))
            {
                return true;
            }
            else
            {
                return false;
            }
        }

        public static string table_columns(int _authenticatedUserId, string _connectionString, string _table)
        {
            try
            {
                DataAccess da = new DataAccess(_authenticatedUserId, _connectionString, CommandType.Text, String.Format("SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = 'socisa' AND TABLE_NAME = '{0}';", _table));
                MySqlDataReader r = da.ExecuteSelectQuery();
                string toReturn = "";
                while (r.Read())
                {
                    toReturn += (((IDataRecord)r)["COLUMN_NAME"].ToString() + ",");
                }
                r.Close(); r.Dispose(); da.CloseConnection();
                return toReturn;
            }
            catch (Exception exp) { throw exp; }
        }


        public static response ValidareColoane(object item, string fieldValueCollection)
        {
            response toReturn = new response(true, null, null, null, new List<Error>());
            try
            {
                Dictionary<string, string> changes = JsonConvert.DeserializeObject<Dictionary<string, string>>(fieldValueCollection);
                foreach (string fieldName in changes.Keys)
                {
                    bool gasit = false;
                    PropertyInfo[] props = item.GetType().GetProperties();
                    foreach (PropertyInfo prop in props)
                    {
                        if (fieldName.ToUpper() == prop.Name.ToUpper())
                        {
                            gasit = true;
                            break;
                        }
                    }
                    if (!gasit)
                    {
                        Error err = ErrorParser.ErrorMessage("campInexistentInTabela");
                        return new response(false, err.ERROR_MESSAGE, null, null, new List<Error>() { err });
                    }
                }
            }
            catch
            {
                Error err = ErrorParser.ErrorMessage("cannotConvertStringToTableColumns");
                return new response(false, err.ERROR_MESSAGE, null, null, new List<Error>() { err });
            }
            return toReturn;
        }

        public static response HasChildrens(int authenticatedUserId, string connectionString, object item, string parentTableName, string childTableName)
        {
            try
            {
                DataAccess da = new DataAccess(authenticatedUserId, connectionString, CommandType.StoredProcedure, "TABLEsp_GetReferences", new object[] { new MySqlParameter("_PARENT_TABLE", parentTableName), new MySqlParameter("_CHILD_TABLE", childTableName) });
                MySqlDataReader r = da.ExecuteSelectQuery();
                while (r.Read())
                {
                    if (r["REFERENCED_TABLE_NAME"].ToString().ToUpper() == childTableName.ToUpper())
                    {
                        PropertyInfo[] props = item.GetType().GetProperties();
                        foreach (PropertyInfo prop in props)
                        {
                            if (prop.Name.ToUpper() == r["COLUMN_NAME"].ToString().ToUpper())
                            {
                                da = new DataAccess(authenticatedUserId, connectionString, CommandType.StoredProcedure, "CHILDRENSsp_Get", new object[] { new MySqlParameter("_PRIMARY_KEY_VALUE", prop.GetValue(item)), new MySqlParameter("_EXTERNAL_ID", r["REFERENCED_COLUMN_NAME"].ToString()), new MySqlParameter("_EXTERNAL_TABLE", r["REFERENCED_TABLE_NAME"].ToString()) });
                                object counter = da.ExecuteScalarQuery().Result;
                                try
                                {
                                    if (Convert.ToInt32(counter) > 0)
                                        return new response(true, "true", true, null, null);
                                }
                                catch { }
                                break;
                            }
                        }
                    }
                    else
                    {
                        PropertyInfo pi = item.GetType().GetProperty("ID");
                        da = new DataAccess(authenticatedUserId, connectionString, CommandType.StoredProcedure, "CHILDRENSsp_Get", new object[] { new MySqlParameter("_PRIMARY_KEY_VALUE", pi.GetValue(item)), new MySqlParameter("_EXTERNAL_ID", r["COLUMN_NAME"].ToString()), new MySqlParameter("_EXTERNAL_TABLE", r["TABLE_NAME"].ToString()) });
                        object counter = da.ExecuteScalarQuery().Result;
                        try
                        {
                            return new response(true, Convert.ToString(Convert.ToInt32(counter) > 0), Convert.ToInt32(counter) > 0, null, null);
                        }
                        catch
                        {
                            return new response(true, "false", false, null, null);
                        }
                    }
                }
                r.Close(); r.Dispose(); da.CloseConnection();
                return new response(true, "false", false, null, null);
            }
            catch (Exception exp) { LogWriter.Log(exp); return new response(false, exp.Message, null, null, new List<Error>() { new Error(exp) }); }
        }

        public static response HasChildren(int authenticatedUserId, string connectionString, object item, string parentTableName, string childTableName, int childrenId)
        {
            try
            {
                DataAccess da = new DataAccess(authenticatedUserId, connectionString, CommandType.StoredProcedure, "TABLEsp_GetReferences", new object[] { new MySqlParameter("_PARENT_TABLE", parentTableName), new MySqlParameter("_CHILD_TABLE", childTableName) });
                MySqlDataReader r = da.ExecuteSelectQuery();
                while (r.Read())
                {
                    if (r["REFERENCED_TABLE_NAME"].ToString().ToUpper() == childTableName.ToUpper())
                    {
                        PropertyInfo[] props = item.GetType().GetProperties();
                        foreach (PropertyInfo prop in props)
                        {
                            if (prop.Name.ToUpper() == r["COLUMN_NAME"].ToString().ToUpper())
                            {
                                da = new DataAccess(authenticatedUserId, connectionString, CommandType.StoredProcedure, "CHILDRENsp_Get", new object[] { new MySqlParameter("_PRIMARY_KEY_VALUE", prop.GetValue(item)), new MySqlParameter("_EXTERNAL_ID", r["REFERENCED_COLUMN_NAME"].ToString()), new MySqlParameter("_EXTERNAL_TABLE", r["REFERENCED_TABLE_NAME"].ToString()), new MySqlParameter("_CHILDREN_ID_FIELD", "1"), new MySqlParameter("_CHILDREN_ID_VALUE", "1") });
                                object counter = da.ExecuteScalarQuery().Result;
                                try
                                {
                                    if (Convert.ToInt32(counter) > 0)
                                        return new response(true, "true", true, null, null);
                                }
                                catch { }
                                break;
                            }
                        }
                    }
                    else
                    {
                        da = new DataAccess(authenticatedUserId, connectionString, CommandType.StoredProcedure, "TABLEsp_GetReferences", new object[] { new MySqlParameter("_PARENT_TABLE", r["TABLE_NAME"].ToString()), new MySqlParameter("_CHILD_TABLE", childTableName) });
                        MySqlDataReader rc = da.ExecuteSelectQuery();
                        while (rc.Read())
                        {
                            PropertyInfo pi = item.GetType().GetProperty("ID");
                            //da = new DataAccess(authenticatedUserId, connectionString, CommandType.StoredProcedure, "CHILDRENsp_Get", new object[] { new MySqlParameter("_PRIMARY_KEY_VALUE", pi.GetValue(item)), new MySqlParameter("_EXTERNAL_ID", r["REFERENCED_COLUMN_NAME"].ToString()), new MySqlParameter("_EXTERNAL_TABLE", r["REFERENCED_TABLE_NAME"].ToString()), new MySqlParameter("_CHILDREN_ID_FIELD", rc["COLUMN_NAME"].ToString()), new MySqlParameter("_CHILDREN_ID_VALUE", childrenId) });
                            da = new DataAccess(authenticatedUserId, connectionString, CommandType.StoredProcedure, "CHILDRENsp_Get", new object[] { new MySqlParameter("_PRIMARY_KEY_VALUE", pi.GetValue(item)), new MySqlParameter("_EXTERNAL_ID", r["COLUMN_NAME"].ToString()), new MySqlParameter("_EXTERNAL_TABLE", r["TABLE_NAME"].ToString()), new MySqlParameter("_CHILDREN_ID_FIELD", rc["COLUMN_NAME"].ToString()), new MySqlParameter("_CHILDREN_ID_VALUE", childrenId) });
                            object counter = da.ExecuteScalarQuery().Result;
                            try
                            {
                                return new response(true, Convert.ToString(Convert.ToInt32(counter) > 0), Convert.ToInt32(counter) > 0, null, null);
                            }
                            catch
                            {
                                return new response(true, "false", false, null, null);
                            }
                        }
                        rc.Close(); rc.Dispose();
                    }
                }
                r.Close(); r.Dispose(); da.CloseConnection();
                return new response(true, "false", false, null, null);
            }
            catch (Exception exp) { LogWriter.Log(exp); return new response(false, exp.Message, null, null, new List<Error>() { new Error(exp) }); }
        }

        public static response GetChildrens(object item, string table_name)
        {
            try
            {
                MethodInfo methodToRun = null;
                MethodInfo[] mis = item.GetType().GetMethods();
                foreach (MethodInfo mi in mis)
                {
                    if (mi.Name.ToLower().IndexOf(table_name.ToLower().Replace("_","")) > -1)
                    {
                        methodToRun = mi;
                        break;
                    }
                }
                //dynamic r = methodToRun.Invoke(item, null);
                //return new response(true, JsonConvert.SerializeObject(r), r, null, null);
                return (response)methodToRun.Invoke(item, null);
            }
            catch (Exception exp) { LogWriter.Log(exp); return new response(false, exp.Message, null, null, new List<Error>() { new Error(exp) }); }
        }

        public static response GetChildren(object item, string table_name, int childrenId)
        {
            try
            {
                //object childrens = GetChildrens(item, table_name);
                object childrens = GetChildrens(item, table_name).Result;
                if (childrens is Array)
                {
                    foreach (object it in (Array)childrens)
                    {
                        PropertyInfo pi = it.GetType().GetProperty("ID");
                        if (Convert.ToInt32(pi.GetValue(it)) == childrenId)
                        {
                            return new response(true, JsonConvert.SerializeObject(it), it, null, null);
                        }
                    }
                }
                return new response(true, "", null, null, null);
            }
            catch (Exception exp) { LogWriter.Log(exp); return new response(false, exp.Message, null, null, new List<Error>() { new Error(exp) }); }
        }

        public static string GetTempFolder()
        {
            string settingsFile = Path.Combine(AppContext.BaseDirectory, "AppSettings.json");
            string settings = File.ReadAllText(settingsFile);
            dynamic result = JsonConvert.DeserializeObject(settings);
            return System.IO.Path.Combine(AppContext.BaseDirectory, Convert.ToString(result.TempFolder));
        }

        public static string GetScansFolder()
        {
            string settingsFile = Path.Combine(AppContext.BaseDirectory, "AppSettings.json");
            string settings = File.ReadAllText(settingsFile);
            dynamic result = JsonConvert.DeserializeObject(settings);
            return System.IO.Path.Combine(AppContext.BaseDirectory, Convert.ToString(result.ScansFolder));
        }

        public static string GetSettingsFolder()
        {
            string settingsFile = Path.Combine(AppContext.BaseDirectory, "AppSettings.json");
            string settings = File.ReadAllText(settingsFile);
            dynamic result = JsonConvert.DeserializeObject(settings);
            return System.IO.Path.Combine(AppContext.BaseDirectory, Convert.ToString(result.SettingsFolder));
        }

        public static string GetPdfsFolder()
        {
            string settingsFile = Path.Combine(AppContext.BaseDirectory, "AppSettings.json");
            string settings = File.ReadAllText(settingsFile);
            dynamic result = JsonConvert.DeserializeObject(settings);
            return System.IO.Path.Combine(AppContext.BaseDirectory, Convert.ToString(result.PdfsFolder));
        }

        public static string GetLogsFolder()
        {
            string settingsFile = Path.Combine(AppContext.BaseDirectory, "AppSettings.json");
            string settings = File.ReadAllText(settingsFile);
            dynamic result = JsonConvert.DeserializeObject(settings);
            return System.IO.Path.Combine(AppContext.BaseDirectory, Convert.ToString(result.LogsFolder));
        }

        public static string GetImportsFolder()
        {
            string settingsFile = Path.Combine(AppContext.BaseDirectory, "AppSettings.json");
            string settings = File.ReadAllText(settingsFile);
            dynamic result = JsonConvert.DeserializeObject(settings);
            return System.IO.Path.Combine(AppContext.BaseDirectory, Convert.ToString(result.ImportsFolder));
        }

        public static string GetCompensariFolder()
        {
            string settingsFile = Path.Combine(AppContext.BaseDirectory, "AppSettings.json");
            string settings = File.ReadAllText(settingsFile);
            dynamic result = JsonConvert.DeserializeObject(settings);
            return System.IO.Path.Combine(AppContext.BaseDirectory, Convert.ToString(result.CompensariFolder));
        }

        public static string GetDigitalSignatureFile()
        {
            string settingsFile = Path.Combine(AppContext.BaseDirectory, "AppSettings.json");
            string settings = File.ReadAllText(settingsFile);
            dynamic result = JsonConvert.DeserializeObject(settings);
            return System.IO.Path.Combine(AppContext.BaseDirectory, Convert.ToString(result.DigitalSignatureFile));
        }

        public static ThumbNailSizes[] GetThumbNailSizes()
        {
            string settingsFile = Path.Combine(AppContext.BaseDirectory, "AppSettings.json");
            string settings = File.ReadAllText(settingsFile);
            dynamic result = JsonConvert.DeserializeObject(settings);
            ThumbNailSizes[] tSizes = JsonConvert.DeserializeObject<ThumbNailSizes[]>(result.ThumbNailSizes.ToString());
            return tSizes;
        }

        public static ThumbNailSizes GetThumbNailSizes(ThumbNailType thType)
        {
            string settingsFile = Path.Combine(AppContext.BaseDirectory, "AppSettings.json");
            string settings = File.ReadAllText(settingsFile);
            dynamic result = JsonConvert.DeserializeObject(settings);
            ThumbNailSizes[] tSizes = JsonConvert.DeserializeObject<ThumbNailSizes[]>(result.ThumbNailSizes.ToString());
            foreach (ThumbNailSizes ts in tSizes)
            {
                if (ts.thumbNailType == thType)
                    return ts;
            }
            return tSizes[2];
        }

        public static bool IsNullOrEmpty(Newtonsoft.Json.Linq.JToken token)
        {
            return (token == null) ||
                   (token.Type == Newtonsoft.Json.Linq.JTokenType.Array && !token.HasValues) ||
                   (token.Type == Newtonsoft.Json.Linq.JTokenType.Object && !token.HasValues) ||
                   (token.Type == Newtonsoft.Json.Linq.JTokenType.String && token.ToString() == String.Empty) ||
                   (token.Type == Newtonsoft.Json.Linq.JTokenType.Null);
        }

        public static bool IsNullable(object x)
        {
            if (x == null || x == DBNull.Value || x.ToString().Trim() == "") return true;
            return false;
        }

        public static class StringCipher
        {
            // This constant is used to determine the keysize of the encryption algorithm in bits.
            // We divide this by 8 within the code below to get the equivalent number of bytes.
            private const int Keysize = 256;

            // This constant determines the number of iterations for the password bytes generation function.
            private const int DerivationIterations = 1000;

            public static string Encrypt(string plainText, string passPhrase)
            {
                // Salt and IV is randomly generated each time, but is preprended to encrypted cipher text
                // so that the same Salt and IV values can be used when decrypting.  
                var saltStringBytes = Generate256BitsOfRandomEntropy();
                var ivStringBytes = Generate256BitsOfRandomEntropy();
                var plainTextBytes = Encoding.UTF8.GetBytes(plainText);
                using (var password = new Rfc2898DeriveBytes(passPhrase, saltStringBytes, DerivationIterations))
                {
                    var keyBytes = password.GetBytes(Keysize / 8);
                    using (var symmetricKey = new RijndaelManaged())
                    {
                        symmetricKey.BlockSize = 256;
                        symmetricKey.Mode = CipherMode.CBC;
                        symmetricKey.Padding = PaddingMode.PKCS7;
                        using (var encryptor = symmetricKey.CreateEncryptor(keyBytes, ivStringBytes))
                        {
                            using (var memoryStream = new MemoryStream())
                            {
                                using (var cryptoStream = new CryptoStream(memoryStream, encryptor, CryptoStreamMode.Write))
                                {
                                    cryptoStream.Write(plainTextBytes, 0, plainTextBytes.Length);
                                    cryptoStream.FlushFinalBlock();
                                    // Create the final bytes as a concatenation of the random salt bytes, the random iv bytes and the cipher bytes.
                                    var cipherTextBytes = saltStringBytes;
                                    cipherTextBytes = cipherTextBytes.Concat(ivStringBytes).ToArray();
                                    cipherTextBytes = cipherTextBytes.Concat(memoryStream.ToArray()).ToArray();
                                    memoryStream.Close();
                                    cryptoStream.Close();
                                    return Convert.ToBase64String(cipherTextBytes);
                                }
                            }
                        }
                    }
                }
            }

            public static string Decrypt(string cipherText, string passPhrase)
            {
                // Get the complete stream of bytes that represent:
                // [32 bytes of Salt] + [32 bytes of IV] + [n bytes of CipherText]
                var cipherTextBytesWithSaltAndIv = Convert.FromBase64String(cipherText);
                // Get the saltbytes by extracting the first 32 bytes from the supplied cipherText bytes.
                var saltStringBytes = cipherTextBytesWithSaltAndIv.Take(Keysize / 8).ToArray();
                // Get the IV bytes by extracting the next 32 bytes from the supplied cipherText bytes.
                var ivStringBytes = cipherTextBytesWithSaltAndIv.Skip(Keysize / 8).Take(Keysize / 8).ToArray();
                // Get the actual cipher text bytes by removing the first 64 bytes from the cipherText string.
                var cipherTextBytes = cipherTextBytesWithSaltAndIv.Skip((Keysize / 8) * 2).Take(cipherTextBytesWithSaltAndIv.Length - ((Keysize / 8) * 2)).ToArray();

                using (var password = new Rfc2898DeriveBytes(passPhrase, saltStringBytes, DerivationIterations))
                {
                    var keyBytes = password.GetBytes(Keysize / 8);
                    using (var symmetricKey = new RijndaelManaged())
                    {
                        symmetricKey.BlockSize = 256;
                        symmetricKey.Mode = CipherMode.CBC;
                        symmetricKey.Padding = PaddingMode.PKCS7;
                        using (var decryptor = symmetricKey.CreateDecryptor(keyBytes, ivStringBytes))
                        {
                            using (var memoryStream = new MemoryStream(cipherTextBytes))
                            {
                                using (var cryptoStream = new CryptoStream(memoryStream, decryptor, CryptoStreamMode.Read))
                                {
                                    var plainTextBytes = new byte[cipherTextBytes.Length];
                                    var decryptedByteCount = cryptoStream.Read(plainTextBytes, 0, plainTextBytes.Length);
                                    memoryStream.Close();
                                    cryptoStream.Close();
                                    return Encoding.UTF8.GetString(plainTextBytes, 0, decryptedByteCount);
                                }
                            }
                        }
                    }
                }
            }

            private static byte[] Generate256BitsOfRandomEntropy()
            {
                var randomBytes = new byte[32]; // 32 Bytes will give us 256 bits.
                using (var rngCsp = new RNGCryptoServiceProvider())
                {
                    // Fill the array with cryptographically secure random bytes.
                    rngCsp.GetBytes(randomBytes);
                }
                return randomBytes;
            }

            public static string RetrieveKey()
            {
                return File.ReadAllText(Path.Combine(AppContext.BaseDirectory, "todo"));
            }

        }
    }

    public static class ExtensionMethods
    {
        // returns the number of milliseconds since Jan 1, 1970 (useful for converting C# dates to JS dates)
        public static string UnixTicks(this DateTime dt)
        {
            DateTime d1 = new DateTime(1970, 1, 1);
            DateTime d2 = dt.ToUniversalTime();
            TimeSpan ts = new TimeSpan(d2.Ticks - d1.Ticks);
            return String.Format("/Date({0})/", ts.TotalMilliseconds);
        }

        public static bool IsValidJson(this string s)
        {
            if((s.StartsWith("{") && s.EndsWith("}")) || (s.StartsWith("[") && s.EndsWith("]")))
            {
                try
                {
                    var tmp = JToken.Parse(s);
                    return true;
                }
                catch
                {
                    return false;
                }
            }
            else
            {
                return false;
            }
        }

        public static Nullable<T> ToNullable<T>(this string s) where T : struct
        {
            Nullable<T> result = new Nullable<T>();
            try
            {
                if (!string.IsNullOrWhiteSpace(s))
                {
                    TypeConverter conv = TypeDescriptor.GetConverter(typeof(T));
                    result = (T)conv.ConvertFrom(s);
                }
            }
            catch { }
            return result;
        }
    }
}