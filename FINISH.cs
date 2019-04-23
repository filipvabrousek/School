using System;
using System.Collections.Generic;
using System.Linq;

namespace countSpace
{
    class MainClass
    {




        public static void Main(string[] args)
        {
            List<int> tryout = new List<int>();

            List<string> already = new List<string>();
            char[] alpha = "ABCDEFGHIJKLMNOPQRSTUVWXYZ-".ToCharArray();

            // 1. index mezery + jak je dlouhá


            List<string> data = new List<string>();


            // var str = "F  JE     TU";
            var str = "F  JE         TU";
            var arr = str.ToCharArray();

            var desired = 12;
            // Console.WriteLine("Hello World!");


            var e = -1;
            for (var sofi = 0; sofi < arr.Length; sofi++)
            {
                if (Array.IndexOf(alpha, arr[sofi]) == -1)
                {
                    e += 1;
                    data.Add("" + sofi + "");
                   // Console.WriteLine("Space " + sofi);
                }
                else
                {
                    data.Add("X");
                }
            }

            Console.WriteLine("");

            var c = 0;
            List<int> ints = new List<int>();



            foreach (var x in data) {
                Console.WriteLine("->  " + x);
            }

            for (var s = 0; s < data.Count; s++)
            {

                var el = data[s];

                if (el != "X") {
                    c += 1;
                } else {
                    if (c != 0) {
                        ints.Add(c);
                        // var str = "F  JE         TU";

                        Console.WriteLine("The space starts at " + s + "and its length is" + c);
                        c = 0;
                    }


                }

              
               
            }

           

        }
    }
}
