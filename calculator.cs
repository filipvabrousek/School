using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace calculator
{
    class Program
    {
        static void Main(string[] args)
        {
           

            try
            {
                Console.WriteLine("Zadejte číslo a");
                double a = double.Parse(Console.ReadLine());
                Console.WriteLine("Zadejte číslo b");
                double b = double.Parse(Console.ReadLine());
                int powerTo = 0;


                Console.WriteLine("1 - odčítání");
                Console.WriteLine("2 - odčítání");
                Console.WriteLine("3 - násobení");
                Console.WriteLine("4 - dělení");
                Console.WriteLine("5 - odmocnina čísla a");
                Console.WriteLine("6 - x. mocnina čísla a");
              

                int option = int.Parse(Console.ReadLine()); // option je volba
                double result = 0; // result je výsledek


                if (option == 1)
                {
                    result = a + b;
                }
                else
                if (option == 2)
                {
                    result = a - b;
                }
                else
                if (option == 3)
                {
                    result = a * b;
                }
                else if (option == 4)
                {
                    result = a / b;
                }
                else if (option == 5)
                {
                    result = Math.Sqrt(a);
                }
                else if (option == 6)
                {
                    result = Math.Pow(a, 2);
                }
                else if (option == 7)
                {
                    if (powerTo != 0)
                    {
                        powerTo = int.Parse(Console.ReadLine());
                        result = Math.Pow(a, powerTo);
                    }
                   
                }

               


                if ((option > 0) && (option < 7))
                {
                    Console.WriteLine("Výsledek: " + result);
                }
                else
                {
                    Console.WriteLine("Neplatná volba");
                }
            } catch(OverflowException)
            {
                Console.WriteLine("Číslo je moc veliké");
            }


            Console.WriteLine("Program ukončíte stisknutím libovolné klávesy");
            Console.ReadKey();
        }
    }
}
