using Newtonsoft.Json;
using SOCISA.Models;

namespace socisaWeb
{
    public class DocumentScanatProcesExtended
    {
        public DocumentScanatProces DocumentScanatProces { get; set; }
        [JsonProperty(NullValueHandling = NullValueHandling.Include)]
        public string DENUMIRE_STADIU { get; set; }

        public DocumentScanatProcesExtended()
        {

        }

        public DocumentScanatProcesExtended(DocumentScanatProces dsp)
        {
            this.DocumentScanatProces = dsp;            
            this.DENUMIRE_STADIU = dsp.GetDenumireProcesStdiu();
        }
    }
    public class DocumentScanatProcesView
    {
        public string[] TipDocumenteScanateProcese { get; set; }
        public DocumentScanatProcesExtended[] Documente { get; set; }
        public DocumentScanatProcesExtended CurDocumentScanatProces { get; set; }

        public DocumentScanatProcesView() {}

        public DocumentScanatProcesView(int _CURENT_USER_ID, string conStr)
        {
            ProceseRepository pr = new ProceseRepository(_CURENT_USER_ID, conStr);
            this.TipDocumenteScanateProcese = (string[])pr.GetTipDocumenteScanatePocese().Result;
            this.CurDocumentScanatProces = new DocumentScanatProcesExtended(new DocumentScanatProces(_CURENT_USER_ID, conStr));
        }

        public DocumentScanatProcesView(int _CURENT_USER_ID, string conStr, int _ID_PROCES)
        {
            ProceseRepository pr = new ProceseRepository(_CURENT_USER_ID, conStr);
            this.TipDocumenteScanateProcese = (string[])pr.GetTipDocumenteScanatePocese().Result;
            Proces p = new Proces(_CURENT_USER_ID, conStr, _ID_PROCES);
            DocumentScanatProces[] dsps = (DocumentScanatProces[])p.GetDocumente().Result;
            this.Documente = new DocumentScanatProcesExtended[dsps.Length];
            for(int i = 0; i < dsps.Length; i++)
            {
                this.Documente[i] = new DocumentScanatProcesExtended(dsps[i]);
            }
            this.CurDocumentScanatProces = new DocumentScanatProcesExtended(new DocumentScanatProces(_CURENT_USER_ID, conStr));
        }
    }
}