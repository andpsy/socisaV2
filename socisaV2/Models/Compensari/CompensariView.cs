using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using SOCISA;
using SOCISA.Models;

namespace socisaWeb
{
    public class CompensariView
    {
        public string[] DateCompensari { get; set; }

        public CompensariView() {
            DateCompensari = new List<string>().ToArray();
        }

        public CompensariView(int CURENT_USER_ID, string conStr)
        {
            CompensariRepository cr = new CompensariRepository(CURENT_USER_ID, conStr);
            DateCompensari = ((List<string>)cr.GetDateCompensari().Result).ToArray();
        }
    }
}