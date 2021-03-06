﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Configuration;
using SOCISA;
using SOCISA.Models;
using System.Reflection;
using Newtonsoft.Json;

namespace socisaWeb.Controllers
{
    [Authorize]
    public class MesajeController : Controller
    {
        //[AuthorizeUser(ActionName = "Mesaje", Recursive = false)]
        public ActionResult Index()
        {
            return PartialView("_MesajeView", new MesajView());
        }

        //[AuthorizeUser(ActionName = "Mesaje", Recursive = false)]
        [HttpGet]
        public ActionResult IndexMain(int? _START_LIMIT, int? _END_LIMIT)
        {
            string conStr = Session["conStr"].ToString(); //ConfigurationManager.ConnectionStrings["MySQLConnectionString"].ConnectionString;
            int uid = Convert.ToInt32(Session["CURENT_USER_ID"]);
            return PartialView("_MesajeView", new MesajView(uid, conStr, _START_LIMIT, _END_LIMIT));
        }

        //[AuthorizeUser(ActionName = "Mesaje", Recursive = false)]
        [HttpGet]
        public JsonResult GetMessages(int? id, int? _START_LIMIT, int? _END_LIMIT) // id_dosar
        {
            MesajView mv = new MesajView();
            string conStr = Session["conStr"].ToString(); //ConfigurationManager.ConnectionStrings["MySQLConnectionString"].ConnectionString;
            int uid = Convert.ToInt32(Session["CURENT_USER_ID"]);
            Mesaj mesaj = new Mesaj(uid, conStr);
            Utilizator[] us = (Utilizator[])mesaj.GetReceivers().Result;
            Utilizator s = (Utilizator)mesaj.GetSender().Result;
            Nomenclator n = (Nomenclator)mesaj.GetTipMesaj().Result;
            DateTime? da = (DateTime?)mesaj.GetMessageReadDate(uid).Result;
            Dosar d = new Dosar(uid, conStr, Convert.ToInt32(id));
            mv.MesajJson = new MesajJson(mesaj, d, s, us, n, da);
            mv.InvolvedParties = (Utilizator[])d.GetInvolvedParties().Result;
            mv.TipuriMesaj = (Nomenclator[])(new NomenclatoareRepository(uid, conStr).GetAll("tip_mesaje").Result);
            List<MesajJson> ls = new List<MesajJson>();
            Mesaj[] ms = null;

            if (id != null)
            {
                d = new Dosar(uid, conStr, Convert.ToInt32(id));
                ms = (Mesaj[])d.GetMesaje().Result;
            }
            else
            {
                Utilizator u = (Utilizator)Session["CURENT_USER"];
                ms = (Mesaj[])u.GetMesaje(_START_LIMIT, _END_LIMIT).Result;
            }
            /*
            foreach(Mesaj m in ms)
            {
                //ls.Add(new MesajJson(m, (Dosar)m.GetDosar().Result, (Utilizator)m.GetSender().Result, (Utilizator[])m.GetReceivers().Result, (Nomenclator)m.GetTipMesaj().Result, (DateTime?)m.GetMessageReadDate(uid).Result));
                MesajJson mj = new MesajJson(m);
                mj.DataCitire = (DateTime?)m.GetMessageReadDate(uid).Result;
                ls.Add(mj);            
            }
            mv.MesajeJson = ls.ToArray();
            */
            mv.MesajeJson = new MesajJson[ms.Length];
            for(int i = 0; i < ms.Length; i++)
            {
                mv.MesajeJson[i] = new MesajJson(ms[i]);
                mv.MesajeJson[i].DataCitire = (DateTime?)ms[i].GetMessageReadDate(uid).Result;
            }

            //return PartialView("_MesajeView", mv);
            return Json(mv, JsonRequestBehavior.AllowGet);
        }

        //[AuthorizeUser(ActionName = "Mesaje", Recursive = false)]
        [HttpGet]
        public JsonResult GetInvolvedParties(int? id) // id_dosar
        {
            string conStr = Session["conStr"].ToString(); //ConfigurationManager.ConnectionStrings["MySQLConnectionString"].ConnectionString;
            int uid = Convert.ToInt32(Session["CURENT_USER_ID"]);
            Dosar d = new Dosar(uid, conStr, Convert.ToInt32(id));
            response r = d.GetInvolvedParties();
            return Json(r, JsonRequestBehavior.AllowGet);
        }

        //[AuthorizeUser(ActionName = "Mesaje", Recursive = false)]
        [HttpGet]
        public JsonResult GetSentMessages(int? id, int? _START_LIMIT, int? _END_LIMIT) // id_dosar
        {
            MesajView mv = new MesajView();
            string conStr = Session["conStr"].ToString(); //ConfigurationManager.ConnectionStrings["MySQLConnectionString"].ConnectionString;
            int uid = Convert.ToInt32(Session["CURENT_USER_ID"]);

            Dosar d = new Dosar(uid, conStr, Convert.ToInt32(id));
            Mesaj mesaj = new Mesaj(uid, conStr);
            Utilizator[] us = (Utilizator[])mesaj.GetReceivers().Result;
            Utilizator s = (Utilizator)mesaj.GetSender().Result;
            Nomenclator n = (Nomenclator)mesaj.GetTipMesaj().Result;
            DateTime? da = (DateTime?)mesaj.GetMessageReadDate(uid).Result;

            mv.MesajJson = new MesajJson(mesaj, d, s, us, n, da);
            mv.InvolvedParties = (Utilizator[])d.GetInvolvedParties().Result;
            mv.TipuriMesaj = (Nomenclator[])(new NomenclatoareRepository(uid, conStr).GetAll("tip_mesaje").Result);

            Mesaj[] ms = null;
            List<MesajJson> ls = new List<MesajJson>();
            if (id != null)
            {
                d = new Dosar(uid, conStr, Convert.ToInt32(id));
                ms = (Mesaj[])d.GetSentMesaje().Result;
            }
            else
            {
                Utilizator u = (Utilizator)Session["CURENT_USER"];
                ms = (Mesaj[])u.GetSentMesaje(_START_LIMIT, _END_LIMIT).Result;
            }

            foreach (Mesaj m in ms)
            {
                //ls.Add(new MesajJson(m, (Dosar)m.GetDosar().Result, (Utilizator)m.GetSender().Result, (Utilizator[])m.GetReceivers().Result, (Nomenclator)m.GetTipMesaj().Result, (DateTime?)m.GetMessageReadDate(uid).Result));
                MesajJson mj = new MesajJson(m);
                mj.DataCitire = (DateTime?)m.GetMessageReadDate(uid).Result;
                ls.Add(mj);
            }

            mv.MesajeJson = ls.ToArray();

            //return PartialView("_MesajeView", mv);
            return Json(mv, JsonRequestBehavior.AllowGet);
        }

        //[AuthorizeUser(ActionName = "Messaje", Recursive = false)]
        [HttpPost]
        public JsonResult GetNewMessages(string j, int? _START_LIMIT, int? _END_LIMIT)
        {
            dynamic x = JsonConvert.DeserializeObject(j);
            string conStr = Session["conStr"].ToString(); //ConfigurationManager.ConnectionStrings["MySQLConnectionString"].ConnectionString;
            int uid = Convert.ToInt32(Session["CURENT_USER_ID"]);
            if(x.id_dosar != null)
            {
                DosareRepository dr = new DosareRepository(uid, conStr);
                Dosar d = (Dosar)dr.Find(Convert.ToInt32(x.id_dosar)).Result;
                //return Json(d.GetNewMesaje(Convert.ToDateTime(x.last_refresh)), JsonRequestBehavior.AllowGet);
                return Json(d.GetNewMesaje(DateTime.ParseExact(Convert.ToString(x.last_refresh), CommonFunctions.DATE_TIME_FORMAT, System.Globalization.CultureInfo.InvariantCulture)), JsonRequestBehavior.AllowGet);
            }
            else
            {
                Utilizator u = (Utilizator)Session["CURENT_USER"];
                return Json(u.GetNewMesaje(DateTime.ParseExact(Convert.ToString(x.last_refresh), CommonFunctions.DATE_TIME_FORMAT, System.Globalization.CultureInfo.InvariantCulture), _START_LIMIT, _END_LIMIT), JsonRequestBehavior.AllowGet);
            }
        }

        //[AuthorizeUser(ActionName = "Mesaje", Recursive = false)]
        [HttpPost]
        public JsonResult Send(MesajJson MesajJson)
        {
            string conStr = Session["conStr"].ToString(); //ConfigurationManager.ConnectionStrings["MySQLConnectionString"].ConnectionString;
            response r = new response();
            Mesaj m = new Mesaj(Convert.ToInt32(Session["CURENT_USER_ID"]), conStr);
            PropertyInfo[] pis = m.GetType().GetProperties();
            foreach(PropertyInfo pi in pis)
            {
                pi.SetValue(m, pi.GetValue(MesajJson.Mesaj));
            }
            m.DATA = DateTime.Now;
            m.ID_SENDER = Convert.ToInt32(Session["CURENT_USER_ID"]);
            r = m.Insert();
            if (r.Status && r.InsertedId != null)
            {
                foreach (Utilizator u in MesajJson.Receivers)
                {
                    MesajUtilizator mu = new MesajUtilizator(Convert.ToInt32(Session["CURENT_USER_ID"]), conStr);
                    mu.ID_MESAJ = Convert.ToInt32(r.InsertedId);
                    mu.ID_UTILIZATOR = Convert.ToInt32(u.ID);
                    mu.Insert();
                }
            }
            return Json(r, JsonRequestBehavior.AllowGet);
        }

        //[AuthorizeUser(ActionName = "Mesaje", Recursive = false)]
        [HttpPost]
        public JsonResult SetDataCitire(MesajJson MesajJson)
        {
            string conStr = Session["conStr"].ToString(); //ConfigurationManager.ConnectionStrings["MySQLConnectionString"].ConnectionString;
            response r = new response();
            Mesaj m = new Mesaj(Convert.ToInt32(Session["CURENT_USER_ID"]), conStr);
            PropertyInfo[] pis = m.GetType().GetProperties();
            foreach (PropertyInfo pi in pis)
            {
                pi.SetValue(m, pi.GetValue(MesajJson.Mesaj));
            }
            r = m.SetMessageReadDate(Convert.ToInt32(Session["CURENT_USER_ID"]), (DateTime)MesajJson.DataCitire);
            return Json(r, JsonRequestBehavior.AllowGet);
        }
    }
}