﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using SOCISA;
using SOCISA.Models;
using System.Reflection;

namespace socisaWeb
{
    public class UtilizatorView
    {
        public UtilizatorJson UtilizatorJson { get; set; }
        public SocietateAsigurareExtended[] SocietatiAsigurare { get; set; }
        public DreptExtended[] Drepturi { get; set; }
        public ActionExtended[] Actions { get; set; }
        public Nomenclator[] TipuriUtilizator { get; set; }
        public SocietateAsigurareExtended[] SocietatiAsigurareAdministrate { get; set; }

        public UtilizatorView() { }

        public UtilizatorView(int CURENT_USER_ID, string conStr)
        {
            SocietatiAsigurareRepository sar = new SocietatiAsigurareRepository(CURENT_USER_ID, conStr);
            SocietatiAsigurare = GetFromBase((SocietateAsigurare[])sar.GetCombo().Result);
            SocietatiAsigurareAdministrate = GetFromBase((SocietateAsigurare[])sar.GetAllAdministrate().Result);

            DrepturiRepository dr = new DrepturiRepository(CURENT_USER_ID, conStr);
            Drepturi = GetFromBase((Drept[])dr.GetAll().Result);

            ActionsRepository ar = new ActionsRepository(CURENT_USER_ID, conStr);
            Actions = GetFromBase((SOCISA.Models.Action[])ar.GetAll().Result);

            NomenclatoareRepository nr = new NomenclatoareRepository(CURENT_USER_ID, conStr);
            TipuriUtilizator = (Nomenclator[])nr.GetAll("tip_utilizatori").Result;

            //HttpContext.Current.Session["l"] = new Dictionary<int, Utilizator>();
            UtilizatorJson = new UtilizatorJson(CURENT_USER_ID, conStr, CURENT_USER_ID);

            UtilizatorJson.UtilizatoriSubordonati = UtilizatorJson.GetUtilizatoriSubordonati(CURENT_USER_ID, conStr);
        }

        SocietateAsigurareExtended[] GetFromBase(SocietateAsigurare[] baze)
        {
            List<SocietateAsigurareExtended> toReturn = new List<SocietateAsigurareExtended>();
            foreach(SocietateAsigurare baza in baze)
            {
                toReturn.Add(new SocietateAsigurareExtended(baza));
            }
            return toReturn.ToArray();
        }

        DreptExtended[] GetFromBase(Drept[] baze)
        {
            List<DreptExtended> toReturn = new List<DreptExtended>();
            foreach (Drept baza in baze)
            {
                toReturn.Add(new DreptExtended(baza));
            }
            return toReturn.ToArray();
        }

        ActionExtended[] GetFromBase(SOCISA.Models.Action[] baze)
        {
            List<ActionExtended> toReturn = new List<ActionExtended>();
            foreach (SOCISA.Models.Action baza in baze)
            {
                toReturn.Add(new ActionExtended(baza));
            }
            return toReturn.ToArray();
        }
    }

    public class SocietateAsigurareExtended : SocietateAsigurare
    {
        public bool selected;

        public SocietateAsigurareExtended() { }

        public SocietateAsigurareExtended(SocietateAsigurare baza)
        {
            PropertyInfo[] pis = baza.GetType().GetProperties();
            foreach (PropertyInfo pi in pis)
            {
                pi.SetValue(this, pi.GetValue(baza));
            }
        }
    }

    public class DreptExtended : Drept
    {
        public bool selected;

        public DreptExtended() { }

        public DreptExtended(Drept baza)
        {
            PropertyInfo[] pis = baza.GetType().GetProperties();
            foreach (PropertyInfo pi in pis)
            {
                pi.SetValue(this, pi.GetValue(baza));
            }
        }
    }

    public class ActionExtended : SOCISA.Models.Action
    {
        public bool selected;

        public ActionExtended() { }

        public ActionExtended(SOCISA.Models.Action baza)
        {
            PropertyInfo[] pis = baza.GetType().GetProperties();
            foreach (PropertyInfo pi in pis)
            {
                pi.SetValue(this, pi.GetValue(baza));
            }
        }
    }

    public class UtilizatorJson
    {
        public Utilizator Utilizator { get; set; }
        public UtilizatorJson[] UtilizatoriSubordonati { get; set; }
        //public UtilizatorExtended[] UtilizatoriSubordonati { get; set; }
        public SocietateAsigurare SocietateAsigurare { get; set; }
        public Drept[] Drepturi { get; set; }
        public SOCISA.Models.Action[] Actions { get; set; }
        public Nomenclator TipUtilizator { get; set; }
        public SocietateAsigurare[] SocietatiAsigurareAdministrate { get; set; }
        

        public UtilizatorJson() { }

        public UtilizatorJson (int CURENT_USER_ID, string conStr, int ID_UTILIZATOR)
        {
            Utilizator = new Utilizator(CURENT_USER_ID, conStr, ID_UTILIZATOR);
            SocietateAsigurare = (SocietateAsigurare)Utilizator.GetSocietatiAsigurare().Result;
            SocietatiAsigurareAdministrate = (SocietateAsigurare[])Utilizator.GetSocietatiAdministrate().Result;
            Drepturi = (Drept[])Utilizator.GetDrepturi().Result;
            Actions = (SOCISA.Models.Action[])Utilizator.GetActions().Result;
            TipUtilizator = (Nomenclator)Utilizator.GetTipUtilizator().Result;

            UtilizatoriSubordonati = new List<UtilizatorJson>().ToArray();
            //UtilizatoriSubordonati = GetUtilizatoriSubordonati(CURENT_USER_ID, conStr, Convert.ToInt32(Utilizator.ID)).Values.ToArray();
        }

        public UtilizatorJson[] GetUtilizatoriSubordonati(int CURENT_USER_ID, string conStr)
        {
            Dictionary<int, UtilizatorJson> l = new Dictionary<int, UtilizatorJson>();
            Utilizator[] us = (Utilizator[])Utilizator.GetUtilizatoriSubordonati().Result;
            foreach (Utilizator ue in us)
            {
                l.Add(Convert.ToInt32(ue.ID), new UtilizatorJson(CURENT_USER_ID, conStr, Convert.ToInt32(ue.ID)));
            }
            return l.Values.ToArray();
        }
    }
}