using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using SOCISA;
using SOCISA.Models;

namespace socisaWeb
{
    public class ImportPlataView
    {
        public ImportPlataJson[] ImportPlatiJson { get; set; }
        public string[] ImportDates { get; set; }
        public SocietateAsigurare[] SocietatiRCA { get; set; }

        public ImportPlataView() {
            ImportPlatiJson = new List<ImportPlataJson>().ToArray();
            ImportDates = new List<string>().ToArray();
            SocietatiRCA = new List<SocietateAsigurare>().ToArray();
        }

        public ImportPlataView(int CURENT_USER_ID, string conStr)
        {
            PlatiRepository pr = new PlatiRepository(CURENT_USER_ID, conStr);
            ImportDates = ((List<string>)pr.GetImportDates().Result).ToArray();
            SocietatiAsigurareRepository sar = new SocietatiAsigurareRepository(CURENT_USER_ID, conStr);
            this.SocietatiRCA = (SocietateAsigurare[])sar.GetAll().Result;
        }
    }

    public class ImportPlataJson
    {
        public bool selected { get; set; }
        public response response { get; set; }
        public Plata Plata { get; set; }

        public ImportPlataJson() { }
    }
}