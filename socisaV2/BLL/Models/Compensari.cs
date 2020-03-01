using System;
using System.Collections.Generic;
using System.Linq;
using MySql.Data.MySqlClient;
using System.Data;

namespace SOCISA.Models
{
    public static class Compensari
    {
        public static void RunCompensation(bool exit, Graph g, int step, double prevCompensatedAmount, double prevTotalCompensatedAmount, out double CompensatedAmount, out double TotalCompensatedAmount)
        {
            step++;
            CompensatedAmount = prevCompensatedAmount;
            TotalCompensatedAmount = prevTotalCompensatedAmount;
            if (!exit)
            {
                //List<Cycle> orderedList = g.Cycles.OrderByDescending(x => x.CycleCompensatedAmount).ToList();
                //g.ListCycles(orderedList, "OrderedCycles" + step.ToString() + ".txt");
                using (Graph clona = g.Clone())
                {
                    int maxCycleIndex = clona.GetMaxCycleByCompensatedAmount();
                    double tmpCompensatedAmount = clona.Cycles[maxCycleIndex].CycleMin;
                    exit = tmpCompensatedAmount <= 0 ? true : false;
                    CompensatedAmount += tmpCompensatedAmount;
                    TotalCompensatedAmount += (tmpCompensatedAmount * clona.Cycles[maxCycleIndex].EdgesCount);
                    clona.CompensateCycle(maxCycleIndex);
                    clona.UpdateCycles();
                    //List<Cycle> orderedList2 = clona.Cycles.OrderByDescending(x => x.CycleCompensatedAmount).ToList();
                    //clona.ListCycles(orderedList2, "OrderedCycles2.txt");
                    //Console.WriteLine(String.Format("{0} - {3} - {1} - {2}\r\n", step, CompensatedAmount, TotalCompensatedAmount, tmpCompensatedAmount));
                    RunCompensation(exit, clona, step, CompensatedAmount, TotalCompensatedAmount, out CompensatedAmount, out TotalCompensatedAmount);
                }
            }
        }

        public static void GenerateRandomNodes(int _authenticatedUserId, string _connectionString)
        {
            SocietatiAsigurareRepository sar = new SocietatiAsigurareRepository(_authenticatedUserId, _connectionString);
            SocietateAsigurare[] sas = (SocietateAsigurare[])sar.GetAll().Result;
            Random r = new Random(10);
            Random r2 = new Random();
            foreach (SocietateAsigurare sa1 in sas)
            {
                int NR_DOSARE = r2.Next(0, 9);
                foreach(SocietateAsigurare sa2 in sas)
                {
                    if (sa1.ID != sa2.ID)
                    {
                        for (int i = 0; i < NR_DOSARE; i++)
                        {
                            Dosar d = new Dosar(_authenticatedUserId, _connectionString);
                            d.NR_DOSAR_CASCO = String.Format("AUTOGENERAT_{0}_{1}_{2}", sa1.ID, sa2.ID, i);
                            d.ID_ASIGURAT_CASCO = 1;
                            d.ID_ASIGURAT_RCA = 2;
                            d.ID_AUTO_CASCO = 1;
                            d.ID_AUTO_RCA = 2;
                            d.ID_SOCIETATE_CASCO = sa1.ID;
                            d.ID_SOCIETATE_RCA = sa2.ID;
                            d.NR_POLITA_CASCO = "TEST_POLITA_CASCO";
                            d.NR_POLITA_RCA = "TEST_POLITA_RCA";
                            d.REZERVA_DAUNA = d.SUMA_IBNR = d.VALOARE_DAUNA = d.VALOARE_REGRES = d.VMD = r.Next(10, 1000);
                            d.STATUS = "AVIZAT";
                            d.DATA_EVENIMENT = d.DATA_CREARE = d.DATA_ULTIMEI_MODIFICARI = DateTime.Now;
                            response rsp = d.Insert();
                        }
                    }
                }
            }
        }

        public static void TestCompensare(int _authenticatedUserId, string _connectionString)
        {
            Graph testGraph = new Graph(_authenticatedUserId, _connectionString);
            testGraph.GenerateNodesFromSocietati();
            testGraph.GenerateEdgesFromSocietati();
            testGraph.GenerateCycles();

            int step = 0;
            double CompensatedAmount = 0;
            double TotalCompensatedAmount = 0;
            Compensari.RunCompensation(false, testGraph, step, CompensatedAmount, TotalCompensatedAmount, out CompensatedAmount, out TotalCompensatedAmount);
        }
    }

    public class Node
    {
        public object Item { get; set; }

        public Node(object _object) // va fi practic ID-ul societatii
        {
            this.Item = _object;
        }
    }

    public class Edge
    {
        int authenticatedUserId { get; set; }
        string connectionString { get; set; }
        public Node Start { get; set; }
        public Node End { get; set; }
        public double Weight { get; set; }
        public double InitialWeight { get; set; }
        public List<int> IduriDosare = new List<int>();

        public Edge() { }

        public Edge(Node _start, Node _end, double _weight)
        {
            this.Start = _start;
            this.End = _end;
            this.Weight = _weight;
        }

        public Edge(int _authenticated_user_id, string _conStr, Node _start, Node _end)
        {
            authenticatedUserId = _authenticated_user_id;
            connectionString = _conStr;
            DataAccess da = new DataAccess(_authenticated_user_id, _conStr, CommandType.StoredProcedure, "COMPENSARIsp_GetBucketDosare", new object[] { new MySqlParameter("_ID_SOCIETATE_CASCO", _start.Item.ToString()), new MySqlParameter("_ID_SOCIETATE_RCA", _end.Item.ToString()), new MySqlParameter("_DATA", new DateTime()) });
            MySqlDataReader r = da.ExecuteSelectQuery();
            double sum = 0;
            List<int> iduriDosare = new List<int>();
            while (r.Read())
            {
                IDataRecord item = (IDataRecord)r;
                int ID_DOSAR = Convert.ToInt32(item["ID_DOSAR"]);
                iduriDosare.Add(ID_DOSAR);
                sum += Convert.ToDouble(item["SUMA"]);
            }
            this.Start = _start;
            this.End = _end;
            this.InitialWeight = this.Weight = sum;
            this.IduriDosare = new List<int>(iduriDosare);
            r.Close(); r.Dispose(); da.CloseConnection();
        }
    }

    public class Cycle
    {
        public List<Edge> Edges = new List<Edge>();
        public double CycleWeight = 0;
        public double CycleMin = 0;
        public double CycleMax = 0;
        public double CycleAverage = 0;
        public double CycleCompensatedAmount = 0;
        public int EdgesCount = 0;

        public Cycle() { }

        public Cycle(List<Edge> _edges)
        {
            this.Edges = new List<Edge>(_edges);
            UpdateCycle();
        }

        public void UpdateCycle()
        {
            UpdateCycle(this);
        }

        public void UpdateCycle(Cycle c)
        {
            double sum = 0;
            double min = c.Edges[0].Weight;
            double max = c.Edges[0].Weight;
            foreach (Edge e in c.Edges)
            {
                sum += e.Weight;
                min = e.Weight < min ? e.Weight : min;
                max = e.Weight > max ? e.Weight : max;
            }
            c.EdgesCount = c.Edges.Count;
            c.CycleWeight = sum;
            c.CycleMin = min;
            c.CycleMax = max;
            c.CycleAverage = sum / c.EdgesCount;
            c.CycleCompensatedAmount = min * c.EdgesCount;
        }
    }

    public class Graph : IDisposable
    {
        int authenticatedUserId { get; set; }
        string connectionString { get; set; }
        public List<Node> Nodes = new List<Node>();
        public List<Edge> Edges = new List<Edge>();
        public List<Cycle> Cycles = new List<Cycle>();
        public int NodesCount { get; set; }

        public Graph() { }

        public Graph(int _nodes) // pt. test
        {
            this.NodesCount = _nodes;

            GenerateNodes();

            GenerateEdges();

            GenerateCycles();

            //SaveToFile("Test2");

            //UpdateCycles();
            /*
            List<Cycle> orderedList = this.Cycles.OrderByDescending(x => x.CycleCompensatedAmount).ToList();
            ListCycles(orderedList);
            */
        }

        public Graph(int _authenticatedUserId, string _connectionString)
        {
            authenticatedUserId = _authenticatedUserId;
            connectionString = _connectionString;
        }

        public void SaveToFile(string _name)
        {
            using (System.IO.StreamWriter file = new System.IO.StreamWriter(_name))
            {
                string nodes = "";
                foreach (Node n in this.Nodes)
                {
                    nodes += (n.Item.ToString() + (this.Nodes.IndexOf(n) == this.Nodes.Count - 1 ? "" : ";"));
                }
                file.Write("Nodes:" + nodes + "&");

                string edges = "";
                foreach (Edge e in this.Edges)
                {
                    edges += (String.Format("({0},{1},{2}){3}", e.Start.Item.ToString(), e.End.Item.ToString(), e.Weight.ToString(), this.Edges.IndexOf(e) == this.Edges.Count - 1 ? "" : ";"));
                }
                file.Write("Edges:" + edges + "&");

                string cycles = "";
                foreach (Cycle c in this.Cycles)
                {
                    string cycle = "";
                    foreach (Edge e in c.Edges)
                    {
                        cycle += ("(" + e.Start.Item.ToString() + "," + e.End.Item.ToString() + "," + e.Weight.ToString() + ")" + (c.Edges.IndexOf(e) == c.Edges.Count - 1 ? "" : ";"));
                    }
                    cycles += cycle + (this.Cycles.IndexOf(c) == this.Cycles.Count - 1 ? "" : "|");
                }
                file.Write("Cycles:" + cycles);
            }
        }

        public void LoadFromFile(string _name, bool _loadCycles)
        {
            using (System.IO.StreamReader file = new System.IO.StreamReader(_name))
            {
                string graph = file.ReadToEnd();
                string[] graphItems = graph.Split('&');
                string[] nodes = graphItems[0].Replace("Nodes:", "").Split(';');
                string[] edges = graphItems[1].Replace("Edges:", "").Split(';');
                string[] cycles = graphItems[2].Replace("Cycles", "").Split('|');
                for (int i = 0; i < nodes.Length; i++)
                {
                    this.Nodes.Add(new Node(nodes[i]));
                }
                this.NodesCount = this.Nodes.Count;
                for (int i = 0; i < edges.Length; i++)
                {
                    string[] edge = edges[i].Replace("(", "").Replace(")", "").Split(',');
                    //Edge e = new Edge(new Node(edge[0]), new Node(edge[1]), Convert.ToDouble(edge[2]));
                    Edge e = new Edge(this.Nodes[this.FindNode(edge[0])], this.Nodes[this.FindNode(edge[1])], Convert.ToDouble(edge[2]));
                    this.Edges.Add(e);
                }
                if (_loadCycles)
                {
                    for (int i = 0; i < cycles.Length; i++)
                    {
                        string[] cycle = cycles[i].Split(';');
                        Cycle c = new Cycle();
                        for (int j = 0; j < cycle.Length; j++)
                        {
                            string[] edge = cycle[j].Replace("(", "").Replace(")", "").Split(',');
                            //Edge e1 = new Edge(new Node(edge[0]), new Node(edge[1]), Convert.ToDouble(edge[2]));
                            //c.Edges.Add(e1);
                            c.Edges.Add(this.Edges[this.FindEdge(edge)]);
                        }
                        this.Cycles.Add(c);
                    }
                }
                else
                {
                    this.GenerateCycles();
                }
            }
        }

        private int FindNode(string _node)
        {
            for (int i = 0; i < this.Nodes.Count; i++)
            {
                if (this.Nodes[i].Item.ToString() == _node)
                    return i;
            }
            return 0;
        }

        private int FindEdge(string[] _edge)
        {
            for (int i = 0; i < this.Edges.Count; i++)
            {
                if (this.Edges[i].Start.Item.ToString() == _edge[0] && this.Edges[i].End.Item.ToString() == _edge[1] && Convert.ToDouble(this.Edges[i].Weight) == Convert.ToDouble(_edge[2]))
                    return i;
            }
            return 0;
        }

        public Graph Clone()
        {
            Graph clona = new Graph();
            clona.Nodes = new List<Node>(this.Nodes);
            clona.Edges = new List<Edge>(this.Edges);
            clona.Cycles = new List<Cycle>(this.Cycles);
            clona.NodesCount = this.NodesCount;
            return clona;
        }
        /*
        public void CompensateCycle(Cycle c)
        {
            foreach(Edge e in c.Edges)
            {
                e.Weight -= c.CycleMin;
            }
        }
        
        public Cycle GetMaxCycleByCompensatedAmount()
        {
            Cycle toReturn = this.Cycles[0];
            for(int i = 0; i < this.Cycles.Count; i++)
            {
                if (this.Cycles[i].CycleCompensatedAmount > toReturn.CycleCompensatedAmount)
                {
                    toReturn = this.Cycles[i];
                }
            }
            return toReturn;
        }
        */

        public void CompensateCycle(int cycleIndex)
        {

            foreach (Edge e in this.Cycles[cycleIndex].Edges)
            {
                e.Weight -= this.Cycles[cycleIndex].CycleMin;
            }
            //this.Cycles[cycleIndex].UpdateCycle(); // actualizam ciclul pt. iteratiile urmatoare
        }

        public int GetMaxCycleByCompensatedAmount()
        {
            int toReturn = 0;
            for (int i = 0; i < this.Cycles.Count; i++)
            {
                if (this.Cycles[i].CycleCompensatedAmount > this.Cycles[toReturn].CycleCompensatedAmount)
                {
                    toReturn = i;
                }
            }
            return toReturn;
        }

        public void ListNodes()
        {
            for (int i = 0; i < this.Nodes.Count; i++)
            {
                Console.Write(this.Nodes[i].Item + (i < this.Nodes.Count - 1 ? ", " : ""));
            }
        }

        public void GenerateNodes()
        {
            for (int i = 0; i < this.NodesCount; i++)
            {
                this.Nodes.Add(new Node("N" + (i + 1).ToString()));
            }
        }

        public void GenerateEdges()
        {
            Random r = new Random();
            foreach (Node nStart in this.Nodes)
            {
                foreach (Node nEnd in Nodes)
                {
                    if (nStart != nEnd)
                    {
                        int _weight = r.Next(0, 500);
                        Edge e = new Edge(nStart, nEnd, _weight);
                        this.Edges.Add(e);
                        //Console.WriteLine("{ " + nStart.Item.ToString() + ", " + nEnd.Item.ToString() + ", " + _weight.ToString() + " }");
                    }
                }
            }
        }

        public void GenerateNodesFromSocietati()
        {
            SocietatiAsigurareRepository sar = new SocietatiAsigurareRepository(authenticatedUserId, connectionString);
            SocietateAsigurare[] sas = (SocietateAsigurare[])sar.GetAll().Result;
            foreach (SocietateAsigurare sa1 in sas)
            {
                Node n = new Node(sa1.ID);
                this.Nodes.Add(n);
            }
        }

        public void GenerateEdgesFromSocietati()
        {
            SocietatiAsigurareRepository sar = new SocietatiAsigurareRepository(authenticatedUserId, connectionString);
            SocietateAsigurare[] sas = (SocietateAsigurare[])sar.GetAll().Result;
            foreach(SocietateAsigurare sa1 in sas)
            {
                List<Edge> tempEdgesList = new List<Edge>(); // cream o lista temporara de edgeuri ca sa vedem mai intai daca nu sunt toate 0
                bool nonZeroEdge = false;
                foreach(SocietateAsigurare sa2 in sas)
                {
                    if(sa1.ID != sa2.ID)
                    {
                        //Node start = new Node(sa1.ID);
                        Node start = this.Nodes[this.FindNode(sa1.ID.ToString())];
                        //Node end = new Node(sa2.ID);
                        Node end = this.Nodes[this.FindNode(sa2.ID.ToString())];
                        Edge e = new Edge(authenticatedUserId, connectionString, start, end);
                        tempEdgesList.Add(e);
                        if (e.Weight > 0)
                            nonZeroEdge = true;
                    }
                }
                if (nonZeroEdge) // adaugam Edge-urile care incep cu "start" doar daca nu sunt toate 0
                {
                    foreach(Edge e in tempEdgesList)
                    {
                        this.Edges.Add(e); // sa vedem daca nu trebuie copy
                    }
                }
            }        
        }

        public void ListEdges()
        {
            for (int i = 0; i < this.Edges.Count; i++)
            {
                Console.WriteLine("(" + this.Edges[i].Start.Item.ToString() + ", " + this.Edges[i].End.Item.ToString() + ", " + this.Edges[i].Weight.ToString() + ")" + (i < this.Edges.Count - 1 ? ", " : ""));
            }
        }

        public void GenerateCycles()
        {
            //int counter = 0;
            foreach (Edge e in this.Edges)
            {
                //Console.WriteLine((counter + 1).ToString() + " --- { " + e.Start.Item + ", " + e.End.Item + " }");
                FindCycles(new Cycle(new List<Edge>() { e }));
                //counter++;
            }
            this.UpdateCycles();
        }

        public void UpdateCycles()
        {
            foreach (Cycle c in this.Cycles)
            {
                c.UpdateCycle();
            }
        }

        public void ListCycles(string path)
        {
            ListCycles(this.Cycles, path);
        }

        public void ListCycles(List<Cycle> _cycles, string path)
        {
            using (System.IO.StreamWriter file = new System.IO.StreamWriter(path))
            {
                int counter = 0;
                foreach (Cycle c in _cycles)
                {
                    //c.UpdayeCycle();

                    //Console.WriteLine((counter + 1).ToString() + ". edges: " + c.EdgesCount + " sum: " + c.CycleWeight + ", min: " + c.CycleMin + ", max: " + c.CycleMax + "  |  ");
                    file.WriteLine((counter + 1).ToString() + ". edges: " + c.EdgesCount + " sum: " + c.CycleWeight + ", min: " + c.CycleMin + ", max: " + c.CycleMax + "  |  ");
                    foreach (Edge e in c.Edges)
                    {
                        //Console.Write("(" + e.Start.Item + ", " + e.End.Item + ", " + e.Weight + ")" + (c.Edges.IndexOf(e) == c.Edges.Count - 1 ? "" : " -> "));
                        file.Write("(" + e.Start.Item + ", " + e.End.Item + ", " + e.Weight + ")" + (c.Edges.IndexOf(e) == c.Edges.Count - 1 ? "" : " -> "));
                    }
                    //Console.WriteLine("\r\n-------------------------------------\r\n");
                    file.WriteLine("\r\n-------------------------------------\r\n");
                    counter++;
                }
            }
        }

        private void FindCycles(Cycle path)
        {
            //foreach (Edge e in this.Edges)
            List<Edge> nextPossibleEdges = GetNextEdges(path.Edges[path.Edges.Count - 1].End);
            foreach (Edge e in nextPossibleEdges)
            {
                //if (e != path.Edges[path.Edges.Count - 1]) // sa nu luam si edge-ul initial
                {
                    //if (e.Start == path.Edges[path.Edges.Count - 1].End)
                    {
                        if (path.Edges.IndexOf(e) < 0) // edge-ul nu exista deja in path (nu a mai fost "vizitat")
                        {
                            List<Edge> temporaryPathEdges = new List<Edge>(path.Edges);
                            temporaryPathEdges.Add(e);
                            Cycle temporaryPath = new Cycle(temporaryPathEdges);

                            //temporaryPath.Edges.Add(e);

                            if (e.End == temporaryPath.Edges[0].Start) // capat - path (ciclu) valid complet
                            {
                                //if (this.Cycles.IndexOf(temporaryPath) < 0) // nu avem deja ciclul in lista; TO DO: de verificat si celelate combinatii de edge-uri, mai putin cel curent
                                if (!CycleExists(temporaryPath))
                                {
                                    Cycles.Add(temporaryPath);
                                }
                                //break;
                            }
                            else
                            {
                                //List<Edge> incompletePathEdges = new List<Edge>(path.Edges);
                                //Cycle incompletePath = new Cycle(incompletePathEdges, 0);
                                //FindCycles(incompletePath);
                                FindCycles(temporaryPath);
                            }
                        }
                    }
                }
            }
        }

        private bool CycleExists(Cycle cycle)
        {
            bool toReturn = false;
            if (this.Cycles.IndexOf(cycle) > -1) { toReturn = true; }
            else
            {
                foreach (Cycle c in this.Cycles)
                {
                    if (c.Edges.Count == cycle.Edges.Count && !CompareEdges(c.Edges[0], cycle.Edges[0])) // sa nu luam si ciclul cautat, desi n-ar trebui sa se ajunga aici de la IndexOf de mai sus
                    {
                        bool cycleExists = true;
                        foreach (Edge e1 in cycle.Edges)
                        {
                            bool edgeExists = false; // daca gasim un nod care nu exista, ciclul cautat nu e identic cu cel curent si putem trece la urmatorul.
                            foreach (Edge e2 in c.Edges)
                            {
                                if (CompareEdges(e1, e2))
                                {
                                    edgeExists = true;
                                    break;
                                }
                            }
                            if (!edgeExists)
                            {
                                cycleExists = false;
                                break;
                            }
                        }
                        if (cycleExists) // daca am gasit un ciclu care are toate edge-urile ciclului cautat, nu e valid.
                        {
                            toReturn = true;
                            break;
                        }
                    }
                }
            }
            return toReturn;
        }

        private bool CompareEdges(Edge e1, Edge e2)
        {
            return (e1.Start.Item.ToString() == e2.Start.Item.ToString() && e1.End.Item.ToString() == e2.End.Item.ToString() && e1.Weight == e2.Weight);
        }

        private List<Edge> GetNextEdges(Node endNode)
        {
            List<Edge> tmp = new List<Edge>();
            foreach (Edge tmpEdge in this.Edges)
            {
                if (endNode == tmpEdge.Start)
                {
                    tmp.Add(tmpEdge);
                }
            }
            return tmp;
        }

        public void UpdateDosareAfterCompensare()
        {
            foreach(Edge e in this.Edges)
            {
                if(e.Weight == 0)
                {
                    foreach(int id_dosar in e.IduriDosare)
                    {
                        //update compensare si status dosar = "compensat"
                        Dosar d = new Dosar(authenticatedUserId, connectionString, id_dosar);
                        Compensare compensare = new Compensare(authenticatedUserId, connectionString);
                        compensare.ID_DOSAR = id_dosar;
                        compensare.DATA = DateTime.Now.Date;
                        compensare.SUMA = d.VALOARE_REGRES;
                        compensare.REST = 0;
                        response r = compensare.Insert();
                        if (r.Status)
                        {
                            d.ChangeStatus("COMPENSAT");
                        }
                    }
                }
                else
                {
                    double sum = 0;
                    foreach(int id_dosar in e.IduriDosare)
                    {
                        Dosar d = new Dosar(authenticatedUserId, connectionString, id_dosar);
                        sum += Convert.ToDouble(d.VALOARE_REGRES);
                       Compensare compensare = new Compensare(authenticatedUserId, connectionString);
                        compensare.ID_DOSAR = id_dosar;
                        compensare.DATA = DateTime.Now.Date;
                        string _status = "";
                        if (e.InitialWeight - sum > e.Weight)
                        {
                            //update compensare si status dosar = "compensat"
                            compensare.SUMA = d.VALOARE_REGRES;
                            compensare.REST = 0;
                            _status = "COMPENSAT";
                        }
                        else
                        {
                            //update compensare cu rest si status dosar = "compensat partial" - TO DO
                            compensare.SUMA = e.InitialWeight - (sum - d.VALOARE_REGRES);
                            compensare.REST = d.VALOARE_REGRES - compensare.SUMA;
                            _status = "COMPENSAT_PARTIAL";
                        }
                        response r = compensare.Insert();
                        if (r.Status)
                        {
                            d.ChangeStatus(_status);
                        }
                    }
                }
            }
        }

        #region IDisposable Support
        private bool disposedValue = false; // To detect redundant calls

        protected virtual void Dispose(bool disposing)
        {
            if (!disposedValue)
            {
                if (disposing)
                {
                    // TODO: dispose managed state (managed objects).
                    this.Nodes = null;
                    this.Edges = null;
                    this.Cycles = null;
                    this.NodesCount = 0;
                }

                // TODO: free unmanaged resources (unmanaged objects) and override a finalizer below.
                // TODO: set large fields to null.

                disposedValue = true;
            }
        }

        // TODO: override a finalizer only if Dispose(bool disposing) above has code to free unmanaged resources.
        // ~Graph() {
        //   // Do not change this code. Put cleanup code in Dispose(bool disposing) above.
        //   Dispose(false);
        // }

        // This code added to correctly implement the disposable pattern.
        public void Dispose()
        {
            // Do not change this code. Put cleanup code in Dispose(bool disposing) above.
            Dispose(true);
            // TODO: uncomment the following line if the finalizer is overridden above.
            // GC.SuppressFinalize(this);
        }
        #endregion


    }

}