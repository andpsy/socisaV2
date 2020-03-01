using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Data;
using ExternalServiceCalls.ServiceReference1;
using SOCISA;
using SOCISA.Models;
using System.Globalization;
using System.Configuration;
using System.Security.Cryptography;
using System.Text;
using System.IO;
using ExternalServiceCalls.ServiceReference2;

namespace ExternalServiceCalls
{
    static class Program
    {
        public static DataTable SocietatiMappings = new DataTable();
        public static DataTable TipuriDocumentMappings = new DataTable();
        public static bool WithoutEmails = false;
        public static bool WithoutMarkings = false;
        public static bool WithPdfs = false;
        public static bool Interactive = false;
        public static bool Documente = false;
        public static bool DocumenteAll = false;
        public static string Cale = "C:\\Uploads\\PlanseFoto";
        public static string DenumireSocietate = "ALLIANZ TIRIAC";
        public static bool RestoreDocumente = false;
        public static bool SincronizareDosarePortal = false;

        /// <summary>
        /// The main entry point for the application.
        /// </summary>
        [STAThread]
        static void Main(string[] args)
        {
            System.Net.ServicePointManager.ServerCertificateValidationCa‌​llback += (se, cert, chain, sslerror) => true;
            Application.EnableVisualStyles();
            Application.SetCompatibleTextRenderingDefault(false);
            try
            {
                SocietatiMappings = GetSocietatiMappings(DenumireSocietate);
                TipuriDocumentMappings = GetTipuriDocumentMappings(DenumireSocietate);
            }
            catch { }
            if(args.Length > 0)
            {
                for (int i = 0; i < args.Length; i++)
                {
                    switch (args[i].Trim())
                    {
                        case "-we":
                            WithoutEmails = true;
                            break;
                        case "-wm":
                            WithoutMarkings = true;
                            break;
                        case "-wp":
                            WithPdfs = true;
                            break;
                        case "-i":
                            Interactive = true;
                            break;
                        case "-d": // pt. import documente 
                            Documente = true;
                            break;
                        case "-a": // daca se trimite si -a fisierele trebuie puse toate in directorul cu numarul dosarului / fara -a trebuie documentele in DOC si pozele in PLANSE
                            DocumenteAll = true;
                            break;
                        case "-rd":
                            RestoreDocumente = true;
                            break;
                        case "-sdp":
                            SincronizareDosarePortal = true;
                            break;
                        default:
                            if (args[i].Trim().IndexOf("-path") > -1)
                            {
                                Cale = args[i].Trim().Replace("-path:", "");
                            }
                            else
                            {
                                DenumireSocietate = args[i].Trim();
                            }
                            break;
                    }
                }
            }
            if (Documente && !Interactive && !RestoreDocumente)
            {
                CallDocumente();
                return;
            }
            if (Interactive && !Documente && !RestoreDocumente)
            {
                Application.Run(new Form1(WithoutEmails, WithoutMarkings, WithPdfs, DenumireSocietate));
                return;
            }
            if (!Documente && !Interactive && !RestoreDocumente && !SincronizareDosarePortal)
            {
                CallService(WithoutEmails, WithoutMarkings, WithPdfs, DenumireSocietate);
                return;
            }
            if (RestoreDocumente && !Documente && !Interactive)
            {
                RestoreOrphanDocuments();
                return;
            }
            if (SincronizareDosarePortal)
            {
                SincronizareTermenePortal();
                return;
            }

            LogWriter.Log(new Exception("Invalid arguments!"));
        }

        public static void RestoreOrphanDocuments()
        {
            string LOG_FILE = "c:\\Uploads\\Log.txt";
            response r = new response();
            string conStr = CommonFunctions.StringCipher.Decrypt(ConfigurationManager.ConnectionStrings["MySqlConnectionString"].ToString(), CommonFunctions.StringCipher.RetrieveKey());
            int id = 1;
            DocumenteScanateRepository dsr = new DocumenteScanateRepository(id, conStr);
            DocumentScanat[] docs = (DocumentScanat[])dsr.GetOrphanDocuments().Result;
            //FileManager.RestoreFilesFromDb(docs);
            StreamWriter sw = File.AppendText(LOG_FILE);
            sw.Write(String.Format("{0} documente orfane\r\n*****************************************************\r\n\r\n", docs.Length));
            sw.Flush(); sw.Dispose();
            foreach (DocumentScanat ds in docs)
            {
                r = FileManager.RestoreFileFromDb(ds);
                string message = String.Format("{0} ({1}) - {2}\r\n", ds.CALE_FISIER, ds.ID_DOSAR, r.Status ? "Recuperat" : r.Message);
                Console.Write(message);
                sw = File.AppendText(LOG_FILE);
                sw.Write(message);
                sw.Flush(); sw.Dispose();
            }
        }

        public static void CallDocumente()
        {
            response r = new response();
            string conStr = CommonFunctions.StringCipher.Decrypt(ConfigurationManager.ConnectionStrings["MySqlConnectionString"].ToString(), CommonFunctions.StringCipher.RetrieveKey());
            int _CURENT_USER_ID = 1;
            DosareRepository dr = new DosareRepository(_CURENT_USER_ID, conStr);
            SOCISA.Models.Dosar[] ds = (SOCISA.Models.Dosar[])dr.GetAll().Result;
            foreach (SOCISA.Models.Dosar d in ds)
            {
                try
                {
                    ProcessDirectory(Cale, d);
                }
                catch (Exception exp)
                {
                    LogWriter.Log(exp);
                }
            }
        }

        // Process all files in the directory passed in, recurse on any directories 
        // that are found, and process the files they contain.
        public static void ProcessDirectory(string targetDirectory, SOCISA.Models.Dosar dosar)
        {
            string conStr = CommonFunctions.StringCipher.Decrypt(ConfigurationManager.ConnectionStrings["MySqlConnectionString"].ToString(), CommonFunctions.StringCipher.RetrieveKey());
            int _CURENT_USER_ID = 1;
            response r = new response();
            string LOG_FILE = "c:\\Uploads\\Log.txt";
            try
            {
                // Recurse into subdirectories of this directory.
                string[] subdirectoryEntries = Directory.GetDirectories(targetDirectory);
                if (DocumenteAll)
                {
                    foreach (string subdirectory in subdirectoryEntries)
                    {
                        if (subdirectory.ToUpper().Substring(subdirectory.LastIndexOf('\\') + 1) == dosar.NR_DOSAR_CASCO.ToUpper())
                        {
                            try
                            {
                                //incarcam documentele
                                string[] docs = Directory.GetFiles(subdirectory, "*.*", SearchOption.AllDirectories);
                                /*
                                StreamWriter sss = File.AppendText(dosar.NR_DOSAR_CASCO + "_docs.txt");
                                foreach (string f in docs)
                                {
                                    sss.Write(String.Format("{0}\r\n", f));
                                }
                                sss.Flush(); sss.Dispose();
                                */
                                TipDocument td = new TipDocument(_CURENT_USER_ID, conStr, "ALTE INSCRISURI");
                                foreach (string fileName in docs)
                                {
                                    try
                                    {
                                        DocumentScanat ods = new DocumentScanat(_CURENT_USER_ID, conStr, fileName.Substring(fileName.LastIndexOf('\\') + 1), Convert.ToInt32(dosar.ID));
                                        if (ods != null && ods.ID != null) // exista deja documentul in bd
                                        {
                                            Console.Write(String.Format("{0} - {1} exista deja in baza de date!", dosar.NR_DOSAR_CASCO, fileName));
                                            StreamWriter sw = File.AppendText(LOG_FILE);
                                            sw.Write(String.Format("{0} - {1} exista deja in baza de date!\r\n", dosar.NR_DOSAR_CASCO, fileName));
                                            sw.Flush(); sw.Dispose();
                                        }
                                        else
                                        {
                                            string newFName = FileManager.CopyFileToServer(fileName);
                                            if (newFName != null)
                                            {
                                                DocumentScanat ds = new DocumentScanat(_CURENT_USER_ID, conStr);
                                                ds.CALE_FISIER = newFName;
                                                ds.DENUMIRE_FISIER = fileName.Substring(fileName.LastIndexOf('\\') + 1);
                                                ds.ID_TIP_DOCUMENT = Convert.ToInt32(td.ID);
                                                ds.ID_DOSAR = Convert.ToInt32(dosar.ID);
                                                r = ds.Insert();
                                                if (r.Status)
                                                {
                                                    Console.Write(String.Format("{0} - {1} importat!", dosar.NR_DOSAR_CASCO, fileName));
                                                    StreamWriter sw = File.AppendText(LOG_FILE);
                                                    sw.Write(String.Format("{0} - {1} importat!\r\n", dosar.NR_DOSAR_CASCO, fileName));
                                                    sw.Flush(); sw.Dispose();
                                                }
                                                else
                                                {
                                                    Console.Write(String.Format("{0} - {1} eroare, {2}!", dosar.NR_DOSAR_CASCO, fileName, r.Message));
                                                    StreamWriter sw = File.AppendText(LOG_FILE);
                                                    sw.Write(String.Format("{0} - {1} eroare, {2}!", dosar.NR_DOSAR_CASCO, fileName, r.Message));
                                                    sw.Flush(); sw.Dispose();
                                                }
                                            }
                                        }
                                    }
                                    catch (Exception exp) { LogWriter.Log(exp); }
                                }
                            }
                            catch (Exception exp) { LogWriter.Log(exp); }
                        }
                        ProcessDirectory(subdirectory, dosar);
                    }
                }
                else
                {
                    foreach (string subdirectory in subdirectoryEntries)
                    {
                        if (subdirectory.ToUpper().Substring(subdirectory.LastIndexOf('\\') + 1) == String.Format("{0} DOC", dosar.NR_DOSAR_CASCO.ToUpper()))
                        {
                            try
                            {
                                //incarcam documentele
                                string[] docs = Directory.GetFiles(subdirectory);
                                TipDocument td = new TipDocument(_CURENT_USER_ID, conStr, "ALTE INSCRISURI");
                                foreach (string fileName in docs)
                                {
                                    try
                                    {
                                        DocumentScanat ods = new DocumentScanat(_CURENT_USER_ID, conStr, fileName.Substring(fileName.LastIndexOf('\\') + 1), Convert.ToInt32(dosar.ID));
                                        if (ods != null && ods.ID != null) // exista deja documentul in bd
                                        {
                                            Console.Write(String.Format("{0} - {1} exista deja in baza de date!", dosar.NR_DOSAR_CASCO, fileName));
                                            StreamWriter sw = File.AppendText(LOG_FILE);
                                            sw.Write(String.Format("{0} - {1} exista deja in baza de date!\r\n", dosar.NR_DOSAR_CASCO, fileName));
                                            sw.Flush(); sw.Dispose();
                                        }
                                        else
                                        {
                                            string newFName = FileManager.CopyFileToServer(fileName);
                                            if (newFName != null)
                                            {
                                                DocumentScanat ds = new DocumentScanat(_CURENT_USER_ID, conStr);
                                                ds.CALE_FISIER = newFName;
                                                ds.DENUMIRE_FISIER = fileName.Substring(fileName.LastIndexOf('\\') + 1);
                                                ds.ID_TIP_DOCUMENT = Convert.ToInt32(td.ID);
                                                ds.ID_DOSAR = Convert.ToInt32(dosar.ID);
                                                r = ds.Insert();
                                                if (r.Status)
                                                {
                                                    Console.Write(String.Format("{0} - {1} importat!", dosar.NR_DOSAR_CASCO, fileName));
                                                    StreamWriter sw = File.AppendText(LOG_FILE);
                                                    sw.Write(String.Format("{0} - {1} importat!\r\n", dosar.NR_DOSAR_CASCO, fileName));
                                                    sw.Flush(); sw.Dispose();
                                                }
                                                else
                                                {
                                                    Console.Write(String.Format("{0} - {1} eroare, {2}!", dosar.NR_DOSAR_CASCO, fileName, r.Message));
                                                    StreamWriter sw = File.AppendText(LOG_FILE);
                                                    sw.Write(String.Format("{0} - {1} eroare, {2}!", dosar.NR_DOSAR_CASCO, fileName, r.Message));
                                                    sw.Flush(); sw.Dispose();
                                                }
                                            }
                                        }
                                    }
                                    catch (Exception exp) { LogWriter.Log(exp); }
                                }
                            }
                            catch (Exception exp) { LogWriter.Log(exp); }
                        }

                        if (subdirectory.ToUpper().Substring(subdirectory.LastIndexOf('\\') + 1) == String.Format("{0} PLANSE", dosar.NR_DOSAR_CASCO.ToUpper()))
                        {
                            try
                            {
                                //incarcam plansele
                                string[] docs = Directory.GetFiles(subdirectory);
                                TipDocument td = new TipDocument(_CURENT_USER_ID, conStr, "FOTOGRAFII DE CONSTATARE");
                                foreach (string fileName in docs)
                                {
                                    try
                                    {
                                        DocumentScanat ods = new DocumentScanat(_CURENT_USER_ID, conStr, fileName.Substring(fileName.LastIndexOf('\\') + 1), Convert.ToInt32(dosar.ID));
                                        if (ods != null && ods.ID != null) // exista deja documentul in bd
                                        {
                                            Console.Write(String.Format("{0} - {1} exista deja in baza de date!", dosar.NR_DOSAR_CASCO, fileName));
                                            StreamWriter sw = File.AppendText(LOG_FILE);
                                            sw.Write(String.Format("{0} - {1} exista deja in baza de date!\r\n", dosar.NR_DOSAR_CASCO, fileName));
                                            sw.Flush(); sw.Dispose();
                                        }
                                        else
                                        {
                                            string newFName = FileManager.CopyFileToServer(fileName);
                                            if (newFName != null)
                                            {
                                                DocumentScanat ds = new DocumentScanat(_CURENT_USER_ID, conStr);
                                                ds.CALE_FISIER = newFName;
                                                ds.DENUMIRE_FISIER = fileName.Substring(fileName.LastIndexOf('\\') + 1);
                                                ds.ID_TIP_DOCUMENT = Convert.ToInt32(td.ID);
                                                ds.ID_DOSAR = Convert.ToInt32(dosar.ID);
                                                r = ds.Insert();
                                                if (r.Status)
                                                {
                                                    Console.Write(String.Format("{0} - {1} importat!", dosar.NR_DOSAR_CASCO, fileName));
                                                    StreamWriter sw = File.AppendText(LOG_FILE);
                                                    sw.Write(String.Format("{0} - {1} importat!\r\n", dosar.NR_DOSAR_CASCO, fileName));
                                                    sw.Flush(); sw.Dispose();
                                                }
                                                else
                                                {
                                                    Console.Write(String.Format("{0} - {1} eroare, {2}!", dosar.NR_DOSAR_CASCO, fileName, r.Message));
                                                    StreamWriter sw = File.AppendText(LOG_FILE);
                                                    sw.Write(String.Format("{0} - {1} eroare, {2}!", dosar.NR_DOSAR_CASCO, fileName, r.Message));
                                                    sw.Flush(); sw.Dispose();
                                                }
                                            }
                                        }
                                    }
                                    catch (Exception exp) { LogWriter.Log(exp); }
                                }
                            }
                            catch (Exception exp) { LogWriter.Log(exp); }
                        }
                        ProcessDirectory(subdirectory, dosar);
                    }
                }
            }
            catch (Exception exp)
            {
                LogWriter.Log(exp);
            }
        }

        public static void CallService(bool WithoutEmails, bool WithoutMarkings, bool WithPdfs, string DenumireSocietate)
        {
            response r = new response();
            try
            {
                int uid = 1;
                List<string> conStrs = new List<string>();
                conStrs.Add(CommonFunctions.StringCipher.Decrypt( ConfigurationManager.ConnectionStrings["MySqlConnectionString"].ToString(), CommonFunctions.StringCipher.RetrieveKey()));
                //conStrs.Add(StringCipher.Decrypt( ConfigurationManager.ConnectionStrings["MySqlConnectionString_test"].ToString(), RetrieveKey()));  // -- daca vrem insert si in baza de test !!! dubleaza documentele in "scan"
                /*
                BasicHttpBinding binding = new BasicHttpBinding();
                binding.MaxBufferPoolSize = binding.MaxBufferSize = Int32.MaxValue;
                binding.MaxReceivedMessageSize = long.MaxValue;
                */
                SubrogationServiceClient s = new SubrogationServiceClient();
                /*
                (s.ChannelFactory.Endpoint.Binding as BasicHttpBinding).MaxBufferPoolSize = Int32.MaxValue;
                (s.ChannelFactory.Endpoint.Binding as BasicHttpBinding).MaxBufferSize = Int32.MaxValue;
                (s.ChannelFactory.Endpoint.Binding as BasicHttpBinding).MaxReceivedMessageSize = Int32.MaxValue;
                */

                s.ClientCredentials.UserName.UserName = CommonFunctions.StringCipher.Decrypt( ConfigurationManager.AppSettings["AllianzWSUser"].ToString(), CommonFunctions.StringCipher.RetrieveKey());
                s.ClientCredentials.UserName.Password = CommonFunctions.StringCipher.Decrypt(ConfigurationManager.AppSettings["AllianzWSPassword"].ToString(), CommonFunctions.StringCipher.RetrieveKey());

                s.InnerChannel.OperationTimeout = new TimeSpan(0, 10, 0);

                SubrogationInfo[] sis = s.BrowseUnreadSubrogations(DateTime.MinValue, DateTime.MinValue);
                int counter = 0;
                foreach (SubrogationInfo si in sis)
                {
                    //if (counter > 2) return;
                    foreach (string conStr in conStrs) // salvam in ambele baze !
                    {
                        try
                        {
                            response validationResponse = new response();
                            SOCISA.Models.Dosar d = new SOCISA.Models.Dosar(uid, conStr);
                            try
                            {
                                SocietateAsigurare sCasco = new SocietateAsigurare(uid, conStr, DenumireSocietate, true);
                                d.ID_SOCIETATE_CASCO = sCasco.ID;
                            }
                            catch (Exception exp) { LogWriter.Log(exp); }
                            try
                            {
                                //SocietateAsigurare sRca = new SocietateAsigurare(uid, conStr, si.SubrogationInsurerName, false);
                                SocietateAsigurare sRca = null;
                                int? id_soc = GetSocietateMapping(SocietatiMappings, si.SubrogationInsurerId);
                                if (id_soc != null && id_soc != 0)
                                {
                                    sRca = new SocietateAsigurare(uid, conStr, Convert.ToInt32(id_soc));
                                }
                                if (sRca == null || sRca.ID == null)
                                {
                                    sRca = new SocietateAsigurare(uid, conStr);
                                    sRca.DENUMIRE = sRca.DENUMIRE_SCURTA = si.SubrogationInsurerName;
                                    sRca.ADRESA = si.SubrogationInsurerCountry;
                                    r = sRca.Insert();
                                    /*
                                    if(r.InsertedId != null && id_soc == null)
                                    {
                                        DataRow newRow = SocietatiMappings.NewRow();
                                        newRow["ID_SCA"] = r.InsertedId;
                                        newRow["ID_SOCIETATE"] = id_soc;
                                        SocietatiMappings.Rows.Add(newRow);
                                        SocietatiMappings.AcceptChanges();
                                        SaveSocietatiMappings(DenumireSocietate);
                                    }
                                    */
                                }
                                d.ID_SOCIETATE_RCA = sRca.ID;
                            }
                            catch(Exception exp) { LogWriter.Log(exp); }

                            try
                            {
                                if (!String.IsNullOrWhiteSpace(si.InsuredFullName))
                                {
                                    Asigurat aCasco = new Asigurat(uid, conStr, si.InsuredFullName);
                                    if (aCasco == null || aCasco.ID == null)
                                    {
                                        aCasco = new Asigurat(uid, conStr);
                                        aCasco.DENUMIRE = si.InsuredFullName;
                                        r = aCasco.Insert();
                                    }
                                    d.ID_ASIGURAT_CASCO = aCasco.ID;
                                }
                            }
                            catch (Exception exp) { LogWriter.Log(exp); }

                            try
                            {
                                if (!String.IsNullOrWhiteSpace(si.SubrogationGuiltyPartner))
                                {
                                    Asigurat aRca = new Asigurat(uid, conStr, si.SubrogationGuiltyPartner);
                                    if (aRca == null || aRca.ID == null)
                                    {
                                        aRca = new Asigurat(uid, conStr);
                                        aRca.DENUMIRE = si.SubrogationGuiltyPartner;
                                        r = aRca.Insert();
                                    }
                                    d.ID_ASIGURAT_RCA = aRca.ID;
                                }
                            }
                            catch (Exception exp) { LogWriter.Log(exp); }

                            try
                            {
                                if (!String.IsNullOrWhiteSpace(si.InsuredCarPlateNo))
                                {
                                    Auto autoCasco = new Auto(uid, conStr, si.InsuredCarPlateNo);
                                    if (autoCasco == null || autoCasco.ID == null)
                                    {
                                        autoCasco = new Auto(uid, conStr);
                                        autoCasco.NR_AUTO = si.InsuredCarPlateNo;
                                        autoCasco.MARCA = si.InsuredCarBrandName;
                                        autoCasco.MODEL = si.InsuredCarModelName;
                                        autoCasco.SERIE_SASIU = si.InsuredCarChassisNo;
                                        r = autoCasco.Insert();
                                    }
                                    d.ID_AUTO_CASCO = autoCasco.ID;
                                }
                            }
                            catch (Exception exp) { LogWriter.Log(exp); }

                            try
                            {
                                if (!String.IsNullOrWhiteSpace(si.SubrogationCarPlateNo))
                                {
                                    Auto autoRca = new Auto(uid, conStr, si.SubrogationCarPlateNo);
                                    if (autoRca == null || autoRca.ID == null)
                                    {
                                        autoRca = new Auto(uid, conStr);
                                        autoRca.NR_AUTO = si.SubrogationCarPlateNo;
                                        //autoRca.MARCA = si.SubrogationCarBrandName;
                                        //autoRca.MODEL = si.SubrogationCarModelName;
                                        autoRca.SERIE_SASIU = si.SubrogationCarChassisNo;
                                        r = autoRca.Insert();
                                    }
                                    d.ID_AUTO_RCA = autoRca.ID;
                                }
                            }
                            catch (Exception exp) { LogWriter.Log(exp); }

                            try { d.CAZ = si.AmiableAssessmentNo; } catch { }
                            try { d.DATA_CREARE = d.DATA_ULTIMEI_MODIFICARI = DateTime.Now; } catch { }
                            try {
                                if (si.LossDate == DateTime.MinValue)
                                    d.DATA_EVENIMENT = null;
                                else
                                    d.DATA_EVENIMENT = si.LossDate;
                            } catch { }
                            try { d.DATA_NOTIFICARE = si.AssessmentDate; } catch { } //?? - la ei este Data Constatarii, nu cred ca e tot una cu Data Notificarii de la noi
                            try { d.NR_DOSAR_CASCO = si.ClaimFileNo; } catch { }
                            try { d.NR_POLITA_CASCO = si.InsuredPolicyNo; } catch { }
                            try { d.NR_POLITA_RCA = si.SubrogationRcoPolicyNo; } catch { }
                            try { d.SUMA_IBNR = d.VALOARE_DAUNA = d.VALOARE_REGRES = d.VMD = d.REZERVA_DAUNA = Convert.ToDouble(si.ClaimReserveValueRon); } catch { }
                            try { d.LOC_ACCIDENT = String.Format("{0}{1}{2}{3}{4}{5}", 
                                si.LossCountry,
                                String.IsNullOrWhiteSpace(si.LossCity) ? "" : ", " + si.LossCity, 
                                String.IsNullOrWhiteSpace(si.LossDistrictNo.ToString()) ? "" : ", sector " + si.LossDistrictNo.ToString(),
                                String.IsNullOrWhiteSpace(si.LossStreet) ? "" : ", str. " + si.LossStreet,
                                String.IsNullOrWhiteSpace(si.LossStreetNo) ? "" : ", nr. " + si.LossStreetNo,
                                String.IsNullOrWhiteSpace(si.LossIntersection) ? "" : ", intersectie cu str. " + si.LossIntersection);
                            } catch { }

                            validationResponse = d.Validare();
                            if (validationResponse.Status)
                            {
                                r = d.Insert();
                                validationResponse.InsertedId = r.InsertedId;
                                validationResponse.Status = true;
                                if (r.Status && r.InsertedId != null)
                                {
                                    d.Log(validationResponse, 1);  // 1 = automatic import
                                    ClaimDocumentSummary[] cdss = s.BrowseClaimDocuments(si.ClaimId, DateTime.MinValue);
                                    foreach (ClaimDocumentSummary cds in cdss)
                                    {
                                        try
                                        {
                                            //TipDocument td = new TipDocument(uid, conStr, cds.CategoryName);
                                            TipDocument td = null;
                                            int? id_tip_doc = GetTipDocumentMapping(TipuriDocumentMappings, cds.CategoryId);
                                            if (id_tip_doc != null && id_tip_doc != 0)
                                            {
                                                td = new TipDocument(uid, conStr, Convert.ToInt32(id_tip_doc));
                                            }

                                            DocumentScanat ds = new DocumentScanat(uid, conStr);
                                            ds.DENUMIRE_FISIER = String.IsNullOrWhiteSpace(cds.Name) ? cds.FileName : cds.Name;
                                            ds.EXTENSIE_FISIER = !String.IsNullOrWhiteSpace(cds.Extension) ? cds.Extension : !String.IsNullOrWhiteSpace(cds.Name) ? cds.Name.Substring(cds.Name.LastIndexOf('.')) : cds.FileName.Substring(cds.FileName.LastIndexOf('.'));
                                            ds.ID_TIP_DOCUMENT = Convert.ToInt32(td.ID);
                                            ds.ID_DOSAR = Convert.ToInt32(d.ID);

                                            BinaryContent bc = s.GetClaimDocumentDetails(cds.Id);
                                            ds.FILE_CONTENT = bc.BinaryData;

                                            ds.CALE_FISIER = FileManager.SaveBinaryContentToFile(bc.BinaryData, ds.EXTENSIE_FISIER);

                                            response rd = ds.Validare();
                                            if (rd.Status)
                                            {
                                                rd = ds.Insert();
                                                ds.Log(rd, 1);  // 1 = automatic import
                                            }
                                            if (!rd.Status) // marcam dosarul ca citit (preluat) de la Allianz doar daca s-a reusit preluarea tuturor documentelor asociate
                                                r.AddResponse(rd);
                                        }
                                        catch (Exception exp) {
                                            LogWriter.Log(exp);
                                            r.AddResponse(new response(false, exp.ToString(), null, null, new List<Error>() { new Error(exp) } ));
                                        }
                                    }

                                    if (r.Status)
                                    {
                                        if(!WithoutMarkings)
                                            s.MarkAsReadByClaimId(si.ClaimId);
                                        if (WithoutEmails && WithPdfs)
                                            d.GenerateNotificarePdf();
                                        if(!WithoutEmails)
                                            d.SendNotificare(EmailProfiles.AwsNotificariSES);
                                    }
                                }
                            }
                            else
                            {
                                r = d.InsertWithErrors();
                                validationResponse.Status = false;
                                validationResponse.InsertedId = r.InsertedId;
                                if (r.Status && r.InsertedId != null)
                                {
                                    d.Log(validationResponse, 1); // 1 = automatic import
                                    ClaimDocumentSummary[] cdss = s.BrowseClaimDocuments(si.ClaimId, DateTime.MinValue);
                                    foreach (ClaimDocumentSummary cds in cdss)
                                    {
                                        try
                                        {
                                            //TipDocument td = new TipDocument(uid, conStr, cds.CategoryName);
                                            TipDocument td = null;
                                            int? id_tip_doc = GetTipDocumentMapping(TipuriDocumentMappings, cds.CategoryId);
                                            if (id_tip_doc != null && id_tip_doc != 0)
                                            {
                                                td = new TipDocument(uid, conStr, Convert.ToInt32(id_tip_doc));
                                            }

                                            DocumentScanat ds = new DocumentScanat(uid, conStr);
                                            ds.DENUMIRE_FISIER = String.IsNullOrWhiteSpace(cds.Name) ? cds.FileName : cds.Name;
                                            ds.EXTENSIE_FISIER = !String.IsNullOrWhiteSpace(cds.Extension) ? cds.Extension : !String.IsNullOrWhiteSpace(cds.Name) ? cds.Name.Substring(cds.Name.LastIndexOf('.')) : cds.FileName.Substring(cds.FileName.LastIndexOf('.'));
                                            ds.ID_TIP_DOCUMENT = Convert.ToInt32(td.ID);
                                            ds.ID_DOSAR = Convert.ToInt32(d.ID);

                                            BinaryContent bc = s.GetClaimDocumentDetails(cds.Id);
                                            ds.FILE_CONTENT = bc.BinaryData;

                                            ds.CALE_FISIER = FileManager.SaveBinaryContentToFile(bc.BinaryData, ds.EXTENSIE_FISIER);

                                            response rd = ds.Validare();
                                            if (rd.Status)
                                            {
                                                rd = ds.InsertWithErrors();
                                                ds.Log(rd, 1); // 1 = automatic import
                                            }
                                            if (!rd.Status) // marcam dosarul ca citit (preluat) de la Allianz doar daca s-a reusit preluarea tuturor documentelor asociate
                                                r.AddResponse(rd);
                                        }
                                        catch (Exception exp) {
                                            LogWriter.Log(exp);
                                            r.AddResponse(new response(false, exp.ToString(), null, null, new List<Error>() { new Error(exp) }));
                                        }
                                    }

                                    if (r.Status)
                                    {
                                        if(!WithoutMarkings)
                                            s.MarkAsReadByClaimId(si.ClaimId);
                                    }
                                }
                            }
                        }
                        catch (Exception exp) { LogWriter.Log(exp); }
                        counter++;
                    }
                }
            }
            catch (Exception exp)
            {
                LogWriter.Log(exp);
            }
        }


        private static DataTable GetSocietatiMappings(string _DENUMIRE_SOCIETATE)
        {
            TextInfo ti = new CultureInfo("en-US", false).TextInfo;
            string file_name = String.Format("{0}SocietatiMappings.xml", ti.ToTitleCase(_DENUMIRE_SOCIETATE));
            DataSet soc = new DataSet("SOCIETATI");
            soc.ReadXml(file_name);
            return soc.Tables[0];
        }

        private static void SaveSocietatiMappings(string _DENUMIRE_SOCIETATE)
        {
            try
            {
                TextInfo ti = new CultureInfo("en-US", false).TextInfo;
                string file_name = String.Format("{0}SocietatiMappings.xml", ti.ToTitleCase(_DENUMIRE_SOCIETATE));
                SocietatiMappings.WriteXml(file_name);
            }
            catch(Exception exp) { LogWriter.Log(exp); }
        }

        private static int? GetSocietateMapping(DataTable _MAPPINGS, int? _ID_SOCIETATE)
        {
            try
            {
                DataRow dr = _MAPPINGS.Select(String.Format("ID_SOCIETATE = '{0}'", _ID_SOCIETATE))[0];
                return Convert.ToInt32(dr["ID_SCA"]);
            }
            catch { return null; }
        }

        private static DataTable GetTipuriDocumentMappings(string _DENUMIRE_SOCIETATE)
        {
            TextInfo ti = new CultureInfo("en-US", false).TextInfo;
            string file_name = String.Format("{0}TipuriDocumentMappings.xml", ti.ToTitleCase(_DENUMIRE_SOCIETATE));
            DataSet tipuri_document = new DataSet("TIPURI_DOCUMENT");
            tipuri_document.ReadXml(file_name);
            return tipuri_document.Tables[0];
        }

        private static int? GetTipDocumentMapping(DataTable _TIPURI_DOCUMENT, int? _ID_TIP_DOCUMENT_SOCIETATE)
        {
            try
            {
                DataRow dr = _TIPURI_DOCUMENT.Select(String.Format("ID_TIP_DOCUMENT_SOCIETATE LIKE '{0},%' OR ID_TIP_DOCUMENT_SOCIETATE LIKE '%,{0}' OR ID_TIP_DOCUMENT_SOCIETATE LIKE '%,{0},%'", _ID_TIP_DOCUMENT_SOCIETATE.ToString()))[0];
                return Convert.ToInt32(dr["ID_TIP_DOCUMENT_SCA"]);
            }
            catch
            {
                try
                {
                    DataRow dr = _TIPURI_DOCUMENT.Select("ID_TIP_DOCUMENT_SOCIETATE LIKE '%,ALL'")[0];
                    return Convert.ToInt32(dr["ID_TIP_DOCUMENT_SCA"]);
                }
                catch
                {
                    return null;
                }
            }
        }

        private static void SincronizareTermenePortal()
        {
            string conStr = CommonFunctions.StringCipher.Decrypt(ConfigurationManager.ConnectionStrings["MySqlConnectionString"].ToString(), CommonFunctions.StringCipher.RetrieveKey());
            int id = 1;
            ProceseRepository pr = new ProceseRepository(id, conStr);
            Proces[] procese = (Proces[])pr.GetFiltered(null, null, " PROCESE.NR_DOSAR_INSTANTA LIKE '%/%' ", null).Result;
            List<SOCISA.Models.SedintaPortal> lst = new List<SedintaPortal>();
            QuerySoapClient ws = new QuerySoapClient();
            for (int i = 0; i < procese.Length; i++)
            {
                try
                {                    
                    int id_dosar = Convert.ToInt32(procese[i].ID_DOSAR);
                    Dosar d = new Dosar(id, conStr, id_dosar);
                    int id_proces = Convert.ToInt32(procese[i].ID);
                    string nr_dosar = procese[i].NR_DOSAR_INSTANTA;

                    socisaV2.PortalWS.Dosar dosar = ws.CautareDosare2(nr_dosar, null, null, null, null, null, null, null)[0];
                    for (int j = 0; j < dosar.sedinte.Length; j++)
                    {
                        bool gasit = false;
                        for (int k = 0; k <= 7; k++)
                        {
                            if (dosar.sedinte[j].data.Date == DateTime.Now.Date.AddDays(k).Date)
                            {
                                SedintaPortal dsp = new SedintaPortal(id, conStr);
                                dsp.ID_DOSAR = id_dosar;
                                try
                                {
                                    dsp.NR_DOSAR_CASCO = d.NR_DOSAR_CASCO;
                                }
                                catch { }
                                dsp.ID_PROCES = id_proces;
                                dsp.NR_DOSAR_INSTANTA = procese[i].NR_DOSAR_INSTANTA;
                                dsp.DATA = DateTime.Now.Date;
                                dsp.DATA_SEDINTA = dosar.sedinte[j].data;
                                dsp.INSTANTA = dosar.institutie.ToString();
                                dsp.COMPLET = dosar.sedinte[j].complet;
                                dsp.ORA = dosar.sedinte[j].ora;
                                dsp.MONITORIZARE = true;
                                dsp.Insert();
                                gasit = true;
                                break;
                            }
                        }
                        if (gasit) break;
                    }
                }
                catch(Exception exp) { exp.ToString(); }
            }
        }
    }
}
