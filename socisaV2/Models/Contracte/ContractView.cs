using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using SOCISA;
using SOCISA.Models;

namespace socisaWeb
{
    public class ContractView
    {
        public Contract CurContract { get; set; }
        public Contract[] Contracte { get; set; }

        public ContractView() { }

        public ContractView(int _CURENT_USER_ID, string conStr)
        {
            ContracteRepository cr = new ContracteRepository(_CURENT_USER_ID, conStr);
            this.Contracte = (Contract[])cr.GetAll().Result;
        }

        public ContractView(int _CURENT_USER_ID, int _ID_PROCES, string conStr)
        {
            Proces p = new Proces(_CURENT_USER_ID, conStr, _ID_PROCES);
            this.CurContract = (Contract)p.GetContract().Result;
            ContracteRepository cr = new ContracteRepository(_CURENT_USER_ID, conStr);
            this.Contracte = (Contract[])cr.GetAll().Result;
        }
    }
}