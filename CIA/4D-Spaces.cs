using System;

namespace Spaces
{
    class MainClass
    {
        public static void Main(string[] args)
        {

            // 2.4.2019

            string str = "F JE TU";
            int desired = 10;
            var spaceIndexes = []

            Console.WriteLine(str);

            if (desired >= str.Length){
                Console.WriteLine("Length is bigger than " + desired + " str.len " + str.Length);

                string copy = str;
                int count = 0;

                for (var i = 0; i < str.Length; i++) {
                    if (str[i].ToString() == " ") {
                        count += 1;
                    }

                    if (str[i].ToString() != " "){
                        Console.WriteLine("Mezera není ");

                    }
                }


                for (var i = 0; i < str.Length - 1; i++) { 
                    if (i != 0) {


                        if (str[i].ToString() == " " && str[i + 1].ToString() != " "){
                            Console.WriteLine("Index of space is " + i);

                           // spaceIndexes.append
                        }
                        
                        
                    }



                }


                for (var i = 0; i < spaceIndexes.Length - 1; i++){
                    
                }


                Console.WriteLine("Number of spaces is " + count);
                Console.WriteLine(desired - count + " spaces " + " need to be added.");



            } else {
                Console.WriteLine("Desired length is smaller than initial.");
            }



            // metoda do kt. dáme řetězec, on vrátí počet mezsilovních mezer.



            /* požadované délka je větší než současná
             pokud ano, spočítat mezislovní mezery (3 za sebou jako jedna)
            doplnit mezislovní mezery, aby délka byla stejná (jako 1 znak)
            */
        }
    }
}
