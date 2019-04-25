using System;
using System;
using System.Text.RegularExpressions;
using System.Collections.Generic;
using System.Linq;


namespace FinalSpaces
{
    class MainClass
    {
        public static void Main(string[] args)
        {
            Console.WriteLine("zadejte řetězec.");
            string rt = Console.ReadLine();

            Console.WriteLine("Na jakou délku chete prodloužit řetězec?");
            int desired = int.Parse(Console.ReadLine());


            //  var rt = "AA   BB  CC";
            //var rt = "F      JE   TU";
            // var rt = "FJ      JE   TU   IN";


            List<List<int>> gross = new List<List<int>>();
            // List<int> sub = new List<int>();
            List<int> pos = new List<int>();
            List<int> spacecount = new List<int>();

            string final = "";

            if (desired <= rt.Length)
            {
                final = "STRING IS TOO SHORT";
            }

            var conv = "";

            // var str = rt.ToCharArray();

            List<char> prestr = new List<char>();
            for (var i = 0; i < rt.Length; i++)
            {
                prestr.Add(rt[i]);
            }



            for (var i = 0; i < prestr.Count; i++)
            {
                var r = prestr[i];

                if (r == ' ')
                {

                    conv += '#';
                }
                else
                {
                    conv += "" + r + "";
                }
            }

            //   Console.WriteLine("CONV " + conv);

            // 46

            var we = conv.ToCharArray();
            List<string> move = new List<string>();

            for (var i = 0; i < conv.Length; i++)
            {
                //string c = String.valueOf(prestr[i]);
                move.Add(conv[i].ToString());


            }

            string e = "";


            for (var i = 0; i < move.Count; i++)
            {
                // Console.WriteLine("Element of move " + move[i]);
            }

            for (var i = 0; i < move.Count; i++)
            {
                string s = move[i];

                if (s == "#")
                {
                    e += "#";
                    // Console.WriteLine("X is at " + i);
                }
                else
                {
                    e += "-";
                    //  Console.WriteLine("-");

                }
            }

            //  Console.WriteLine("ELE");
            //  Console.WriteLine(e);



            var fe = e.ToCharArray();
            for (var i = 0; i < fe.Length; i++)
            {
                // Console.WriteLine("Control " + fe[i]);
            }


            List<int> fiedl = new List<int>();

            for (var i = 0; i < fe.Length - 1; i++)
            {
                string s = fe[i].ToString();
                string inc = fe[i + 1].ToString();

                if (s == "#" && inc == "-")
                {
                    fiedl.Add(i + 1);
                }

            }


            List<int> sub = new List<int>();
            for (var i = 0; i < move.Count; i++)
            {
                string w = move[i];

                if (w == "#")
                {
                    sub.Add(i);
                }
                else
                {
                    if (sub.Count > 0)
                    {
                        gross.Add(sub);
                        sub.Clear();
                    }
                }
            }


            double ci = 0.0;


            List<int> sf = new List<int>();

            for (var i = 0; i < gross.Count; i++)
            {
                var el = gross[i];
                sf.Add(Math.Abs(el.Count - desired / gross.Count));
                ci += el.Count;
            }


            var csi = Convert.ToDouble(ci);
            var gro = Convert.ToDouble(gross.Count);

            double ro = Math.Round(csi / gro);





            for (var i = 0; i < fiedl.Count; i++)
            {
                var str = sf[i].ToString();
                move.Insert(fiedl[i], str);
            }











            //  Console.WriteLine("MC " + move.Count);

            for (var i = 0; i < move.Count; i++)
            {
                var el = move[i];
                var res = "";

                int mint = 0;

                if (int.TryParse(el, out mint))
                {

                    if (mint == 0)
                    {
                        move.RemoveAt(i);
                        move.Insert(i, "#");
                    }


                    for (var x = 0; x < mint; x++)
                    {
                        res += "#";
                        // Console.WriteLine("HIHI " + i);
                        move.RemoveAt(i);
                        move.Insert(i, res);

                    }
                }



            }



            string save = "";

            for (var i = 0; i < move.Count; i++)
            {
                save += move[i];
            }

            // Console.WriteLine("7 " + save);
            // 66


            List<string> chrr = new List<string>();

            for (var i = 0; i < move.Count; i++)
            {
                //string c = String.valueOf(prestr[i]);
                chrr.Add(move[i]);


            }


            var pres = "";


            for (var i = 0; i < chrr.Count; i++)
            {
                if (chrr[i] == "#")
                {
                    pres += " ";

                }
                else
                {
                    pres += chrr[i];
                }
            }

            // Console.WriteLine("P is " + pres);


            var arr = pres.ToCharArray();

            var er = "";
            for (var i = 0; i < arr.Length; i++)
            {
                if (arr[i] == '#')
                {
                    er += " ";
                }
                else
                {
                    er += arr[i];
                }
            }

            Console.WriteLine("Výsledek:" + er);



            // Console.WriteLine("Hello World!");
        }
    }
}
