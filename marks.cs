using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace crosses
{
    class Program
    {
        static void Main(string[] args)
        {

            int line, column, r, s, pom;
            double sum, avg;

            line = 5;
            column = 5;
            r = 0;
            s = 0;
            sum = 0;

            int[,] arr = new int[column, line];

            Console.WriteLine("Zadej znamky z predmetu v tomhle poradi: matematika, cesky jazyk, anglicky jazyk, fyzika, grafika.");
            Console.WriteLine("V každém předmětu je 5 známek");
            for (r = 0; r < line; r++)
            {
                for (s = 0; s < column; s++)
                {
                    arr[s, r] = int.Parse(Console.ReadLine());
                }
            }

            for (r = 0; r < line; r++)
            {
                for (s = 0; s < column; s++)
                {
                    Console.Write(arr[s, r]);
                }
                Console.WriteLine();
            }


           

            Console.WriteLine("Matematika:");
            for (s = 0; s < column; s++)
            {
                pom = arr[s, 0];
                sum = sum + pom;
            }
            avg = sum / column;
            Console.WriteLine(avg);
            avg = 0;
            sum = 0;
            pom = 0;

            Console.WriteLine("Cesky jazyk:");
            for (s = 0; s < column; s++)
            {
                pom = arr[s, 1];
                sum = sum + pom;
            }
            avg = sum / column;
            Console.WriteLine(avg);
            avg = 0;
            sum = 0;
            pom = 0;

            Console.WriteLine("Anglicky jazyk:");
            for (s = 0; s < column; s++)
            {
                pom = arr[s, 2];
                sum = sum + pom;
            }
            avg = sum / column;
            Console.WriteLine(avg);
            avg = 0;
            sum = 0;
            pom = 0;

            Console.WriteLine("Fyzika:");
            for (s = 0; s < column; s++)
            {
                pom = arr[s, 3]; // arr[s][r]
                sum = sum + pom;
            }
            avg = sum / column;
            Console.WriteLine(avg);
            avg = 0;
            sum = 0;
            pom = 0;

            Console.WriteLine("Grafika:");
            for (s = 0; s < column; s++)
            {
                pom = arr[s, 4];
                sum = sum + pom;
            }
            avg = sum / column;
            Console.WriteLine(avg);
            avg = 0;
            sum = 0;
            pom = 0;

            Console.ReadKey();

        }
    }
}
