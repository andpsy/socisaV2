using System;
using System.Collections.Generic;
using System.IO;
using System.Data;
using MySql.Data.MySqlClient;
//using Microsoft.AspNetCore.Http;
using System.Linq;
using System.Collections;
using System.IO.Compression;

namespace SOCISA
{
    public static class FileManager
    {
        /*
        public static Dictionary<string, byte[]> UploadFile(ICollection<IFormFile> files)
        {
            Dictionary<string, byte[]> toReturn = new Dictionary<string, byte[]>();

            foreach (IFormFile file in files)
            {
                if (file.Length > 0)
                {
                    toReturn.Add(file.FileName, UploadFile(file));
                }
            }
            return toReturn;
        }
        */

        /*
        public static byte[] UploadFile(IFormFile file)
        {
            BinaryReader reader = new BinaryReader(file.OpenReadStream());
            byte[]  toReturn = reader.ReadBytes((int)file.Length);
            return toReturn;
        }
        */

        public static byte[] UploadFile(string filePath)
        {
            string newFilePath = File.Exists(filePath) ? filePath : Path.Combine(CommonFunctions.GetScansFolder(), filePath);
            FileStream fs = File.Open(newFilePath, FileMode.Open, FileAccess.Read);
            byte[] toReturn = new byte[fs.Length];
            fs.Read(toReturn, 0, (int)fs.Length);
            fs.Flush();
            fs.Dispose();
            response r = ThumbNails.GenerateImgThumbNail(filePath);
            return toReturn;
        }

        public static byte[] UploadFile(string filePath, string fileName)
        {
            FileStream fs = File.Open(Path.Combine(filePath, fileName), FileMode.Open, FileAccess.Read);
            byte[] toReturn = new byte[fs.Length];
            fs.Read(toReturn, 0, (int)fs.Length);
            fs.Flush();
            fs.Dispose();
            response r = ThumbNails.GenerateImgThumbNail(filePath, fileName);
            return toReturn;
        }

        public static bool LoadTemplateFileIntoDb(int _authenticatedUserId, string _connectionString, string filePath, string _DETALII)
        {
            try
            {
                FileInfo fi = new FileInfo(filePath);
                int FileSize;
                byte[] rawData;
                FileStream fs;
                fs = new FileStream(filePath, FileMode.Open, FileAccess.Read);
                FileSize = (int)fs.Length;

                rawData = new byte[FileSize];
                fs.Read(rawData, 0, FileSize);
                DataAccess da = new DataAccess(_authenticatedUserId, _connectionString, CommandType.StoredProcedure, "TEMPLATESsp_insert", new object[]
                {
                    new MySqlParameter("_DENUMIRE_FISIER", fi.Name),
                    new MySqlParameter("_EXTENSIE_FISIER", fi.Extension),
                    new MySqlParameter("_DIMENSIUNE_FISIER", FileSize),
                    new MySqlParameter("_FILE_CONTENT", rawData),
                    new MySqlParameter("_DETALII", _DETALII)
                });
                response r = da.ExecuteInsertQuery();
                return r.Status;
            }
            catch { return false; }
        }

        public static bool UpdateTemplateFileIntoDb(int _authenticatedUserId, string _connectionString, int ID, string filePath, string _DETALII)
        {
            try
            {
                FileInfo fi = new FileInfo(filePath);
                int FileSize;
                byte[] rawData;
                FileStream fs;
                fs = new FileStream(filePath, FileMode.Open, FileAccess.Read);
                FileSize = (int)fs.Length;

                rawData = new byte[FileSize];
                fs.Read(rawData, 0, FileSize);
                DataAccess da = new DataAccess(_authenticatedUserId, _connectionString, CommandType.StoredProcedure, "TEMPLATESsp_update", new object[]
                {
                    new MySqlParameter("_ID", ID),
                    new MySqlParameter("_DENUMIRE_FISIER", fi.Name),
                    new MySqlParameter("_EXTENSIE_FISIER", fi.Extension),
                    new MySqlParameter("_DIMENSIUNE_FISIER", FileSize),
                    new MySqlParameter("_FILE_CONTENT", rawData),
                    new MySqlParameter("_DETALII", _DETALII)
                });
                response r = da.ExecuteUpdateQuery();
                return r.Status;
            }
            catch { return false; }
        }

        public static byte[] GetTemplateFileFromDb(int _authenticatedUserId, string _connectionString, string fileName)
        {
            try
            {
                byte[] rawData;
                DataAccess da = new DataAccess(_authenticatedUserId, _connectionString, CommandType.StoredProcedure, "TEMPLATESsp_GetByName", new object[]
                {
                    new MySqlParameter("_DENUMIRE_FISIER", fileName)
                });
                IDataReader r = da.ExecuteSelectQuery();
                r.Read();
                rawData = (byte[])r["FILE_CONTENT"];
                r.Close(); r.Dispose(); da.CloseConnection();
                return rawData;
            }
            catch { return null; }
        }

        public static byte[] GetTemplateFileFromDb(int _authenticatedUserId, string _connectionString, int templateId)
        {
            try
            {
                byte[] rawData;
                DataAccess da = new DataAccess(_authenticatedUserId, _connectionString, CommandType.StoredProcedure, "TEMPLATESsp_GetById", new object[]
                {
                    new MySqlParameter("_ID", templateId)
                });
                IDataReader r = da.ExecuteSelectQuery();
                r.Read();
                rawData = (byte[])r["FILE_CONTENT"];
                r.Close(); r.Dispose(); da.CloseConnection();
                return rawData;
            }
            catch { return null; }
        }

        public static byte[] GetFileContentFromFile(string fileName)
        {
            try
            {
                FileStream fs = new FileStream(fileName, FileMode.Open, FileAccess.Read);
                byte[] toReturn = new byte[fs.Length];
                fs.Read(toReturn, 0, (int)fs.Length);
                return toReturn;
            }
            catch { return null; }
        }

        public static byte[] GetFileContentFromDb(int _authenticatedUserId, string _connectionString, int documentScanatId)
        {
            try
            {
                byte[] rawData;
                DataAccess da = new DataAccess(_authenticatedUserId, _connectionString, CommandType.StoredProcedure, "DOCUMENTE_SCANATEsp_GetById", new object[]
                {
                    new MySqlParameter("_ID", documentScanatId)
                });
                IDataReader r = da.ExecuteSelectQuery();
                r.Read();
                rawData = (byte[])r["FILE_CONTENT"];
                r.Close(); r.Dispose(); da.CloseConnection();
                return rawData;
            }
            catch { return null; }
        }

        public static string SaveBinaryContentToFile(byte[] fileContent, string extension)
        {
            try
            {
                string filePath = Guid.NewGuid() + extension;
                string newFilePath = File.Exists(filePath) ? filePath : Path.Combine(CommonFunctions.GetScansFolder(), filePath);
                FileStream fs = File.Create(newFilePath);
                fs.Write(fileContent, 0, fileContent.Length);
                fs.Flush();
                fs.Dispose();
                response r = ThumbNails.GenerateImgThumbNail(filePath);
                return filePath;
            }catch(Exception exp)
            {
                LogWriter.Log(exp);
                throw exp;
            }
        }

        public static string CopyFileToServer(string fileName)
        {
            try
            {
                string extension = fileName.Substring(fileName.LastIndexOf('.'));
                string filePath = Guid.NewGuid() + extension;
                string newFilePath = Path.Combine(CommonFunctions.GetScansFolder(), filePath);
                File.Copy(fileName, newFilePath);
                return filePath;
            }
            catch (Exception exp)
            {
                LogWriter.Log(exp);
                return null;
            }
        }

        public static string[] GetOrphanFiles(int _authenticatedUserId, string _connectionString)
        {
            List<string> toReturn = new List<string>();
            Models.DocumenteScanateRepository dsr = new Models.DocumenteScanateRepository(_authenticatedUserId, _connectionString);
            Models.DocumentScanat[] dss = (Models.DocumentScanat[])dsr.GetAll().Result;
            Models.DocumenteScanateProceseRepository dspr = new Models.DocumenteScanateProceseRepository(_authenticatedUserId, _connectionString);
            Models.DocumentScanatProces[] dsps = (Models.DocumentScanatProces[])dsr.GetAll().Result;

            //var files = Directory.GetFiles(CommonFunctions.GetScansFolder()).AsQueryable().Except(Directory.GetFiles(CommonFunctions.GetScansFolder(), "*_Custom.jpg")); // requires System.Linq.Queryable (4.3.0)
            string[] files = Directory.GetFiles(CommonFunctions.GetScansFolder());
            foreach (string fileName in files)
            {
                if (fileName.IndexOf("*_Custom.jpg") < 0)
                {
                    string fName = Path.GetFileName(fileName);
                    try
                    {
                        int f = dss.Where(item => item.CALE_FISIER == fName).Count();
                        int p = dsps.Where(item => item.CALE_FISIER == fName).Count();
                        if (f == 0 && p == 0)
                        {
                            toReturn.Add(fName);
                        }
                    }
                    catch { toReturn.Add(fName); }
                }
            }
            return toReturn.ToArray();
        }

        public static bool DeleteOrphan(string fileName)
        {
            try
            {
                string extension = fileName.Substring(fileName.LastIndexOf('.'));
                File.Delete(Path.Combine(CommonFunctions.GetScansFolder(), fileName.Replace(extension, "_Custom.jpg")));
                File.Delete(Path.Combine(CommonFunctions.GetScansFolder(), fileName));
                return true;
            }catch(Exception exp) { LogWriter.Log(exp); return false; }
        }

        public static bool DeleteOrphans(string[] fileNames)
        {
            try
            {
                foreach (string fileName in fileNames)
                {
                    File.Delete(Path.Combine(CommonFunctions.GetScansFolder(), fileName));
                }
                return true;
            }
            catch (Exception exp) { LogWriter.Log(exp); return false; }
        }

        public static Models.DocumentScanat[] GetOrphanDocuments(int _authenticatedUserId, string _connectionString)
        {
            List<Models.DocumentScanat> toReturn = new List<Models.DocumentScanat>();
            Models.DocumenteScanateRepository dsr = new Models.DocumenteScanateRepository(_authenticatedUserId, _connectionString);
            Models.DocumentScanat[] dss = (Models.DocumentScanat[])dsr.GetAll().Result;
            foreach(Models.DocumentScanat ds in dss)
            {
                if(!File.Exists(Path.Combine(CommonFunctions.GetScansFolder(), ds.CALE_FISIER)))
                {
                    toReturn.Add(ds);
                }
            }
            return toReturn.ToArray();
        }

        public static Models.DocumentScanatProces[] GetOrphanDocumentsProcese(int _authenticatedUserId, string _connectionString)
        {
            List<Models.DocumentScanatProces> toReturn = new List<Models.DocumentScanatProces>();
            Models.DocumenteScanateProceseRepository dsr = new Models.DocumenteScanateProceseRepository(_authenticatedUserId, _connectionString);
            Models.DocumentScanatProces[] dss = (Models.DocumentScanatProces[])dsr.GetAll().Result;
            foreach (Models.DocumentScanatProces ds in dss)
            {
                if (!File.Exists(Path.Combine(CommonFunctions.GetScansFolder(), ds.CALE_FISIER)))
                {
                    toReturn.Add(ds);
                }
            }
            return toReturn.ToArray();
        }

        //public static response RestoreFileFromDb(Models.DocumentScanat ds)
        public static response RestoreFileFromDb(dynamic ds)
        {
            try
            {
                if (ds.FILE_CONTENT == null)
                    ds.GetFileContent();
                if (!File.Exists(Path.Combine(CommonFunctions.GetScansFolder(), ds.CALE_FISIER))){
                    FileStream fs = new FileStream(Path.Combine(CommonFunctions.GetScansFolder(), ds.CALE_FISIER), FileMode.CreateNew, FileAccess.ReadWrite);
                    fs.Write(ds.FILE_CONTENT, 0, ds.FILE_CONTENT.Length);
                    fs.Flush();
                    fs.Dispose();
                }
                try
                {
                    string outputThumbFile = ds.CALE_FISIER.Replace(ds.EXTENSIE_FISIER, "_Custom.jpg");
                    if (!File.Exists(Path.Combine(CommonFunctions.GetScansFolder(), outputThumbFile)))
                    {
                        ThumbNails.GenerateImgThumbNail(CommonFunctions.GetThumbNailSizes(ThumbNailType.Custom), ds.CALE_FISIER);
                    }
                }
                catch (Exception exp) { LogWriter.Log(exp); }
                return new response(true, "", null, null, null);
                // to do - restore thumbnails
            }catch(Exception exp) { LogWriter.Log(exp); return new response(false, exp.Message, null, null, new List<Error>() { new Error(exp) }); }
        }

        //public static response RestoreFilesFromDb(Models.DocumentScanat[] dss)
        public static response RestoreFilesFromDb(dynamic dss)
        {
            response toReturn = new response(true, "", null, null, new List<Error>());
            try
            {
                foreach (Models.DocumentScanat ds in dss)
                {
                    response r = RestoreFileFromDb(ds);
                    if (!r.Status)
                    {
                        toReturn.AddResponse(r);
                    }
                }
                return toReturn;
            }
            catch (Exception exp) { LogWriter.Log(exp); return new response(false, exp.Message, null, null, new List<Error>() { new Error(exp) }); }
        }

        public static response CreateZipFromDosar(Models.Dosar dosar, bool bulk) // bulk = false - fisiere grupate pe tip documente / bulk = true - fisiere la gramada
        {
            response r = new response();
            try
            {
                Models.DocumentScanat[] dss = (Models.DocumentScanat[])dosar.GetDocumente().Result;
                //Models.TipDocument[] tds = (Models.TipDocument[])dosar.GetDocumenteTipuri().Result;

                string zipFilePath = Path.Combine(CommonFunctions.GetTempFolder(), String.Format("{0}.zip", dosar.NR_DOSAR_CASCO));
                using (FileStream zipFile = new FileStream(zipFilePath, FileMode.Create))
                {
                    using (ZipArchive archive = new ZipArchive(zipFile, ZipArchiveMode.Create))
                    {
                        foreach (Models.DocumentScanat ds in dss)
                        {
                            try
                            {
                                if (ds.VIZA_CASCO)
                                {
                                    response rg = PdfGenerator.GeneratePdfWithSignatureFromDocument(ds);
                                    ZipArchiveEntry entry = null;
                                    if (!bulk)
                                    {
                                        //entry = archive.CreateEntry(String.Format("{0}/{1}", dosar.NR_DOSAR_CASCO, ds.DENUMIRE_FISIER), CompressionLevel.Optimal); // old version - fara semnatura digitala
                                        entry = archive.CreateEntry(String.Format("{0}/{1}", dosar.NR_DOSAR_CASCO, rg.Message), CompressionLevel.Optimal);
                                    }
                                    else
                                    {
                                        Models.TipDocument td = (Models.TipDocument)ds.GetTipDocument().Result;
                                        //entry = archive.CreateEntry(String.Format("{0}/{1}/{2}", dosar.NR_DOSAR_CASCO, td.DENUMIRE, ds.DENUMIRE_FISIER), CompressionLevel.Optimal); // old version - fara semnatura digitala
                                        entry = archive.CreateEntry(String.Format("{0}/{1}/{2}", dosar.NR_DOSAR_CASCO, td.DENUMIRE, rg.Message), CompressionLevel.Optimal);
                                    }
                                    using (BinaryWriter writer = new BinaryWriter(entry.Open()))
                                    {
                                        /*
                                        ds.GetFileContent();
                                        writer.Write(ds.FILE_CONTENT);
                                        writer.Flush();
                                        */
                                        byte[] src = File.ReadAllBytes(rg.Result.ToString());
                                        writer.Write(src);
                                        writer.Flush();
                                        File.Delete(rg.Result.ToString());
                                    }
                                }
                            }catch(Exception exp)
                            {
                                LogWriter.Log(exp);
                            }
                        }
                    }
                }
                return new response(true, zipFilePath, zipFilePath, null, null);
            }
            catch (Exception exp)
            {
                LogWriter.Log(exp);
                return new response(false, exp.Message, null, null, new List<Error>() { new Error(exp) });
            }
        }

        public static void CreateArhiveEntryWithSignature(Models.DocumentScanat ds)
        {

        }
    }
}
