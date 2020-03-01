using Newtonsoft.Json;
using System;
using System.Data;
using System.Data.Common;
using System.Reflection;
using System.Text.RegularExpressions;
using Newtonsoft.Json.Linq;
using System.Globalization;
using System.Collections.Generic;
using System.IO;

namespace SOCISA
{
    public static class PredefinedFilters
    {
        public static Dictionary<string, Dictionary<string, string>> PredefinedFilter = new Dictionary<string, Dictionary<string, string>>()
        {
            { "predefinedDashboardFilters", new Dictionary<string, string>()
                {
                    {"toateDosarele", " (DOSARE.ID_SOCIETATE_CASCO='{0}' OR DOSARE.ID_SOCIETATE_RCA='{0}') "},
                    {"dosareCasco", " DOSARE.ID_SOCIETATE_CASCO='{0}' "},
                    {"dosareRca", " DOSARE.ID_SOCIETATE_RCA='{0}' "},
                    {"dosareNoiDeLaUltimulLogin", " (DOSARE.ID_SOCIETATE_CASCO='{0}' OR DOSARE.ID_SOCIETATE_RCA='{0}') AND (DOSARE.DATA_CREARE >= '{1}' OR '{1}' IS NULL) "},
                    {"dosareNoiCascoDeLaUltimulLogin", " DOSARE.ID_SOCIETATE_CASCO='{0}' AND (DOSARE.DATA_CREARE >= '{1}' OR '{1}' IS NULL) "},
                    {"dosareNoiRcaDeLaUltimulLogin", " DOSARE.ID_SOCIETATE_RCA='{0}' AND (DOSARE.DATA_CREARE >= '{1}' OR '{1}' IS NULL) "},
                    {"dosareNeoperate", " (((DOSARE.DATA_ULTIMEI_MODIFICARI IS NOT NULL AND DOSARE.DATA_ULTIMEI_MODIFICARI <= '{1}') OR (DOSARE.DATA_ULTIMEI_MODIFICARI IS NULL AND DOSARE.DATA_CREARE IS NOT NULL AND DOSARE.DATA_CREARE <= '{1}') OR (DOSARE.DATA_ULTIMEI_MODIFICARI IS NULL AND DOSARE.DATA_CREARE IS NULL)) AND (DOSARE.ID_SOCIETATE_CASCO = {0} OR (DOSARE.ID_SOCIETATE_RCA = {0} AND UPPER(DOSARE.STATUS) NOT IN ('INCOMPLET','NEAVIZAT')))) "},
                    {"dosareCascoNeoperate", " (((DOSARE.DATA_ULTIMEI_MODIFICARI IS NOT NULL AND DOSARE.DATA_ULTIMEI_MODIFICARI <= '{1}') OR (DOSARE.DATA_ULTIMEI_MODIFICARI IS NULL AND DOSARE.DATA_CREARE IS NOT NULL AND DOSARE.DATA_CREARE <= '{1}') OR (DOSARE.DATA_ULTIMEI_MODIFICARI IS NULL AND DOSARE.DATA_CREARE IS NULL)) AND DOSARE.ID_SOCIETATE_CASCO = {0}) "},
                    {"dosareRcaNeoperate", " (((DOSARE.DATA_ULTIMEI_MODIFICARI IS NOT NULL AND DOSARE.DATA_ULTIMEI_MODIFICARI <= '{1}') OR (DOSARE.DATA_ULTIMEI_MODIFICARI IS NULL AND DOSARE.DATA_CREARE IS NOT NULL AND DOSARE.DATA_CREARE <= '{1}') OR (DOSARE.DATA_ULTIMEI_MODIFICARI IS NULL AND DOSARE.DATA_CREARE IS NULL)) AND (DOSARE.ID_SOCIETATE_RCA = {0} AND UPPER(DOSARE.STATUS) NOT IN ('INCOMPLET','NEAVIZAT'))) "},
                    {"dosareNeasignate", " ((DOSARE.ID_SOCIETATE_CASCO='{0}' OR DOSARE.ID_SOCIETATE_RCA='{0}') AND DOSARE.ID NOT IN (SELECT ID_DOSAR FROM UTILIZATORI_DOSARE)) "},
                    {"dosareCascoNeasignate", " (DOSARE.ID_SOCIETATE_CASCO='{0}' AND DOSARE.ID NOT IN (SELECT ID_DOSAR FROM UTILIZATORI_DOSARE)) "},
                    {"dosareRcaNeasignate", " (DOSARE.ID_SOCIETATE_RCA='{0}' AND DOSARE.ID NOT IN (SELECT ID_DOSAR FROM UTILIZATORI_DOSARE)) "},
                    {"dosareNeasignateFromLastLogin", " ((DOSARE.ID_SOCIETATE_CASCO='{0}' OR DOSARE.ID_SOCIETATE_RCA='{0}') AND DOSARE.ID NOT IN (SELECT ID_DOSAR FROM UTILIZATORI_DOSARE) AND (DOSARE.DATA_CREARE >= '{1}' OR '{1}' IS NULL)) "},
                    {"dosareCascoNeasignateFromLastLogin", " (DOSARE.ID_SOCIETATE_CASCO='{0}' AND DOSARE.ID NOT IN (SELECT ID_DOSAR FROM UTILIZATORI_DOSARE) AND (DOSARE.DATA_CREARE >= '{1}' OR '{1}' IS NULL)) "},
                    {"dosareRcaNeasignateFromLastLogin", " (DOSARE.ID_SOCIETATE_RCA='{0}' AND DOSARE.ID NOT IN (SELECT ID_DOSAR FROM UTILIZATORI_DOSARE) AND (DOSARE.DATA_CREARE >= '{1}' OR '{1}' IS NULL)) "},
                    {"dosareIncomplete", " (DOSARE.ID_SOCIETATE_CASCO='{0}' OR DOSARE.ID_SOCIETATE_RCA='{0}') AND DOSARE.STATUS='INCOMPLET' "},
                    {"dosareNeavizate", " (DOSARE.ID_SOCIETATE_CASCO='{0}' OR DOSARE.ID_SOCIETATE_RCA='{0}') AND DOSARE.STATUS='NEAVIZAT' "},
                    {"dosareAvizateTotal", " (DOSARE.ID_SOCIETATE_CASCO='{0}' OR DOSARE.ID_SOCIETATE_RCA='{0}') AND DOSARE.STATUS NOT IN ('INCOMPLET','NEAVIZAT') "},
                    {"dosareAvizate", " (DOSARE.ID_SOCIETATE_CASCO='{0}' OR DOSARE.ID_SOCIETATE_RCA='{0}') AND DOSARE.STATUS='AVIZAT' "},
                    {"dosareNeachitate", " (DOSARE.ID_SOCIETATE_CASCO='{0}' OR DOSARE.ID_SOCIETATE_RCA='{0}') AND DOSARE.STATUS='NEACHITAT' "},
                    {"dosareAchitatePartial", " (DOSARE.ID_SOCIETATE_CASCO='{0}' OR DOSARE.ID_SOCIETATE_RCA='{0}') AND DOSARE.STATUS='ACHITAT_PARTIAL' "},
                    {"dosareAchitate", " (DOSARE.ID_SOCIETATE_CASCO='{0}' OR DOSARE.ID_SOCIETATE_RCA='{0}') AND DOSARE.STATUS='ACHITAT' "},
                    {"externalId", " DOSARE.ID='{0}' "},
                    {"proceseTotal", " ((PROCESE.ID_DOSAR IS NOT NULL AND (DOSARE.ID_SOCIETATE_CASCO='{0}' OR DOSARE.ID_SOCIETATE_RCA='{0}')) OR (PROCESE.ID_DOSAR IS NULL AND (PROCESE.ID_RECLAMANT='{0}' OR PROCESE.ID_PARAT='{0}'))) "},
                    {"proceseReclamantTotal", " ((PROCESE.ID_DOSAR IS NOT NULL AND DOSARE.ID_SOCIETATE_CASCO='{0}') OR (PROCESE.ID_DOSAR IS NULL AND PROCESE.ID_RECLAMANT='{0}')) "},
                    {"proceseParatTotal", " ((PROCESE.ID_DOSAR IS NOT NULL AND DOSARE.ID_SOCIETATE_RCA='{0}') OR (PROCESE.ID_DOSAR IS NULL AND PROCESE.ID_PARAT='{0}')) "},
                    {"proceseNoiTotal", " (LOWER(S.DENUMIRE) = 'preluat de la asigurator' AND ((PROCESE.ID_DOSAR IS NOT NULL AND (DOSARE.ID_SOCIETATE_CASCO='{0}' OR DOSARE.ID_SOCIETATE_RCA='{0}')) OR (PROCESE.ID_DOSAR IS NULL AND (PROCESE.ID_RECLAMANT='{0}' OR PROCESE.ID_PARAT='{0}')))) "},
                    {"dosareFaraDocumente", "  (DOSARE.ID_SOCIETATE_CASCO='{0}' OR DOSARE.ID_SOCIETATE_RCA='{0}') AND (IFNULL(DOSARE.`COUNT_DOCUMENTE`, 0) = 0) "},
                    {"dosareFaraProces", "  (DOSARE.ID_SOCIETATE_CASCO='{0}' OR DOSARE.ID_SOCIETATE_RCA='{0}') AND (IFNULL(DOSARE.`COUNT_PROCESE`, 0) = 0 AND D.INSTANTA = TRUE) "}
                }
            }
        };
        
        public static Dictionary<string, Dictionary<string, string>> Filters
        {
            get
            {
                try
                {
                    string predefinedFiltersFile = Path.Combine(CommonFunctions.GetSettingsFolder(), "PredefinedFilters.json");
                    string filters = File.ReadAllText(predefinedFiltersFile);
                    Dictionary < string, Dictionary < string, string>> toReturn = JsonConvert.DeserializeObject<Dictionary<string, Dictionary<string, string>>>(filters);
                    return toReturn;
                }
                catch (Exception exp)
                {
                    LogWriter.Log(exp);
                    return PredefinedFilters.PredefinedFilter;
                }
            }
        }

        public static string CreateFilter(string filterName, string filterKey, object[] args)
        {
            //Dictionary<string, string> subFilter = PredefinedFilters.PredefinedFilter[filterName];
            Dictionary<string, string> subFilter = PredefinedFilters.Filters[filterName];
            string toReturn = args == null || args.Length <= 0 ? subFilter[filterKey] : String.Format(subFilter[filterKey], args);
            return toReturn;
        }

        public static object CreateJsonFilter(string filterName, string filterKey, object[] args)
        {
            var toReturn = new { filterName, filterKey, args };
            return toReturn;
        }
    }

    /// <summary>
    /// Clasa care defineste un Filtru pentru selectia inregistrarilor din baza de date
    /// </summary>
    public class Filtru
    {
        /// <summary>
        /// Coloana din tabel pe care se aplica filtrul
        /// </summary>
        public string Coloana { get; set; }
        /// <summary>
        /// Conditia pe care trebuie sa o indeplineasca valoarea din coloana
        /// </summary>
        public string Conditie { get; set; }
        /// <summary>
        /// Valoarea cu care se compara valorile din coloana
        /// </summary>
        public string Valoare { get; set; }
        /// <summary>
        /// Operatorul pentru crearea unui filtru compus (SI, SAU)
        /// </summary>
        public string Operator { get; set; }
    }

    public class Filter
    {
        string _limit;
        public string Sort { get; set; }
        public string Order { get; set; }
        public string Filtru { get; set; }
        public string Limit {
            get { return _limit; }
            set { string toReturn = value.ToLower().IndexOf("limit") > -1 ? " " + value.ToUpper() + " " : " LIMIT " + value + " "; _limit = toReturn;  }
        }

        public Filter() { }
        public Filter(string _sort, string _order, string _filtru, string _limit)
        {
            Sort = _sort; Order = _order; Filtru = _filtru; Limit = _limit;
        }
    }

    public static class Filtering
    {
        public static string GenerateFilterFromJsonObject(Type T, string _filter, int authenticatedUserId, string connectionString)
        {
            string toReturn = "";
            try
            {
                JObject jObj = JObject.Parse(_filter);
                if(jObj.Count == 2)
                {
                    /*
                    JToken j1 = jObj[0];
                    JToken j2 = jObj[1];
                    if(JsonConvert.DeserializeObject(JsonConvert.SerializeObject( j1), T).GetType().Name.IndexOf("Dosar") > -1 && j2.HasValues)
                    */
                    JToken j1 = jObj["jObject"];
                    JToken j2 = jObj["jobjectJson"];
                    if (jObj["jObject"] != null && jObj["jobjectJson"] != null)
                    {
                        string f1 = GenerateFilterFromJsonObject(T, JsonConvert.SerializeObject(j1), authenticatedUserId, connectionString);
                        string f2 = GenerateFilterFromJsonObject(T, JsonConvert.SerializeObject(j2), authenticatedUserId, connectionString);
                        toReturn = !String.IsNullOrEmpty(f1) && !String.IsNullOrEmpty(f2) ? String.Format("{0} AND {1}", f1, f2) : String.Format("{0}{1}", f1 == null ? "" : f1, f2 == null ? "" : f2);
                        return toReturn;
                    }
                }
            }
            catch { }


            try
            {
                //dynamic jObj = JsonConvert.DeserializeObject(_filter);
                JObject jObj = JObject.Parse(_filter);
                var x = Activator.CreateInstance(T, new object[] { authenticatedUserId, connectionString });
                string className = x.GetType().Name; // to check if it returns only the short name
                string tableAllias = CommonFunctions.ClassNamesTableNamesAlliases[className].ToUpper();
                PropertyInfo[] pisX = x.GetType().GetProperties();
                //PropertyInfo[] pisJObj = jObj.GetType().GetProperties();
                //foreach (PropertyInfo piJObj in pisJObj)
                foreach(var t in jObj)
                {
                    string key = t.Key;
                    JToken j = t.Value;
                    string v = j == null || j.IsNullOrEmpty() ? null : (j.Type == JTokenType.Float ? j.ToString(Formatting.None) : j.ToString());
                    bool propertyInMasterObject = false;
                    foreach (PropertyInfo piX in pisX)
                    {
                        ////if (piX.Name == piJObj.Name)
                        //if (piX.Name != "ID" && (j != null && !String.IsNullOrEmpty(v)))
                        if (j != null && !String.IsNullOrEmpty(v))
                        {
                            if (piX.Name == key)
                            {

                                string op = "";
                                switch (piX.PropertyType.ToString())
                                {
                                    case "System.Boolean":
                                    case "System.Nullable`1[System.Boolean]":
                                        op = String.IsNullOrEmpty(v) ? "is null" : String.Format("= {0}", v.ToLower());
                                        toReturn += String.Format("{0}{1}.`{2}` {3}", (toReturn == "" ? "" : " AND "), tableAllias, piX.Name, op);
                                        break;
                                    case "System.DateTime":
                                    case "System.Nullable`1[System.DateTime]":
                                        if (v.IndexOf('?') > -1)
                                        {
                                            DateTime dStart = Convert.ToDateTime(v.Split('?')[0]);
                                            DateTime dEnd = Convert.ToDateTime(v.Split('?')[1]);
                                            toReturn += String.Format("{0}(DATE({1}.`{2}`) >= '{3}' AND DATE({1}.`{2}`) <= '{4}')", (toReturn == "" ? " " : " AND "), tableAllias, piX.Name, CommonFunctions.ToMySqlFormatDate(dStart), CommonFunctions.ToMySqlFormatDate(dEnd));
                                        }
                                        else
                                        {
                                            DateTime d = Convert.ToDateTime(v);
                                            toReturn += String.Format("{0} {1}.`{2}` = '{3}'", (toReturn == "" ? " " : " AND "), tableAllias, piX.Name, CommonFunctions.ToMySqlFormatDate(d));
                                        }
                                        break;
                                    case "System.Double":
                                    case "System.Nullable`1[System.Double]":
                                    case "System.Decimal":
                                    case "System.Nullable`1[System.Decimal]":
                                        op = v.StartsWith("*") && v.EndsWith("*") ? String.Format("like '%{0}%'", v==null?null:Convert.ToDouble( CommonFunctions.BackDoubleValue(v.Substring(1, v.Length - 2))).ToString(CultureInfo.InvariantCulture)) :
                                            v.StartsWith("*") ? String.Format("like '%{0}'", v==null ? null : Convert.ToDouble( CommonFunctions.BackDoubleValue(v.Substring(1, v.Length - 1))).ToString(CultureInfo.InvariantCulture)) :
                                            v.EndsWith("*") ? String.Format("like '{0}%'", v==null?null: Convert.ToDouble( CommonFunctions.BackDoubleValue(v.Substring(0, v.Length - 1))).ToString(CultureInfo.InvariantCulture)) :
                                            String.Format("= '{0}'", v==null? null:Convert.ToDouble( CommonFunctions.BackDoubleValue(v)).ToString(CultureInfo.InvariantCulture));
                                        toReturn += String.Format("{0}{1}.`{2}` {3}", (toReturn == "" ? "" : " AND "), tableAllias, piX.Name, op);
                                        break;
                                    default:
                                        op = v.StartsWith("*") && v.EndsWith("*") ? String.Format("like '%{0}%'", v.Substring(1, v.Length - 2)) : v.StartsWith("*") ? String.Format("like '%{0}'", v.Substring(1, v.Length - 1)) : v.EndsWith("*") ? String.Format("like '{0}%'", v.Substring(0, v.Length - 1)) : String.Format("= '{0}'", v);
                                        toReturn += String.Format("{0}{1}.`{2}` {3}", (toReturn == "" ? "" : " AND "), tableAllias, piX.Name, op);
                                        break;
                                }

                                propertyInMasterObject = true;
                                break;
                            }
                        }
                    }
                    if (!propertyInMasterObject && (j != null && !String.IsNullOrEmpty(v))) // pt. campuri externe trimise pt. filtrare - ex. Nume societate sau asigurat din Dosar
                    {
                        string op = v.StartsWith("*") && v.EndsWith("*") ? String.Format("like '%{0}%'", v.Substring(1, v.Length - 2)) : v.StartsWith("*") ? String.Format("like '%{0}'", v.Substring(1, v.Length - 1)) : v.EndsWith("*") ? String.Format("like '{0}%'", v.Substring(0, v.Length - 1)) : String.Format("= '{0}'", v);
                        //switch (piJObj.Name.ToLower().Replace("_", "").Replace(" ", ""))
                        switch (key.ToLower().Replace("_", "").Replace(" ", ""))
                        {
                            //dosare
                            case "calitatesocietate":
                                string[] statuses = op.Replace("=","").Replace("'","").Trim().Split(',');
                                toReturn += String.Format("{0}(DOSARE.STATUS IN (", (toReturn == "" ? "" : " AND "));
                                for(int i=0;i<statuses.Length;i++)
                                {
                                    toReturn += String.Format("'{1}'{0}", i == statuses.Length - 1 ? "" : ",", statuses[i]);
                                }
                                toReturn += "))";
                                break;
                            case "asiguratcasco":
                            case "numeasiguratcasco":
                                //toReturn += String.Format("{2}ASIGC.`{0}` LIKE '%{1}%'", "DENUMIRE", piJObj.GetValue(jObj, null), (toReturn == "" ? "" : " AND "));
                                //toReturn += String.Format("{2}ASIGC.`{0}` LIKE '{1}%'", "DENUMIRE", v, (toReturn == "" ? "" : " AND "));
                                toReturn += String.Format("{2}ASIGC.`{0}` {1}", "DENUMIRE", op, (toReturn == "" ? "" : " AND "));
                                break;
                            case "asiguratrca":
                            case "numeasiguratrca":
                                //toReturn += String.Format("{2}ASIGR.`{0}` LIKE '%{1}%'", "DENUMIRE", piJObj.GetValue(jObj, null), (toReturn == "" ? "" : " AND "));
                                //toReturn += String.Format("{2}ASIGR.`{0}` LIKE '{1}%'", "DENUMIRE", v, (toReturn == "" ? "" : " AND "));
                                toReturn += String.Format("{2}ASIGR.`{0}` {1}", "DENUMIRE", op, (toReturn == "" ? "" : " AND "));
                                break;
                            case "autocasco":
                            case "numarautocasco":
                                //toReturn += String.Format("{2}AC.`{0}` LIKE '%{1}%'", "NR_AUTO", piJObj.GetValue(jObj, null), (toReturn == "" ? "" : " AND "));
                                //toReturn += String.Format("{2}AC.`{0}` LIKE '{1}%'", "NR_AUTO", v, (toReturn == "" ? "" : " AND "));
                                toReturn += String.Format("{2}AC.`{0}` {1}", "NR_AUTO", op, (toReturn == "" ? "" : " AND "));
                                break;
                            case "autorca":
                            case "numarautorca":
                                //toReturn += String.Format("{2}AR.`{0}` LIKE '%{1}%'", "NR_AUTO", piJObj.GetValue(jObj, null), (toReturn == "" ? "" : " AND "));
                                //toReturn += String.Format("{2}AR.`{0}` LIKE '{1}%'", "NR_AUTO", v, (toReturn == "" ? "" : " AND "));
                                toReturn += String.Format("{2}AR.`{0}` {1}", "NR_AUTO", op, (toReturn == "" ? "" : " AND "));
                                break;
                            case "societatecasco":
                            case "asiguratorcasco":
                                //toReturn += String.Format("{2}SC.`{0}` LIKE '%{1}%'", "DENUMIRE_SCURTA", piJObj.GetValue(jObj, null), (toReturn == "" ? "" : " AND "));
                                //toReturn += String.Format("{2}SC.`{0}` LIKE '{1}%'", "DENUMIRE_SCURTA", v, (toReturn == "" ? "" : " AND "));
                                toReturn += String.Format("{2}SC.`{0}` {1}", "DENUMIRE_SCURTA", op, (toReturn == "" ? "" : " AND "));
                                break;
                            case "societaterca":
                            case "asiguratorrca":
                                //toReturn += String.Format("{2}SR.`{0}` LIKE '%{1}%'", "DENUMIRE_SCURTA", piJObj.GetValue(jObj, null), (toReturn == "" ? "" : " AND "));
                                //toReturn += String.Format("{2}SR.`{0}` LIKE '{1}%'", "DENUMIRE_SCURTA", v, (toReturn == "" ? "" : " AND "));
                                toReturn += String.Format("{2}SR.`{0}` {1}", "DENUMIRE_SCURTA", op, (toReturn == "" ? "" : " AND "));
                                break;
                            case "intervenient":
                            case "numeintervenient":
                                //toReturn += String.Format("{2}I.`{0}` LIKE '%{1}%'", "DENUMIRE", piJObj.GetValue(jObj, null), (toReturn == "" ? "" : " AND "));
                                //toReturn += String.Format("{2}I.`{0}` LIKE '{1}%'", "DENUMIRE", v, (toReturn == "" ? "" : " AND "));
                                toReturn += String.Format("{2}I.`{0}` {1}", "DENUMIRE", op, (toReturn == "" ? "" : " AND "));
                                break;
                            case "tipdosar":
                                //toReturn += String.Format("{2}TD.`{0}` LIKE '%{1}%'", "DENUMIRE", piJObj.GetValue(jObj, null), (toReturn == "" ? "" : " AND "));
                                //toReturn += String.Format("{2}TD.`{0}` LIKE '{1}%'", "DENUMIRE", v, (toReturn == "" ? "" : " AND "));
                                toReturn += String.Format("{2}TD.`{0}` {1}", "DENUMIRE", op, (toReturn == "" ? "" : " AND "));
                                break;
                            //procese
                            case "tipproces":
                                toReturn += String.Format("{2}TD.`{0}` {1}", "DENUMIRE", op, (toReturn == "" ? "" : " AND "));
                                break;
                            case "complet":
                                toReturn += String.Format("{2}C.`{0}` {1}", "DENUMIRE", op, (toReturn == "" ? "" : " AND "));
                                break;
                            case "instanta":
                                toReturn += String.Format("{2}I.`{0}` {1}", "DENUMIRE", op, (toReturn == "" ? "" : " AND "));
                                break;
                            case "reclamant":
                                toReturn += String.Format("{2} (REC1.`{0}` {1} OR REC2.`{3}` {4})", "DENUMIRE", op, (toReturn == "" ? "" : " AND "), "DENUMIRE", op);
                                break;
                            case "parat":
                                toReturn += String.Format("{2} (PAR1.`{0}` {1} OR PAR2.`{3}` {4})", "DENUMIRE", op, (toReturn == "" ? "" : " AND "), "DENUMIRE", op);
                                break;
                            case "tert":
                                toReturn += String.Format("{2} (TER.`{0}` {1})", "DENUMIRE", op, (toReturn == "" ? "" : " AND "));
                                break;
                            case "contract":
                                toReturn += String.Format("{2}CTR.`{0}` {1}", "NR_CONTRACT", op, (toReturn == "" ? "" : " AND "));
                                break;
                            case "stadiu":
                                toReturn += String.Format("{2}S.`{0}` {1}", "ID", op, (toReturn == "" ? "" : " AND "));
                                break;
                            case "datastadiu":
                                if (v.IndexOf('?') > -1)
                                {
                                    DateTime dStart = Convert.ToDateTime(v.Split('?')[0]);
                                    DateTime dEnd = Convert.ToDateTime(v.Split('?')[1]);
                                    toReturn += String.Format("{0} (DATE({1}.`{2}`) >= '{3}' AND DATE({1}.`{2}`) <= '{4}')", (toReturn == "" ? " " : " AND "), "PS", "DATA", CommonFunctions.ToMySqlFormatDate(dStart), CommonFunctions.ToMySqlFormatDate(dEnd));
                                }
                                else
                                {
                                    DateTime d = Convert.ToDateTime(v);
                                    toReturn += String.Format("{0} {1}.`{2}` = '{3}'", (toReturn == "" ? " " : " AND "), "PS", "DATA", CommonFunctions.ToMySqlFormatDate(d));
                                }
                                break;                                
                            case "calitate":
                                toReturn += String.Format("{0} {1}", (toReturn == "" ? "" : " AND "), v);
                                break;
                            case "dosarfaradocumente":
                                //toReturn += String.Format("{2}IFNULL(DS.`{0}`, 0) {1}", "CNT", op.ToLower().IndexOf("true") > -1 ? " = 0 " : op.ToLower().IndexOf("false") > -1 ? " > 0 " : " >= 0 ", (toReturn == "" ? "" : " AND "));
                                toReturn += String.Format("{2}IFNULL(DOSARE.`{0}`, 0) {1}", "COUNT_DOCUMENTE", op.ToLower().IndexOf("true") > -1 ? " = 0 " : op.ToLower().IndexOf("false") > -1 ? " > 0 " : " >= 0 ", (toReturn == "" ? "" : " AND "));
                                break;
                            case "dosarfaraproces":
                                //toReturn += String.Format("{2}IFNULL(P.`{0}`, 0) {1}", "CNT", op.ToLower().IndexOf("true") > -1 ? " = 0 " : op.ToLower().IndexOf("false") > -1 ? " > 0 " : " >= 0 ", (toReturn == "" ? "" : " AND "));
                                toReturn += String.Format("{2}IFNULL(DOSARE.`{0}`, 0) {1}", "COUNT_PROCESE", op.ToLower().IndexOf("true") > -1 ? " = 0 " : op.ToLower().IndexOf("false") > -1 ? " > 0 " : " >= 0 ", (toReturn == "" ? "" : " AND "));
                                break;
                        }
                    }
                }
                /*
                MethodInfo mi = x.GetType().GetMethod("ValidareColoane");
                response res = (response)mi.Invoke(x, new object[] { _filter });
                if (res.Status)
                {
                    mi = x.GetType().GetMethod("GenerateFilterFromJsonObject");
                    var r = mi.Invoke(x, null);
                    toReturn = r.ToString();
                }
                */
            }
            catch { }
            return toReturn;
        }

        public static string GenerateFilterFromJsonObject(object item)
        {
            string toReturn = "";
            string className = item.GetType().Name;
            string tableAllias = CommonFunctions.ClassNamesTableNamesAlliases[className].ToUpper();

            PropertyInfo[] props = item.GetType().GetProperties();
            foreach (PropertyInfo prop in props)
            {
                string propName = prop.Name;
                string propType = prop.PropertyType.ToString();
                object propValue = prop.GetValue(item, null);
                propValue = propValue == null ? DBNull.Value : propValue;
                if (propType != null && propValue != null && propValue != DBNull.Value)
                {
                    try
                    {
                        switch (propType)
                        {
                            case "System.DateTime":
                                toReturn += String.Format("{2}{3}.`{0}` = '{1}'", propName, propValue, (toReturn == "" ? "" : " AND "), tableAllias);
                                break;
                            default:
                                toReturn += String.Format("{2}{3}.`{0}` like '{1}%'", propName, propValue, (toReturn == "" ? "" : " AND "), tableAllias);
                                break;
                        }
                    }
                    catch { }
                }
            }
            return toReturn;
        }

        #region -- older --
        /*
        public static object[] Conditii = new object[]{
          "egal cu",
          "diferit de",
          "mai mic decat",
          "mai mic sau egal cu",
          "mai mare decat",
          "mai mare sau egal cu",
          "incepe cu",
          "nu incepe cu",
          "se termina cu",
          "nu se termina cu",
          "contine",
          "nu contine"
        };

        public static string getConditie(string _strConditie)
        {
            switch (_strConditie)
            {
                case "egal cu":
                    return " = ";
                //break;
                case "diferit de":
                    return " != ";
                //break;
                case "mai mic decat":
                    return " < ";
                //break;
                case "mai mic sau egal cu":
                    return " <= ";
                //break;
                case "mai mare decat":
                    return " > ";
                //break;
                case "mai mare sau egal cu":
                    return " >= ";
                //break;
                case "incepe cu":
                    return " LIKE <#VALUE#>% ";
                //break;
                case "nu incepe cu":
                    return " NOT LIKE <#VALUE#>% ";
                //break;
                case "se termina cu":
                    return " LIKE %<#VALUE#> ";
                //break;
                case "contine":
                    return " LIKE %<#VALUE#>% ";
                //break;
                case "nu contine":
                    return " NOT LIKE %<#VALUE#>% ";
                    //break;
            }
            return null;
        }

        public static string GenerateSimpleFilter(string _filtru, MySqlDataReader _table)
        {
            string _strFilter = "";
            int column_counter = 0;
            int counter = CommonFunctions.GetDbReaderRowCount(_table);
            
            while (_table.Read())
            {
                IDataRecord dr = (IDataRecord)_table;
                string columnName = dr["Field"].ToString().ToLower();
                string columnType = dr["Type"].ToString().ToLower();
                if (columnName != "id" && columnName.IndexOf("id_") == -1 && columnName.IndexOf("_id") == -1)
                {
                    if (_strFilter.Length > 0 && column_counter < counter)
                        _strFilter = String.Format("{0} OR ", _strFilter);

                    if (columnType.IndexOf("bool") > -1 || columnType.IndexOf("tinyint") > -1)
                        _strFilter = String.Format("{0}CAST(`{1}` AS CHAR) LIKE '%{2}%'", _strFilter, columnName, _filtru);
                    else if (columnType.IndexOf("int") > -1 || columnType.IndexOf("double") > -1 || columnType.IndexOf("decimal") > -1)
                        _strFilter = String.Format("{0}CAST(`{1}` AS CHAR) LIKE '%{2}%'", _strFilter, columnName, _filtru);
                    else if (columnType.IndexOf("date") > -1)
                        _strFilter = String.Format("{0}CAST(`{1}` AS CHAR) LIKE '%{2}%'", _strFilter, columnName, _filtru);
                    else if (columnType.IndexOf("char") > -1 || columnType.IndexOf("text") > -1)
                        _strFilter = String.Format("{0}`{1}` LIKE '%{2}%'", _strFilter, columnName, _filtru);
                }
                column_counter++;
            }
            return _strFilter;
        }

        public static string GenerateFilterFromJson(string _filtru, MySqlDataReader _table)
        {
            Filtru[] filtru = JsonConvert.DeserializeObject<Filtru[]>(_filtru);
            //DataTable dt = full_table_columns(_table_name);
            string _strFilter = "";


            for (int i = 0; i < filtru.Length; i++)
            {
                {
                    string _col = filtru[i].Coloana;

                    string columnType = "";

                    if (_col == "EXTRA CONTRACT") _col = "D.EXTRACONTRACT";
                    else _col = _col.Replace(' ', '_');

                    while (_table.Read())
                    {
                        IDataRecord dr = (IDataRecord)_table;

                        if (dr["Field"].ToString() == _col)
                        {
                            columnType = dr["Type"].ToString();
                            break;
                        }

                        switch (_col)
                        {
                            case "ASIGURAT_CASCO":
                                _col = "ASIGC.DENUMIRE";
                                columnType = "VARCHAR";
                                break;
                            case "ASIGURAT_RCA":
                                _col = "ASIGR.DENUMIRE";
                                columnType = "VARCHAR";
                                break;
                            case "ASIGURATOR_CASCO":
                                _col = "SC.DENUMIRE";
                                columnType = "VARCHAR";
                                break;
                            case "ASIGURATOR_RCA":
                                _col = "SR.DENUMIRE";
                                columnType = "VARCHAR";
                                break;
                            case "INTERVENIENT":
                                _col = "I.DENUMIRE";
                                columnType = "VARCHAR";
                                break;
                            case "NR_AUTO_CASCO":
                                _col = "AC.NR_AUTO";
                                columnType = "VARCHAR";
                                break;
                            case "NR_AUTO_RCA":
                                _col = "AR.NR_AUTO";
                                columnType = "VARCHAR";
                                break;
                            case "TIP_DOSAR":
                                _col = "TD.DENUMIRE";
                                columnType = "VARCHAR";
                                break;
                            default:
                                _col = "D." + _col;
                                break;
                        }
                        string _tmpCond = getConditie(filtru[i].Conditie);
                        string _tmpVal = filtru[i].Valoare;

                        if (_tmpVal.ToLower() == "null" && (_tmpCond.Trim() == "=" || _tmpCond.Trim() == "!="))
                        {
                            _strFilter += (_col + (_tmpCond.Trim() == "=" ? " IS NULL " : " IS NOT NULL "));
                        }
                        else if (columnType.ToUpper().StartsWith("DATETIME"))
                        {
                            _tmpVal = CommonFunctions.ToMySqlFormatDate(CommonFunctions.SwitchBackFormatedDate(_tmpVal));
                            _strFilter += (_col + _tmpCond + "'" + _tmpVal + "' ");
                        }
                        else if (columnType.ToUpper().StartsWith("VARCHAR") || columnType.ToUpper().StartsWith("TEXT"))
                        {
                            if (_tmpCond.Replace("<#VALUE#>", "") != _tmpCond)
                            {
                                string _tC = _tmpCond.Replace("%<#VALUE#>%", "'%" + _tmpVal + "%'");
                                _tC = _tC.Replace("%<#VALUE#>", "'%" + _tmpVal + "'");
                                _tC = _tC.Replace("<#VALUE#>%", "'" + _tmpVal + "%'");
                                _tC = _tC.Replace("<#VALUE#>", "'" + _tmpVal + "'");
                                _strFilter += (_col + _tC + " ");
                            }
                            else
                                _strFilter += (_col + _tmpCond + " '" + _tmpVal + "' ");
                        }
                        else
                        {
                            if (_tmpCond.Replace("<#VALUE#>", "") != _tmpCond)
                            {
                                _strFilter += (_col + " = " + _tmpVal);
                            }
                            else
                                _strFilter += (_col + _tmpCond + " " + _tmpVal + " ");
                        }
                        if (filtru[i].Operator != null && filtru[i].Operator.Trim() != "" && i < filtru.Length - 1)
                            _strFilter += (filtru[i].Operator.Replace("SI", "AND").Replace("SAU", "OR") + " ");
                    }
                }
            }
            return _strFilter;
        }

        public static bool Like(this string str, string pattern)
        {
            return new Regex(
                "^" + Regex.Escape(pattern).Replace(@"\*", ".*").Replace(@"\?", ".") + "$",
                RegexOptions.IgnoreCase | RegexOptions.Singleline
            ).IsMatch(str);
        }
        */
        #endregion
    }
}
