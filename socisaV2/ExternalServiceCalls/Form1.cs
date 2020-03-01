using System;
using System.Windows.Forms;
using ExternalServiceCalls.ServiceReference1;
using SOCISA;
using SOCISA.Models;
using System.Collections.Generic;
using System.Globalization;
using System.Data;
using System.Linq;
using System.Xml.Linq;
using System.ServiceModel;
using System.Configuration;

namespace ExternalServiceCalls
{
    public partial class Form1 : Form
    {
        bool WithoutEmails;
        bool WithoutMarkings;
        bool WithPdfs;
        string DenumireSocietate;

        public Form1()
        {
            InitializeComponent();
        }

        public Form1(bool withoutEmails, bool withoutMarkings, bool withPdfs, string denumireSocietate)
        {
            InitializeComponent();
            this.WithoutEmails = withoutEmails;
            this.WithoutMarkings = withoutMarkings;
            this.DenumireSocietate = denumireSocietate;
            this.WithPdfs = withPdfs;
        }

        private void Form1_Load(object sender, EventArgs e)
        {

        }

        private void button1_Click(object sender, EventArgs e)
        {
            Program.CallService(WithoutEmails, WithoutMarkings, WithPdfs, DenumireSocietate);
        }
    }
}
