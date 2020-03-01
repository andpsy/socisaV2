using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Threading.Tasks;
using SOCISA;
using SOCISA.Models;
using System.Configuration;
using System.Web.Security;
using System.Reflection;
using System.Security.Cryptography;
using System.Net.Mail;

namespace socisaWeb
{
    [Authorize]
    public class UtilizatoriController : Controller
    {
        //[AuthorizeUser(ActionName = "Utilizatori", Recursive = false)]
        public ActionResult Index()
        {
            string conStr = Session["conStr"].ToString(); //ConfigurationManager.ConnectionStrings["MySQLConnectionString"].ConnectionString;
            UtilizatorView uv = new UtilizatorView(Convert.ToInt32(Session["CURENT_USER_ID"]), conStr);
            return PartialView("Utilizatori", uv);
        }

        //[AuthorizeUser(ActionName = "Utilizatori", Recursive = false)]
        public JsonResult IndexJson()
        {
            string conStr = Session["conStr"].ToString();  //ConfigurationManager.ConnectionStrings["MySQLConnectionString"].ConnectionString;
            UtilizatorView uv = new UtilizatorView(Convert.ToInt32(Session["CURENT_USER_ID"]), conStr);
            return Json(uv, JsonRequestBehavior.AllowGet);
        }

        [AuthorizeUser(ActionName = "Utilizatori", Recursive = false)]
        [HttpPost]
        public JsonResult Save(Utilizator Utilizator)
        {
            response r = new response();

            string conStr = Session["conStr"].ToString();  //ConfigurationManager.ConnectionStrings["MySQLConnectionString"].ConnectionString;
            int _CURENT_USER_ID = Convert.ToInt32(Session["CURENT_USER_ID"]);
            UtilizatoriRepository ur = new UtilizatoriRepository(_CURENT_USER_ID, conStr);
            Utilizator u = new Utilizator(_CURENT_USER_ID, conStr);
            PropertyInfo[] pis = Utilizator.GetType().GetProperties();
            foreach (PropertyInfo pi in pis)
            {
                pi.SetValue(u, pi.GetValue(Utilizator));
            }
            if (Utilizator.ID == null) // insert
            {
                r = u.Insert();
            }
            else // update
            {
                r = u.Update();
            }
            return Json(r, JsonRequestBehavior.AllowGet);
        }

        [AuthorizeUser(ActionName = "Utilizatori", Recursive = false)]
        [HttpPost]
        public JsonResult SetPassword(int id_utilizator, string password, string confirmPassword)
        {
            response r = new response();
            if (password != confirmPassword) // alte validari aici !!!
            {
                r = new response(false, "Parolele nu coincid!", null, null, new List<Error>() { ErrorParser.ErrorMessage("passwordsDontMatch") });
                return Json(r, JsonRequestBehavior.AllowGet);
            }
            string conStr = Session["conStr"].ToString();  //ConfigurationManager.ConnectionStrings["MySQLConnectionString"].ConnectionString;
            int _CURENT_USER_ID = Convert.ToInt32(Session["CURENT_USER_ID"]);
            UtilizatoriRepository ur = new UtilizatoriRepository(_CURENT_USER_ID, conStr);
            r = ur.SetPassword(id_utilizator, password);
            return Json(r, JsonRequestBehavior.AllowGet);
        }

        [AuthorizeUser(ActionName = "Utilizatori", Recursive = false)]
        [HttpPost]
        public JsonResult Delete(int id)
        {
            response r = new response();

            string conStr = Session["conStr"].ToString();  //ConfigurationManager.ConnectionStrings["MySQLConnectionString"].ConnectionString;
            int _CURENT_USER_ID = Convert.ToInt32(Session["CURENT_USER_ID"]);
            UtilizatoriRepository ur = new UtilizatoriRepository(_CURENT_USER_ID, conStr);
            Utilizator u = new Utilizator(_CURENT_USER_ID, conStr, id);
            r = u.Delete();
            return Json(r, JsonRequestBehavior.AllowGet);
        }

        [AuthorizeUser(ActionName = "Utilizatori", Recursive = false)]
        [HttpPost]
        public JsonResult GetUtilizatoriSubordonat(int id)
        {
            string conStr = Session["conStr"].ToString();  //ConfigurationManager.ConnectionStrings["MySQLConnectionString"].ConnectionString;
            int _CURENT_USER_ID = Convert.ToInt32(Session["CURENT_USER_ID"]);
            UtilizatorJson uj = new UtilizatorJson(_CURENT_USER_ID, conStr, id);
            return Json(uj.GetUtilizatoriSubordonati(_CURENT_USER_ID, conStr), JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        [AllowAnonymous]
        public ActionResult TokenLogin(LoginJson model, string submitCode)
        {
            if (submitCode == "Retrimite codul")
            {
                model.Code = null;
                //string rnd = "1234"; // pt. test

                Utilizator u = (Utilizator)TempData["tempLogin"];
                string _token = TempData["TOKEN"].ToString();
                string _url = TempData["URL"].ToString();
                string[] separator = { "|" };
                string[] token = _token.Split(separator, StringSplitOptions.RemoveEmptyEntries);
                int id = Convert.ToInt32(token[1]);
                string conStr = HttpContext.Server.MapPath("~").ToLower().IndexOf("test") > 0 ? CommonFunctions.StringCipher.Decrypt(System.Configuration.ConfigurationManager.ConnectionStrings["MySQLConnectionString_test"].ConnectionString, CommonFunctions.StringCipher.RetrieveKey()) : CommonFunctions.StringCipher.Decrypt(System.Configuration.ConfigurationManager.ConnectionStrings["MySQLConnectionString"].ConnectionString, CommonFunctions.StringCipher.RetrieveKey()); // separam socisa de socisa_test
                Dosar d = new Dosar(Convert.ToInt32(u.ID), conStr, id);
                SocietateAsigurare sa = (SocietateAsigurare)d.GetSocietateRca().Result;

                Random generator = new Random();
                string rnd = generator.Next(0, 1000000).ToString("D6");
                SendVerificationCode(EmailProfiles.AwsCereriSES, sa.EMAIL_NOTIFICARI, rnd);
                TempData.Clear();
                TempData["TOKEN"] = _token;
                TempData["URL"] = _url;
                TempData["tempLogin"] = u;
                TempData["verificationCode"] = rnd;
                TempData["verificationCodeIssueTime"] = DateTime.Now;
                return View("TokenLogin", new LoginJson());
            }

            if (TempData["TOKEN"] != null && TempData["URL"] != null && TempData["tempLogin"] != null)
            {
                if (TempData["verificationCode"] == null || String.IsNullOrWhiteSpace(TempData["verificationCode"].ToString()))
                {
                    ModelState.AddModelError("", socisaV2.Resources.ErrorMessagesResx.VERIFICATION_CODE_EXPIRED);
                    //TempData.Clear();
                    TempData.Keep();
                    return View("TokenLogin", model);
                }
                else
                {
                    //model.Code = TempData["verificationCode"].ToString();
                    var passedSeconds = (DateTime.Now - (DateTime)TempData["verificationCodeIssueTime"]).TotalSeconds;
                    if (Math.Abs((int)passedSeconds) > Convert.ToInt32(ConfigurationManager.AppSettings["VerificationCodeExpiration"]))
                    {
                        ModelState.AddModelError("", socisaV2.Resources.ErrorMessagesResx.VERIFICATION_CODE_EXPIRED);
                        //TempData.Clear();
                        TempData.Keep();
                        return View("TokenLogin", model);
                    }
                    else
                    {
                        if (String.IsNullOrEmpty(model.Code))
                        {
                            ModelState.AddModelError("", socisaV2.Resources.ErrorMessagesResx.EMPTY_CODE);
                            return View("TokenLogin", model);
                        }
                        else
                        {
                            if (model.Code != TempData["verificationCode"].ToString())
                            {
                                ModelState.AddModelError("", socisaV2.Resources.ErrorMessagesResx.VERIFICATION_CODE_DONT_MATCH);
                                return View("TokenLogin", model);
                            }
                            else
                            {
                                return InternalTokenLogin(TempData["TOKEN"].ToString(), TempData["URL"].ToString(), (Utilizator)TempData["tempLogin"]);
                            }
                        }
                    }
                }
            }
            else
            {
                TempData.Clear();
                return Redirect("~");
            }
        }

        private ActionResult InternalTokenLogin(string _token, string _url, Utilizator u)
        {
            string conStr = HttpContext.Server.MapPath("~").ToLower().IndexOf("test") > 0 ? CommonFunctions.StringCipher.Decrypt(ConfigurationManager.ConnectionStrings["MySQLConnectionString_test"].ConnectionString, CommonFunctions.StringCipher.RetrieveKey()) : CommonFunctions.StringCipher.Decrypt(ConfigurationManager.ConnectionStrings["MySQLConnectionString"].ConnectionString, CommonFunctions.StringCipher.RetrieveKey()); // separam socisa de socisa_test
            HttpContext.Session["TOKEN"] = _token;
            TempData.Clear();

            string[] separator = { "|" };
            string[] token = _token.Split(separator, StringSplitOptions.RemoveEmptyEntries);
            int id = Convert.ToInt32(token[1]);
            Dosar d = new Dosar(Convert.ToInt32(u.ID), conStr, id);

            HttpContext.Session["conStr"] = conStr;
            HttpContext.Session["CURENT_USER_ID"] = u.ID;
            HttpContext.Session["CURENT_USER"] = u;
            FormsAuthentication.SetAuthCookie(u.USER_NAME, true);
            //System.Web.Security.FormsAuthentication.SetAuthCookie("", false);
            NomenclatoareRepository nr = new NomenclatoareRepository(Convert.ToInt32(u.ID), conStr);
            Nomenclator n = (Nomenclator)nr.Find("TIP_UTILIZATORI", Convert.ToInt32(u.ID_TIP_UTILIZATOR)).Result;
            HttpContext.Session["CURENT_USER_TYPE"] = n;
            HttpContext.Session["CURENT_USER_RIGHTS"] = (Drept[])u.GetDrepturi().Result;
            HttpContext.Session["CURENT_USER_ACTIONS"] = (SOCISA.Models.Action[])u.GetActions().Result;
            HttpContext.Session["CURENT_USER_SETTINGS"] = (Setare[])u.GetSetari().Result;
            HttpContext.Session["CURENT_USER_SOCIETATI_ADMINISTRATE"] = (SocietateAsigurare[])u.GetSocietatiAdministrate().Result;

            HttpContext.Session["ID_SOCIETATE"] = d.ID_SOCIETATE_CASCO;
            SocietateAsigurare sa = new SocietateAsigurare(Convert.ToInt32(u.ID_SOCIETATE), conStr, Convert.ToInt32(d.ID_SOCIETATE_CASCO));
            HttpContext.Session["SOCIETATE_ASIGURARE"] = sa;
            //return Redirect(String.Format("/Dashboard/IndexMain/{0}", Token));
            return Redirect(String.Format("{0}{1}", HttpUtility.UrlDecode(_url), _token));
        }

        [HttpGet]
        [AllowAnonymous]
        public ActionResult TokenLogin(string _url, string _token)
        {
            //string Token = HttpContext.Request.Params["URL"].ToString().Substring(HttpContext.Request.Params["URL"].ToString().LastIndexOf('/') + 1);

            if (!String.IsNullOrWhiteSpace(_token) && _token.IndexOf('|') > -1)
            {
                if (Session["CURENT_USER_ID"] != null && Session["ID_SOCIETATE"] != null) // s-a mai accesat odata linkul (de exemplu pt. email si pt. printare documente
                {
                    HttpContext.Session["TOKEN"] = _token;
                    return Redirect(String.Format("{0}{1}", HttpUtility.UrlDecode(_url), _token));
                }
                else // aici trebuie sa trimitem cod pe email
                {
                    if (TempData["TOKEN"] == null || String.IsNullOrWhiteSpace(TempData["TOKEN"].ToString()))
                    {
                        string conStr = HttpContext.Server.MapPath("~").ToLower().IndexOf("test") > 0 ? CommonFunctions.StringCipher.Decrypt(ConfigurationManager.ConnectionStrings["MySQLConnectionString_test"].ConnectionString, CommonFunctions.StringCipher.RetrieveKey()) : CommonFunctions.StringCipher.Decrypt(ConfigurationManager.ConnectionStrings["MySQLConnectionString"].ConnectionString, CommonFunctions.StringCipher.RetrieveKey()); // separam socisa de socisa_test
                        Utilizator u = null;
                        MySql.Data.MySqlClient.MySqlConnection con = new MySql.Data.MySqlClient.MySqlConnection(conStr);
                        MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand();
                        cmd.Connection = con;
                        cmd.CommandType = System.Data.CommandType.StoredProcedure;
                        cmd.CommandText = "UTILIZATORIsp_GetByUserName";
                        cmd.Parameters.Add(new MySql.Data.MySqlClient.MySqlParameter("_USER_NAME", "email"));
                        con.Open();
                        MySql.Data.MySqlClient.MySqlDataReader r = cmd.ExecuteReader(System.Data.CommandBehavior.CloseConnection);
                        while (r.Read())
                        {
                            int authenticatedUserId = Convert.ToInt32(r["ID"]);
                            u = new Utilizator(Convert.ToInt32(authenticatedUserId), conStr, r);
                            break;
                        }
                        r.Close(); r.Dispose();
                        if (con != null && con.State == System.Data.ConnectionState.Open)
                        {
                            con.Close();
                            con.Dispose();
                        }

                        if (u == null)
                        {
                            TempData.Clear();
                            return Redirect("~");
                        }
                        else
                        {
                            TempData["TOKEN"] = _token;
                            TempData["URL"] = _url;
                            string[] separator = { "|" };
                            string[] token = _token.Split(separator, StringSplitOptions.RemoveEmptyEntries);
                            string md5p = token[0];
                            int id = Convert.ToInt32(token[1]);
                            Dosar d = new Dosar(Convert.ToInt32(u.ID), conStr, id);
                            MD5 md5h = MD5.Create();
                            if (!CommonFunctions.VerifyMd5Hash(md5h, d.NR_DOSAR_CASCO, md5p))
                            {
                                TempData.Clear();
                                return Redirect("~");
                            }
                            else
                            {
                                if (Convert.ToBoolean(ConfigurationManager.AppSettings["UseDoubleAutentificationForEmail"]))
                                {
                                    SocietateAsigurare sa = (SocietateAsigurare)d.GetSocietateRca().Result;
                                    TempData["tempLogin"] = u;

                                    //string rnd = "1234"; // pt. test

                                    Random generator = new Random();
                                    string rnd = generator.Next(0, 1000000).ToString("D6");
                                    SendVerificationCode(EmailProfiles.AwsCereriSES, sa.EMAIL_NOTIFICARI, rnd);

                                    TempData["verificationCode"] = rnd;
                                    TempData["verificationCodeIssueTime"] = DateTime.Now;
                                    return View("TokenLogin", new LoginJson());
                                    //return RedirectToAction("TokenLogin", "Utilizatori");
                                }
                                else
                                {
                                    return InternalTokenLogin(_token, _url, u);
                                }
                            }
                        }
                    }
                    else
                    {
                        TempData.Clear();
                        return Redirect("~");
                    }
                }
            }
            else
            {
                return Redirect("~");
            }
        }

        [HttpGet]
        [AllowAnonymous]
        public ActionResult Login(string returnUrl)
        {
            /*
            try
            {
                Session.RemoveAll();
                FormsAuthentication.SignOut();
            }
            catch { }
            */
            if(TempData["tempLogin"] != null || TempData["verificationCode"] != null)
                TempData.Keep();
            ViewBag.ReturnUrl = returnUrl;
            return View("Login", new LoginJson());
        }

        [HttpPost]
        [AllowAnonymous]
        public ActionResult Login(LoginJson model, string returnUrl, string submitCode)
        {
            string culture = "en-US";
            if (Session["Culture"] != null)
            {
                culture = Session["Culture"].ToString();
            }
            Session.RemoveAll();
            Session["Culture"] = culture;

            if (submitCode == "Retrimite codul")
            {
                model.Code = null;
                //string rnd = "1234"; // pt. test

                Utilizator u = (Utilizator)TempData["tempLogin"];
                Random generator = new Random();
                string rnd = generator.Next(0, 1000000).ToString("D6");
                SendVerificationCode(EmailProfiles.AwsCereriSES, u.EMAIL, rnd);
                TempData.Clear();
                TempData["tempLogin"] = u;
                TempData["verificationCode"] = rnd;
                TempData["verificationCodeIssueTime"] = DateTime.Now;
                return View("Login", new LoginJson());
            }


            if ((TempData["tempLogin"] == null || String.IsNullOrWhiteSpace(TempData["tempLogin"].ToString())) && String.IsNullOrWhiteSpace(model.Username))
            {
                ModelState.AddModelError("", socisaV2.Resources.ErrorMessagesResx.EMPTY_USERNAME);
            }
            if ((TempData["tempLogin"] == null || String.IsNullOrWhiteSpace(TempData["tempLogin"].ToString())) && String.IsNullOrWhiteSpace(model.Password))
            {
                ModelState.AddModelError("", socisaV2.Resources.ErrorMessagesResx.EMPTY_PASSWORD);
            }
            if (!ModelState.IsValid)
            {
                return View(model);
            }

            if (Session["conStr"] == null) // pt. relogin dupa expirare sesiune sau inactivitate
            {
                string conStr = Server.MapPath("~").ToLower().IndexOf("test") > 0 ? CommonFunctions.StringCipher.Decrypt(ConfigurationManager.ConnectionStrings["MySQLConnectionString_test"].ConnectionString, CommonFunctions.StringCipher.RetrieveKey()) : CommonFunctions.StringCipher.Decrypt(System.Configuration.ConfigurationManager.ConnectionStrings["MySQLConnectionString"].ConnectionString, CommonFunctions.StringCipher.RetrieveKey()); // separam socisa de socisa_test
                Session["conStr"] = conStr;
            }
            UtilizatoriRepository ur = new UtilizatoriRepository(null, Session["conStr"].ToString());

            try
            {
                FormsAuthentication.SignOut();
            }
            catch { }

            if (Convert.ToBoolean(ConfigurationManager.AppSettings["UseDoubleAutentificationForLogin"]))
            {
                if (TempData["tempLogin"] == null)
                {
                    response r = ur.Login(model.Username, model.Password);
                    if (r.Result != null)
                    {
                        TempData["tempLogin"] = (Utilizator)r.Result;
                        string _to = ((Utilizator)r.Result).EMAIL;
                        //string rnd = "1234"; // pt. test

                        Random generator = new Random();
                        string rnd = generator.Next(0, 1000000).ToString("D6");
                        SendVerificationCode(EmailProfiles.AwsCereriSES, _to, rnd);

                        TempData["verificationCode"] = rnd;
                        TempData["verificationCodeIssueTime"] = DateTime.Now;
                        return RedirectToAction("Login", "Utilizatori", new { returnUrl = returnUrl });
                    }
                    else
                    {
                        ModelState.AddModelError("", socisaV2.Resources.ErrorMessagesResx.FAILED_LOGIN);
                        return View(model);
                    }
                }
                else
                {
                    if (TempData["verificationCode"] == null || String.IsNullOrWhiteSpace(TempData["verificationCode"].ToString())) // a expirat codul! TO DO !!!
                    {
                        ModelState.AddModelError("", socisaV2.Resources.ErrorMessagesResx.VERIFICATION_CODE_EXPIRED);
                        //TempData.Clear();
                        TempData.Keep();
                        return View(model);
                        //return RedirectToAction("Login", "Utilizatori", new { returnUrl = returnUrl });
                    }
                    else
                    {
                        var passedSeconds = (DateTime.Now - (DateTime)TempData["verificationCodeIssueTime"]).TotalSeconds;
                        if (Math.Abs((int)passedSeconds) > Convert.ToInt32(ConfigurationManager.AppSettings["VerificationCodeExpiration"]))
                        {
                            ModelState.AddModelError("", socisaV2.Resources.ErrorMessagesResx.VERIFICATION_CODE_EXPIRED);
                            //TempData.Clear();
                            TempData.Keep();
                            return View(model);
                            //return RedirectToAction("Login", "Utilizatori", new { returnUrl = returnUrl });
                        }
                        else
                        {
                            if (String.IsNullOrEmpty(model.Code))
                            {
                                ModelState.AddModelError("", socisaV2.Resources.ErrorMessagesResx.EMPTY_CODE);
                                return View(model);
                            }
                            else
                            {
                                if (model.Code != TempData["verificationCode"].ToString())
                                {
                                    ModelState.AddModelError("", socisaV2.Resources.ErrorMessagesResx.VERIFICATION_CODE_DONT_MATCH);
                                    return View(model);
                                }
                                else
                                {
                                    return LoginInternal(returnUrl);
                                }
                            }
                        }
                    }
                }
            }
            else
            {
                response r = ur.Login(model.Username, model.Password);
                if (r.Result != null)
                {
                    TempData["tempLogin"] = (Utilizator)r.Result;
                    return LoginInternal(returnUrl);
                }
                else
                {
                    ModelState.AddModelError("", socisaV2.Resources.ErrorMessagesResx.FAILED_LOGIN);
                    return View(model);
                }
            }
        }

        private ActionResult LoginInternal(string returnUrl)
        {
            Utilizator u = (Utilizator)TempData["tempLogin"];
            TempData.Clear();
            u.IS_ONLINE = true;
            //Session["LAST_LOGIN"] = DateTime.Now;
            Session["LAST_LOGIN"] = u.CURRENT_LOGIN = DateTime.Now;
            //string s = "{'IS_ONLINE':true}";
            u.Update();
            Session["CURENT_USER"] = u;
            Session["CURENT_USER_ID"] = u.ID;
            FormsAuthentication.SetAuthCookie(u.USER_NAME, true);
            //NomenclatoareRepository nr = new NomenclatoareRepository(Convert.ToInt32(u.ID), conStr);
            NomenclatoareRepository nr = new NomenclatoareRepository(Convert.ToInt32(u.ID), Session["conStr"].ToString());
            Nomenclator n = (Nomenclator)nr.Find("TIP_UTILIZATORI", Convert.ToInt32(u.ID_TIP_UTILIZATOR)).Result;

            Session["CURENT_USER_TYPE"] = n;
            Session["CURENT_USER_RIGHTS"] = (Drept[])u.GetDrepturi().Result;
            Session["CURENT_USER_ACTIONS"] = (SOCISA.Models.Action[])u.GetActions().Result;
            Session["CURENT_USER_SETTINGS"] = (Setare[])u.GetSetari().Result;
            Session["CURENT_USER_SOCIETATI_ADMINISTRATE"] = (SocietateAsigurare[])u.GetSocietatiAdministrate().Result;

            if (u.ID_SOCIETATE == null && (n != null && n.DENUMIRE.ToUpper() == "ADMINISTRATOR"))
            {
                //return Redirect(returnUrl ?? Url.Action("SelectSocietate", "UtilizatoriController"));
                return RedirectToAction("SelectSocietate");
            }
            else
            {
                Session["ID_SOCIETATE"] = u.ID_SOCIETATE;
                //SocietatiAsigurareRepository sar = new SocietatiAsigurareRepository(Convert.ToInt32(u.ID), conStr);
                SocietatiAsigurareRepository sar = new SocietatiAsigurareRepository(Convert.ToInt32(u.ID), Session["conStr"].ToString());
                SocietateAsigurare sa = (SocietateAsigurare)sar.Find(Convert.ToInt32(u.ID_SOCIETATE)).Result;
                Session["SOCIETATE_ASIGURARE"] = sa;

                //return RedirectToAction("Index", "Home");
                //return Redirect(returnUrl ?? Url.Action("Index", "Home"));
                //return Redirect(returnUrl ?? Url.Action("IndexMain", "Dashboard"));
                if (returnUrl != null && returnUrl != "/")
                    return Redirect(returnUrl);
                else
                    return RedirectToAction("IndexMain", "Dashboard");
            }
        }

        //[AuthorizeUser(ActionName = "Dashboard", Recursive = false)]
        public ActionResult SelectSocietate()
        {
            string conStr = Session["conStr"].ToString(); //ConfigurationManager.ConnectionStrings["MySQLConnectionString"].ConnectionString;
            Utilizator u = (Utilizator)Session["CURENT_USER"];
            SocietatiAsigurareRepository sar = new SocietatiAsigurareRepository(Convert.ToInt32(u.ID), conStr);
            SocietateAsigurare[] sas = (SocietateAsigurare[])sar.GetAll().Result;
            return View(sas);
        }

        [AllowAnonymous]
        [HttpPost]
        public void ChangeCulture(string culture)
        {
            Session["Culture"] = culture;
            //Response.Redirect(Request.Url.ToString(), true);
            //System.Globalization.CultureInfo cultureInfo = new System.Globalization.CultureInfo(culture);
            //System.Threading.Thread.CurrentThread.CurrentCulture = cultureInfo;
            //System.Threading.Thread.CurrentThread.CurrentUICulture = cultureInfo;
        }

        //[AuthorizeUser(ActionName = "Dashboard", Recursive = false)]
        [HttpPost]
        public ActionResult SelectSocietate(FormCollection model)
        {
            string conStr = Session["conStr"].ToString(); // ConfigurationManager.ConnectionStrings["MySQLConnectionString"].ConnectionString;
            Utilizator u = (Utilizator)Session["CURENT_USER"];
            SocietatiAsigurareRepository sar = new SocietatiAsigurareRepository(Convert.ToInt32(u.ID), conStr);
            SocietateAsigurare[] sas = (SocietateAsigurare[])sar.GetAll().Result;
            if (!ModelState.IsValid)
            {
                return View(sas);
            }
            /* -- modelul cu lista --
            if(model["item.ID"] != null)
            {
                Session["ID_SOCIETATE"] = model["item.ID"];
                SocietateAsigurare sa = (SocietateAsigurare)sar.Find(Convert.ToInt32(model["item.ID"])).Result;
                Session["SOCIETATE_ASIGURARE"] = sa;
                return RedirectToAction("Index", "Home");
            }
            */
            if (model["Societate"] != null && model["Societate"] != "")
            {
                Session["ID_SOCIETATE"] = model["Societate"];
                SocietateAsigurare sa = (SocietateAsigurare)sar.Find(Convert.ToInt32(model["Societate"])).Result;
                Session["SOCIETATE_ASIGURARE"] = sa;
                //return RedirectToAction("Index", "Home");
                return RedirectToAction("IndexMain", "Dashboard");
            }
            else
            {
                ModelState.AddModelError("", "Selectati societatea!");
                return View(sas);
            }
        }

        public ActionResult Logout()
        {
            TempData.Clear();
            try
            {
                Utilizator u = (Utilizator)Session["CURENT_USER"];
                u.IS_ONLINE = false;
                u.CURRENT_LOGIN = null;
                u.LAST_LOGIN = Convert.ToDateTime(Session["LAST_LOGIN"]);
                u.Update();
            }
            catch { }
            string culture = "en-US";
            if (Session["Culture"] != null)
            {
                culture = Session["Culture"].ToString();
            }
            Session.RemoveAll();
            Session["Culture"] = culture;            /*
            Session["CURENT_USER"] = null;
            Session["CURENT_USER_ID"] = null;
            Session["ID_SOCIETATE"] = null;
            Session["SOCIETATE_ASIGURARE"] = null;
            Session["CURENT_USER_TYPE"] = null;
            Session["CURENT_USER_RIGHTS"] = null;
            Session["CURENT_USER_ACTIONS"] = null;
            Session["CURENT_USER_SETTINGS"] = null;
            Session["CURENT_USER_SOCIETATI_ADMINISTRATE"] = null;
            */
            FormsAuthentication.SignOut();
            return RedirectToAction("Index", "Home");
            //return RedirectToAction("Login", "Utilizatori");
        }
        
        public response SendVerificationCode(EmailProfile ep, string _to, string _code)
        {
            Emailing e = new Emailing(ep);
            e.Message.From = new MailAddress(ep.IncomingUser);
            //e.Message.Bcc.Add(new MailAddress(ep.IncomingUser)); // daca vrem sa se trimita mesajul si la noi

            e.Message.To.Add(_to);
            e.Message.Subject = String.Format("Cod acces www.compensaredirecta.ro: {0}", _code);
            e.Message.IsBodyHtml = true;

            //e.Message.Body = String.Format("Acesta este un mesaj generat automat.<br /><br />Puteti descarca documentele asociate dosarului facand click <a ses:notrack href=\"{2}\">aici</a>.<br /><br />Detalii suplimentare puteti gasi accesand linkul: <a ses:notrack href=\"{0}\">{1}</a>.<br /><br />Atasat va transmitem Cererea de despagubire.<br /><br /><br />Cu stima,<br />Echipa compensaredirecta.ro<br /><br />Va rugam sa nu raspundeti la acest email. Daca doriti sa ne contactati, scrieti-ne la avizari_rca@compensaredirecta.ro.", linkDosar, this.NR_DOSAR_CASCO, linkDocumentePdf);
            string templateHtmlText = System.IO.File.ReadAllText(System.IO.Path.Combine(CommonFunctions.GetSettingsFolder(), "template_email_cod_acces.html"));
            double exp = Convert.ToDouble(ConfigurationManager.AppSettings["VerificationCodeExpiration"]);
            int minute = (int)(exp / 60);
            int secunde = (int)(exp % 60);
            string expiration = (minute > 0 ? minute.ToString() + " minute" : "");
            expiration += (minute > 0 && secunde > 0 ? " si " : "");
            expiration += (secunde > 0 ? secunde.ToString() + " secunde" : "");

            templateHtmlText = templateHtmlText.Replace("{{CODE}}", _code)
                .Replace("{{EXPIRATION}}", expiration);
            e.Message.Body = templateHtmlText;
            response toReturn = e.SendVerificationCodeMessage(_code);
            return toReturn;
        }
    }
}