using System;
using System.Collections.Generic;
using System.Linq;
using SOCISA;
using SOCISA.Models;
using System.Configuration;
using System.Text;
using Xfinium.Pdf.Graphics;
using Xfinium.Pdf.Graphics.Text;
using Xfinium.Pdf;
using Xfinium.Pdf.Graphics.FormattedContent;
using System.IO;
using Xfinium.Pdf.FlowDocument;
using System.Reflection;

namespace Compensare
{
    public class Cycle
    {
        public List<int> Path = new List<int>();
        public double CycleMin = 0;
        public double CycleCompensatedAmount = 0;

        public Cycle()
        {
            this.Path = new List<int>();
            this.CycleMin = 0;
            this.CycleCompensatedAmount = 0;
        }

        public Cycle(Cycle c)
        {
            this.Path = new List<int>(c.Path);
            this.CycleMin = c.CycleMin;
            this.CycleCompensatedAmount = c.CycleCompensatedAmount;
        }
    }

    public class ExtendedEdge
    {
        public int ReceiverNode { get; set; }
        public int GiverNode { get; set; }
        public List<BucketListItem> BucketList = new List<BucketListItem>();
        public double BucketListTotal = 0;

        public ExtendedEdge(int _idGiver, int _idReceiver, List<BucketListItem> _bucketList)
        {
            this.ReceiverNode = _idReceiver;
            this.GiverNode = _idGiver;
            this.BucketList = new List<BucketListItem>(_bucketList);
            foreach(BucketListItem bli in this.BucketList)
            {
                this.BucketListTotal += bli.Suma;
            }
        }
    }

    public class Graph
    {
        string conStr = CommonFunctions.StringCipher.Decrypt(ConfigurationManager.ConnectionStrings["MySqlConnectionString"].ToString(), CommonFunctions.StringCipher.RetrieveKey());
        int id = 1;

        public int[] Nodes = new int[] { };
        public double[][] Edges = null;
        public Cycle LastOptimPath = new Cycle();
        public bool GraphOptimized = false;
        public List<ExtendedEdge> ExtendedEdgesBucketsList = new List<ExtendedEdge>();
        //public DateTime Data = DateTime.Now.Date;
        public DateTime Data = new DateTime(2018, 2, 10);

        public Graph() {
            CreateGraph();
            GenerateReport(this.Data);
            GenerateReportSinteza(this.Data);
            GenerateAnexaPdf(this.Data);
        }

        public Graph(int _nodes) // pentru test
        {
            this.Nodes = new int[_nodes];
            GenerateNodes();
            GenerateEdges();
            PrintEdges();
            GenerateCycles();
            //PrintEdges();
        }

        public void CreateGraph()
        {
            GenerateNodesFromSocietati();
            GenerateEdgesFromSocietati(this.Data);
            PrintEdges();
            GenerateCycles();
            UpdateEdgesInDataBase();
        }

        public void GenerateReport(DateTime _data)
        {
            try
            {
                PdfUnicodeTrueTypeFont boldFontTitle = new PdfUnicodeTrueTypeFont(new FileStream(Path.Combine(AppContext.BaseDirectory, "Content", "arialbold.ttf"), FileMode.Open, FileAccess.Read, FileShare.Read), 14, true);
                PdfUnicodeTrueTypeFont boldFont = new PdfUnicodeTrueTypeFont(new FileStream(Path.Combine(AppContext.BaseDirectory, "Content", "arialbold.ttf"), FileMode.Open, FileAccess.Read, FileShare.Read), 8, true);
                PdfUnicodeTrueTypeFont regularFont = new PdfUnicodeTrueTypeFont(new FileStream(Path.Combine(AppContext.BaseDirectory, "Content", "arial.ttf"), FileMode.Open, FileAccess.Read, FileShare.Read), 8, true);
                PdfFlowDocument document = new PdfFlowDocument();
                PdfFlowTableContent table2 = new PdfFlowTableContent(6);
                table2.DefaultCell.InnerMargins = new PdfFlowContentMargins(3, 3, 1, 1);
                table2.DefaultCell.Borders = new PdfFlowContentBorders(new PdfPen(PdfRgbColor.Black, 0));
                PdfFlowTableRow row = table2.Rows.Add();
                row.MinHeight = 20;
                PdfFlowTableStringCell cell = new PdfFlowTableStringCell("PROCES VERBAL DE COMPENSARE");
                cell.InnerMargins = new PdfFlowContentMargins(3, 3, 1, 20);
                cell.Font = boldFontTitle;
                cell.ColSpan = 6;
                cell.HorizontalAlign = PdfGraphicAlign.Center;
                row.Cells.Add(cell);

                row = table2.Rows.Add();
                row.MinHeight = 20;
                cell = new PdfFlowTableStringCell("Avand in vedere ca la data de " + _data.ToString("dd.MM.yyyy"));
                cell.InnerMargins = new PdfFlowContentMargins(3, 3, 1, 1);
                cell.Font = boldFont;
                cell.ColSpan = 6;
                cell.HorizontalAlign = PdfGraphicAlign.Near;
                cell.Multiline = true;
                row.Cells.Add(cell);

                SocietatiAsigurareRepository sar = new SocietatiAsigurareRepository(id, conStr);
                SocietateAsigurare[] sas = (SocietateAsigurare[])sar.GetAll().Result;
                CompensariRepository cr = new CompensariRepository(id, conStr);
                List<object[]> compsCascoRca = (List<object[]>)cr.GetRaportCompensareCascoRcaAll(_data).Result;
                List<object[]> compsRcaCasco = (List<object[]>)cr.GetRaportCompensareRcaCascoAll(_data).Result;
                foreach (SocietateAsigurare sa in sas)
                {
                    row = table2.Rows.Add();
                    row.MinHeight = 20;
                    cell = new PdfFlowTableStringCell("Societatea " + sa.DENUMIRE + " are de incasat de la, respectiv de platit catre societatile:");
                    cell.InnerMargins = new PdfFlowContentMargins(3, 3, 10, 1);
                    cell.Font = boldFont;
                    cell.ColSpan = 6;
                    cell.HorizontalAlign = PdfGraphicAlign.Near;
                    cell.Multiline = true;
                    row.Cells.Add(cell);

                    row = table2.Rows.Add();
                    row.MinHeight = 20;
                    cell = new PdfFlowTableStringCell("");
                    cell.InnerMargins = new PdfFlowContentMargins(3, 3, 1, 1);
                    cell.HorizontalAlign = PdfGraphicAlign.Near;
                    cell.ColSpan = 4;
                    cell.Multiline = true;
                    cell.Font = regularFont;
                    row.Cells.Add(cell);

                    cell = new PdfFlowTableStringCell("de incasat");
                    cell.InnerMargins = new PdfFlowContentMargins(3, 3, 1, 1);
                    cell.HorizontalAlign = PdfGraphicAlign.Far;
                    cell.Font = boldFont;
                    row.Cells.Add(cell);

                    cell = new PdfFlowTableStringCell("de platit");
                    cell.InnerMargins = new PdfFlowContentMargins(3, 3, 1, 1);
                    cell.HorizontalAlign = PdfGraphicAlign.Far;
                    cell.Font = boldFont;
                    row.Cells.Add(cell);

                    double totalToGive = 0;
                    double totalToRecive = 0;
                    foreach (SocietateAsigurare sa2 in sas)
                    {
                        double s1 = 0;
                        double s2 = 0;
                        if (sa.ID != sa2.ID)
                        {
                            row = table2.Rows.Add();
                            row.MinHeight = 20;
                            cell = new PdfFlowTableStringCell(sa2.DENUMIRE);
                            cell.InnerMargins = new PdfFlowContentMargins(10, 3, 1, 1);
                            cell.HorizontalAlign = PdfGraphicAlign.Near;
                            cell.ColSpan = 4;
                            cell.Multiline = true;
                            cell.Font = regularFont;
                            row.Cells.Add(cell);

                            for (int i = 0; i < compsRcaCasco.Count; i++)
                            {
                                if (sa2.ID == Convert.ToInt32(compsRcaCasco[i][0]))
                                {
                                    s1 = Convert.ToDouble(compsRcaCasco[i][2]);
                                    totalToGive += s1;
                                    break;
                                }
                            }
                            for (int i = 0; i < compsCascoRca.Count; i++)
                            {
                                if (sa2.ID == Convert.ToInt32(compsCascoRca[i][0]))
                                {
                                    s2 = Convert.ToDouble(compsCascoRca[i][2]);
                                    totalToRecive += s2;
                                    break;
                                }
                            }
                            cell = new PdfFlowTableStringCell(s1.ToString("N2") + " lei");
                            cell.InnerMargins = new PdfFlowContentMargins(3, 3, 1, 1);
                            cell.HorizontalAlign = PdfGraphicAlign.Far;
                            cell.Font = regularFont;
                            row.Cells.Add(cell);

                            cell = new PdfFlowTableStringCell(s2.ToString("N2") + " lei");
                            cell.InnerMargins = new PdfFlowContentMargins(3, 3, 1, 1);
                            cell.HorizontalAlign = PdfGraphicAlign.Far;
                            cell.Font = regularFont;
                            row.Cells.Add(cell);
                        }
                    }
                    row = table2.Rows.Add();
                    row.MinHeight = 20;

                    cell = new PdfFlowTableStringCell("SUBTOTAL:");
                    cell.InnerMargins = new PdfFlowContentMargins(3, 3, 1, 1);
                    cell.HorizontalAlign = PdfGraphicAlign.Near;
                    cell.ColSpan = 4;
                    cell.Font = boldFont;
                    row.Cells.Add(cell);

                    cell = new PdfFlowTableStringCell(totalToGive.ToString("N2") + " lei");
                    cell.InnerMargins = new PdfFlowContentMargins(3, 3, 1, 1);
                    cell.HorizontalAlign = PdfGraphicAlign.Far;
                    cell.Font = boldFont;
                    row.Cells.Add(cell);

                    cell = new PdfFlowTableStringCell(totalToRecive.ToString("N2") + " lei");
                    cell.InnerMargins = new PdfFlowContentMargins(3, 3, 1, 1);
                    cell.HorizontalAlign = PdfGraphicAlign.Far;
                    cell.Font = boldFont;
                    row.Cells.Add(cell);
                }

                row = table2.Rows.Add();
                row.MinHeight = 20;
                cell = new PdfFlowTableStringCell("s-a convenit ca in baza Protocolului incheiat intre societatile de asigurare si a prezentului document, sumele reprezentand datorii si creante reciproce sa se compenseze.");
                cell.InnerMargins = new PdfFlowContentMargins(3, 3, 10, 1);
                cell.Font = boldFont;
                cell.ColSpan = 6;
                cell.HorizontalAlign = PdfGraphicAlign.Near;
                cell.Multiline = true;
                row.Cells.Add(cell);

                document.AddContent(table2);
                try
                {
                    string path = Path.Combine(AppContext.BaseDirectory, "COMPENSARI");
                    if (!Directory.Exists(path))
                    {
                        DirectoryInfo di = Directory.CreateDirectory(path);
                    }
                    string fileName = Path.Combine(AppContext.BaseDirectory, "COMPENSARI", String.Format("PROCES_VERBAL_{0}.pdf", _data.ToString("dd_MM_yyyy")));
                    document.Save(fileName);
                }
                catch (Exception e)
                {
                    LogWriter.Log(e);
                }
            }
            catch (Exception exp)
            {
                LogWriter.Log(exp);
            }
        }

        public void GenerateAnexaPdf(DateTime _data)
        {
            try
            {
                PdfUnicodeTrueTypeFont boldFontTitle = new PdfUnicodeTrueTypeFont(new FileStream(Path.Combine(AppContext.BaseDirectory, "Content", "arialbold.ttf"), FileMode.Open, FileAccess.Read, FileShare.Read), 12, true);
                PdfUnicodeTrueTypeFont boldFont = new PdfUnicodeTrueTypeFont(new FileStream(Path.Combine(AppContext.BaseDirectory, "Content", "arialbold.ttf"), FileMode.Open, FileAccess.Read, FileShare.Read), 6, true);
                PdfUnicodeTrueTypeFont regularFont = new PdfUnicodeTrueTypeFont(new FileStream(Path.Combine(AppContext.BaseDirectory, "Content", "arial.ttf"), FileMode.Open, FileAccess.Read, FileShare.Read), 6, true);
                PdfFlowDocument document = new PdfFlowDocument();
                PdfFlowTableContent table2 = new PdfFlowTableContent(9);
                table2.DefaultCell.InnerMargins = new PdfFlowContentMargins(1, 1, 1, 1);
                table2.DefaultCell.Borders = new PdfFlowContentBorders(new PdfPen(PdfRgbColor.Black, 0));
                SocietatiAsigurareRepository sar = new SocietatiAsigurareRepository(id, conStr);
                SocietateAsigurare[] sas = (SocietateAsigurare[])sar.GetAll().Result;
                CompensariRepository cr = new CompensariRepository(id, conStr);
                for (int i = 0; i < sas.Length; i++)
                {
                    int _id_societate = Convert.ToInt32(sas[i].ID);
                    List<SOCISA.Models.Compensare> listRcaCasco = (List<SOCISA.Models.Compensare>)cr.GetRaportCompensareRcaCascoDesfasurat(_data, _id_societate).Result;
                    List<SOCISA.Models.Compensare> listCascoRca = (List<SOCISA.Models.Compensare>)cr.GetRaportCompensareCascoRcaDesfasurat(_data, _id_societate).Result;
                    int counter = listCascoRca.Count > listRcaCasco.Count ? listCascoRca.Count : listRcaCasco.Count;
                    int initCounter = counter;
                    // -- title --
                    PdfFlowTableRow row = table2.Rows.Add();
                    row.MinHeight = 20;
                    PdfFlowTableStringCell cell = new PdfFlowTableStringCell("ANEXA " + (i + 1).ToString());
                    cell.InnerMargins = new PdfFlowContentMargins(3, 3, 20, 2);
                    cell.Font = boldFontTitle;
                    cell.ColSpan = 9;
                    cell.HorizontalAlign = PdfGraphicAlign.Center;
                    row.Cells.Add(cell);

                    row = table2.Rows.Add();
                    row.MinHeight = 20;
                    cell = new PdfFlowTableStringCell("-- " + sas[i].DENUMIRE + " --");
                    cell.InnerMargins = new PdfFlowContentMargins(3, 3, 2, 20);
                    cell.Font = boldFontTitle;
                    cell.ColSpan = 9;
                    cell.HorizontalAlign = PdfGraphicAlign.Center;
                    row.Cells.Add(cell);
                    //-- end title --

                    //-- table header --
                    row = table2.Rows.Add();
                    row.MinHeight = 5;
                    cell.Multiline = true;
                    cell = new PdfFlowTableStringCell("NR. CRT.");
                    cell.RowSpan = 2;
                    cell.InnerMargins = new PdfFlowContentMargins(1, 1, 1, 8);
                    cell.Font = boldFont;
                    cell.HorizontalAlign = PdfGraphicAlign.Far;
                    row.Cells.Add(cell);

                    cell = new PdfFlowTableStringCell("DE INCASAT");
                    cell.ColSpan = 4;
                    cell.InnerMargins = new PdfFlowContentMargins(1, 1, 1, 3);
                    cell.Font = boldFont;
                    cell.HorizontalAlign = PdfGraphicAlign.Center;
                    row.Cells.Add(cell);

                    cell = new PdfFlowTableStringCell("DE PLATIT");
                    cell.ColSpan = 4;
                    cell.InnerMargins = new PdfFlowContentMargins(1, 1, 1, 3);
                    cell.Font = boldFont;
                    cell.HorizontalAlign = PdfGraphicAlign.Center;
                    row.Cells.Add(cell);

                    row = table2.Rows.Add();
                    cell = new PdfFlowTableStringCell("SOCIETATE");
                    cell.InnerMargins = new PdfFlowContentMargins(3, 3, 1, 5);
                    cell.Font = boldFont;
                    cell.HorizontalAlign = PdfGraphicAlign.Near;
                    row.Cells.Add(cell);

                    cell = new PdfFlowTableStringCell("NR. DOSAR");
                    cell.InnerMargins = new PdfFlowContentMargins(3, 3, 1, 5);
                    cell.Font = boldFont;
                    cell.HorizontalAlign = PdfGraphicAlign.Near;
                    row.Cells.Add(cell);

                    cell = new PdfFlowTableStringCell("COMPENSAT");
                    cell.InnerMargins = new PdfFlowContentMargins(1, 1, 1, 5);
                    cell.Font = boldFont;
                    cell.HorizontalAlign = PdfGraphicAlign.Far;
                    row.Cells.Add(cell);

                    cell = new PdfFlowTableStringCell("REST");
                    cell.InnerMargins = new PdfFlowContentMargins(1, 20, 1, 5);
                    cell.Font = boldFont;
                    cell.HorizontalAlign = PdfGraphicAlign.Far;
                    row.Cells.Add(cell);

                    cell = new PdfFlowTableStringCell("SOCIETATE");
                    cell.InnerMargins = new PdfFlowContentMargins(1, 1, 1, 5);
                    cell.Font = boldFont;
                    cell.HorizontalAlign = PdfGraphicAlign.Near;
                    row.Cells.Add(cell);

                    cell = new PdfFlowTableStringCell("NR. DOSAR");
                    cell.InnerMargins = new PdfFlowContentMargins(1, 1, 1, 5);
                    cell.Font = boldFont;
                    cell.HorizontalAlign = PdfGraphicAlign.Near;
                    row.Cells.Add(cell);

                    cell = new PdfFlowTableStringCell("COMPENSAT");
                    cell.InnerMargins = new PdfFlowContentMargins(1, 1, 1, 5);
                    cell.Font = boldFont;
                    cell.HorizontalAlign = PdfGraphicAlign.Far;
                    row.Cells.Add(cell);

                    cell = new PdfFlowTableStringCell("REST");
                    cell.InnerMargins = new PdfFlowContentMargins(1, 1, 1, 5);
                    cell.Font = boldFont;
                    cell.HorizontalAlign = PdfGraphicAlign.Far;
                    row.Cells.Add(cell);
                    //-- end table header--

                    while (counter > 0)
                    {
                        row = table2.Rows.Add();
                        row.MinHeight = 5;
                        cell = new PdfFlowTableStringCell((initCounter - counter + 1).ToString());
                        cell.InnerMargins = new PdfFlowContentMargins(1, 1, 1, 1);
                        cell.Font = regularFont;
                        cell.HorizontalAlign = PdfGraphicAlign.Far;
                        row.Cells.Add(cell);
                        if (initCounter - counter < listCascoRca.Count)
                        {
                            Dosar d = new Dosar(id, conStr, Convert.ToInt32(listCascoRca[initCounter - counter].ID_DOSAR));
                            SocietateAsigurare saRca = (SocietateAsigurare)d.GetSocietateRca().Result;
                            cell = new PdfFlowTableStringCell(saRca.DENUMIRE_SCURTA);
                            cell.InnerMargins = new PdfFlowContentMargins(3, 3, 1, 1);

                            cell.Font = regularFont;
                            cell.HorizontalAlign = PdfGraphicAlign.Near;
                            row.Cells.Add(cell);

                            cell = new PdfFlowTableStringCell(d.NR_DOSAR_CASCO);
                            cell.InnerMargins = new PdfFlowContentMargins(3, 3, 1, 1);
                            cell.Font = regularFont;
                            cell.HorizontalAlign = PdfGraphicAlign.Near;
                            row.Cells.Add(cell);

                            cell = new PdfFlowTableStringCell(Convert.ToDouble(listCascoRca[initCounter - counter].SUMA).ToString("N2"));
                            cell.InnerMargins = new PdfFlowContentMargins(1, 1, 1, 1);
                            cell.Font = regularFont;
                            cell.HorizontalAlign = PdfGraphicAlign.Far;
                            row.Cells.Add(cell);

                            cell = new PdfFlowTableStringCell(Convert.ToDouble(listCascoRca[initCounter - counter].REST).ToString("N2"));
                            cell.InnerMargins = new PdfFlowContentMargins(1, 20, 1, 1);
                            cell.Font = regularFont;
                            cell.HorizontalAlign = PdfGraphicAlign.Far;
                            row.Cells.Add(cell);
                        }
                        else
                        {
                            cell = new PdfFlowTableStringCell(" ");
                            cell.ColSpan = 4;
                            cell.InnerMargins = new PdfFlowContentMargins(3, 3, 1, 1);
                            cell.Font = regularFont;
                            cell.HorizontalAlign = PdfGraphicAlign.Near;
                            row.Cells.Add(cell);
                        }

                        if (initCounter - counter < listRcaCasco.Count)
                        {
                            Dosar d = new Dosar(id, conStr, Convert.ToInt32(listRcaCasco[initCounter - counter].ID_DOSAR));
                            SocietateAsigurare saCasco = (SocietateAsigurare)d.GetSocietateCasco().Result;
                            cell = new PdfFlowTableStringCell(saCasco.DENUMIRE_SCURTA);
                            cell.InnerMargins = new PdfFlowContentMargins(1, 1, 1, 1);
                            cell.Font = regularFont;
                            cell.HorizontalAlign = PdfGraphicAlign.Near;
                            row.Cells.Add(cell);

                            cell = new PdfFlowTableStringCell(d.NR_DOSAR_CASCO);
                            cell.InnerMargins = new PdfFlowContentMargins(1, 1, 1, 1);
                            cell.Font = regularFont;
                            cell.HorizontalAlign = PdfGraphicAlign.Near;
                            row.Cells.Add(cell);

                            cell = new PdfFlowTableStringCell(Convert.ToDouble(listRcaCasco[initCounter - counter].SUMA).ToString("N2"));
                            cell.InnerMargins = new PdfFlowContentMargins(1, 1, 1, 1);
                            cell.Font = regularFont;
                            cell.HorizontalAlign = PdfGraphicAlign.Far;
                            row.Cells.Add(cell);

                            cell = new PdfFlowTableStringCell(Convert.ToDouble(listRcaCasco[initCounter - counter].REST).ToString("N2"));
                            cell.InnerMargins = new PdfFlowContentMargins(1, 1, 1, 1);
                            cell.Font = regularFont;
                            cell.HorizontalAlign = PdfGraphicAlign.Far;
                            row.Cells.Add(cell);
                        }
                        else
                        {
                            cell = new PdfFlowTableStringCell(" ");
                            cell.ColSpan = 4;
                            cell.InnerMargins = new PdfFlowContentMargins(1, 1, 1, 1);
                            cell.Font = regularFont;
                            cell.HorizontalAlign = PdfGraphicAlign.Near;
                            row.Cells.Add(cell);
                        }
                        counter--;
                    }
                }
                document.AddContent(table2);
                try
                {
                    string path = Path.Combine(AppContext.BaseDirectory, "COMPENSARI");
                    if (!Directory.Exists(path))
                    {
                        DirectoryInfo di = Directory.CreateDirectory(path);
                    }
                    string fileName = Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "COMPENSARI", String.Format("ANEXE_{0}.pdf", _data.ToString("dd_MM_yyyy")));
                    document.Save(fileName);
                }
                catch (Exception e)
                {
                    LogWriter.Log(e);
                }
            }
            catch (Exception exp)
            {
                LogWriter.Log(exp);
            }
        }

        public void GenerateReportSinteza(DateTime _data)
        {
            try
            {
                PdfUnicodeTrueTypeFont boldFontTitle = new PdfUnicodeTrueTypeFont(new FileStream(Path.Combine(AppContext.BaseDirectory, "Content", "arialbold.ttf"), FileMode.Open, FileAccess.Read, FileShare.Read), 14, true);
                PdfUnicodeTrueTypeFont boldFont = new PdfUnicodeTrueTypeFont(new FileStream(Path.Combine(AppContext.BaseDirectory, "Content", "arialbold.ttf"), FileMode.Open, FileAccess.Read, FileShare.Read), 8, true);
                PdfUnicodeTrueTypeFont regularFont = new PdfUnicodeTrueTypeFont(new FileStream(Path.Combine(AppContext.BaseDirectory, "Content", "arial.ttf"), FileMode.Open, FileAccess.Read, FileShare.Read), 8, true);

                CompensariRepository cr = new CompensariRepository(id, conStr);
                List<SintezaCompensare> lsc = (List<SintezaCompensare>)cr.GetRaportSintezaCompensare(_data).Result;

                PdfFlowDocument document = new PdfFlowDocument();
                document.PageCreated += Document_PageCreated;
                PdfFlowTableColumn[] cols = new PdfFlowTableColumn[9];
                for (int i = 0; i < 9; i++)
                {
                    cols[i] = new PdfFlowTableColumn();
                    cols[i].VerticalAlign = PdfGraphicAlign.Center;
                    if (i == 0)
                    {
                        cols[i].HorizontalAlign = PdfGraphicAlign.Near;
                        cols[i].Width = 200;
                    }
                    else
                    {
                        cols[i].HorizontalAlign = PdfGraphicAlign.Far;
                        cols[i].Width = 70;
                    }
                }
                PdfFlowTableContent table2 = new PdfFlowTableContent(cols);
                table2.DefaultCell.InnerMargins = new PdfFlowContentMargins(3, 3, 1, 1);
                table2.Border = new PdfPen(PdfRgbColor.Black, 1);
                PdfFlowTableRow row = table2.Rows.Add();
                row.MinHeight = 20;
                PdfFlowTableStringCell cell = new PdfFlowTableStringCell("SINTEZA PROCES VERBAL DE COMPENSARE");
                cell.InnerMargins = new PdfFlowContentMargins(3, 3, 1, 1);
                cell.Font = boldFontTitle;
                cell.ColSpan = 9;
                cell.HorizontalAlign = PdfGraphicAlign.Center;
                row.Cells.Add(cell);

                //table header
                row = table2.Rows.Add();
                row.MinHeight = 30;
                cell = new PdfFlowTableStringCell("Denumire societate", true);
                cell.InnerMargins = new PdfFlowContentMargins(3, 3, 1, 1);
                cell.Font = boldFont;
                cell.HorizontalAlign = PdfGraphicAlign.Near;
                row.Cells.Add(cell);
                cell = new PdfFlowTableStringCell("Credit / Debit", true);
                cell.InnerMargins = new PdfFlowContentMargins(3, 3, 1, 1);
                cell.Font = boldFont;
                cell.HorizontalAlign = PdfGraphicAlign.Far;
                row.Cells.Add(cell);
                cell = new PdfFlowTableStringCell("Nr. dosare intrate in compensare", true);
                cell.InnerMargins = new PdfFlowContentMargins(3, 3, 1, 1);
                cell.Font = boldFont;
                cell.HorizontalAlign = PdfGraphicAlign.Far;
                row.Cells.Add(cell);
                cell = new PdfFlowTableStringCell("Nr. dosare compensate integral", true);
                cell.InnerMargins = new PdfFlowContentMargins(3, 3, 1, 1);
                cell.Font = boldFont;
                cell.HorizontalAlign = PdfGraphicAlign.Far;
                row.Cells.Add(cell);
                cell = new PdfFlowTableStringCell("Nr. dosare compensate partial", true);
                cell.InnerMargins = new PdfFlowContentMargins(3, 3, 1, 1);
                cell.Font = boldFont;
                cell.HorizontalAlign = PdfGraphicAlign.Far;
                row.Cells.Add(cell);
                cell = new PdfFlowTableStringCell("Nr. dosare necompensate", true);
                cell.InnerMargins = new PdfFlowContentMargins(3, 3, 1, 1);
                cell.Font = boldFont;
                cell.HorizontalAlign = PdfGraphicAlign.Far;
                row.Cells.Add(cell);
                cell = new PdfFlowTableStringCell("Sume compensate", true);
                cell.InnerMargins = new PdfFlowContentMargins(3, 3, 1, 1);
                cell.Font = boldFont;
                cell.HorizontalAlign = PdfGraphicAlign.Far;
                row.Cells.Add(cell);
                cell = new PdfFlowTableStringCell("Sume necompensate", true);
                cell.InnerMargins = new PdfFlowContentMargins(3, 3, 1, 1);
                cell.Font = boldFont;
                cell.HorizontalAlign = PdfGraphicAlign.Far;
                row.Cells.Add(cell);
                cell = new PdfFlowTableStringCell("Total", true);
                cell.InnerMargins = new PdfFlowContentMargins(3, 3, 1, 1);
                cell.Font = boldFont;
                cell.HorizontalAlign = PdfGraphicAlign.Far;
                row.Cells.Add(cell);

                // end table header

                int altRow = 0;
                foreach (SintezaCompensare sc in lsc)
                {
                    row = table2.Rows.Add();
                    row.MinHeight = 20;
                    if (altRow % 2 == 1)
                        row.Background = new PdfBrush(PdfRgbColor.LightGray);
                    PropertyInfo[] pis = sc.GetType().GetProperties();
                    int counter = 0;
                    foreach (PropertyInfo pi in pis)
                    {
                        if (counter == 10)
                        {
                            row = table2.Rows.Add();
                            row.MinHeight = 20;
                            if (altRow % 2 == 1)
                                row.Background = new PdfBrush(PdfRgbColor.LightGray);
                        }
                        if (counter == 3)
                        {
                            cell = new PdfFlowTableStringCell("credit\r\n(de incasat)");
                            cell.InnerMargins = new PdfFlowContentMargins(3, 3, 1, 1);
                            cell.Multiline = true;
                            cell.Font = regularFont;
                            row.Cells.Add(cell);
                        }
                        if (counter == 10)
                        {
                            cell = new PdfFlowTableStringCell("debit\r\n(de achitat)");
                            cell.InnerMargins = new PdfFlowContentMargins(3, 3, 1, 1);
                            cell.Font = regularFont;
                            cell.Multiline = true;
                            row.Cells.Add(cell);
                        }
                        if (pi.Name.IndexOf("ID") > -1 || pi.Name.IndexOf("DENUMIRE_SCURTA") > -1)
                        {
                            counter++;
                            continue;
                        }
                        if (pi.Name == "DENUMIRE")
                        {
                            cell = new PdfFlowTableStringCell(pi.GetValue(sc).ToString());
                            cell.InnerMargins = new PdfFlowContentMargins(3, 3, 1, 1);
                            cell.Multiline = true;
                            cell.Font = regularFont;
                            cell.RowSpan = 2;
                            row.Cells.Add(cell);
                            counter++;
                            continue;
                        }
                        if (pi.PropertyType.Name == "Double")
                        {
                            cell = new PdfFlowTableStringCell(Math.Round(Convert.ToDouble(pi.GetValue(sc)), 2).ToString("N2"));
                            cell.InnerMargins = new PdfFlowContentMargins(3, 3, 1, 1);
                            cell.Font = regularFont;
                            row.Cells.Add(cell);
                            counter++;
                            continue;
                        }
                        cell = new PdfFlowTableStringCell(pi.GetValue(sc).ToString());
                        cell.InnerMargins = new PdfFlowContentMargins(3, 3, 1, 1);
                        cell.Font = regularFont;
                        row.Cells.Add(cell);
                        counter++;
                    }
                    altRow++;
                }
                document.AddContent(table2);
                try
                {
                    string path = Path.Combine(AppContext.BaseDirectory, "COMPENSARI");
                    if (!Directory.Exists(path))
                    {
                        DirectoryInfo di = Directory.CreateDirectory(path);
                    }
                    string fileName = Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "COMPENSARI", String.Format("SINTEZA_{0}.pdf", _data.ToString("dd_MM_yyyy")));
                    document.Save(fileName);
                }
                catch (Exception e)
                {
                    LogWriter.Log(e);
                }
            }
            catch (Exception exp)
            {
                LogWriter.Log(exp);
            }
        }

        private void Document_PageCreated(object sender, PdfFlowPageCreatedEventArgs e)
        {
            e.Page.Width = 842; e.Page.Height = 595; // landscape
        }

        public static PdfFormattedContent GeneratePVPdfContent(List<string> pdfText)
        {
            PdfUnicodeTrueTypeFont boldFontTitle = new PdfUnicodeTrueTypeFont(new FileStream(Path.Combine(AppContext.BaseDirectory, "Content", "arialbold.ttf"), FileMode.Open, FileAccess.Read, FileShare.Read), 14, true);
            PdfUnicodeTrueTypeFont regularFontTitle = new PdfUnicodeTrueTypeFont(new FileStream(Path.Combine(AppContext.BaseDirectory, "Content", "arial.ttf"), FileMode.Open, FileAccess.Read, FileShare.Read), 14, true);
            PdfUnicodeTrueTypeFont boldFont = new PdfUnicodeTrueTypeFont(new FileStream(Path.Combine(AppContext.BaseDirectory, "Content", "arialbold.ttf"), FileMode.Open, FileAccess.Read, FileShare.Read), 10, true);
            PdfUnicodeTrueTypeFont regularFont = new PdfUnicodeTrueTypeFont(new FileStream(Path.Combine(AppContext.BaseDirectory, "Content", "arial.ttf"), FileMode.Open, FileAccess.Read, FileShare.Read), 10, true);

            PdfFormattedContent pfc = new PdfFormattedContent();
            foreach (string s in pdfText)
            {
                PdfFormattedParagraph pfp = new PdfFormattedParagraph();
                pfp.LineSpacingMode = PdfFormattedParagraphLineSpacing.Multiple;
                pfp.LineSpacing = 1.15;
                pfp.SpacingAfter = 5;
                PdfFormattedTextBlock b1 = new PdfFormattedTextBlock();
                if (s.IndexOf("PROCES VERBAL") > -1)
                {
                    pfp.HorizontalAlign = PdfStringHorizontalAlign.Center;
                    b1 = new PdfFormattedTextBlock(s, boldFontTitle);
                }
                else if(s.IndexOf("Avand in vedere") > -1 || s.IndexOf("s-a convenit") > -1)
                {
                    pfp.HorizontalAlign = PdfStringHorizontalAlign.Justified;
                    pfp.LeftIndentation = 15;
                    b1 = new PdfFormattedTextBlock(s, boldFont);
                }
                else if (s.IndexOf("Societatea ") > -1 || s.IndexOf("► ") > -1 || s.IndexOf("---") > -1 || s.IndexOf("TOTAL") > -1)
                {
                    pfp.HorizontalAlign = PdfStringHorizontalAlign.Justified;
                    pfp.LeftIndentation = 30;
                    b1 = new PdfFormattedTextBlock(s, boldFont);
                }
                else
                {
                    pfp.HorizontalAlign = PdfStringHorizontalAlign.Center;
                    pfp.LeftIndentation = 50;
                    b1 = new PdfFormattedTextBlock(s, regularFont);
                }
                pfp.Blocks.Add(b1);
                pfc.Paragraphs.Add(pfp);
            }
            //pfc.SplitByBox(485, 742);
            //PdfFlowTextContent pftc = new PdfFlowTextContent(pfc);
            //return pftc;
            return pfc;
        }

        public static PdfFormattedContent GeneratePVSintezaPdfContent(List<string> pdfText)
        {
            PdfUnicodeTrueTypeFont boldFontTitle = new PdfUnicodeTrueTypeFont(new FileStream(Path.Combine(AppContext.BaseDirectory, "Content", "arialbold.ttf"), FileMode.Open, FileAccess.Read, FileShare.Read), 14, true);
            PdfUnicodeTrueTypeFont regularFontTitle = new PdfUnicodeTrueTypeFont(new FileStream(Path.Combine(AppContext.BaseDirectory, "Content", "arial.ttf"), FileMode.Open, FileAccess.Read, FileShare.Read), 14, true);
            PdfUnicodeTrueTypeFont boldFont = new PdfUnicodeTrueTypeFont(new FileStream(Path.Combine(AppContext.BaseDirectory, "Content", "arialbold.ttf"), FileMode.Open, FileAccess.Read, FileShare.Read), 10, true);
            PdfUnicodeTrueTypeFont regularFont = new PdfUnicodeTrueTypeFont(new FileStream(Path.Combine(AppContext.BaseDirectory, "Content", "arial.ttf"), FileMode.Open, FileAccess.Read, FileShare.Read), 10, true);

            PdfFormattedContent pfc = new PdfFormattedContent();
            foreach (string s in pdfText)
            {
                PdfFormattedParagraph pfp = new PdfFormattedParagraph();
                pfp.LineSpacingMode = PdfFormattedParagraphLineSpacing.Multiple;
                pfp.LineSpacing = 1.15;
                pfp.SpacingAfter = 5;
                PdfFormattedTextBlock b1 = new PdfFormattedTextBlock();
                if (s.IndexOf("SINTEZA PROCES VERBAL") > -1)
                {
                    pfp.HorizontalAlign = PdfStringHorizontalAlign.Center;
                    b1 = new PdfFormattedTextBlock(s, boldFontTitle);
                }
                else if (s.IndexOf("Avand in vedere") > -1 || s.IndexOf("s-a convenit") > -1)
                {
                    pfp.HorizontalAlign = PdfStringHorizontalAlign.Justified;
                    pfp.LeftIndentation = 15;
                    b1 = new PdfFormattedTextBlock(s, boldFont);
                }
                else if (s.IndexOf("Societatea ") > -1 || s.IndexOf("► ") > -1 || s.IndexOf("---") > -1 || s.IndexOf("TOTAL") > -1)
                {
                    pfp.HorizontalAlign = PdfStringHorizontalAlign.Justified;
                    pfp.LeftIndentation = 30;
                    b1 = new PdfFormattedTextBlock(s, boldFont);
                }
                else
                {
                    pfp.HorizontalAlign = PdfStringHorizontalAlign.Center;
                    pfp.LeftIndentation = 50;
                    b1 = new PdfFormattedTextBlock(s, regularFont);
                }
                pfp.Blocks.Add(b1);
                pfc.Paragraphs.Add(pfp);
            }
            //pfc.SplitByBox(485, 742);
            //PdfFlowTextContent pftc = new PdfFlowTextContent(pfc);
            //return pftc;
            return pfc;
        }

        public ExtendedEdge FindExtendedEdge(int _idGiver, int _idReceiver)
        {
            foreach(ExtendedEdge ee in this.ExtendedEdgesBucketsList)
            {
                if(ee.GiverNode == _idGiver && ee.ReceiverNode == _idReceiver)
                {
                    return ee;
                }
            }
            return null;
        }

        public void GenerateNodes() // pentru test
        {
            for (int i = 0; i < this.Nodes.Length; i++)
            {
                this.Nodes[i] = i; // aici vom pune id-ul societatii
            }
        }

        public void GenerateEdges() // pentru test
        {
            Random r = new Random();
            this.Edges = new double[this.Nodes.Length][];
            for (int i = 0; i < this.Nodes.Length; i++)
            {
                this.Edges[i] = new double[this.Nodes.Length];
                for (int j = 0; j < this.Nodes.Length; j++)
                {
                    this.Edges[i][j] = i == j ? 0 : r.Next(0, 500); // aici vom pune valoarea din bd (cat are i de dat lui j si invers ...)
                }
            }
        }

        public void GenerateNodesFromSocietati()
        {
            SocietatiAsigurareRepository sar = new SocietatiAsigurareRepository(id, conStr);
            SocietateAsigurare[] sas = (SocietateAsigurare[])sar.GetAll().Result;
            this.Nodes = new int[sas.Length];
            for(int i=0;i<sas.Length;i++)
            {
                this.Nodes[i] = Convert.ToInt32(sas[i].ID);
            }
        }

        public void GenerateEdgesFromSocietati(DateTime _data)
        {
            CompensariRepository cr = new CompensariRepository(id, conStr);
            this.Edges = new double[this.Nodes.Length][];
            for (int i = 0; i < this.Nodes.Length; i++)
            {
                this.Edges[i] = new double[this.Nodes.Length];
                for (int j = 0; j < this.Nodes.Length; j++)
                {
                    if (i != j)
                    {
                        List<BucketListItem> bl = (List<BucketListItem>)cr.GetBucketList(this.Nodes[i], this.Nodes[j], _data).Result;
                        ExtendedEdge ee = new ExtendedEdge(this.Nodes[i], this.Nodes[j], bl);
                        this.ExtendedEdgesBucketsList.Add(ee);

                        this.Edges[i][j] = i == j ? 0 : ee.BucketListTotal; // aici vom pune valoarea din bd (cat are i de dat lui j si invers ...)
                    }
                }
            }
        }

        public void UpdateEdgesInDataBase()
        {
            for (int i = 0; i < this.Edges.Length; i++)
            {
                for (int j = 0; j < this.Edges.Length; j++)
                {
                    if (i != j)
                    {
                        int idGiver = this.Nodes[i]; // id soc. RCA
                        int idReceiver = this.Nodes[j]; // id soc. Casco
                        ExtendedEdge ee = FindExtendedEdge(idGiver, idReceiver);
                        double newAmount = ee.BucketListTotal - this.Edges[i][j]; // cat s-a compensat din edge
                        double tmpAmount = 0;
                        foreach (BucketListItem bli in ee.BucketList.OrderBy(d => d.Suma))
                        {
                            if(tmpAmount + bli.Suma <= newAmount)
                            {
                                // aici salvam compensarea si actualizam status dosar = COMPENSAT pt. toata suma din dosar - bli.Suma si rest 0
                                SOCISA.Models.Compensare c = new SOCISA.Models.Compensare(id, conStr);
                                c.DATA = this.Data;
                                c.ID_DOSAR = bli.Dosar.ID;
                                c.SUMA = bli.Suma;
                                c.REST = 0;
                                response r = c.Insert();
                                if (r.Status) // de vazut ce facem daca avem erori !!!
                                {
                                    bli.Dosar.ChangeStatus("COMPENSAT"); 
                                }
                                //tmpAmount += bli.Suma;
                            }
                            if (tmpAmount + bli.Suma > newAmount && tmpAmount < newAmount) // suntem la ultimul dosar care se compenseaza partial
                            {
                                // aici salvam compensarea si actualizam status dosar = COMPENSAT_PARTIAL pt. newAmount - tmpAmount si rest = bli.Suma - (newAmount - tmpAmount)
                                SOCISA.Models.Compensare c = new SOCISA.Models.Compensare(id, conStr);
                                c.DATA = this.Data;
                                c.ID_DOSAR = bli.Dosar.ID;
                                c.SUMA = newAmount - tmpAmount;
                                c.REST = bli.Suma - (newAmount - tmpAmount);
                                response r = c.Insert();
                                if (r.Status)
                                {
                                    bli.Dosar.ChangeStatus("COMPENSAT PARTIAL");
                                }
                                //tmpAmount += (newAmount - tmpAmount);
                            }
                            if (tmpAmount + bli.Suma > newAmount && tmpAmount > newAmount) 
                            {
                                //pt. restul dosarelor salvam compensarea cu suma = 0 si rest = toata suma din dosar.
                                SOCISA.Models.Compensare c = new SOCISA.Models.Compensare(id, conStr);
                                c.DATA = this.Data;
                                c.ID_DOSAR = bli.Dosar.ID;
                                c.SUMA = 0;
                                c.REST = bli.Suma;
                                response r = c.Insert();
                                if (r.Status)
                                {
                                    //bli.Dosar.ChangeStatus("NECOMPENSAT"); 
                                }
                                //tmpAmount += (newAmount - tmpAmount);
                            }
                            tmpAmount += bli.Suma;
                        }
                    }
                }
            }
        }

        public void VariableRowHeightTable()
        {
            double marginLeft = 18;
            double marginTop = 18;
            double marginBottom = 18;
            double columnWidth = 96;
            int columns = 6;
            string[] defaultColumnContent = new string[5];
            defaultColumnContent[0] = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut dolor turpis, luctus ut nulla ac, " +
                "elementum bibendum felis. Curabitur non justo et erat auctor posuere. Quisque quam lacus, sollicitudin vitae dui eget, scelerisque porta metus";
            defaultColumnContent[1] = "Duis gravida diam vel est tempor facilisis. Quisque nec leo eu lorem consequat malesuada. " +
                "Phasellus nec odio quis lorem lacinia lobortis in sed ligula.";
            defaultColumnContent[2] = "Cras adipiscing vestibulum tincidunt. Sed eget iaculis sem. Ut sollicitudin a magna sed ultrices. " +
                "Vivamus in rutrum nisl, ac aliquet lectus.";
            defaultColumnContent[3] = "Sed sed condimentum diam. Duis sit amet ipsum euismod sem aliquet vehicula sed in tortor. " +
                "Nullam vitae odio gravida, porttitor risus ac, tempor nibh. Donec accumsan lorem in turpis placerat, ut eleifend erat aliquam. " +
                "Mauris iaculis, velit ut malesuada pretium, dui dui sagittis enim, vehicula accumsan massa metus id lacus.";
            defaultColumnContent[4] = "Interdum et malesuada fames ac ante ipsum primis in faucibus. Sed vitae diam a sapien rhoncus malesuada vitae quis eros.";
            double defaultRowHeight = 12;
            string[] columnContent = new string[5];
            double rowHeight = defaultRowHeight;

            PdfBrush blackBrush = new PdfBrush();
            PdfStandardFont helvetica = new PdfStandardFont(PdfStandardFontFace.Helvetica, 10);
            PdfStandardFont helveticaBold = new PdfStandardFont(PdfStandardFontFace.HelveticaBold, 10);
            PdfPen pen = new PdfPen(PdfRgbColor.Black, 0.5);
            PdfBrush brush = new PdfBrush(PdfRgbColor.Black);

            PdfFixedDocument doc = new PdfFixedDocument();
            PdfPage page = doc.Pages.Add();
            double currentY = marginTop;

            PdfStringAppearanceOptions sao = new PdfStringAppearanceOptions();
            sao.Brush = brush;
            PdfStringLayoutOptions slo = new PdfStringLayoutOptions();

            Random rnd = new Random();
            int recordCount = 50 + rnd.Next(50);
            bool headerRequired = true;
            bool rowContentRequired = true;
            for (int i = 0; i < recordCount; i++)
            {
                if (headerRequired)
                {
                    // Draw table header
                    currentY = marginTop;
                    sao.Font = helveticaBold;
                    slo.HorizontalAlign = PdfStringHorizontalAlign.Center;
                    slo.VerticalAlign = PdfStringVerticalAlign.Middle;
                    slo.Width = 0;
                    page.Graphics.DrawLine(pen, marginLeft, currentY, marginLeft + columns * columnWidth, currentY);
                    for (int j = 0; j <= columns; j++)
                    {
                        page.Graphics.DrawLine(pen, marginLeft + j * columnWidth, currentY, marginLeft + j * columnWidth, currentY + defaultRowHeight);

                        if (j < columns)
                        {
                            slo.X = marginLeft + j * columnWidth + columnWidth / 2;
                            slo.Y = currentY + defaultRowHeight / 2;
                            page.Graphics.DrawString(String.Format("Column {0}", j + 1), sao, slo);
                        }
                    }
                    currentY += defaultRowHeight;
                    page.Graphics.DrawLine(pen, marginLeft, currentY, marginLeft + columns * columnWidth, currentY);

                    headerRequired = false;
                    slo.HorizontalAlign = PdfStringHorizontalAlign.Left;
                    slo.VerticalAlign = PdfStringVerticalAlign.Top;
                    sao.Font = helvetica;
                }

                if (rowContentRequired)
                {
                    rowHeight = defaultRowHeight;
                    // Generate random content for the current row.
                    for (int j = 0; j < columnContent.Length; j++)
                    {
                        columnContent[j] = defaultColumnContent[rnd.Next(5)];
                    }
                    // Compute the actual row height
                    for (int j = 0; j < columnContent.Length; j++)
                    {
                        double cellHeight = PdfTextEngine.GetStringHeight(columnContent[j], helvetica, columnWidth);
                        if (cellHeight > rowHeight)
                        {
                            rowHeight = cellHeight;
                        }
                    }
                    rowContentRequired = false;
                }

                // Check if there is no more space on the page and there are more records.
                if ((currentY + rowHeight > page.Height - marginBottom) &&
                    (i < recordCount - 1))
                {
                    page.Graphics.CompressAndClose();
                    page = doc.Pages.Add();
                    currentY = marginTop;
                    headerRequired = true;

                    // The record has not been drawn yet.
                    i--;
                    continue;
                }

                // Draw row
                slo.Y = currentY + 1;
                for (int j = 0; j <= columns; j++)
                {
                    page.Graphics.DrawLine(pen, marginLeft + j * columnWidth, currentY, marginLeft + j * columnWidth, currentY + rowHeight);

                    if (j < columns)
                    {
                        if (j == 0)
                        {
                            slo.X = marginLeft + j * columnWidth + 1;
                            slo.Width = 0;
                            page.Graphics.DrawString(String.Format("Record {0}", i + 1), sao, slo);
                        }
                        else
                        {
                            slo.X = marginLeft + j * columnWidth;
                            slo.Width = columnWidth;
                            page.Graphics.DrawString(columnContent[j - 1], sao, slo);
                        }
                    }
                }
                currentY += rowHeight;
                page.Graphics.DrawLine(pen, marginLeft, currentY, marginLeft + columns * columnWidth, currentY);

                rowContentRequired = true;
            }
            page.Graphics.CompressAndClose();

            doc.Save("VariableRowHeightTable.pdf");
        }

        public void UpdateCycle(Cycle c)
        {
            if (c.Path.Count < 2)
            {
                c.CycleMin = 0;
                c.CycleCompensatedAmount = 0;
                return;
            }
            if (c.Path.Count == 2)
            {
                c.CycleMin = c.CycleCompensatedAmount = this.Edges[c.Path[0]][c.Path[1]];
                return;
            }
            if (c.Path.Count > 2)
            {
                double lastInsertedEdgeAmount = this.Edges[c.Path[c.Path.Count - 2]][c.Path[c.Path.Count - 1]];
                c.CycleMin = c.CycleMin < lastInsertedEdgeAmount ? c.CycleMin : lastInsertedEdgeAmount;
                c.CycleCompensatedAmount = c.CycleMin * (c.Path.Count - 1);
                return;
            }
        }

        public void PrintEdges()
        {
            for (int i = 0; i < this.Nodes.Length; i++)
            {
                string line = "";
                for (int j = 0; j < this.Nodes.Length; j++)
                {
                    line += (this.Edges[i][j].ToString() + (j == this.Nodes.Length - 1 ? "" : "\t"));
                }
                Console.WriteLine(line);
            }
            Console.WriteLine("\r\n\r\n");
        }

        public void PrintOptimPath()
        {
            string line = "";
            for (int i = 0; i < this.LastOptimPath.Path.Count; i++)
            {
                line += (this.LastOptimPath.Path[i].ToString() + (i == this.LastOptimPath.Path.Count - 1 ? "" : ", "));
            }
            line += " *** " + this.LastOptimPath.CycleMin.ToString() + " *** " + this.LastOptimPath.CycleCompensatedAmount.ToString() + " *** " + this.GraphOptimized.ToString();
            Console.WriteLine(line);
        }

        public void UpdateEdges()
        {
            for (int i = 0; i < this.LastOptimPath.Path.Count - 1; i++)
            {
                this.Edges[this.LastOptimPath.Path[i]][this.LastOptimPath.Path[i + 1]] -= this.LastOptimPath.CycleMin;
            }
        }

        public bool IsValid(int _nextNodeIndex, Cycle _curPath)
        {
            if (_curPath.Path.Count > 2)
            {
                if (_curPath.Path[_curPath.Path.Count - 2] == _nextNodeIndex)
                {
                    return false;
                }
            }

            if (EdgeExistsInPath(_nextNodeIndex, _curPath)) return false;

            double nextEdgeWeight = this.Edges[_curPath.Path[_curPath.Path.Count - 1]][_nextNodeIndex];
            if (nextEdgeWeight == 0) return false; // edge-ul generat de nodul urmator = 0, deci nu e valid

            ////if (_curPath.Path.Count > this.LastOptimPath.Path.Count && nextEdgeWeight < this.LastOptimPath.CycleMin) return false; // edge-ul genereaza un path inferior celui curent optim

            //double newCycleCompensatedAmount = (_curPath.Path.Count) * (_curPath.CycleMin < nextEdgeWeight ? _curPath.CycleMin : nextEdgeWeight);
            //if (newCycleCompensatedAmount < this.LastOptimPath.CycleCompensatedAmount) return false; // edge-ul genereaza un path inferior celui curent optim

            if (_curPath.Path.Count > 1)
            {
                double newMin = _curPath.CycleMin < nextEdgeWeight ? _curPath.CycleMin : nextEdgeWeight;
                if (this.Nodes.Length * (this.Nodes.Length - 1) * newMin <= this.LastOptimPath.CycleCompensatedAmount)
                    return false;
            }
            return true;
        }

        public bool EdgeExistsInPath(int _nextNodeIndex, Cycle _curPath) // functie pt. determinarea existentei in path a edge-ului creat de adaugarea unui nou nod
        {
            for (int k = 1; k < _curPath.Path.Count; k++)
            {
                if (_curPath.Path[k] == _nextNodeIndex && _curPath.Path[k - 1] == _curPath.Path[_curPath.Path.Count - 1]) // edge-ul exista deja in path
                {
                    return true;
                }
            }
            return false;
        }

        public bool IsOptim(Cycle _curPath)
        {
            if (_curPath.CycleCompensatedAmount > this.LastOptimPath.CycleCompensatedAmount) return true;
            return false;
        }

        public void GenerateCycles()
        {
            while (!this.GraphOptimized)
            {
                this.GraphOptimized = true;
                for (int i = 0; i < this.Nodes.Length; i++)
                {
                    Cycle nc = new Cycle();
                    nc.Path.Add(i);
                    FindCycles(nc);
                }
                if (!this.GraphOptimized)
                {
                    UpdateEdges();
                    //PrintOptimPath();
                    PrintEdges();
                    this.LastOptimPath = new Cycle();
                }
            }
        }

        private void FindCycles(Cycle path)
        {
            int LastVisitedNode = -1;
            /*
            Dictionary<string, List<int>> visitedNodes = new Dictionary<string, List<int>>();
            string curNode = path.Path[path.Path.Count - 1].ToString();
            try
            {
                visitedNodes.Add(curNode, new List<int>());
            }
            catch { }
            */
            while (path.Path.Count > 0)
            {
                int steps = 0;
                while (steps < this.Nodes.Length)
                {
                    steps = 0;
                    for (int i = 0; i < this.Nodes.Length; i++) // pt. toate nodurile adiacente (practic toate)
                    {
                        if (i == path.Path[path.Path.Count - 1]) // mai putin nodul curent
                        {
                            steps++;
                            continue;
                        }
                        if (!IsValid(i, path)) // nodul genereaza un edge = 0 sau mai mic decat minimul din pathul curent optim
                        {
                            steps++;
                            continue;
                        }

                        if (i == path.Path[0])
                        {
                            Cycle tmpPath = new Cycle(path);
                            tmpPath.Path.Add(i);
                            UpdateCycle(tmpPath);
                            if (tmpPath.CycleCompensatedAmount > this.LastOptimPath.CycleCompensatedAmount)
                            {
                                this.LastOptimPath = new Cycle(tmpPath);
                                this.GraphOptimized = false;
                                PrintOptimPath();
                            }
                            steps++;
                            continue;
                        }
                        /*
                        if (visitedNodes[curNode].IndexOf(i) == -1)
                        {
                            visitedNodes[curNode].Add(i);
                            path.Path.Add(i);
                            UpdateCycle(path);
                            curNode += i.ToString();
                            if (!visitedNodes.Keys.Contains(curNode))
                                visitedNodes.Add(curNode, new List<int>());
                            break;
                        }
                        */
                        if (i > LastVisitedNode)
                        {
                            path.Path.Add(i);
                            UpdateCycle(path);
                            break;
                        }
                        steps++;
                    }
                }
                LastVisitedNode = path.Path[path.Path.Count - 1];
                path.Path.RemoveAt(path.Path.Count - 1);
                //curNode = curNode.Remove(curNode.Length - 1);
                UpdateCycle(path);
            }
        }
    }
}