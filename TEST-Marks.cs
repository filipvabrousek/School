using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConsoleApp8
{
    class Program
    {
        static void Main(string[] args)
        {
            int radek, sloupec, r, s, pom;
            double soucet, prumer;

            radek = 5;
            sloupec = 5;
            r = 0;
            s = 0;
            soucet = 0;

            int[,] pole = new int[sloupec, radek];

            Console.WriteLine("Ahoj :)");
            Console.WriteLine("Jsem program.");
            Console.WriteLine("Vypocitam tvuj prumer znamek.");

            for (r = 0; r < radek; r++)
            {
                for (s = 0; s < sloupec; s++)
                {
                    pole[s, r] = int.Parse(Console.ReadLine());
                }
            }

            for (r = 0; r < radek; r++)
            {
                for (s = 0; s < sloupec; s++)
                {
                    Console.Write(pole[s, r]);
                }
                Console.WriteLine();
            }


            Console.WriteLine("Zadej znamky z predmetu v tomhle poradi: matematika, cesky jazyk, anglicky jazyk, fyzika, grafika.");

            Console.WriteLine("Matematika:");
            for (s = 0; s < sloupec; s++)
            {
                pom = pole[s, 0];
                soucet = soucet + pom;
            }
            prumer = soucet / sloupec;
            Console.WriteLine(prumer);
            prumer = 0;
            soucet = 0;
            pom = 0;

            Console.WriteLine("Cesky jazyk:");
            for (s = 0; s < sloupec; s++)
            {
                pom = pole[s, 1];
                soucet = soucet + pom;
            }
            prumer = soucet / sloupec;
            Console.WriteLine(prumer);
            prumer = 0;
            soucet = 0;
            pom = 0;

            Console.WriteLine("Anglicky jazyk:");
            for (s = 0; s < sloupec; s++)
            {
                pom = pole[s, 2];
                soucet = soucet + pom;
            }
            prumer = soucet / sloupec;
            Console.WriteLine(prumer);
            prumer = 0;
            soucet = 0;
            pom = 0;

            Console.WriteLine("Fyzika:");
            for (s = 0; s < sloupec; s++)
            {
                pom = pole[s, 3];
                soucet = soucet + pom;
            }
            prumer = soucet / sloupec;
            Console.WriteLine(prumer);
            prumer = 0;
            soucet = 0;
            pom = 0;

            Console.WriteLine("Grafika:");
            for (s = 0; s < sloupec; s++)
            {
                pom = pole[s, 4];
                soucet = soucet + pom;
            }
            prumer = soucet / sloupec;
            Console.WriteLine(prumer);
            prumer = 0;
            soucet = 0;
            pom = 0;

            Console.ReadKey();
        }
    }
}
