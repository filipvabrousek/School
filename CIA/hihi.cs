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



            char[] alpha = "ABCDEFGHIJKLMNOPQRSTUVWXYZ-".ToCharArray();


            // string str = "F JE     TU           X";
            Console.WriteLine("Zadejte řetězec.");
           // string str = Console.ReadLine();
            string str = "F JE  TU";


           // string oldstr = "F JE  TU";
           // string str = "TU TU    TU";

           
            List<int> tryout = new List<int>();


            List<char> charList = new List<char>();



            int desired = 50;
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








                var w = tryout[0] + desired / 2;
                Console.WriteLine("W" + w);

                var icc = 0;

                for (var i = tryout[0]; i < desired / 2; i++)
                {
                    icc += 1;
                    charList.Insert(i, '-');
                
                }


                for (var i = tryout[1] + icc; i < desired; i++)
                {
                    charList.Insert(i, '-');

                }


                /*

                var begin = desired / count;

                var end = charList.Count;

                var inc = 0;

                for (var i = 0; i < charList.Count; i++){
          
                    if (tryout.Contains(i)){
                        Console.WriteLine("D " + desired / count);
                        for (var n = tryout[0]; n < (tryout[1]); n++){
                            // inc += 1;

                            var e = desired / 2;


                            charList.Insert(n, '-');
                         
                        }



                      
                    }
                   
                }



                Console.WriteLine("TR " + tryout[1]);

                for (var n = tryout[1] + inc; n < desired; n++)
                {
                    // Console.WriteLine("NOW " + (tryout[1] + 1) + "END" + end);
                    if (n < desired)
                    {
                       // Console.WriteLine("Insert at " + n);
                        //space += '0';
                        charList.Insert(n, '-');
                    }


                }

                Console.WriteLine("charlist.count  " + charList.Count);

                */

                for (var i = 0; i < tryout.Count; i++)
                {
                    Console.WriteLine("Index " + tryout[i]);
                  //  Console.WriteLine("PO " + charList[i]);
                
                }


                Console.WriteLine("Počateční " + str);


                for (var i = 0; i < charList.Count; i++)
                {
                   // Console.WriteLine("CHI " + charList[i]);
                    if (Array.IndexOf(alpha, charList[i]) != -1 ){
                        Console.Write(charList[i]);
                    }
                   

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
