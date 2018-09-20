// 26.4.2018

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace test
{
    class Program
    {
        static void Main(string[] args)
        {

/*nefunguje mi zadávání lodí přes 2 pole, lze zadat jen jako souřadnici x, y
 vyhodnocení funguje jako porovnání souřadnic požadových střel a zásahů */


            int x, y, r, s, pom;
            double sum, avg, percent;

            x = 3;
            y = 3;
            r = 0;
            s = 0;
            sum = 0;
            percent = 0;
            int success = 0;
            int fail = 0;


            int[,] arr = new int[y, x];

            Console.WriteLine("Zadejte pozice vašich lodí v pořadí x, y");

            for (r = 0; r < x; r++)
            {
                for (s = 0; s < y; s++)
                {
                    arr[s, r] = int.Parse(Console.ReadLine());
                }
            }

            for (r = 0; r < x; r++)
            {
                for (s = 0; s < y; s++)
                {
                    Console.Write(arr[s, r]);
                }
                Console.WriteLine();
            }


            Console.WriteLine("Kam chcete vystřelit ? Zadejte všechny souřadnice na které chcete vystřelit");
            int[,] shot = new int[y, x];
            for (r = 0; r < x; r++)
            {
                for (s = 0; s < y; s++)
                {
                    shot[s, r] = int.Parse(Console.ReadLine());
                }
            }

          





            // zkontrolovat výhru
            for (r = 0; r < x; r++)
             {
                 for (s = 0; s < y; s++)
                 {
                     if (arr[s, r] == shot[s, r])
                     {
                         Console.Write(" Zásah na souřadnici " + arr[s, r]);
                        success += 1;
                     } else
                    {
                        Console.Write("Mimo :)");
                        fail += 1;
                    }

                     if (success > fail)
                    {
                        percent = (fail / success) * 100;
                    }
                    else
                    {
                        percent = (success / fail) * 100;
                    }
                }
                 Console.WriteLine();
             }



            Console.WriteLine("Výpis:");
            Console.WriteLine("Zasáhli jste " + success + " minuli jste " + fail + " zasáhli jste " + percent + " lodí" + " minuli jste " + (100 - percent) + " % lodí");

            Console.ReadKey();


        }
    }
}
