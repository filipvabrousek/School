using System;

namespace arraymethods
{
    class MainClass
    {
        public static void Main(string[] args)
        {


            Console.WriteLine("zadejte délku pole.");
            int mlen = int.Parse(Console.ReadLine());
            median(mlen);


            Console.WriteLine("-----------------");
            Console.WriteLine("Zadejte délku pole.");
            int len = int.Parse(Console.ReadLine());

            int[] arr = new int[len];

            int sum = 0;

            for (var i = 0; i < arr.Length; i++)
            {
                Console.WriteLine("Zadejte hodnotu " + (i + 1));
                arr[i] = int.Parse(Console.ReadLine());

            }
            // ARR = [10, 20, 21]

            for (var i = 0; i < arr.Length; i++)
            {
                sum += arr[i];
            }

            Console.WriteLine("Celková suma " + sum);
            Console.WriteLine("Průměr je " + sum / len);
            Console.ReadKey();


            // Výpis pole

            string resdata = "";
            for (var i = 0; i < arr.Length; i++)
            {
                resdata += arr[i];
            }

            Console.WriteLine("Výpis: " + resdata);
        }


        static void median(int len)
        {
            int[] arr = new int[len];

            int sum, i, j, helper = 0;

            // 1 - Naplnění hodnotami
            for (i = 0; i < arr.Length; i++)
            {
                Console.WriteLine("Zadejte hodnotu pro medián " + (i + 1));
                arr[i] = int.Parse(Console.ReadLine());

            }


            // 2 - bubble sort (seřazení a výpis)
            for (j = 0; j < len - 1; j++)
            {

                for (i = 0; i < (len - j - 1); i++)
                {
                    if (arr[i] > arr[i + 1])
                    {
                        helper = arr[i];
                        arr[i] = arr[i + 1];
                        arr[i + 1] = helper;
                    }

                }

                Console.Write(arr[i] + " ");
            }


            // 3 - zjištění zda jsou čísla lichá
            int[] marr = new int[len];

            bool isOdd = false;


            for (var q = 0; q < marr.Length; i++)
            {
                if (marr[q] % 2 == 0)
                { // máme liché číslo
                    isOdd = false;
                }
                isOdd = true;
            }

            for (var q = 0; q < marr.Length; i++)
            {
                if (isOdd == false)
                { // only even numbers
                    if (marr.Length % 2 == 0)
                    { // the array has even length
                        int half = arr.Length / 2;
                        int halfn = marr[half];
                        Console.WriteLine("Median of even array is " + halfn);
                    }
                    else
                    {
                        // prostřední 2 a z nich průměr
                        if (arr.Length >= 2)
                        {
                            int half = arr.Length / 2;
                            int halfn = marr[half]; // první z  těch dvou
                            int halfa = marr[half + 1]; // druhý z těch dvou

                            int res = (halfa + halfn) / 2;
                            Console.WriteLine("Median of odd array is " + res);

                        }
                    }
                }
            }

            Console.WriteLine("All numbers are odd " + isOdd);
            Console.ReadKey();
        }



        static void minMax(int[] arr)
        {
            int currmin = 0;
            int currmax = 0;

            for (var i = 0; i < arr.Length; i++)
            {
                if (arr[i] < currmin)
                {
                    currmin = arr[i];
                }

                if (arr[i] > currmax)
                {
                    currmax = arr[i];
                }
            }

            Console.WriteLine("Min value: " + currmin, "Max value " + currmax);

            Console.ReadKey();

        }
    }
}
