using System;
using System.Text.RegularExpressions;
using System.Collections.Generic;


namespace Spaces
{
    class MainClass
    {
        public static void Main(string[] args)
        {

            // 2.4.2019 - 4.4.2019



            /*
1 - Zadat String, počítat mezery 2 jako 1)
2 - rozmístit mezery rovnoměrně
3 - 

            */

            RegexOptions options = RegexOptions.None;
            Regex regex = new Regex("[ ]{2,}", options);



              string str = "F JE  TU";

           // string str = "TU TU    TU";

           
            List<int> tryout = new List<int>();


            List<char> charList = new List<char>();



            int desired = 17;
            int count = 0;

            if (desired >= str.Length){
                //Console.WriteLine("Length is bigger than " + desired + " str.len " + str.Length);

                string copy = str;
 

                // 1 - počítání 2 mezer jako 1
                var t = regex.Replace(str, " ");

                for (var i = 0; i < t.Length; i++) {
                    if (t[i].ToString() == " ") {
                        tryout.Add(i);
                        count += 1;
                    }
                }


              /* 
                Console.WriteLine("STR is " + str);
                Console.WriteLine("Number of spaces is " + count);
                Console.WriteLine(desired - count + " spaces " + " need to be added.");
*/

                // 2 adding spaces to desired length

                int rem = desired;

                char[] warr = str.ToCharArray();




                for (var i = 0; i < warr.Length; i++){
                    charList.Add(warr[i]);
                }
                    
                string[] real = new string[str.Length];

                Console.WriteLine("charlist.count BEF " + charList.Count);



                Console.WriteLine("" + desired / count + " spaces need to be added to String");





                for (var i = 0; i < charList.Count; i++){
                    char space = '0';
                    if (tryout.Contains(i)){
                        Console.WriteLine("D " + desired / count);
                        for (var n = 0; n < (desired / count); n++){
                            space += '0';
                            charList.Insert(i, space);
                          //  Console.WriteLine("---- " + i);
                           // Console.WriteLine("Addign X at " + n);
                        }
                       // Console.WriteLine("II " + i);

                       // charList.Insert(i, Convert.ToChar(space));




                      
                    }
                    // Console.WriteLine("i + " + i);
                }


                Console.WriteLine("charlist.count  " + charList.Count);



                for (var i = 0; i < charList.Count; i++)
                {
                  //  Console.WriteLine("PO " + charList[i]);
                
                }


                Console.WriteLine("Počateční " + str);


                for (var i = 0; i < charList.Count; i++)
                {
                    Console.Write(charList[i]);

                }






                // Add "desired / count"







                /* for (var i = 0; i < tryout.Count; i++) {
                    Console.WriteLine("Index of space is " + tryout[i]);

                    if (rem != 0)
                    {
                        rem -= 1;

                        var sp = Convert.ToChar(" ");
                        char space = sp;
                        warr[i] += space;

                    }
                }*/


                // bool carryOn = true;





                /*
                string tr = "";

                for (var i = 0; i < warr.Length; i++)
                {
                    Console.WriteLine("S " + warr[i]);
                    tr += warr[i];
                }

                Console.WriteLine("TR ");
                Console.WriteLine(tr);
*/


                /*
                string tr = "";

                for (var i = 0; i < warr.Length; i++)
                {
                    Console.WriteLine("S " + warr[i]);
                    tr += warr[i];
                }

                Console.WriteLine("TR ");
                Console.WriteLine(tr);
*/




               

                /*
Count 

                */


              



            } else {
                Console.WriteLine("Desired length is smaller than initial.");
            }






            // metoda do kt. dáme řetězec, on vrátí počet mezsilovních mezer.



            /* požadované délka je větší než současná 8 10
             pokud ano, spočítat mezislovní mezery (3 za sebou jako jedna)
            doplnit mezislovní mezery, aby délka byla stejná (jako 1 znak)
            */
        }
    }
}
