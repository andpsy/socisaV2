using System;
using System.Collections;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Reflection;
using System.Resources;
using System.Web;
using SOCISA;
using SOCISA.Models;

namespace socisaWeb
{
    public class DocumentView
    {
        public Int32 ID_DOSAR { get; set; }
        //public TipDocument[] TipuriDocumente { get; set; }
        //public DocumentScanat[] DocumenteScanate { get; set; }
        public TipDocumentJson[] TipuriDocumente { get; set; }
        public string[][] TranslatedTipDocumenteNames { get; set; }
        public DocumentScanat CurDocumentScanat { get; set; }

        public DocumentView() {}

        public DocumentView(int _CURENT_USER_ID, string conStr)
        {
            TipDocumenteRepository tdr = new TipDocumenteRepository(_CURENT_USER_ID, conStr);
            //this.TipuriDocumente = (TipDocument[])tdr.GetAll().Result;
            TipDocument[] tipuriDocumente = (TipDocument[])tdr.GetAll().Result;
            /*
            List<TipDocumentJson> l = new List<TipDocumentJson>();
            foreach(TipDocument td in tipuriDocumente)
            {
                l.Add(new TipDocumentJson(td, null));
            }
            this.TipuriDocumente = l.ToArray();
            //this.CurDocumentScanat = new DocumentScanat();
            */
            this.TipuriDocumente = new TipDocumentJson[tipuriDocumente.Length];
            for (int i = 0; i < tipuriDocumente.Length; i++)
            {
                this.TipuriDocumente[i] = new TipDocumentJson(tipuriDocumente[i], null);
            }

            ResourceSet resourceSet = socisaV2.Resources.TipDocumenteResx.ResourceManager.GetResourceSet(CultureInfo.CurrentUICulture, true, true);
            List<KeyValuePair<string, string>> t = new List<KeyValuePair<string, string>>();
            foreach (DictionaryEntry entry in resourceSet)
            {
                t.Add(new KeyValuePair<string, string>( entry.Key.ToString(), entry.Value.ToString()));
            }
            this.TranslatedTipDocumenteNames = new string[t.Count][];
            for(int i = 0; i < t.Count; i++)
            {
                this.TranslatedTipDocumenteNames[i] = new string[2];
                this.TranslatedTipDocumenteNames[i][0] = t[i].Key;
                this.TranslatedTipDocumenteNames[i][1] = t[i].Value;
            }
        }

        public DocumentView(int _CURENT_USER_ID, int _ID_DOSAR, string conStr)
        {
            this.ID_DOSAR = _ID_DOSAR;
            TipDocumenteRepository tdr = new TipDocumenteRepository(_CURENT_USER_ID, conStr);
            //this.TipuriDocumente = (TipDocument[])tdr.GetAll().Result;
            TipDocument[] tipuriDocumente = (TipDocument[])tdr.GetAll().Result;
            DosareRepository dr = new DosareRepository(_CURENT_USER_ID, conStr);
            Dosar d = (Dosar)dr.Find(_ID_DOSAR).Result;
            //this.DocumenteScanate = (DocumentScanat[])d.GetDocumente().Result;
            DocumentScanat[] dss = (DocumentScanat[])d.GetDocumente().Result;
            /*
            List<TipDocumentJson> l = new List<TipDocumentJson>();
            foreach (TipDocument td in tipuriDocumente)
            {
                List<DocumentScanat> ld = new List<DocumentScanat>();
                foreach(DocumentScanat ds in dss)
                {
                    if(ds.ID_TIP_DOCUMENT == td.ID)
                    {
                        ld.Add(ds);
                    }
                }
                l.Add(new TipDocumentJson(td, ld.ToArray()));
            }
            this.TipuriDocumente = l.ToArray();
            //this.CurDocumentScanat = new DocumentScanat();
            */

            this.TipuriDocumente = new TipDocumentJson[tipuriDocumente.Length];
            for (int i = 0; i < tipuriDocumente.Length; i++)
            {
                List<DocumentScanat> ld = new List<DocumentScanat>();
                for (int j = 0; j < dss.Length; j++)
                {
                    if (dss[j].ID_TIP_DOCUMENT == tipuriDocumente[i].ID)
                    {
                        ld.Add(dss[j]);
                    }
                }

                this.TipuriDocumente[i] = new TipDocumentJson(tipuriDocumente[i], ld.ToArray());
            }

            ResourceSet resourceSet = socisaV2.Resources.TipDocumenteResx.ResourceManager.GetResourceSet(CultureInfo.CurrentUICulture, true, true);
            List<KeyValuePair<string, string>> t = new List<KeyValuePair<string, string>>();
            foreach (DictionaryEntry entry in resourceSet)
            {
                t.Add(new KeyValuePair<string, string>(entry.Key.ToString(), entry.Value.ToString()));
            }
            this.TranslatedTipDocumenteNames = new string[t.Count][];
            for (int i = 0; i < t.Count; i++)
            {
                this.TranslatedTipDocumenteNames[i] = new string[2];
                this.TranslatedTipDocumenteNames[i][0] = t[i].Key;
                this.TranslatedTipDocumenteNames[i][1] = t[i].Value;
            }
        }
    }

    public class TipDocumentJson
    {
        public TipDocument TipDocument { get; set; }
        public DocumentScanat[] DocumenteScanate { get; set; }

        public TipDocumentJson() { }

        public TipDocumentJson(TipDocument td, DocumentScanat[] dss)
        {
            this.TipDocument = td;
            this.DocumenteScanate = dss;
        }
    }
}