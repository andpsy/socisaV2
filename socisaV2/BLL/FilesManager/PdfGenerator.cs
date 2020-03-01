using System;
using Xfinium.Pdf;
using Xfinium.Pdf.Content;
using Xfinium.Pdf.FlowDocument;
using Xfinium.Pdf.Graphics.FormattedContent;
using Xfinium.Pdf.Graphics;
using System.IO;
using System.Collections.Generic;
using System.Globalization;
using Xfinium.Pdf.DigitalSignatures;
using Xfinium.Pdf.Forms;
using System.Security.Cryptography;
using Xfinium.Pdf.Annotations;
using System.Drawing;
using System.Drawing.Imaging;

namespace SOCISA
{
    public class Articol
    {
        public int Paragraf { get; set; }
        public DateTime? DataStart { get; set; }
        public DateTime? DataEnd { get; set; }
        public string TemeiCerere { get; set; }
        public string Lege { get; set; }
        public string Ordin { get; set; }
        public string ArticolPlata { get; set; }
        public string ArticolObiectiuni { get; set; }
        public string NrZile { get; set; }
        public double? ProcentPenalitati { get; set; }

        public Articol(int p, DateTime? ds, DateTime? de, string t, string l, string o, string ap, string ao, string nz, double? pp)
        {
            Paragraf = p; DataStart = ds; DataEnd = de; TemeiCerere = t; Lege = l; Ordin = o; ArticolPlata = ap; ArticolObiectiuni = ao; NrZile = nz; ProcentPenalitati = pp;
        }
    }

    public static class Articole
    {
        public static Articol[] articole
        {
            get
            {
                List<Articol> l = new List<Articol>();
                l.Add(new Articol(1, new DateTime(2016, 9, 18), null, "art. 49", "Legea 136/1995", null, null, null, null, null));
                l.Add(new Articol(1, new DateTime(2016, 9, 19), new DateTime(2017, 7, 11), "art. 11 si 12", "OUG nr. 54/2016", null, null, null, null, null));
                l.Add(new Articol(1, null, new DateTime(2017, 7, 12), "art. 10 si 11", "Legea 132/2017", null, null, null, null, null));

                l.Add(new Articol(9, new DateTime(2014, 12, 31), null, null, null, "Ordinul CSA nr. 14/2011", "art. 64, alin. 2, lit. a", "art. 64, alin. 2, lit. b", "15", 0.10));
                l.Add(new Articol(9, new DateTime(2015, 1, 1), new DateTime(2016, 12, 22), null, null, "Norma ASF nr. 23/2014", "art. 58, alin. 2, lit. a", "art. 58, alin. 2, lit. b", "15", 0.20));
                l.Add(new Articol(9, new DateTime(2016, 12, 23), new DateTime(2017, 7, 11), null, null, "OUG nr. 54/2016", "art. 20, alin. 2", "art. 20, alin. 1, lit. b", "30", 0.20));
                l.Add(new Articol(9, null, new DateTime(2017, 7, 12), null, null, "Legea 132/2017", "art. 21, alin. 2", "art. 21, alin. 1, lit. b", "30", 0.20));

                return l.ToArray();
            }
        }
    }

    public static class PdfGenerator
    {
        public const int PDF_PAGE_MARGIN = 60;

        public static response AddDigitalSignature(string pdfFilePath, PdfDigitalSignatureDigestAlgorithm pdsda)
        {
            if (!Convert.ToBoolean(System.Configuration.ConfigurationManager.AppSettings["UseDigitalSignature"])) return new response(true, null, null, null, null);
            string digitalSignatureFilePath = CommonFunctions.GetDigitalSignatureFile();
            string digitalSignatureFilePassword = CommonFunctions.StringCipher.Decrypt(System.Configuration.ConfigurationManager.AppSettings["DigitalSignaturePassword"].ToString(), CommonFunctions.StringCipher.RetrieveKey());
            return AddDigitalSignature(pdfFilePath, digitalSignatureFilePath, digitalSignatureFilePassword, pdsda);
        }

        public static response AddDigitalSignature(string pdfFilePath, string digitalSignatureFilePath, string digitalSignatureFilePassword, PdfDigitalSignatureDigestAlgorithm pdsda)
        {
            if (!Convert.ToBoolean(System.Configuration.ConfigurationManager.AppSettings["UseDigitalSignature"])) return new response(true, null, null, null, null);
            PdfFixedDocument pdf = new PdfFixedDocument(pdfFilePath);
            return AddDigitalSignature(pdf, pdfFilePath, digitalSignatureFilePath, digitalSignatureFilePassword, pdsda);
        }

        public static response AddDigitalSignature(string pdfFilePath, string saveTo, string digitalSignatureFilePath, string digitalSignatureFilePassword, PdfDigitalSignatureDigestAlgorithm pdsda)
        {
            if (!Convert.ToBoolean(System.Configuration.ConfigurationManager.AppSettings["UseDigitalSignature"])) return new response(true, null, null, null, null);
            PdfFixedDocument pdf = new PdfFixedDocument(pdfFilePath);
            return AddDigitalSignature(pdf, saveTo, digitalSignatureFilePath, digitalSignatureFilePassword, pdsda);
        }

        public static response AddDigitalSignature(PdfFixedDocument pdf, string saveTo, string digitalSignatureFilePath, string digitalSignatureFilePassword, PdfDigitalSignatureDigestAlgorithm pdsda)
        {
            if (!Convert.ToBoolean(System.Configuration.ConfigurationManager.AppSettings["UseDigitalSignature"])) return new response(true, null, null, null, null);

            try
            {
                //PdfAnnotationAppearance paa = new PdfAnnotationAppearance(200, 100);
                

                //PdfFixedDocument pdf = new PdfFixedDocument(Path.Combine(AppContext.BaseDirectory, "test_unsigned.pdf"));

                //PdfPage p = pdf.Pages.Add();
                PdfPage p = new PdfPage();
                pdf.Pages.Insert(0, p);
                PdfSignatureField psf = new PdfSignatureField("semnatura_digitala");
                p.Fields.Add(psf);
                psf.Widgets[0].VisualRectangle = new PdfVisualRectangle(150, 150, 300, 100);

                var signature = new PdfPadesDigitalSignature();
                //string certFileName2 = Path.Combine(AppContext.BaseDirectory, "AndreiIon.pfx");
                System.Security.Cryptography.X509Certificates.X509Certificate2 cert2 = new System.Security.Cryptography.X509Certificates.X509Certificate2(digitalSignatureFilePath, digitalSignatureFilePassword);

                signature.Certificate = cert2;
                //signature.Name = cert2.FriendlyName; // "Andrei ION";
                signature.Location = "Bucuresti";
                signature.CertificateIncludeOption = PdfX509CertificateIncludeOption.WholeChain;
                string signedBy = cert2.Subject.Split(',')[4].Replace("CN=", "");
                signature.ContactInfo = signedBy; // cert2.Subject; // "contact info";
                //signature.Reason = "Motivul";
                //signature.SignatureDigestAlgorithm = PdfDigitalSignatureDigestAlgorithm.Sha1;
                signature.SignatureDigestAlgorithm = pdsda;

                //psf.Widgets[0].NormalAppearance = paa;

                psf.Signature = signature;
                //pdf.Save(Path.Combine(AppContext.BaseDirectory, "test_sign2.pdf"));
                pdf.Save(saveTo);
                return new response(true, saveTo, saveTo, null, null);
            }
            catch (Exception exp) { LogWriter.Log(exp); return new response(false, exp.Message, null, null, new System.Collections.Generic.List<Error>() { new Error(exp) }); }
        }

        public static response ExportDosarToPdf(string templateFileName, Models.Dosar dosar)
        {
            try
            {
                FileStream fs = null;
                byte[] bs = null;
                if (File.Exists(templateFileName))
                    fs = new FileStream(templateFileName, FileMode.Open, FileAccess.Read);
                else
                    if (File.Exists(Path.Combine(CommonFunctions.GetPdfsFolder(), templateFileName)))
                    fs = new FileStream(Path.Combine(CommonFunctions.GetPdfsFolder(), templateFileName), FileMode.Open, FileAccess.Read);
                if (fs != null)
                {
                    bs = new byte[fs.Length];
                    int n = fs.Read(bs, 0, (int)fs.Length);
                }
                return ExportDosarToPdf(bs, dosar);
            }
            catch (Exception exp) { LogWriter.Log(exp); return new response(false, exp.Message, null, null, new List<Error>() { new Error(exp) }); }
        }

        public static response ExportDosarToPdf(int authenticatedUserId, string connectionString, string templateFileName, Models.Dosar dosar)
        {
            try
            {
                FileStream fs = null;
                byte[] bs = null;
                if (File.Exists(templateFileName))
                    fs = new FileStream(templateFileName, FileMode.Open, FileAccess.Read);
                else
                    if (File.Exists(Path.Combine(CommonFunctions.GetPdfsFolder(), templateFileName)))
                        fs = new FileStream(Path.Combine(CommonFunctions.GetPdfsFolder(), templateFileName), FileMode.Open, FileAccess.Read);
                if (fs != null)
                {
                    bs = new byte[fs.Length];
                    int n = fs.Read(bs, 0, (int)fs.Length);
                    fs.Dispose();
                }
                else
                {
                    bs = FileManager.GetTemplateFileFromDb(authenticatedUserId, connectionString, templateFileName);
                }
                return ExportDosarToPdf(bs, dosar);
            }
            catch (Exception exp) { LogWriter.Log(exp); return new response(false, exp.Message, null, null, new System.Collections.Generic.List<Error>() { new Error(exp) }); }
        }

        public static response ExportDosarToPdf(byte[] template_file_content, Models.Dosar dosar)
        {
            try
            {
                MemoryStream ms = new MemoryStream(template_file_content);
                string fileName = dosar.NR_DOSAR_CASCO.Replace('/', '_').Replace(' ', '_') + "_cerere.pdf";
                FileStream fs = File.Open(Path.Combine(CommonFunctions.GetPdfsFolder(), fileName), FileMode.Create, FileAccess.ReadWrite);
                PdfFixedDocument poDocument = new PdfFixedDocument(ms);
                List<string> pdfText = new List<string>();
                string text = "";
                foreach (PdfPage p in poDocument.Pages)
                {
                    PdfContentExtractor ce = new PdfContentExtractor(p);
                    text += ce.ExtractText();
                }
                string[] paragraphs = text.Split(new string[] { "\r\n \r\n" }, StringSplitOptions.None);
                foreach (string s in paragraphs)
                {
                    pdfText.Add(s.Replace("\r\n", ""));
                    //pdfText.Add(s);
                }
                /*
                PdfFlowDocument pf = new PdfFlowDocument();
                pf.PageCreated += Pf_PageCreated;
                PdfFlowTextContent pftc = GeneratePdfContent(pdfText, dosar);
                pftc.InnerMargins = new PdfFlowContentMargins(0, 0, 0, 0);
                pftc.OuterMargins = new PdfFlowContentMargins(0, 0, 0, 0);
                pf.AddContent(pftc);
                */
                PdfFixedDocument pf = DrawFormattedContent(GeneratePdfContent(pdfText, dosar));
                pf.Save(fs);
                fs.Flush();
                fs.Dispose();
                ms.Close();
                ms.Dispose();
                string toReturn = Path.Combine(CommonFunctions.GetPdfsFolder(), fileName);
                if (Convert.ToBoolean(System.Configuration.ConfigurationManager.AppSettings["UseDigitalSignature"]))
                {
                    AddDigitalSignature(toReturn, PdfDigitalSignatureDigestAlgorithm.Sha1);
                }
                return new response(true, toReturn, toReturn, null, null);
            }
            catch (Exception exp) { LogWriter.Log(exp); return new response(false, exp.Message, null, null, new List<Error>() { new Error(exp) }); }
        }

        public static response GeneratePdfDocumentFromText(string text)
        {
            try
            {
                /*
                PdfFixedDocument document = new PdfFixedDocument();
                PdfPage page = document.Pages.Add();
                PdfStandardFont font = new PdfStandardFont(PdfStandardFontFace.Courier, 8);
                PdfBrush brush = new PdfBrush(PdfRgbColor.Red);
                PdfStringAppearanceOptions sao = new PdfStringAppearanceOptions();
                sao.Brush = brush;
                sao.Font = font;

                PdfStringLayoutOptions slo = new PdfStringLayoutOptions();
                slo.HorizontalAlign = PdfStringHorizontalAlign.Left;
                slo.VerticalAlign = PdfStringVerticalAlign.Top;
                
                slo.X = slo.Y = PDF_PAGE_MARGIN;
                slo.Width = page.Width - PDF_PAGE_MARGIN * 2;
                slo.Height = page.Height - PDF_PAGE_MARGIN * 2;
                
                page.Graphics.DrawString(text, sao, slo);
                */
                PdfFormattedContent pfc = new PdfFormattedContent(text);
                PdfFixedDocument document = DrawFormattedContent(pfc);
                string newFName = Guid.NewGuid() + ".pdf";
                string file_name = Path.Combine(CommonFunctions.GetScansFolder(), newFName);
                document.Save(file_name);
                if (Convert.ToBoolean(System.Configuration.ConfigurationManager.AppSettings["UseDigitalSignature"]))
                {
                    AddDigitalSignature(file_name, PdfDigitalSignatureDigestAlgorithm.Sha1);
                }
                return new response(true, null, newFName, null, null);
            }catch(Exception exp)
            {
                LogWriter.Log(exp);
                return new response(false, exp.ToString(), null, null, new List<Error>() { new Error(exp) });
            }
        }

        public static response GenerareNotificarePdf(Models.Dosar dosar)
        {
            try
            {
                Models.SocietateAsigurare sCasco = (Models.SocietateAsigurare)dosar.GetSocietateCasco().Result;
                byte[] template_file_content = (byte[])sCasco.GetTemplateNotificari().Result;
                MemoryStream ms = new MemoryStream(template_file_content);
                string fileName = dosar.NR_DOSAR_CASCO.Replace('/', '_').Replace(' ', '_') + "_notificare.pdf";
                FileStream fs = File.Open(Path.Combine(CommonFunctions.GetPdfsFolder(), fileName), FileMode.Create, FileAccess.ReadWrite);
                PdfFixedDocument poDocument = new PdfFixedDocument(ms);
                List<string> pdfText = new List<string>();
                string text = "";
                foreach (PdfPage p in poDocument.Pages)
                {
                    PdfContentExtractor ce = new PdfContentExtractor(p);
                    text += ce.ExtractText();
                }
                string[] paragraphs = text.Split(new string[] { "\r\n \r\n" }, StringSplitOptions.None);
                foreach (string s in paragraphs)
                {
                    pdfText.Add(s.Replace("\r\n", ""));
                    //pdfText.Add(s);
                }
                PdfFixedDocument pf = DrawFormattedContent(GeneratePdfContent(pdfText, dosar));
                pf.Save(fs);
                fs.Flush();
                fs.Dispose();
                string toReturn = Path.Combine(CommonFunctions.GetPdfsFolder(), fileName);
                if (Convert.ToBoolean(System.Configuration.ConfigurationManager.AppSettings["UseDigitalSignature"]))
                {
                    AddDigitalSignature(toReturn, PdfDigitalSignatureDigestAlgorithm.Sha1);
                }
                return new response(true, toReturn, toReturn, null, null);
            }
            catch (Exception exp) { LogWriter.Log(exp); return new response(false, exp.Message, null, null, new List<Error>() { new Error(exp) }); }
        }


        private static void Pf_PageCreated(object sender, PdfFlowPageCreatedEventArgs e)
        {
            e.PageDefaults.Margins.Left = 60;
            e.PageDefaults.Margins.Right = 50;
            e.PageDefaults.Margins.Bottom = 50;
            e.PageDefaults.Margins.Top = 50;
            e.PageDefaults.Height = 842;
            e.PageDefaults.Width = 595;
        }

        //public static PdfFlowTextContent GeneratePdfContent(List<string> pdfText, Models.Dosar dosar)
        public static PdfFormattedContent GeneratePdfContent(List<string> pdfText, Models.Dosar dosar)            
        {
            Models.SocietateAsigurare sCasco = (Models.SocietateAsigurare)dosar.GetSocietateCasco().Result;
            Models.SocietateAsigurare sRca = (Models.SocietateAsigurare)dosar.GetSocietateRca().Result;
            Models.Asigurat aCasco = (Models.Asigurat)dosar.GetAsiguratCasco().Result;
            Models.Asigurat aRca = (Models.Asigurat)dosar.GetAsiguratRca().Result;
            Models.Auto autoCasco = (Models.Auto)dosar.GetAutoCasco().Result;
            Models.Auto autoRca = (Models.Auto)dosar.GetAutoRca().Result;
            Models.Intervenient intervenient = (Models.Intervenient)dosar.GetIntervenient().Result;

            Dictionary<string, string> field_names = new Dictionary<string, string>();
            field_names.Add("{{NR_SCA}}", dosar.NR_SCA == null || dosar.NR_SCA.Trim() == "" ? "_________" : dosar.NR_SCA);
            field_names.Add("{{DATA_SCA}}", dosar.DATA_SCA == null ? "____________" : Convert.ToDateTime(dosar.DATA_SCA).Year.ToString());
            field_names.Add("{{NR_DOSAR_CASCO}}", dosar.NR_DOSAR_CASCO == null || dosar.NR_DOSAR_CASCO.Trim() == "" ? "_________________" : dosar.NR_DOSAR_CASCO);
            field_names.Add("{{VALOARE_DAUNA}}", dosar.VALOARE_DAUNA.ToString().Trim() == "" ? "___________" : String.Format(CultureInfo.CreateSpecificCulture("ro-RO"), "{0:0,0.00}", Convert.ToDouble(dosar.VALOARE_DAUNA)));
            field_names.Add("{{VALOARE_REGRES}}", dosar.VALOARE_REGRES.ToString().Trim() == "" ? "___________" : String.Format(CultureInfo.CreateSpecificCulture("ro-RO"), "{0:0,0.00}", Convert.ToDouble(dosar.VALOARE_REGRES)));
            field_names.Add("{{NR_POLITA_CASCO}}", dosar.NR_POLITA_CASCO == null || dosar.NR_POLITA_CASCO.Trim() == "" ? "_________________" : dosar.NR_POLITA_CASCO);
            field_names.Add("{{NR_POLITA_RCA}}", dosar.NR_POLITA_RCA == null || dosar.NR_POLITA_RCA.Trim() == "" ? "_________________" : dosar.NR_POLITA_RCA);
            field_names.Add("{{DATA_EVENIMENT}}", dosar.DATA_EVENIMENT == null ? "___________" : Convert.ToDateTime(dosar.DATA_EVENIMENT).ToString("dd/MM/yyyy"));
            field_names.Add("{{DATA_NOTIFICARE}}", dosar.DATA_NOTIFICARE == null ? "___________" : Convert.ToDateTime(dosar.DATA_NOTIFICARE).ToString("dd/MM/yyyy"));

            field_names.Add("{{SOCIETATE_CASCO}}", sCasco.DENUMIRE == null || sCasco.DENUMIRE.Trim() == "" ? "__________________________________" : sCasco.DENUMIRE);
            field_names.Add("{{TELEFON_CASCO}}", sCasco.TELEFON == null || sCasco.TELEFON.Trim() == "" ? "__________________________________" : sCasco.TELEFON);
            field_names.Add("{{EMAIL_CASCO}}", sCasco.EMAIL_NOTIFICARI == null || sCasco.EMAIL_NOTIFICARI.Trim() == "" ? "__________________________________" : sCasco.EMAIL_NOTIFICARI);
            field_names.Add("{{ADRESA_SOCIETATE_CASCO}}", sCasco.ADRESA == null || sCasco.ADRESA.Trim() == "" ? "___________________________________________________" : sCasco.ADRESA);
            field_names.Add("{{NR_REG_COM_SOCIETATE_CASCO}}", sCasco.NR_REG_COM == null || sCasco.NR_REG_COM.Trim() == "" ? "_______________" : sCasco.NR_REG_COM.ToUpper());
            field_names.Add("{{CUI_SOCIETATE_CASCO}}", sCasco.CUI == null || sCasco.CUI.Trim() == "" ? "______________" : sCasco.CUI.ToUpper());
            field_names.Add("{{IBAN_SOCIETATE_CASCO}}", sCasco.IBAN == null || sCasco.IBAN.Trim() == "" ? "__________________________________________" : sCasco.IBAN.ToUpper());
            field_names.Add("{{BANCA_SOCIETATE_CASCO}}", sCasco.BANCA == null || sCasco.BANCA.Trim() == "" ? "____________________________________" : sCasco.BANCA.ToUpper());

            field_names.Add("{{SOCIETATE_RCA}}", sRca.DENUMIRE == null || sRca.DENUMIRE.Trim() == "" ? "_________________________________" : sRca.DENUMIRE);
            field_names.Add("{{ADRESA_SOCIETATE_RCA}}", sRca.ADRESA == null || sRca.ADRESA.Trim() == "" ? "___________________________________________________" : sRca.ADRESA);
            field_names.Add("{{ASIGURAT_CASCO}}", aCasco.DENUMIRE == null || aCasco.DENUMIRE.Trim() == "" ? "__________________________________" : aCasco.DENUMIRE);
            //field_names.Add("{{ASIGURAT_RCA}}", aRca.DENUMIRE == null || aRca.DENUMIRE.Trim() == "" ? "__________________________________" : aRca.DENUMIRE);
            field_names.Add("{{ASIGURAT_RCA}}", intervenient != null && !String.IsNullOrWhiteSpace(intervenient.DENUMIRE) ? intervenient.DENUMIRE : (aRca == null || String.IsNullOrWhiteSpace(aRca.DENUMIRE) ? "__________________________________" : aRca.DENUMIRE));

            field_names.Add("{{NR_AUTO_CASCO}}", autoCasco.NR_AUTO == null || autoCasco.NR_AUTO.Trim() == "" ? "____________" : autoCasco.NR_AUTO.ToUpper());
            field_names.Add("{{SERIE_SASIU_AUTO_CASCO}}", autoCasco.SERIE_SASIU == null || autoCasco.SERIE_SASIU.Trim() == "" ? "____________" : autoCasco.SERIE_SASIU.ToUpper());
            field_names.Add("{{MARCA_AUTO_CASCO}}", autoCasco.MARCA == null || autoCasco.MARCA.Trim() == "" ? "______________" : autoCasco.MARCA.ToUpper());
            field_names.Add("{{NR_AUTO_RCA}}", autoRca.NR_AUTO == null || autoRca.NR_AUTO.Trim() == "" ? "____________" : autoRca.NR_AUTO.ToUpper());
            field_names.Add("{{SERIE_SASIU_AUTO_RCA}}", autoRca.SERIE_SASIU == null || autoRca.SERIE_SASIU.Trim() == "" ? "____________" : autoRca.SERIE_SASIU.ToUpper());
            field_names.Add("{{PROPRIETAR_AUTO_RCA}}", "_______________________");

            field_names.Add("{{CAZ}}", dosar.CAZ == null || dosar.CAZ.Trim() == "" ? "_____" : dosar.CAZ);
            field_names.Add("{{LOC_ACCIDENT}}", dosar.LOC_ACCIDENT == null || dosar.LOC_ACCIDENT.Trim() == "" ? "_______________________" : dosar.LOC_ACCIDENT);
            field_names.Add("{{DATA}}", DateTime.Now.ToString("dd/MM/yyyy"));


            foreach(Articol a in Articole.articole)
            {
                switch(a.Paragraf)
                {
                    case 9:
                        if((a.DataStart != null && a.DataEnd == null && dosar.DATA_EVENIMENT <= a.DataStart) ||
                            (a.DataStart != null && a.DataEnd != null && dosar.DATA_EVENIMENT >= a.DataStart && dosar.DATA_EVENIMENT <= a.DataEnd) ||
                            (a.DataStart == null && a.DataEnd != null && dosar.DATA_EVENIMENT >= a.DataEnd))
                        {
                            field_names.Add("{{NORMA}}", a.Ordin);
                            field_names.Add("{{ARTICOL_PLATA}}", a.ArticolPlata);
                            field_names.Add("{{ARTICOL_OBIECTIUNI}}", a.ArticolObiectiuni);
                            field_names.Add("{{TERMEN}}", a.NrZile);
                        }
                        break;
                    case 1:
                        if ((a.DataStart != null && a.DataEnd == null && dosar.DATA_EVENIMENT <= a.DataStart) ||
                            (a.DataStart != null && a.DataEnd != null && dosar.DATA_EVENIMENT >= a.DataStart && dosar.DATA_EVENIMENT <= a.DataEnd) ||
                            (a.DataStart == null && a.DataEnd != null && dosar.DATA_EVENIMENT >= a.DataEnd))
                        {
                            field_names.Add("{{TEMEI_CERERE}}", a.TemeiCerere);
                            field_names.Add("{{LEGE}}", a.Lege);
                        }
                        break;
                }
            }
            /*
            field_names.Add("{{NORMA}}", dosar.DATA_EVENIMENT < new DateTime(2015, 1, 1) ? Articole.articole[0].Ordin : dosar.DATA_EVENIMENT >= new DateTime(2015, 1, 1) && dosar.DATA_EVENIMENT <= new DateTime(2016, 12, 22) ? Articole.articole[1].Ordin : Articole.articole[2].Ordin);
            field_names.Add("{{ARTICOL_PLATA}}", dosar.DATA_EVENIMENT < new DateTime(2015, 1, 1) ? Articole.articole[0].ArticolPlata : dosar.DATA_EVENIMENT >= new DateTime(2015, 1, 1) && dosar.DATA_EVENIMENT <= new DateTime(2016, 12, 22) ? Articole.articole[1].ArticolPlata : Articole.articole[2].ArticolPlata);
            field_names.Add("{{ARTICOL_OBIECTIUNI}}", dosar.DATA_EVENIMENT < new DateTime(2015, 1, 1) ? Articole.articole[0].ArticolObiectiuni : dosar.DATA_EVENIMENT >= new DateTime(2015, 1, 1) && dosar.DATA_EVENIMENT <= new DateTime(2016, 12, 22) ? Articole.articole[1].ArticolObiectiuni : Articole.articole[2].ArticolObiectiuni);
            field_names.Add("{{TERMEN}}", dosar.DATA_EVENIMENT < new DateTime(2015, 1, 1) ? Articole.articole[0].NrZile : dosar.DATA_EVENIMENT >= new DateTime(2015, 1, 1) && dosar.DATA_EVENIMENT <= new DateTime(2016, 12, 22) ? Articole.articole[1].NrZile : Articole.articole[2].NrZile);

            field_names.Add("{{TEMEI_CERERE}}", "");
            field_names.Add("{{LEGE}}", "");
            */

            string docs = "";
            //pentru insiruirea in opis a tuturor documentelor, negrupate pe tip
            /*
            Models.DocumentScanat[] dsj = (Models.DocumentScanat[])dosar.GetDocumente().Result;
            foreach (Models.DocumentScanat doc in dsj)
            {
                Models.Nomenclator tip_document = (Models.Nomenclator)doc.GetTipDocument().Result;
                //docs = String.Format("- {1}\r\n{0}", docs, (doc.DETALII != "" && doc.DETALII != null ? doc.DETALII : doc.DENUMIRE_FISIER));
                docs = String.Format("- {1}\r\n{0}", docs, tip_document.DENUMIRE + " " + (doc.DETALII != "" && doc.DETALII != null ? doc.DETALII : ""));
            }
            */
            object[] DocumenteTipuri = (object[])dosar.GetDocumenteTipuri().Result;
            foreach(object[] documentTip in DocumenteTipuri)
            {
                docs = String.Format("{0}\r\n- {1}{2}", docs, documentTip[1].ToString(), Convert.ToInt32(documentTip[2]) > 1 ? " (" + documentTip[2].ToString() + " file)" : "");
            }

            field_names.Add("{{DOCUMENTE}}", docs);


            PdfUnicodeTrueTypeFont boldFont = new PdfUnicodeTrueTypeFont(new FileStream(Path.Combine(AppContext.BaseDirectory, "Content", "arialbold.ttf"), FileMode.Open, FileAccess.Read, FileShare.Read), 12, true);
            PdfUnicodeTrueTypeFont regularFont = new PdfUnicodeTrueTypeFont(new FileStream(Path.Combine(AppContext.BaseDirectory, "Content", "arial.ttf"), FileMode.Open, FileAccess.Read, FileShare.Read), 12, true);

            PdfFormattedContent pfc = new PdfFormattedContent();
            foreach (string s in pdfText)
            {
                PdfFormattedParagraph pfp = new PdfFormattedParagraph();
                pfp.LineSpacingMode = PdfFormattedParagraphLineSpacing.Multiple;
                pfp.LineSpacing = 1.3;
                pfp.SpacingAfter = 15;

                if (s.IndexOf("{{NR_SCA}}") > -1)
                    pfp.HorizontalAlign = PdfStringHorizontalAlign.Right;
                else if (s.IndexOf("CERERE DE DESPAGUBIRE") > -1)
                {
                    pfp.HorizontalAlign = PdfStringHorizontalAlign.Center;
                }
                else
                {
                    pfp.HorizontalAlign = PdfStringHorizontalAlign.Justified;
                    if(s.IndexOf("Catre") < 0 && s.IndexOf("{{DOCUMENTE}}") < 0 && s.IndexOf("$$") < 0)
                        pfp.FirstLineIndent = 30;
                    if (s.IndexOf("{{DOCUMENTE}}") > -1 || s.IndexOf("$$") > -1)
                        pfp.LeftIndentation = 50;
                }

                List<string> splitters = new List<string>();
                foreach (KeyValuePair<string,string> field in field_names)
                {
                    if (s.IndexOf(field.Key) > -1)
                    {
                        splitters.Add(field.Key);
                    }
                }
                string[] sBlocks = null;
                if (splitters.Count > 0)
                    sBlocks = s.Split(splitters.ToArray(), StringSplitOptions.None);
                else
                    sBlocks = new string[] { s };

                int splitter_count = 0;
                for(int i = 0; i < sBlocks.Length; i++)
                {
                    try
                    {
                        PdfFormattedTextBlock b1 = new PdfFormattedTextBlock(sBlocks[i].Replace("$$","\r\n"), sBlocks[i].IndexOf("CERERE DE DESPAGUBIRE") > -1 ? boldFont : regularFont);
                        pfp.Blocks.Add(b1);
                        string theFuckingWrightSplitter = "";
                        //if (splitter_count < splitters.Count)
                        {
                            foreach (string splitter in splitters)
                            {
                                if (s.IndexOf(sBlocks[i] + splitter) > -1)
                                {
                                    theFuckingWrightSplitter = splitter;
                                    splitter_count++;
                                    splitters.Remove(splitter);
                                    break;
                                }
                            }
                            //PdfFormattedTextBlock b2 = new PdfFormattedTextBlock(field_names[splitters[i]], boldFont);
                            PdfFormattedTextBlock b2 = new PdfFormattedTextBlock(field_names[theFuckingWrightSplitter], boldFont);
                            pfp.Blocks.Add(b2);
                        }
                    }
                    catch { }
                }
                pfc.Paragraphs.Add(pfp);
            }
            //pfc.SplitByBox(485, 742);
            //PdfFlowTextContent pftc = new PdfFlowTextContent(pfc);
            //return pftc;
            return pfc;
        }

        public static PdfFixedDocument DrawFormattedContent(PdfFormattedContent fc)
        {
            PdfFixedDocument _doc = new PdfFixedDocument();
            PdfPage page = _doc.Pages.Add();
            page.Width = 595; page.Height = 842;
            PdfFormattedContent fragment = fc.SplitByBox(485, 742);
            while (fragment != null)
            {
                page.Graphics.DrawFormattedContent(fragment, 60, 50);
                page.Graphics.CompressAndClose();

                fragment = fc.SplitByBox(485, 742);
                if (fragment != null)
                {
                    page = _doc.Pages.Add();
                    page.Width = 595; page.Height = 842;
                }
            }
            return _doc;
        }

        public static response GenerateNotificarePdfWithPdfForm(Models.Dosar dosar)
        {
            try
            {
                Models.SocietateAsigurare sCasco = (Models.SocietateAsigurare)dosar.GetSocietateCasco().Result;
                Models.SocietateAsigurare sRca = (Models.SocietateAsigurare)dosar.GetSocietateRca().Result;
                Models.Asigurat aCasco = (Models.Asigurat)dosar.GetAsiguratCasco().Result;
                Models.Asigurat aRca = (Models.Asigurat)dosar.GetAsiguratRca().Result;
                Models.Auto autoCasco = (Models.Auto)dosar.GetAutoCasco().Result;
                Models.Auto autoRca = (Models.Auto)dosar.GetAutoRca().Result;

                byte[] template_file_content = (byte[])sCasco.GetTemplateNotificari().Result;
                MemoryStream ms = new MemoryStream(template_file_content);
                string fileName = dosar.NR_DOSAR_CASCO.Replace('/', '_').Replace(' ', '_') + "_notificare.pdf";
                FileStream fs = File.Open(Path.Combine(CommonFunctions.GetPdfsFolder(), fileName), FileMode.Create, FileAccess.ReadWrite);
                PdfFixedDocument poDocument = new PdfFixedDocument(ms);

                poDocument.Form.Fields["SOCIETATE_RCA"].Value = sRca.DENUMIRE;
                poDocument.Form.Fields["NR_DOSAR_CASCO"].Value = dosar.NR_DOSAR_CASCO;
                poDocument.Form.Fields["ASIGURAT_CASCO"].Value = aCasco.DENUMIRE;
                poDocument.Form.Fields["DATA_NOTIFICARE"].Value = Convert.ToDateTime(dosar.DATA_NOTIFICARE).ToString("dd/MM/yyyy");
                poDocument.Form.Fields["DOCUMENT"].Value = "";
                poDocument.Form.Fields["DATA_EVENIMENT"].Value = Convert.ToDateTime(dosar.DATA_EVENIMENT).ToString("dd/MM/yyyy");
                poDocument.Form.Fields["LOC_ACCIDENT"].Value = dosar.LOC_ACCIDENT;
                poDocument.Form.Fields["NR_AUTO_RCA"].Value = autoRca.NR_AUTO;
                poDocument.Form.Fields["SERIE_SASIU_AUTO_RCA"].Value = autoRca.SERIE_SASIU;
                poDocument.Form.Fields["NR_POLITA_RCA"].Value = dosar.NR_POLITA_RCA;
                poDocument.Form.Fields["NR_AUTO_CASCO"].Value = autoCasco.NR_AUTO;
                poDocument.Form.Fields["SERIE_SASIU_AUTO_CASCO"].Value = autoCasco.SERIE_SASIU;
                poDocument.Form.Fields["VALOARE_DAUNA"].Value = dosar.VALOARE_DAUNA.ToString();
                poDocument.Form.Fields["TELEFON_CASCO"].Value = sCasco.TELEFON;
                poDocument.Form.Fields["EMAIL_CASCO"].Value = sCasco.EMAIL;
                poDocument.Form.FlattenFields();

                Models.DocumentScanat[] ds = (Models.DocumentScanat[])dosar.GetDocumente().Result;
                foreach (Models.DocumentScanat dsj in ds)
                {
                    Models.TipDocument td = (Models.TipDocument)dsj.GetTipDocument().Result;
                    try
                    {
                        if (dsj.VIZA_CASCO && (td.DENUMIRE.ToUpper() == "PROCES VERBAL" || td.DENUMIRE.ToUpper() == "CONSTATARE AMIABILA" || td.DENUMIRE.ToUpper() == "POLITA VINOVAT"))
                        {
                            FileStream msd = File.Open(Path.Combine(CommonFunctions.GetScansFolder(), dsj.CALE_FISIER), FileMode.Open, FileAccess.Read);

                            //pt. cazul cand un png are extensia jpg de ex.
                            Image img = null;
                            string extensie_corecta = dsj.EXTENSIE_FISIER;
                            try
                            {
                                img = Image.FromStream(ms);
                                if (ImageFormat.Jpeg.Equals(img.RawFormat) && !(dsj.EXTENSIE_FISIER.Replace(".", "").ToLower() == "jpg" || dsj.EXTENSIE_FISIER.Replace(".", "").ToLower() == "jpeg"))
                                {
                                    extensie_corecta = "jpg";
                                }
                                if (ImageFormat.Png.Equals(img.RawFormat) && dsj.EXTENSIE_FISIER.Replace(".", "").ToLower() != "png")
                                {
                                    extensie_corecta = "png";
                                }
                                if (ImageFormat.Tiff.Equals(img.RawFormat) && dsj.EXTENSIE_FISIER.Replace(".", "").ToLower() != "tiff")
                                {
                                    extensie_corecta = "tiff";
                                }
                            }
                            catch { }
                            ms.Position = 0;
                            //--

                            switch (extensie_corecta.Replace(".", "").ToLower())
                            {
                                case "pdf":
                                    PdfFixedDocument pd = new PdfFixedDocument(msd);
                                    for (int i = 0; i < pd.Pages.Count; i++)
                                        poDocument.Pages.Add(pd.Pages[i]);
                                    break;
                                case "png":
                                    PdfPngImage pngImg = new PdfPngImage(msd);
                                    PdfPage p = new PdfPage();
                                    ThumbNailSize tns = ThumbNails.ScaleImage(pngImg, p.Width - PDF_PAGE_MARGIN, p.Height - PDF_PAGE_MARGIN);
                                    p.Graphics.DrawImage(pngImg, (p.Width - tns.Width) / 2, (p.Height - tns.Height) / 2, tns.Width, tns.Height);
                                    //p.Graphics.DrawImage(pngImg, 0, 0, p.Width, p.Height);
                                    poDocument.Pages.Add(p);
                                    break;
                                case "jpg":
                                case "jpeg":
                                    Xfinium.Pdf.Graphics.PdfJpegImage jpgImg = new Xfinium.Pdf.Graphics.PdfJpegImage(msd);
                                    p = new PdfPage();
                                    tns = ThumbNails.ScaleImage(jpgImg, p.Width - PDF_PAGE_MARGIN, p.Height - PDF_PAGE_MARGIN);
                                    p.Graphics.DrawImage(jpgImg, (p.Width - tns.Width) / 2, (p.Height - tns.Height) / 2, tns.Width, tns.Height);
                                    //p.Graphics.DrawImage(jpgImg, 0, 0, p.Width, p.Height);
                                    poDocument.Pages.Add(p);
                                    break;
                                case "tiff":
                                    Xfinium.Pdf.Graphics.PdfTiffImage tiffImg = new Xfinium.Pdf.Graphics.PdfTiffImage(msd);
                                    p = new PdfPage();
                                    tns = ThumbNails.ScaleImage(tiffImg, p.Width - PDF_PAGE_MARGIN, p.Height - PDF_PAGE_MARGIN);
                                    p.Graphics.DrawImage(tiffImg, (p.Width - tns.Width) / 2, (p.Height - tns.Height) / 2, tns.Width, tns.Height);
                                    //p.Graphics.DrawImage(tiffImg, 0, 0, p.Width, p.Height);
                                    poDocument.Pages.Add(p);
                                    break;
                                default:
                                    ms.Flush();
                                    ms.Dispose();
                                    throw new Exception("unsupportedFormat");
                            }
                            msd.Flush();
                            msd.Dispose();
                        }
                    }
                    catch (Exception exp) { LogWriter.Log(exp); }
                }


                poDocument.Save(fs);
                fs.Flush();
                fs.Dispose();
                string toReturn = Path.Combine(CommonFunctions.GetPdfsFolder(), fileName);
                if (Convert.ToBoolean(System.Configuration.ConfigurationManager.AppSettings["UseDigitalSignature"]))
                {
                    AddDigitalSignature(toReturn, PdfDigitalSignatureDigestAlgorithm.Sha1);
                }
                return new response(true, toReturn, toReturn, null, null);
            }
            catch (Exception exp) { LogWriter.Log(exp); return new response(false, exp.Message, null, null, new System.Collections.Generic.List<Error>() { new Error(exp) }); }
        }

        public static response ExportDosarToPdfWithPdfForm(byte[] template_file_content, Models.Dosar dosar)
        {
            try
            {
                MemoryStream ms = new MemoryStream(template_file_content);
                string fileName = dosar.NR_DOSAR_CASCO.Replace('/','_').Replace(' ','_') + "_cerere.pdf";
                FileStream fs = File.Open(Path.Combine(CommonFunctions.GetPdfsFolder(), fileName), FileMode.Create, FileAccess.ReadWrite);
                PdfFixedDocument poDocument = new PdfFixedDocument(ms);

                Models.SocietateAsigurare sCasco = (Models.SocietateAsigurare)dosar.GetSocietateCasco().Result;
                Models.SocietateAsigurare sRca = (Models.SocietateAsigurare)dosar.GetSocietateRca().Result;
                Models.Asigurat aCasco = (Models.Asigurat)dosar.GetAsiguratCasco().Result;
                Models.Asigurat aRca = (Models.Asigurat)dosar.GetAsiguratRca().Result;
                Models.Auto autoCasco = (Models.Auto) dosar.GetAutoCasco().Result;
                Models.Auto autoRca = (Models.Auto)dosar.GetAutoRca().Result;

                poDocument.Form.Fields["FieldSocietateCasco"].Value = sCasco.DENUMIRE;
                poDocument.Form.Fields["FieldAdresaSocietateCasco"].Value = sCasco.ADRESA;
                poDocument.Form.Fields["FieldCUISocietateCasco"].Value = sCasco.CUI;
                poDocument.Form.Fields["FieldContBancarSocietateCasco"].Value = sCasco.IBAN;
                poDocument.Form.Fields["FieldBancaSocietateCasco"].Value = sCasco.BANCA;
                poDocument.Form.Fields["FieldSocietateRCA"].Value = sRca.DENUMIRE;
                poDocument.Form.Fields["FieldAdresaSocietateRCA"].Value = sRca.ADRESA;
                poDocument.Form.Fields["FieldNrDosarCasco"].Value = dosar.NR_DOSAR_CASCO;
                poDocument.Form.Fields["FieldPolitaRCA"].Value = dosar.NR_POLITA_RCA;
                poDocument.Form.Fields["FieldPolitaCasco"].Value = dosar.NR_POLITA_CASCO;
                poDocument.Form.Fields["FieldAsiguratCasco"].Value = aCasco.DENUMIRE;
                poDocument.Form.Fields["FieldAsiguratRCA"].Value = aRca.DENUMIRE;
                poDocument.Form.Fields["FieldNrAutoCasco"].Value = autoCasco.NR_AUTO;
                poDocument.Form.Fields["FieldAutoCasco"].Value = autoCasco.MARCA + " " + autoCasco.MODEL;
                poDocument.Form.Fields["FieldNrAutoRCA"].Value = autoRca.NR_AUTO;
                poDocument.Form.Fields["FieldDataEveniment"].Value = Convert.ToDateTime(dosar.DATA_EVENIMENT).ToString("dd/MM/yyyy");
                poDocument.Form.Fields["FieldSuma"].Value = dosar.VALOARE_DAUNA.ToString();

                string docs = "";
                Models.DocumentScanat[] dsj = (Models.DocumentScanat[])dosar.GetDocumente().Result;
                foreach (Models.DocumentScanat doc in dsj)
                {
                    docs = String.Format("- {1}\r\n{0}", docs, (doc.DETALII != "" && doc.DETALII != null ? doc.DETALII : doc.DENUMIRE_FISIER));
                }
                poDocument.Form.Fields["FieldDocumente"].Value = docs;

                poDocument.Form.FlattenFields();

                poDocument.Save(fs);
                fs.Flush();
                fs.Dispose();
                string toReturn = Path.Combine(CommonFunctions.GetPdfsFolder(), fileName);
                if (Convert.ToBoolean(System.Configuration.ConfigurationManager.AppSettings["UseDigitalSignature"]))
                {
                    AddDigitalSignature(toReturn, PdfDigitalSignatureDigestAlgorithm.Sha1);
                }
                return new response(true, toReturn, toReturn, null, null);
            }
            catch (Exception exp) { LogWriter.Log(exp); return new response(false, exp.Message, null, null, new System.Collections.Generic.List<Error>() { new Error(exp) }); }
        }

        public static response ExportDocumenteDosarToPdf(Models.Dosar dosar)
        {
            try
            {
                object[] DocumenteTipuri = (object[])dosar.GetDocumenteTipuri().Result;
                PdfFixedDocument poDocument = new PdfFixedDocument();
                Models.DocumentScanat[] ds = (Models.DocumentScanat[])dosar.GetDocumente().Result;
                foreach (object[] documentTip in DocumenteTipuri)
                {
                    foreach (Models.DocumentScanat dsj in ds)
                    {
                        try
                        {
                            if (dsj.ID_TIP_DOCUMENT == Convert.ToInt32(documentTip[0]) && dsj.VIZA_CASCO)
                            {
                                //MemoryStream ms = new MemoryStream(dsj.FILE_CONTENT); // -- pt. citire content fisier din  BD
                                FileStream ms = File.Open(Path.Combine(CommonFunctions.GetScansFolder(), dsj.CALE_FISIER), FileMode.Open, FileAccess.Read);

                                //pt. cazul cand un png are extensia jpg de ex.
                                Image img = null;
                                string extensie_corecta = dsj.EXTENSIE_FISIER;
                                try
                                {
                                    img = Image.FromStream(ms);
                                    if (ImageFormat.Jpeg.Equals(img.RawFormat) && !(dsj.EXTENSIE_FISIER.Replace(".", "").ToLower() == "jpg" || dsj.EXTENSIE_FISIER.Replace(".", "").ToLower() == "jpeg"))
                                    {
                                        extensie_corecta = "jpg";
                                    }
                                    if (ImageFormat.Png.Equals(img.RawFormat) && dsj.EXTENSIE_FISIER.Replace(".", "").ToLower() != "png")
                                    {
                                        extensie_corecta = "png";
                                    }
                                    if (ImageFormat.Tiff.Equals(img.RawFormat) && dsj.EXTENSIE_FISIER.Replace(".", "").ToLower() != "tiff")
                                    {
                                        extensie_corecta = "tiff";
                                    }
                                }
                                catch { }
                                ms.Position = 0;
                                //--

                                switch (extensie_corecta.Replace(".", "").ToLower())
                                {
                                    case "pdf":
                                        PdfFixedDocument pd = new PdfFixedDocument(ms);
                                        for (int i = 0; i < pd.Pages.Count; i++)
                                            poDocument.Pages.Add(pd.Pages[i]);
                                        break;
                                    case "png":
                                        Xfinium.Pdf.Graphics.PdfPngImage pngImg = new Xfinium.Pdf.Graphics.PdfPngImage(ms);
                                        PdfPage p = new PdfPage();
                                        ThumbNailSize tns = ThumbNails.ScaleImage(pngImg, p.Width - PDF_PAGE_MARGIN, p.Height - PDF_PAGE_MARGIN);
                                        p.Graphics.DrawImage(pngImg, (p.Width - tns.Width) / 2, (p.Height - tns.Height) / 2, tns.Width, tns.Height);
                                        //p.Graphics.DrawImage(pngImg, 0, 0, p.Width, p.Height);
                                        poDocument.Pages.Add(p);
                                        break;
                                    case "jpg":
                                    case "jpeg":
                                        Xfinium.Pdf.Graphics.PdfJpegImage jpgImg = new Xfinium.Pdf.Graphics.PdfJpegImage(ms);
                                        p = new PdfPage();
                                        tns = ThumbNails.ScaleImage(jpgImg, p.Width - PDF_PAGE_MARGIN, p.Height - PDF_PAGE_MARGIN);
                                        p.Graphics.DrawImage(jpgImg, (p.Width - tns.Width) / 2, (p.Height - tns.Height) / 2, tns.Width, tns.Height);
                                        //p.Graphics.DrawImage(jpgImg, 0, 0, p.Width, p.Height);
                                        poDocument.Pages.Add(p);
                                        break;
                                    case "tiff":
                                        Xfinium.Pdf.Graphics.PdfTiffImage tiffImg = new Xfinium.Pdf.Graphics.PdfTiffImage(ms);
                                        p = new PdfPage();
                                        tns = ThumbNails.ScaleImage(tiffImg, p.Width - PDF_PAGE_MARGIN, p.Height - PDF_PAGE_MARGIN);
                                        p.Graphics.DrawImage(tiffImg, (p.Width - tns.Width) / 2, (p.Height - tns.Height) / 2, tns.Width, tns.Height);
                                        //p.Graphics.DrawImage(tiffImg, 0, 0, p.Width, p.Height);
                                        poDocument.Pages.Add(p);
                                        break;
                                    default:
                                        ms.Flush();
                                        ms.Dispose();
                                        throw new Exception("unsupportedFormat");
                                }
                                ms.Flush();
                                ms.Dispose();
                                //break;
                            }
                        }
                        catch (Exception exp) { LogWriter.Log(exp); }
                    }
                }
                if (poDocument.Pages.Count > 0)
                {
                    string fileName = dosar.NR_DOSAR_CASCO.Replace('/', '_').Replace(' ', '_') + "_documente.pdf";
                    FileStream fs = File.Open(Path.Combine(CommonFunctions.GetPdfsFolder(), fileName), FileMode.Create, FileAccess.ReadWrite);
                    poDocument.Save(fs);
                    fs.Flush();
                    fs.Dispose();
                    string toReturn = Path.Combine(CommonFunctions.GetPdfsFolder(), fileName);
                    return new response(true, toReturn, toReturn, null, null);
                }
                else
                {
                    return new response(false, ErrorParser.ErrorMessage("dosarFaraDocumente").ERROR_MESSAGE, null, null, new List<Error>() { ErrorParser.ErrorMessage("dosarFaraDocumente") });
                }
            }
            catch (Exception exp) { LogWriter.Log(exp); return new response(false, exp.Message, null, null, new System.Collections.Generic.List<Error>() { new Error(exp) }); }
        }

        public static response GeneratePdfWithSignatureFromDocument(Models.DocumentScanat ds)
        {
            try
            {
                PdfFixedDocument poDocument = new PdfFixedDocument();
                if (ds.VIZA_CASCO)
                {
                    //MemoryStream ms = new MemoryStream(dsj.FILE_CONTENT); // -- pt. citire content fisier din  BD
                    FileStream ms = File.Open(Path.Combine(CommonFunctions.GetScansFolder(), ds.CALE_FISIER), FileMode.Open, FileAccess.Read);
                    
                    //pt. cazul cand un png are extensia jpg de ex.
                    Image img = null;
                    string extensie_corecta = ds.EXTENSIE_FISIER;
                    try
                    {
                        img = Image.FromStream(ms);
                        if (ImageFormat.Jpeg.Equals(img.RawFormat) && !(ds.EXTENSIE_FISIER.Replace(".", "").ToLower() == "jpg" || ds.EXTENSIE_FISIER.Replace(".", "").ToLower() == "jpeg"))
                        {
                            extensie_corecta = "jpg";
                        }
                        if (ImageFormat.Png.Equals(img.RawFormat) && ds.EXTENSIE_FISIER.Replace(".", "").ToLower() != "png")
                        {
                            extensie_corecta = "png";
                        }
                        if (ImageFormat.Tiff.Equals(img.RawFormat) && ds.EXTENSIE_FISIER.Replace(".", "").ToLower() != "tiff")
                        {
                            extensie_corecta = "tiff";
                        }
                    }
                    catch { }
                    ms.Position = 0;
                    //--

                    switch (extensie_corecta.Replace(".", "").ToLower())
                    {
                        case "pdf":
                            PdfFixedDocument pd = new PdfFixedDocument(ms);
                            for (int i = 0; i < pd.Pages.Count; i++)
                                poDocument.Pages.Add(pd.Pages[i]);
                            break;
                        case "png":
                            PdfPngImage pngImg = new PdfPngImage(ms);
                            PdfPage p = new PdfPage();
                            ThumbNailSize tns = ThumbNails.ScaleImage(pngImg, p.Width - PDF_PAGE_MARGIN, p.Height - PDF_PAGE_MARGIN);
                            p.Graphics.DrawImage(pngImg, (p.Width - tns.Width) / 2, (p.Height - tns.Height) / 2, tns.Width, tns.Height);
                            //p.Graphics.DrawImage(pngImg, 0, 0, p.Width, p.Height);
                            poDocument.Pages.Add(p);
                            break;
                        case "jpg":
                        case "jpeg":
                            PdfJpegImage jpgImg = new PdfJpegImage(ms);                               
                            p = new PdfPage();
                            tns = ThumbNails.ScaleImage(jpgImg, p.Width - PDF_PAGE_MARGIN, p.Height - PDF_PAGE_MARGIN);
                            //LogWriter.Log("width: " + tns.Width + " / height: " + tns.Height);
                            p.Graphics.DrawImage(jpgImg, (p.Width - tns.Width) / 2, (p.Height - tns.Height) / 2, tns.Width, tns.Height);
                            //p.Graphics.DrawImage(jpgImg, 0, 0, p.Width, p.Height);
                            poDocument.Pages.Add(p);
                            break;
                        case "tiff":
                            PdfTiffImage tiffImg = new PdfTiffImage(ms);
                            p = new PdfPage();
                            tns = ThumbNails.ScaleImage(tiffImg, p.Width - PDF_PAGE_MARGIN, p.Height - PDF_PAGE_MARGIN);
                            p.Graphics.DrawImage(tiffImg, (p.Width - tns.Width) / 2, (p.Height - tns.Height) / 2, tns.Width, tns.Height);
                            //p.Graphics.DrawImage(tiffImg, 0, 0, p.Width, p.Height);
                            poDocument.Pages.Add(p);
                            break;
                        default:
                            ms.Flush();
                            ms.Dispose();
                            throw new Exception("unsupportedFormat");
                    }
                    ms.Flush();
                    ms.Dispose();
                    //break;
                }
                if (poDocument.Pages.Count > 0)
                {
                    string fileName = ds.DENUMIRE_FISIER.Replace(ds.EXTENSIE_FISIER, ".pdf");
                    string filePath = Path.Combine(CommonFunctions.GetTempFolder(), fileName);
                    FileStream fs = File.Open(filePath, FileMode.Create, FileAccess.ReadWrite);
                    poDocument.Save(fs);
                    fs.Flush();
                    fs.Dispose();
                    if (Convert.ToBoolean(System.Configuration.ConfigurationManager.AppSettings["UseDigitalSignature"]))
                    {
                        AddDigitalSignature(filePath, PdfDigitalSignatureDigestAlgorithm.Sha1);
                    }
                    return new response(true, fileName, filePath, null, null);
                }
                else
                {
                    return new response(false, ErrorParser.ErrorMessage("dosarFaraDocumente").ERROR_MESSAGE, null, null, new List<Error>() { ErrorParser.ErrorMessage("dosarFaraDocumente") });
                }
            }
            catch (Exception exp) {
                exp.Data.Add("Fisier", ds.DENUMIRE_FISIER);
                exp.Data.Add("CaleFisier", ds.CALE_FISIER);
                LogWriter.Log(exp); return new response(false, exp.Message, null, null, new System.Collections.Generic.List<Error>() { new Error(exp) });
            }
        }


        public static response ExportDosarCompletToPdf(string templateFileName, Models.Dosar Dosar)
        {
            try
            {
                string f1 = null;
                response r1 = ExportDosarToPdf(templateFileName, Dosar);
                if (r1.Status)
                    f1 = r1.Message;

                string f2 = null;
                response r2 = ExportDocumenteDosarToPdf(Dosar);
                if (r2.Status)
                    f2 = r2.Message;

                if (r1.Status && r2.Status)
                {
                    FileStream fs1 = new FileStream(f1, FileMode.Open, FileAccess.Read);
                    PdfFixedDocument p1 = new PdfFixedDocument(fs1);
                    FileStream fs2 = new FileStream(f2, FileMode.Open, FileAccess.Read);
                    PdfFixedDocument p2 = new PdfFixedDocument(fs2);
                    for (int i = 0; i < p2.Pages.Count; i++)
                    {
                        p1.Pages.Add(p2.Pages[i]);
                    }
                    string fileNameToReturn = Dosar.NR_DOSAR_CASCO.Replace('/', '_').Replace(' ', '_') + ".pdf";
                    FileStream fs = File.Open(Path.Combine(CommonFunctions.GetPdfsFolder(), fileNameToReturn), FileMode.Create, FileAccess.ReadWrite);
                    p1.Save(fs);
                    fs.Flush();
                    fs.Dispose();
                    fs1.Flush();
                    fs1.Dispose();
                    fs2.Flush();
                    fs2.Dispose();
                    string toReturn = Path.Combine(CommonFunctions.GetPdfsFolder(), fileNameToReturn);
                    return new response(true, toReturn, toReturn, null, null);
                }
                r1.AddResponse(r2);
                return r1;
            }
            catch (Exception exp) { LogWriter.Log(exp); return new response(false, exp.Message, null, null, new System.Collections.Generic.List<Error>() { new Error(exp) }); }
        }

        public static response ExportDosarCompletToPdf(int authenticatedUserId, string connectionString, string templateFileName, Models.Dosar Dosar)
        {
            try
            {
                string f1 = null;
                response r1 = ExportDosarToPdf(authenticatedUserId, connectionString, templateFileName, Dosar);
                if (r1.Status)
                    f1 = r1.Message;

                string f2 = null;
                response r2 = ExportDocumenteDosarToPdf(Dosar);
                if (r2.Status)
                    f2 = r2.Message;

                if (r1.Status && r2.Status)
                {
                    FileStream fs1 = new FileStream(f1, FileMode.Open, FileAccess.Read);
                    PdfFixedDocument p1 = new PdfFixedDocument(fs1);
                    FileStream fs2 = new FileStream(f2, FileMode.Open, FileAccess.Read);
                    PdfFixedDocument p2 = new PdfFixedDocument(fs2);
                    for (int i = 0; i < p2.Pages.Count; i++)
                    {
                        p1.Pages.Add(p2.Pages[i]);
                    }
                    string fileNameToReturn = Dosar.NR_DOSAR_CASCO.Replace('/', '_').Replace(' ', '_') + ".pdf";
                    FileStream fs = File.Open(Path.Combine(CommonFunctions.GetPdfsFolder(), fileNameToReturn), FileMode.Create, FileAccess.ReadWrite);
                    p1.Save(fs);
                    fs.Flush();
                    fs.Dispose();
                    fs1.Flush();
                    fs1.Dispose();
                    fs2.Flush();
                    fs2.Dispose();
                    string toReturn = Path.Combine(CommonFunctions.GetPdfsFolder(), fileNameToReturn);
                    if (Convert.ToBoolean(System.Configuration.ConfigurationManager.AppSettings["UseDigitalSignature"]))
                    {
                        AddDigitalSignature(toReturn, PdfDigitalSignatureDigestAlgorithm.Sha1);
                    }
                    return new response(true, toReturn, toReturn, null, null);
                }
                r1.AddResponse(r2);
                return r1;
            }
            catch (Exception exp) { LogWriter.Log(exp); return new response(false, exp.Message, null, null, new System.Collections.Generic.List<Error>() { new Error(exp) }); }
        }
    }
}