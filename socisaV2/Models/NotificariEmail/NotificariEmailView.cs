using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;
using Newtonsoft.Json;
using Newtonsoft.Json.Converters;
using SOCISA;
using SOCISA.Models;
using socisaV2.PortalWS;

namespace socisaWeb
{
    public class NotificariEmailView
    {
        public EmailNotificationExtended[] EmailNotifications { get; set; }

        public NotificariEmailView()
        {

        }

        public NotificariEmailView(int _CURENT_USER_ID, string conStr)
        {
            EmailNotificationsRepository enr = new EmailNotificationsRepository(_CURENT_USER_ID, conStr);
            EmailNotification[] ens = (EmailNotification[])enr.GetAll().Result;
            this.EmailNotifications = new EmailNotificationExtended[ens.Length];
            for(int i=0;i<ens.Length;i++)
            {
                this.EmailNotifications[i] = new EmailNotificationExtended(_CURENT_USER_ID, conStr, ens[i]);
            }
        }

        public NotificariEmailView(int _CURENT_USER_ID, string conStr, DateTime _data)
        {
            EmailNotificationsRepository enr = new EmailNotificationsRepository(_CURENT_USER_ID, conStr);
            string _filter = String.Format(" DATE(EMAIL_NOTIFICATIONS.TIMESTAMP) = '{0}' ", CommonFunctions.ToMySqlFormatDate(_data));
            //LogWriter.Log(_filter);
            EmailNotification[] ens = (EmailNotification[])enr.GetFiltered(null, null, _filter, null).Result;
            //LogWriter.Log(String.Format("length: {0}", ens.Length));
            this.EmailNotifications = new EmailNotificationExtended[ens.Length];
            for (int i = 0; i < ens.Length; i++)
            {
                this.EmailNotifications[i] = new EmailNotificationExtended(_CURENT_USER_ID, conStr, ens[i]);
            }
        }
    }

    public class EmailNotificationExtended
    {
        public EmailNotification EmailNotification { get; set; } 
        public string NR_DOSAR_CASCO { get; set; }

        public EmailNotificationExtended(int _CURENT_USER_ID, string conStr, EmailNotification en)
        {
            this.EmailNotification = en;
            SOCISA.Models.Dosar d = new SOCISA.Models.Dosar(_CURENT_USER_ID, conStr, Convert.ToInt32(en.ID_DOSAR));
            this.NR_DOSAR_CASCO = d.NR_DOSAR_CASCO;
        }
    }
}