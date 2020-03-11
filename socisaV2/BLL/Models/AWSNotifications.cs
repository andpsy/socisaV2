using MySql.Data.MySqlClient;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Reflection;
using Newtonsoft.Json;
using System.ComponentModel.DataAnnotations;

namespace SOCISA.Models
{
    /// <summary>Represents the bounce or complaint notification stored in Amazon SQS.</summary>
    class AmazonSqsNotification
    {
        public string Type { get; set; }
        public string Message { get; set; }
    }

    /// <summary>Represents an Amazon SES bounce notification.</summary>
    class AmazonSesBounceNotification
    {
        public string NotificationType { get; set; }
        public AmazonSesBounce Bounce { get; set; }
    }
    /// <summary>Represents meta data for the bounce notification from Amazon SES.</summary>
    class AmazonSesBounce
    {
        public string BounceType { get; set; }
        public string BounceSubType { get; set; }
        public DateTime Timestamp { get; set; }
        public List<AmazonSesBouncedRecipient> BouncedRecipients { get; set; }
    }
    /// <summary>Represents the email address of recipients that bounced
    /// when sending from Amazon SES.</summary>
    class AmazonSesBouncedRecipient
    {
        public string EmailAddress { get; set; }
    }


    /// <summary>Represents an Amazon SES complaint notification.</summary>
    class AmazonSesComplaintNotification
    {
        public string NotificationType { get; set; }
        public AmazonSesComplaint Complaint { get; set; }
    }
    /// <summary>Represents the email address of individual recipients that complained 
    /// to Amazon SES.</summary>
    class AmazonSesComplainedRecipient
    {
        public string EmailAddress { get; set; }
    }
    /// <summary>Represents meta data for the complaint notification from Amazon SES.</summary>
    class AmazonSesComplaint
    {
        public List<AmazonSesComplainedRecipient> ComplainedRecipients { get; set; }
        public DateTime Timestamp { get; set; }
        public string MessageId { get; set; }
    }


    /// <summary>Represents an Amazon SES complaint notification.</summary>
    class AmazonSesDeliveryNotification
    {
        public string NotificationType { get; set; }
        public AmazonSesDelivery Delivery { get; set; }
    }
    /// <summary>Represents the email address of individual recipients that complained 
    /// to Amazon SES.</summary>
    class AmazonSesDeliveryRecipient
    {
        public string EmailAddress { get; set; }
    }
    /// <summary>Represents meta data for the complaint notification from Amazon SES.</summary>
    class AmazonSesDelivery
    {
        public List<AmazonSesDeliveryRecipient> DeliveryRecipients { get; set; }
        public DateTime Timestamp { get; set; }
        public string MessageId { get; set; }
    }

}