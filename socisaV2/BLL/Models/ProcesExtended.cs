using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace SOCISA.Models
{
    public class ProcesExtended
    {
        public Proces Proces { get; set; }
        //public Dosar Dosar { get; set; }
        public Nomenclator TipProces { get; set; }
        public Nomenclator Instanta { get; set; }
        public Nomenclator Complet { get; set; }
        public Contract Contract { get; set; }
        public ProcesStadiuExtended StadiuCurent { get; set; }
        //public ProcesStadiuExtended[] Stadii{ get; set; }

        public object Reclamant { get; set; }
        public object Parat { get; set; }
        public object Tert { get; set; }
        public string CalitateTert { get; set; }

        public Nomenclator Calitate { get; set; }

        public bool selected { get; set; }

        public ProcesExtended() { }

        public ProcesExtended(Proces p) : this(p, false)
        {
        }

        public ProcesExtended(Proces p, bool _selected) : this(p, _selected, null)
        {
        }

        public ProcesExtended(Proces p, bool _selected, int? _ID_SOCIETATE)
        {
            this.Proces = p;
            //this.Dosar = (Dosar)p.GetDosar().Result;
            try { this.TipProces = (Nomenclator)p.GetTipProces().Result; }
            catch { this.TipProces = new Nomenclator(); }
            try { this.Instanta = (Nomenclator)p.GetInstanta().Result; }
            catch { this.Instanta = new Nomenclator(); }
            try { this.Complet = (Nomenclator)p.GetComplet().Result; }
            catch { this.Complet = new Nomenclator(); }
            try { this.Contract = (Contract)p.GetContract().Result; }
            catch { this.Contract = new Contract(); }
            try
            {
                ProcesStadiu ps = (ProcesStadiu)p.GetStadiuCurent().Result;
                this.StadiuCurent = new ProcesStadiuExtended(ps);
            }
            catch
            {
                this.StadiuCurent = new ProcesStadiuExtended(new ProcesStadiu());
            }
            /*
            try
            {
                ProcesStadiu[] pss = (ProcesStadiu[])p.GetStadii().Result;
                this.Stadii = new ProcesStadiuExtended[pss.Length];
                for (int i = 0; i < pss.Length; i++)
                {
                    this.Stadii[i] = new ProcesStadiuExtended(pss[i]);
                }
            }
            catch
            {
                this.StadiuCurent = new ProcesStadiuExtended(new ProcesStadiu());
                this.Stadii = null;
            }
            */

            this.Reclamant = this.Proces.GetReclamant(_ID_SOCIETATE).Result;
            this.Parat = this.Proces.GetParat(_ID_SOCIETATE).Result;
            this.Tert = this.Proces.GetTert(_ID_SOCIETATE).Result;
            if (_ID_SOCIETATE != null)
            {
                this.Calitate = (Nomenclator)(this.Proces.GetCalitate(Convert.ToInt32(_ID_SOCIETATE)).Result);
            }
            this.selected = _selected;
        }
    }
}
