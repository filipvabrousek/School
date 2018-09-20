using System;

namespace arraymethods
{
    class MainClass
    {
        public static void Main(string[] args)
        {
            
            int len = 3;
            int[] arr = { 2, 6, 7, 2, 3, 8 };

            // WRITE EACH
            string res = writeEach(arr);
            Console.WriteLine("Výpis: " + res);
            Console.ReadKey();

            // SUM
            int sumo = sum(arr);
            Console.WriteLine("Sum: " + sumo);
            Console.ReadKey();

            // MIN AND MAX
            minMax(arr); // will write data inside the method
            Console.ReadKey();

            // MEDIAN
            median(arr);
            Console.ReadKey();

        }

        static bool isEmpty(int[] arr){
            if (arr.Length == 0) {
                return true;
            } else {
                return false;
            }
        }

        static string writeEach(int[] arr){
            string resdata = "";
            for (var i = 0; i < arr.Length; i++)
            {
                resdata += arr[i];
            }
            return resdata;
        }


        static int sum(int[] arr){

            int sum = 0;
            for (var i = 0; i < arr.Length; i++)
            {
                sum += arr[i];
            }

            return sum;
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
        }


        static void median(int[] arr) // does not work for odd length
        {
            
            int len = arr.Length;
            int i, j, helper = 0;

            int res = 0;
            // 1 - bubble sort (seřazení a výpis)
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



            if ((len % 2) == 0){
                res = (arr[len / 2] + arr[(len / 2) + 1]) / 2;
            } else {
                res = arr[len / 2];  
            }

            Console.WriteLine("Res is " + res);
        }
    }
}


