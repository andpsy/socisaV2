using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace SOCISA.Models
{
    public class PlataExtended
    {
        public Plata Plata { get; set; }
        public Dosar Dosar { get; set; }
        public Nomenclator TipPlata { get; set; }
        public bool selected { get; set; }

        public PlataExtended() { }

        public PlataExtended(Plata p)
        {
            this.Plata = p;
            this.Dosar = (Dosar)p.GetDosar().Result;
            this.TipPlata = (Nomenclator)p.GetTipPlata().Result;
            this.selected = false;
        }

        public PlataExtended(Plata p, bool _selected)
        {
            this.Plata = p;
            this.Dosar = (Dosar)p.GetDosar().Result;
            this.TipPlata = (Nomenclator)p.GetTipPlata().Result;
            this.selected = _selected;
        }
    }
}
