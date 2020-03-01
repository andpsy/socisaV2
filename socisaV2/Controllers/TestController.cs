using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using SOCISA;
using SOCISA.Models;
using Xfinium.Pdf;
using Xfinium.Pdf.Graphics;

namespace socisaWeb.Controllers
{
    public class TestController : Controller
    {
        public ActionResult Index(string id)
        {
            //response r = new response();
            //string conStr = Session["conStr"].ToString();
            ////FileManager.LoadTemplateFileIntoDb(1, conStr, "C:\\notificare_allianz.pdf", "test");

            ////Dosar d = new Dosar(1, conStr, Convert.ToInt32(id));
            ////d.GenerateNotificarePdf();
            ////r = d.SendCerereDespagubire();

            ////Compensari.GenerateRandomNodes(1, conStr);
            //Compensari.TestCompensare(1, conStr);
            //return Json(r, JsonRequestBehavior.AllowGet);

            //return Json(CommonFunctions.StringCipher.Encrypt("regres.rca@compensaredirecta.ro", CommonFunctions.StringCipher.RetrieveKey()), JsonRequestBehavior.AllowGet);
            CommonFunctions.StringCipher.Encrypt("As.1720411470013", CommonFunctions.StringCipher.RetrieveKey());

            //PdfGenerator.AddDigitalSignature();

            return View("Test");


        }

        [HttpPost]
        public void UploadImage(string imageData)
        {
            string fileName = "MyUniqueImageFileName.png";
            string fileNameWitPath = Path.Combine(Server.MapPath("~/Temp"), fileName);

            using (FileStream fs = new FileStream(fileNameWitPath, FileMode.Create))
            {
                using (BinaryWriter bw = new BinaryWriter(fs))
                {
                    byte[] data = Convert.FromBase64String(imageData);
                    bw.Write(data);
                    bw.Close();
                }
                fs.Close();
            }
            PdfFixedDocument poDocument = new PdfFixedDocument();
            PdfPngImage pngImg = new PdfPngImage(fileNameWitPath);
            PdfPage p = new PdfPage();
            p.Graphics.DrawImage(pngImg, 0, 0, pngImg.Width, pngImg.Height);
            poDocument.Pages.Add(p);
            poDocument.Save(fileNameWitPath.Replace("png", "pdf"));
            byte[] pdfContent = System.IO.File.ReadAllBytes(fileNameWitPath.Replace("png", "pdf"));
            Response.BinaryWrite(pdfContent);
        }

        public void LoadTemplates()
        {
            string conStr = Server.MapPath("~").ToLower().IndexOf("test") > 0 ? CommonFunctions.StringCipher.Decrypt(System.Configuration.ConfigurationManager.ConnectionStrings["MySQLConnectionString_test"].ConnectionString, CommonFunctions.StringCipher.RetrieveKey()) : CommonFunctions.StringCipher.Decrypt(System.Configuration.ConfigurationManager.ConnectionStrings["MySQLConnectionString"].ConnectionString, CommonFunctions.StringCipher.RetrieveKey()); // separam socisa de socisa_test
            //FileManager.LoadTemplateFileIntoDb(1, conStr, "C:\\notificare_allianz.pdf", "test");
            FileManager.UpdateTemplateFileIntoDb(1, conStr, 18, "C:\\Cerere_despagubire_t1.pdf", "test");
            FileManager.UpdateTemplateFileIntoDb(1, conStr, 19, "C:\\Cerere_despagubire_t2.pdf", "test");
            FileManager.UpdateTemplateFileIntoDb(1, conStr, 22, "C:\\Cerere_t1.pdf", "test");
            FileManager.UpdateTemplateFileIntoDb(1, conStr, 23, "C:\\Cerere_t2.pdf", "test");
        }

        //[AuthorizeToken]
        [HttpGet]
        public ActionResult eShow(string token)
        {
            string conStr = Session["conStr"].ToString(); //ConfigurationManager.ConnectionStrings["MySQLConnectionString"].ConnectionString;
            string[] t = token.Split(new string[] { "|" }, StringSplitOptions.RemoveEmptyEntries);
            Dosar d = new Dosar(Convert.ToInt32(Session["CURENT_USER_ID"]), conStr, Convert.ToInt32(t[1]));
            return PartialView("_DosareNavigator", new DosarView(Convert.ToInt32(Session["CURENT_USER_ID"]), Convert.ToInt32(Session["ID_SOCIETATE"]), d, conStr));
        }
    }
}