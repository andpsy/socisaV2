using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Net;
using System.Net.Mail;
using System.Configuration;

namespace SOCISA.Models
{
    public class EmailProfile
    {
        public string IncomingServer { get; set; }
        public string OutgoingServer { get; set; }
        public string IncomingUser { get; set; }
        public string IncomingPassword { get; set; }
        public string OutgoingUser { get; set; }
        public string OutgoingPassword { get; set; }
        public int? IncomingPort { get; set; }
        public int? OutgoingPort { get; set; }
        public bool? IncomingUsingSSL { get; set; }
        public bool? OutgoingUsingSSL { get; set; }

        public EmailProfile(string isrv, string osrv, string iusr, string ipsw, string ousr, string opsw, int? iport, int? oport, bool? issl, bool? ossl)
        {
            IncomingServer = isrv;
            OutgoingServer = osrv;
            IncomingUser = iusr;
            OutgoingUser = ousr;
            IncomingPassword = ipsw;
            OutgoingPassword = opsw;
            IncomingPort = iport;
            OutgoingPort = oport;
            IncomingUsingSSL = issl;
            OutgoingUsingSSL = ossl;
        }
    }

    public static class EmailProfiles
    {
        public static EmailProfile AwsCereriSES
        {
            get
            {
                return new EmailProfile(null, EmailingSettings.AwsSESServer, EmailingSettings.AwsCereriUser, null, EmailingSettings.AwsSESUser, EmailingSettings.AwsSESPassword, null, EmailingSettings.AwsSESPort, EmailingSettings.AwsIncomingUseSSL, EmailingSettings.AwsOutgoingUseSSL);
            }
        }
        public static EmailProfile AwsNotificariSES
        {
            get
            {
                return new EmailProfile(null, EmailingSettings.AwsSESServer, EmailingSettings.AwsNotificariUser, null, EmailingSettings.AwsSESUser, EmailingSettings.AwsSESPassword, null, EmailingSettings.AwsSESPort, EmailingSettings.AwsIncomingUseSSL, EmailingSettings.AwsOutgoingUseSSL);
            }
        }

        public static EmailProfile Chiric
        {
            get
            {
                return new EmailProfile(EmailingSettings.ChiricServer, EmailingSettings.ChiricServer, EmailingSettings.ChiricUser, EmailingSettings.ChiricPassword, EmailingSettings.ChiricUser, EmailingSettings.ChiricPassword, null, null, null, null);
            }
        }
    }

    public static class EmailingSettings
    {
        public static string AwsSESServer
        {
            get
            {
                return CommonFunctions.StringCipher.Decrypt(ConfigurationManager.AppSettings["AwsSESServer"].ToString(), CommonFunctions.StringCipher.RetrieveKey());
            }
        }

        public static string AwsNotificariUser
        {
            get
            {
                return CommonFunctions.StringCipher.Decrypt(ConfigurationManager.AppSettings["AwsNotificariUser"].ToString(), CommonFunctions.StringCipher.RetrieveKey());
            }
        }
        public static string AwsCereriUser
        {
            get
            {
                return CommonFunctions.StringCipher.Decrypt(ConfigurationManager.AppSettings["AwsCereriUser"].ToString(), CommonFunctions.StringCipher.RetrieveKey());
            }
        }

        public static string AwsSESUser
        {
            get
            {
                return CommonFunctions.StringCipher.Decrypt(ConfigurationManager.AppSettings["AwsSESUser"].ToString(), CommonFunctions.StringCipher.RetrieveKey());
            }
        }

        public static string AwsSESPassword
        {
            get
            {
                return CommonFunctions.StringCipher.Decrypt(ConfigurationManager.AppSettings["AwsSESPassword"].ToString(), CommonFunctions.StringCipher.RetrieveKey());

            }
        }

        public static int AwsSESPort
        {
            get
            {
                return Convert.ToInt32(ConfigurationManager.AppSettings["AwsSESPort"]);
            }
        }

        public static bool AwsIncomingUseSSL
        {
            get
            {
                return Convert.ToBoolean(ConfigurationManager.AppSettings["AwsIncomingUseSSL"]);
            }
        }

        public static bool AwsOutgoingUseSSL
        {
            get
            {
                return Convert.ToBoolean(ConfigurationManager.AppSettings["AwsOutgoingUseSSL"]);
            }
        }

        public static string ChiricServer
        {
            get
            {
                return CommonFunctions.StringCipher.Decrypt(ConfigurationManager.AppSettings["ChiricServer"].ToString(), CommonFunctions.StringCipher.RetrieveKey());
            }
        }

        public static string ChiricUser
        {
            get
            {
                return CommonFunctions.StringCipher.Decrypt(ConfigurationManager.AppSettings["ChiricUser"].ToString(), CommonFunctions.StringCipher.RetrieveKey());
            }
        }

        public static string ChiricPassword
        {
            get
            {
                return CommonFunctions.StringCipher.Decrypt(ConfigurationManager.AppSettings["ChiricPassword"].ToString(), CommonFunctions.StringCipher.RetrieveKey());
            }
        }
    }

    public class Emailing {
        public EmailProfile EmailProfile { get; set; }
        public MailMessage Message { get; set; }

        public Emailing()
        {
            Message = new MailMessage();
        }

        public Emailing(EmailProfile ep)
        {
            EmailProfile = ep;
            Message = new MailMessage();
        }

        public bool CheckHost(string emailAdrress) //true = are erori - pt. angular validation
        {
            try
            {
                string hostname = emailAdrress.Split('@')[1];
                IPHostEntry IPhst = Dns.GetHostEntry(hostname);
                /*
                IPEndPoint endPt = new IPEndPoint(IPhst.AddressList[0], 25);
                Socket s = new Socket(endPt.AddressFamily, SocketType.Stream, ProtocolType.Tcp);
                s.Connect(endPt);
                */
                if (IPhst == null || IPhst.AddressList.Length == 0)
                {
                    return false;
                }
            }catch(Exception exp)
            {
                LogWriter.Log(exp);
                return false;
            }
            try
            {
                string hostname = emailAdrress.Split('@')[1];
                IPHostEntry IPhst = Dns.GetHostByName(hostname);
                if (IPhst == null || IPhst.AddressList.Length == 0)
                {
                    return false;
                }
            }
            catch (Exception exp)
            {
                LogWriter.Log(exp);
                return false;
            }
            return true;
        }

        public response SendSimpleMessage()
        {
            //Message.IsBodyHtml = true; // Altfel nu merge notificarea de Open si Click pe Amazon SES/SNS

            SmtpClient client = EmailProfile.OutgoingPort != null ? new SmtpClient(EmailProfile.OutgoingServer, Convert.ToInt32(EmailProfile.OutgoingPort)) : new SmtpClient(EmailProfile.OutgoingServer);
            client.Credentials = new NetworkCredential(EmailProfile.OutgoingUser, EmailProfile.OutgoingPassword);
            client.EnableSsl = EmailProfile.OutgoingUsingSSL != null ? Convert.ToBoolean(EmailProfile.OutgoingUsingSSL) : false;

            try
            {
                client.Send(Message);
                return new response(true, "", null, null, null);
            }
            catch (Exception ex)
            {
                LogWriter.Log(ex);
                return new response(false, ex.Message, null, null, new List<Error>() { new Error(ex) });
            }
        }

        public response SendMessageNotificare()
        {
            const String CONFIGSET = "NOTIFICARIDAUNE-SES-CONFIGURATION-SET";
            Message.Headers.Add("X-SES-CONFIGURATION-SET", CONFIGSET);
            Message.IsBodyHtml = true; // Altfel nu merge notificarea de Open si Click pe Amazon SES/SNS
            /*
            SmtpClient client = new SmtpClient(this.AwsOutgoingSESServer, this.AwsOutgoingSESPort);
            client.Credentials = new NetworkCredential(this.AwsNotificariSESUser, this.AwsNotificariSESPassword);
            client.EnableSsl = this.AwsOutgoingUseSSL;
            */

            SmtpClient client = EmailProfile.OutgoingPort != null ?  new SmtpClient(EmailProfile.OutgoingServer, Convert.ToInt32(EmailProfile.OutgoingPort)) : new SmtpClient(EmailProfile.OutgoingServer);
            client.Credentials = new NetworkCredential(EmailProfile.OutgoingUser, EmailProfile.OutgoingPassword);
            client.EnableSsl = EmailProfile.OutgoingUsingSSL != null ? Convert.ToBoolean(EmailProfile.OutgoingUsingSSL) : false;

            try
            {
                client.Send(Message);
                return new response(true, "", null, null, null);
            }
            catch (Exception ex)
            {
                LogWriter.Log(ex);
                return new response(false, ex.Message, null, null, new List<Error>() { new Error(ex) });
            }
        }

        public response SendMessageCerereDespagubire()
        {
            const String CONFIGSET = "RegresRCA";
            Message.Headers.Add("X-SES-CONFIGURATION-SET", CONFIGSET);
            Message.IsBodyHtml = true; // Altfel nu merge notificarea de Open si Click pe Amazon SES/SNS
            /*
            SmtpClient client = new SmtpClient(this.AwsOutgoingSESServer, this.AwsOutgoingSESPort);
            client.Credentials = new NetworkCredential(this.AwsNotificariSESUser, this.AwsNotificariSESPassword);
            client.EnableSsl = this.AwsOutgoingUseSSL;
            */
            SmtpClient client = EmailProfile.OutgoingPort != null ? new SmtpClient(EmailProfile.OutgoingServer, Convert.ToInt32(EmailProfile.OutgoingPort)) : new SmtpClient(EmailProfile.OutgoingServer);
            client.Credentials = new NetworkCredential(EmailProfile.OutgoingUser, EmailProfile.OutgoingPassword);
            client.EnableSsl = EmailProfile.OutgoingUsingSSL != null ? Convert.ToBoolean(EmailProfile.OutgoingUsingSSL) : false;

            try
            {
                client.Send(Message);
                return new response(true, "", null, null, null);
            }
            catch (Exception ex)
            {
                LogWriter.Log(ex);
                return new response(false, ex.Message, null, null, new List<Error>() { new Error(ex) });
            }
        }

        public response SendVerificationCodeMessage(string _code)
        {
            //const String CONFIGSET = "RegresRCA";
            //Message.Headers.Add("X-SES-CONFIGURATION-SET", CONFIGSET);
            Message.IsBodyHtml = true; // Altfel nu merge notificarea de Open si Click pe Amazon SES/SNS
            /*
            SmtpClient client = new SmtpClient(this.AwsOutgoingSESServer, this.AwsOutgoingSESPort);
            client.Credentials = new NetworkCredential(this.AwsNotificariSESUser, this.AwsNotificariSESPassword);
            client.EnableSsl = this.AwsOutgoingUseSSL;
            */
            SmtpClient client = EmailProfile.OutgoingPort != null ? new SmtpClient(EmailProfile.OutgoingServer, Convert.ToInt32(EmailProfile.OutgoingPort)) : new SmtpClient(EmailProfile.OutgoingServer);
            client.Credentials = new NetworkCredential(EmailProfile.OutgoingUser, EmailProfile.OutgoingPassword);
            client.EnableSsl = EmailProfile.OutgoingUsingSSL != null ? Convert.ToBoolean(EmailProfile.OutgoingUsingSSL) : false;

            try
            {
                client.Send(Message);
                return new response(true, "", null, null, null);
            }
            catch (Exception ex)
            {
                LogWriter.Log(ex);
                return new response(false, ex.Message, null, null, new List<Error>() { new Error(ex) });
            }
        }

    }
}