using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.IO;
using System.Reflection;

namespace SOCISA
{
    public class ValidationCondition
    {
        public string FieldName { get; set; }
        public string Operator { get; set; }
        public string FieldValue { get; set; }
        public string ExternalTable { get; set; }
        public string ExternalFieldName { get; set; }
        public bool Nomenclature { get; set; }
        public bool Active { get; set; }
    }

    public class Validation
    {
        public string FieldName { get; set; }
        public string ValidationType { get; set; }
        public string ErrorCode { get; set; }
        public bool Active { get; set; }
        public ValidationCondition[] Conditions { get; set; }
    }

    public static class Validator
    {
        public static Dictionary<string, Validation[]> Validations
        {
            get
            {
                try
                {
                    string vs = File.ReadAllText(Path.Combine(CommonFunctions.GetSettingsFolder(), "Validations.json"));
                    return JsonConvert.DeserializeObject<Dictionary<string, Validation[]>>(vs);
                }
                catch { return null; }
            }
        }

        public static Validation[] GetTableValidations(string tableName)
        {
            try
            {
                return Validations[tableName];
            }catch(Exception exp) { LogWriter.Log(exp); return null; }
        }

        private static bool ValidatePropertyValue(string propertyName, object propertyValue, object obj, string op)
        {
            PropertyInfo pi = obj.GetType().GetProperty(propertyName);
            switch (op)
            {
                // TO DO: ceilalti operatori
                default:
                    if (pi.GetValue(obj) == null)
                        return pi.GetValue(obj) == null && propertyValue == null;
                    else
                        return pi.GetValue(obj).ToString() == propertyValue.ToString();
            }
        }

        public static response Validate(int authenticatedUserId, string connectionString, object obj, string tableName, out bool succes)
        {
            succes = false;
            response toReturn = new response(true, "", null, null, new List<Error>());
            Error err = new Error();
            try
            {
                Validation[] validations = Validator.GetTableValidations(tableName);
                if (validations != null && validations.Length > 0) // daca s-au citit validarile din fisier mergem pe fisier
                {
                    PropertyInfo[] pis = obj.GetType().GetProperties();
                    foreach (Validation v in validations)
                    {
                        if (v.Active)
                        {
                            if (v.ValidationType == "Duplicate" && v.FieldName.IndexOf(',') > -1 && obj.GetType().GetProperty("ID").GetValue(obj) == null ) // pentru cautare duplicate dupa campuri (cheie) compusa, doar la Insert
                            {
                                string[] fields = v.FieldName.Replace(" ","").Split(',');
                                if (!Validator.ObjectIsUniqueByMultipleFields(authenticatedUserId, connectionString, fields, obj, tableName))
                                {
                                    toReturn.Status = false;
                                    err = ErrorParser.ErrorMessage(v.ErrorCode);
                                    toReturn.Message = string.Format("{0}{1};", toReturn.Message ?? "", err.ERROR_MESSAGE);
                                    toReturn.InsertedId = null;
                                    toReturn.Error.Add(err);
                                }
                            }
                            else
                            {
                                foreach (PropertyInfo pi in pis)
                                {
                                    if (v.FieldName.ToUpper() == pi.Name.ToUpper())
                                    {
                                        bool applyCondition = true;
                                        switch (v.ValidationType)
                                        {
                                            case "Mandatory":
                                                if (!(v.Conditions == null || v.Conditions.Length == 0))
                                                {
                                                    foreach(ValidationCondition vc in v.Conditions)
                                                    {
                                                        if (vc.Active)
                                                        {
                                                            if (String.IsNullOrWhiteSpace(vc.ExternalTable))
                                                            {
                                                                if(!ValidatePropertyValue(vc.FieldName, vc.FieldValue, obj, vc.Operator))
                                                                {
                                                                    applyCondition = false;
                                                                    break; //una dintre conditii nu e indeplinita
                                                                }
                                                            }
                                                            else
                                                            {
                                                                if (vc.Nomenclature)
                                                                {
                                                                    Models.Nomenclator n = new Models.Nomenclator(authenticatedUserId, connectionString, vc.ExternalTable, vc.FieldValue);
                                                                    PropertyInfo pin = obj.GetType().GetProperty(vc.FieldName);
                                                                    //if (!(Convert.ToInt32(n.ID) == Convert.ToInt32(pin.GetValue(obj))))
                                                                    if (!ValidatePropertyValue(vc.FieldName, n.ID, obj, vc.Operator))
                                                                    {
                                                                        applyCondition = false;
                                                                        break;
                                                                    }
                                                                }
                                                                else
                                                                {
                                                                    // TO DO: conditie pt. altele decat nomenclatoare
                                                                }
                                                            }
                                                        }
                                                    }
                                                }

                                                if (applyCondition)
                                                {
                                                    if (pi.GetValue(obj) == null || pi.GetValue(obj).ToString().Trim() == "")
                                                    {
                                                        toReturn.Status = false;
                                                        err = ErrorParser.ErrorMessage(v.ErrorCode);
                                                        toReturn.Message = string.Format("{0}{1};", toReturn.Message ?? "", err.ERROR_MESSAGE);
                                                        toReturn.InsertedId = null;
                                                        toReturn.Error.Add(err);
                                                    }
                                                }
                                                break;
                                            case "Confirmation":
                                                // ... TO DO ...
                                                break;
                                            case "Duplicate":
                                                try
                                                {
                                                    Type typeOfThis = obj.GetType();
                                                    Type propertyType = pi.GetValue(obj).GetType();
                                                    //ConstructorInfo[] cis = typeOfThis.GetConstructors(BindingFlags.Instance | BindingFlags.Public | BindingFlags.NonPublic);
                                                    ConstructorInfo ci = typeOfThis.GetConstructor(new Type[] { Type.GetType("System.Int32"), Type.GetType("System.String"), propertyType });

                                                    if (ci != null && obj.GetType().GetProperty("ID").GetValue(obj) == null) // doar la insert verificam dublura
                                                    {
                                                        //Dosar dj = new Dosar(authenticatedUserId, connectionString, pi.GetValue(this).ToString()); // trebuie sa existe constructorul pt. campul trimis ca parametru !!!
                                                        dynamic dj = Activator.CreateInstance(typeOfThis, new object[] { authenticatedUserId, connectionString, pi.GetValue(obj) });
                                                        if (dj != null && dj.ID != null)
                                                        {
                                                            toReturn.Status = false;
                                                            err = ErrorParser.ErrorMessage(v.ErrorCode);
                                                            toReturn.Message = string.Format("{0}{1};", toReturn.Message ?? "", err.ERROR_MESSAGE);
                                                            toReturn.InsertedId = null;
                                                            toReturn.Error.Add(err);
                                                        }
                                                    }
                                                }
                                                catch { }
                                                break;
                                        }
                                        break;
                                    }
                                }
                            }
                        }
                    }
                    succes = true;
                }else { succes = false; }
            }catch { succes = false; }
            return toReturn;
        }

        public static bool ObjectIsUniqueByMultipleFields(int authenticatedUserId, string connectionString, string[] fields, object source, string tableName)
        {
            bool toReturn = true;
            string command = String.Format("SELECT * FROM `v{0}` WHERE ", tableName);
            for (int i = 0; i < fields.Length; i++)
            {
                PropertyInfo pi = source.GetType().GetProperty(fields[i]);
                command = String.Format("{0} {1}", command, String.Format("{0}`{1}`='{2}'", i == 0 ? "" : " AND ", fields[i], pi.GetValue(source)));
            }
            DataAccess da = new DataAccess(authenticatedUserId, connectionString, System.Data.CommandType.Text, command);
            MySql.Data.MySqlClient.MySqlDataReader dr = da.ExecuteSelectQuery();
            while (dr.Read())
            {
                System.Data.IDataRecord item = (System.Data.IDataRecord)dr;
                if(dr != null && dr["ID"] != null)
                {
                    toReturn = false;
                    break;
                }
            }
            return toReturn;
        }
    }
}
