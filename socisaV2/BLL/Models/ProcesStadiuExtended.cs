using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace SOCISA.Models
{
    public class ProcesStadiuExtended
    {
        public ProcesStadiu ProcesStadiu { get; set; }
        public Stadiu Stadiu { get; set; }
        public Sentinta Sentinta { get; set; }
        public DocumentScanatProces[] Documente { get; set; }
        public bool selected { get; set; }

        public ProcesStadiuExtended() { }

        public ProcesStadiuExtended(ProcesStadiu ps) : this(ps, false)
        {
        }

        public ProcesStadiuExtended(ProcesStadiu ps, bool _selected)
        {
            this.ProcesStadiu = ps;
            try { this.Stadiu = (Stadiu)ps.GetStadiu().Result; }
            catch { this.Stadiu = new Stadiu(); }
            try { this.Sentinta = (Sentinta)ps.GetSentinta().Result; }
            catch { this.Sentinta = new Sentinta(); }
            try { this.Documente = (DocumentScanatProces[])ps.GetDocumente().Result; }
            catch { this.Documente = null; }
            this.selected = _selected;
        }
    }
}
