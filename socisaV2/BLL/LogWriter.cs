using System;
using System.IO;

namespace SOCISA
{
    public static class LogWriter
    {
        public static string StringFromExceptionData(Exception exp)
        {
            string toReturn = "\r\n";
            if(exp.Data.Count > 0)
            {
                foreach(string key in exp.Data.Keys)
                {
                    toReturn += (key + ": " + exp.Data[key].ToString() + "\r\n");
                }
            }
            return toReturn;
        }

        public static void Log(string exp)
        {
            try
            {
                using (StreamWriter w = File.AppendText(Path.Combine(CommonFunctions.GetLogsFolder(), "ErrorLog.txt")))
                {
                    w.Write(DateTime.Now.ToString("dd.MM.yyyy HH:mm:ss") + exp + "\r\n=====================================================\r\n");
                }
            }
            catch {}
        }

        public static void Log(Exception exp)
        {
            try
            {
                using (StreamWriter w = File.AppendText(Path.Combine(CommonFunctions.GetLogsFolder(), "ErrorLog.txt")))
                {
                    //w.Write(DateTime.Now.ToString("dd.MM.yyyy HH:mm:ss") + "\r\n" + exp.ToString() + (exp.Data.Contains("Fisier") ? ("\r\nFisier: " + exp.Data["Fisier"].ToString()) : "")   + "\r\n=====================================================\r\n");
                    w.Write(DateTime.Now.ToString("dd.MM.yyyy HH:mm:ss") + "\r\n" + exp.ToString() + LogWriter.StringFromExceptionData(exp) + "\r\n=====================================================\r\n");
                }
            }
            catch(Exception exp2) {
                try
                {
                    using (StreamWriter w = File.AppendText("TmpErrorLog.txt"))
                    {
                        w.Write(DateTime.Now.ToString("dd.MM.yyyy HH:mm:ss") + "\r\n" + exp.ToString() + "\r\n=====================================================\r\n");
                        w.Write(DateTime.Now.ToString("dd.MM.yyyy HH:mm:ss") + "\r\n" + exp2.ToString() + "\r\n=====================================================\r\n");
                    }
                }
                catch { }
            }
        }

        public static void Log(string exp, string file)
        {
            try
            {
                using (StreamWriter w = File.AppendText(Path.Combine(CommonFunctions.GetLogsFolder(), file)))
                {
                    w.Write(DateTime.Now.ToString("dd.MM.yyyy HH:mm:ss") + "\r\n" + exp + "\r\n=====================================================\r\n");
                }
            }
            catch { }
        }
    }
}