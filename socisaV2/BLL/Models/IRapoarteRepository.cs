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
    public interface IRapoarteRepository
    {
        response GetMenu();
    }

    public class RapoarteRepository : IRapoarteRepository
    {
        private string connectionString;
        private int authenticatedUserId;

        public RapoarteRepository(int _authenticatedUserId, string _connectionString)
        {
            authenticatedUserId = _authenticatedUserId;
            connectionString = _connectionString;
        }

        public response GetMenu()
        {
            try
            {
                DataAccess da = new DataAccess(authenticatedUserId, connectionString, CommandType.StoredProcedure, "RAPOARTE_MENUsp_select", new object[] {
                new MySqlParameter("_SORT", null),
                new MySqlParameter("_ORDER", null),
                new MySqlParameter("_FILTER", null),
                new MySqlParameter("_LIMIT", null) });

                List<Action> aList = new List<Action>();
                MySqlDataReader r = da.ExecuteSelectQuery();
                while (r.Read())
                {
                    Action a = new Action(authenticatedUserId, connectionString, (IDataRecord)r);
                    aList.Add(a);
                }
                r.Close(); r.Dispose(); da.CloseConnection();
                return new response(true, JsonConvert.SerializeObject(aList.ToArray(), CommonFunctions.JsonSerializerSettings), aList.ToArray(), null, null);
            }
            catch (Exception exp) { LogWriter.Log(exp); return new response(false, exp.ToString(), null, null, new List<Error>() { new Error(exp) }); }
        }
    }
} 
