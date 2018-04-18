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

        

            int[] arr = new int[6];
            int sum = 0, res = 0;
            Console.WriteLine("Zadejte délku pole.");
            int maxLen = int.Parse(Console.ReadLine());

            while (maxLen > 20)
            {
                Console.WriteLine("Zadejte menší číslo");
            }

            /* */
           
            for (int i = 0; i < maxLen; i++)
            {
                Console.WriteLine("Zadejte známku");
                arr[i] = int.Parse(Console.ReadLine());
                sum += arr[i];

            }
            res = sum / 6;
            Console.WriteLine("Průměr je " + avg);

            Console.ReadKey();

        }
    }
}
