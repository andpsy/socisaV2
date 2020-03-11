using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
//using System.Web.Mvc;
using SOCISA;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System.Dynamic;

using System.Net;
using System.Net.Http;
//using System.Reflection;
using System.Web.Http;
//using System.Web.Http.Description;
using SOCISA.Models;

namespace socisaWeb
{
    public class AWSController : ApiController
    {
        [HttpPost]
        public HttpResponseMessage Post(string id = "")
        {
            try
            {
                var jsonData = Request.Content.ReadAsStringAsync().Result;
                
                var sm = Amazon.SimpleNotificationService.Util.Message.ParseMessage(jsonData); // ESCAPE FOR TESTING WITH POSTMAN

                if (sm.IsSubscriptionType)
                {
                    sm.SubscribeToTopic(); // CONFIRM THE SUBSCRIPTION
                }
                if (sm.IsNotificationType) // PROCESS NOTIFICATIONS               
                {
                    try
                    {
                        LogWriter.Log(String.Format("MessageId: {0}\r\nMessageText: {1}\r\nSubject: {2}\r\nTimeStamp: {3}\r\nToken: {4}\r\nTopicArn: {5}\r\nType: {6}", sm.MessageId, sm.MessageText, sm.Subject, sm.Timestamp, sm.Token, sm.TopicArn, sm.Type), "AWSloging.txt");
                        JObject json = JObject.Parse(sm.MessageText);
                        //JObject json = JObject.Parse(jsonData.ToString()); // FOR TESTING WITH POSTMAN
                        if (json["eventType"] == null)
                            return Request.CreateResponse(HttpStatusCode.OK, new { }); // ne intereseaza doar notificarile cu eventType

                        ////JToken eventType = json["eventType"];
                        string eventType = json.GetValue("eventType").Value<string>();

                        JToken mail = json["mail"];
                        string initialEmailId = mail.Value<string>("messageId");
                        string conStr = CommonFunctions.StringCipher.Decrypt(System.Configuration.ConfigurationManager.ConnectionStrings["MySQLConnectionString"].ConnectionString, CommonFunctions.StringCipher.RetrieveKey());


                        if (initialEmailId != null) {
                            int? ID_DOSAR = null;
                            JArray headers = (JArray)mail["headers"];
                            for(int i = 0; i < headers.Count; i++)
                            {
                                JToken header = (JToken)headers[i];
                                if(header.Value<string>("name") == "ID_DOSAR")
                                {
                                    ID_DOSAR = Convert.ToInt32(header.Value<string>("value"));
                                    break;
                                }
                            }

                            #region -- BEFORE 10.01.2020 --
                            /*
                            EmailNotification en = new EmailNotification(1, conStr, initialEmailId);
                            if(en == null || en.ID == null)
                            {
                                en = new EmailNotification(1, conStr);
                                en.MESSAGE_ID = initialEmailId;
                                en.MESSAGE_TEXT = sm.MessageText;
                                //en.MESSAGE_TEXT = jsonData.ToString(); // FOR TESTING WITH POSTMAN
                                en.ID_DOSAR = ID_DOSAR;
                                response r = en.Insert();
                                en.ID = r.InsertedId;
                            }
                            switch (eventType)
                            {
                                case "Send":
                                    en.SEND = true;
                                    en.SEND_TIMESTAMP = mail.Value<DateTime>("timestamp");
                                    break;
                                case "Delivery":
                                    JToken delivery = json["delivery"];
                                    en.DELIVERY = true;
                                    en.DELIVERY_TIMESTAMP = delivery.Value<DateTime>("timestamp");
                                    try
                                    {
                                        en.DELIVERY_MESSAGE_TEXT = delivery.ToString();
                                    }
                                    catch(Exception exp) { LogWriter.Log(exp); }
                                    //TO DO: de adaugat salvarea in pdf
                                    //string txt_file_name = System.IO.Path.Combine(CommonFunctions.GetPdfsFolder(), "AwsEmailConfirmation.txt");
                                    //System.IO.File.WriteAllText(txt_file_name, JsonConvert.SerializeObject(json, Formatting.Indented));
                                    response r = PdfGenerator.GeneratePdfDocumentFromText(JsonConvert.SerializeObject(json, Formatting.Indented));
                                    if (r.Status)
                                    {
                                        TipDocument td = null;
                                        if (sm.TopicArn.IndexOf("NotificariDaune") > -1)
                                        {
                                            td = new TipDocument(1, conStr, "AVIZARE DE DAUNE POLITA PAGUBIT");
                                        }
                                        if (sm.TopicArn.IndexOf("RegresRCA") > -1)
                                        {
                                            td = new TipDocument(1, conStr, "CONFIRMARE CERERE DESPAGUBIRE");
                                        }
                                        DocumentScanat ds = new DocumentScanat(1, conStr);
                                        ds.CALE_FISIER = r.Result.ToString();
                                        ds.DENUMIRE_FISIER = ds.CALE_FISIER.Substring(ds.CALE_FISIER.LastIndexOf("\\") + 1);
                                        ds.ID_DOSAR = Convert.ToInt32(ID_DOSAR);
                                        ds.ID_TIP_DOCUMENT = Convert.ToInt32(td.ID);
                                        //r = ds.Insert(CommonFunctions.GetThumbNailSizes());
                                        r = ds.Insert();
                                    }                                    
                                    break;
                                case "Reject":
                                    JToken reject = json["reject"];
                                    en.REJECT = true;
                                    en.REJECT_TIMESTAMP = reject.Value<DateTime>("timestamp");
                                    try
                                    {
                                        en.REJECT_MESSAGE_TEXT = reject.ToString();
                                    }
                                    catch (Exception exp) { LogWriter.Log(exp); }
                                    break;
                                case "Bounce":
                                    JToken bounce = json["bounce"];
                                    en.BOUNCE = true;
                                    en.BOUNCE_TIMESTAMP = bounce.Value<DateTime>("timestamp");
                                    try
                                    {
                                        en.BOUNCE_MESSAGE_TEXT = bounce.ToString();
                                    }
                                    catch (Exception exp) { LogWriter.Log(exp); }
                                    break;
                                case "Complaint":
                                    JToken complaint = json["complaint"];
                                    en.COMPLAINT = true;
                                    en.COMPLAINT_TIMESTAMP = complaint.Value<DateTime>("timestamp");
                                    try
                                    {
                                        en.COMPLAINT_MESSAGE_TEXT = complaint.ToString();
                                    }
                                    catch (Exception exp) { LogWriter.Log(exp); }
                                    break;
                                case "Open":
                                    JToken open = json["open"];
                                    en.OPEN = true;
                                    en.OPEN_TIMESTAMP = open.Value<DateTime>("timestamp");
                                    try
                                    {
                                        en.OPEN_MESSAGE_TEXT = open.ToString();
                                    }
                                    catch (Exception exp) { LogWriter.Log(exp); }
                                    break;
                                case "Click":
                                    JToken click = json["click"];
                                    en.CLICK = true;
                                    en.CLICK_TIMESTAMP = click.Value<DateTime>("timestamp");
                                    try
                                    {
                                        en.CLICK_MESSAGE_TEXT = click.ToString();
                                    }
                                    catch (Exception exp) { LogWriter.Log(exp); }
                                    break;
                            }
                            en.Update();
                            */
                            #endregion
                            EmailNotification en = new EmailNotification(1, conStr);
                            en.MESSAGE_ID = initialEmailId;
                            en.ID_DOSAR = ID_DOSAR;
                            en.EVENT_TYPE = eventType;
                            en.TIME_CHECKED = null;
                            switch (eventType)
                            {
                                case "Send":
                                    //en.MESSAGE_TEXT = sm.MessageText;
                                    en.MESSAGE_TEXT = mail.ToString();
                                    en.TIMESTAMP = mail.Value<DateTime>("timestamp");
                                    break;
                                case "Delivery":
                                    JToken delivery = json["delivery"];
                                    en.TIMESTAMP = delivery.Value<DateTime>("timestamp");
                                    en.MESSAGE_TEXT = delivery.ToString();
                                    try
                                    {
                                        List<AmazonSesDeliveryRecipient> tmp = delivery.Value<List<AmazonSesDeliveryRecipient>>("recipients");
                                        en.RECIPIENTS = "";
                                        foreach(AmazonSesDeliveryRecipient asdr in tmp)
                                        {
                                            en.RECIPIENTS = String.Format("{0},{1}", en.RECIPIENTS, asdr.EmailAddress);
                                        }
                                        en.RECIPIENTS.Remove(en.RECIPIENTS.Length - 1);
                                    }catch(Exception exp) { LogWriter.Log(exp); }
                                    response r = PdfGenerator.GeneratePdfDocumentFromText(JsonConvert.SerializeObject(json, Formatting.Indented));
                                    if (r.Status)
                                    {
                                        TipDocument td = null;
                                        if (sm.TopicArn.IndexOf("NotificariDaune") > -1)
                                        {
                                            td = new TipDocument(1, conStr, "AVIZARE DE DAUNE POLITA PAGUBIT");
                                        }
                                        if (sm.TopicArn.IndexOf("RegresRCA") > -1)
                                        {
                                            td = new TipDocument(1, conStr, "CONFIRMARE CERERE DESPAGUBIRE");
                                        }
                                        DocumentScanat ds = new DocumentScanat(1, conStr);
                                        ds.CALE_FISIER = r.Result.ToString();
                                        ds.DENUMIRE_FISIER = ds.CALE_FISIER.Substring(ds.CALE_FISIER.LastIndexOf("\\") + 1);
                                        ds.ID_DOSAR = Convert.ToInt32(ID_DOSAR);
                                        ds.ID_TIP_DOCUMENT = Convert.ToInt32(td.ID);
                                        //r = ds.Insert(CommonFunctions.GetThumbNailSizes());
                                        r = ds.Insert();
                                    }
                                    break;
                                case "Reject":
                                    JToken reject = json["reject"];
                                    //en.TIMESTAMP = reject.Value<DateTime>("timestamp"); // nu are timestamp acest event
                                    en.TIMESTAMP = DateTime.Now;
                                    en.MESSAGE_TEXT = reject.ToString();
                                    try
                                    {
                                        Dosar d = new Dosar(1, conStr, Convert.ToInt32(ID_DOSAR));
                                        EmailProfile ep = EmailProfiles.AwsNotificariSES;
                                        Emailing e = new Emailing(ep);
                                        e.Message.From = new System.Net.Mail.MailAddress(ep.IncomingUser);
                                        e.Message.To.Add("chiric.chiric@gmail.com");
                                        e.Message.Bcc.Add("andpsy@gmail.com");
                                        e.Message.Subject = String.Format("\"Reject\" event from AWS SES email (Nr. dosar CASCO: {0})", d.NR_DOSAR_CASCO);
                                        e.Message.Body = reject.ToString();
                                        e.SendSimpleMessage();
                                    }catch(Exception exp) { LogWriter.Log(exp); }
                                    break;
                                case "Bounce":
                                    JToken bounce = json["bounce"];
                                    en.TIMESTAMP = bounce.Value<DateTime>("timestamp");
                                    en.MESSAGE_TEXT = bounce.ToString();
                                    try
                                    {
                                        List<AmazonSesBouncedRecipient> tmp = bounce.Value<List<AmazonSesBouncedRecipient>>("BouncedRecipients");
                                        en.RECIPIENTS = "";
                                        foreach (AmazonSesBouncedRecipient asdr in tmp)
                                        {
                                            en.RECIPIENTS = String.Format("{0},{1}", en.RECIPIENTS, asdr.EmailAddress);
                                        }
                                        en.RECIPIENTS.Remove(en.RECIPIENTS.Length - 1);
                                    }
                                    catch (Exception exp) { LogWriter.Log(exp); }
                                    try
                                    {
                                        Dosar d = new Dosar(1, conStr, Convert.ToInt32(ID_DOSAR));
                                        EmailProfile ep = EmailProfiles.AwsNotificariSES;
                                        Emailing e = new Emailing(ep);
                                        e.Message.From = new System.Net.Mail.MailAddress(ep.IncomingUser);
                                        e.Message.To.Add("chiric.chiric@gmail.com");
                                        e.Message.Bcc.Add("andpsy@gmail.com");
                                        e.Message.Subject = String.Format("\"Bounce\" event from AWS SES email (Nr. dosar CASCO: {0})", d.NR_DOSAR_CASCO);
                                        e.Message.Body = bounce.ToString();
                                        e.SendSimpleMessage();
                                    }
                                    catch (Exception exp) { LogWriter.Log(exp); }
                                    break;
                                case "Complaint":
                                    JToken complaint = json["complaint"];
                                    en.TIMESTAMP = complaint.Value<DateTime>("timestamp");
                                    en.MESSAGE_TEXT = complaint.ToString();
                                    try
                                    {
                                        List<AmazonSesComplainedRecipient> tmp = complaint.Value<List<AmazonSesComplainedRecipient>>("ComplainedRecipients ");
                                        en.RECIPIENTS = "";
                                        foreach (AmazonSesComplainedRecipient asdr in tmp)
                                        {
                                            en.RECIPIENTS = String.Format("{0},{1}", en.RECIPIENTS, asdr.EmailAddress);
                                        }
                                        en.RECIPIENTS.Remove(en.RECIPIENTS.Length - 1);
                                    }
                                    catch (Exception exp) { LogWriter.Log(exp); }
                                    try
                                    {
                                        Dosar d = new Dosar(1, conStr, Convert.ToInt32(ID_DOSAR));
                                        EmailProfile ep = EmailProfiles.AwsNotificariSES;
                                        Emailing e = new Emailing(ep);
                                        e.Message.From = new System.Net.Mail.MailAddress(ep.IncomingUser);
                                        e.Message.To.Add("chiric.chiric@gmail.com");
                                        e.Message.Bcc.Add("andpsy@gmail.com");
                                        e.Message.Subject = String.Format("\"Complaint\" event from AWS SES email (Nr. dosar CASCO: {0})", d.NR_DOSAR_CASCO);
                                        e.Message.Body = complaint.ToString();
                                        e.SendSimpleMessage();
                                    }
                                    catch (Exception exp) { LogWriter.Log(exp); }
                                    break;
                                case "Open":
                                    JToken open = json["open"];
                                    en.TIMESTAMP = open.Value<DateTime>("timestamp");
                                    en.MESSAGE_TEXT = open.ToString();
                                    break;
                                case "Click":
                                    JToken click = json["click"];
                                    en.TIMESTAMP = click.Value<DateTime>("timestamp");
                                    en.MESSAGE_TEXT = click.ToString();
                                    break;
                                case "Failure":
                                    JToken failure = json["failure"];
                                    //en.TIMESTAMP = failure.Value<DateTime>("timestamp"); // nu are timestamp acest event
                                    en.TIMESTAMP = DateTime.Now;
                                    en.MESSAGE_TEXT = failure.ToString();
                                    try
                                    {
                                        Dosar d = new Dosar(1, conStr, Convert.ToInt32(ID_DOSAR));
                                        EmailProfile ep = EmailProfiles.AwsNotificariSES;
                                        Emailing e = new Emailing(ep);
                                        e.Message.From = new System.Net.Mail.MailAddress(ep.IncomingUser);
                                        e.Message.To.Add("chiric.chiric@gmail.com");
                                        e.Message.Bcc.Add("andpsy@gmail.com");
                                        e.Message.Subject = String.Format("\"Failure\" event from AWS SES email (Nr. dosar CASCO: {0})", d.NR_DOSAR_CASCO);
                                        e.Message.Body = failure.ToString();
                                        e.SendSimpleMessage();
                                    }
                                    catch (Exception exp) { LogWriter.Log(exp); }
                                    break;
                            }
                            try
                            {
                                Dosar d = new Dosar(1, conStr, Convert.ToInt32(en.ID_DOSAR));
                                d.UpdateSendStatus(eventType);
                            }
                            catch (Exception exp) { LogWriter.Log(exp); }
                            en.Insert();
                        }
                    }
                    catch(Exception exp)
                    {
                        LogWriter.Log(String.Format("Exception: {0}\r\nMessageId: {1}\r\nMessageText: {2}\r\nSubject: {3}\r\nTimeStamp: {4}\r\nToken: {5}\r\nTopicArn: {6}\r\nType: {7}", exp, sm.MessageId, sm.MessageText, sm.Subject, sm.Timestamp, sm.Token, sm.TopicArn, sm.Type), "AWSloging.txt");
                    }
                }
                return Request.CreateResponse(HttpStatusCode.OK, new { });
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, new { status = "unexpected error" });
            }
        }
    }
}