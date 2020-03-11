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

        public NotificariEmailView(int _CURENT_USER_ID, string conStr, object _filterParams)
        {
            string _filter = "";
            if(_filterParams is DateTime)
                _filter = String.Format(" DATE(EMAIL_NOTIFICATIONS.TIMESTAMP) = '{0}' ", CommonFunctions.ToMySqlFormatDate(Convert.ToDateTime(_filterParams)));
            if (_filterParams is int)
                _filter = String.Format(" EMAIL_NOTIFICATIONS.ID_DOSAR = {0} ", Convert.ToInt32(_filterParams));
            if (_filterParams is FilterNotificari)
            {
                FilterNotificari fn = (FilterNotificari)_filterParams;
                _filter = String.Format(" DATE(EMAIL_NOTIFICATIONS.TIMESTAMP) >= '{0}' ", CommonFunctions.ToMySqlFormatDate(Convert.ToDateTime(fn.TimeStampStartFilter)));
                _filter = String.Format("{0} AND DATE(EMAIL_NOTIFICATIONS.TIMESTAMP) <= '{1}' ", _filter, CommonFunctions.ToMySqlFormatDate(Convert.ToDateTime(fn.TimeStampEndFilter)));
                if(!String.IsNullOrWhiteSpace(fn.NrDosarCascoFilter))
                    _filter = String.Format("{0} AND DOSARE.NR_DOSAR_CASCO LIKE '%{1}%' ", _filter, fn.NrDosarCascoFilter);
            }

            EmailNotificationsRepository enr = new EmailNotificationsRepository(_CURENT_USER_ID, conStr);
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
        [JsonProperty(NullValueHandling = NullValueHandling.Include)]
        [Display(Name = "NR_DOSAR_CASCO", ResourceType = typeof(socisaV2.Resources.NotificariEmailResx))]
        public string NR_DOSAR_CASCO { get; set; }

        [JsonConstructor]
        public EmailNotificationExtended(EmailNotification EmailNotification, string NR_DOSAR_CASCO)
        {
            this.EmailNotification = EmailNotification;
            this.NR_DOSAR_CASCO = NR_DOSAR_CASCO;
        }


        public EmailNotificationExtended(int _CURENT_USER_ID, string conStr, EmailNotification en)
        {
            this.EmailNotification = en;
            SOCISA.Models.Dosar d = new SOCISA.Models.Dosar(_CURENT_USER_ID, conStr, Convert.ToInt32(en.ID_DOSAR));
            this.NR_DOSAR_CASCO = d.NR_DOSAR_CASCO;
        }
    }
}