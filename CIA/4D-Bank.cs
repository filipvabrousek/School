using System;

namespace Payout
{
    class MainClass
    {
        public static void Main(string[] args)
        {
            Console.WriteLine("Enter employee count.");

            int size = int.Parse(Console.ReadLine()); // 3
            int[] money = new int[size];

            for (var i = 0; i < money.Length; i++){
                Console.WriteLine("Zadejte hodnotu " + (i + 1));
                money[i] = int.Parse(Console.ReadLine());
            }

            Console.WriteLine("Výpis");
            for (var i = 0; i < money.Length; i++) {
                Console.Write(money[i] + ", ");
            }  // výpis pole

            int sumo = sum(money);
            Console.WriteLine("Celková suma je " + sumo);

            int avg = getAvg(money);
            Console.WriteLine("Průměr je " + avg);

            minMax(money); // vypíše ve funkci
            Console.WriteLine("-----------------------");

            getDivision(money);

            /// 1 - načíst platy zamětanců
            // 2 - celková suma, průměr, nejnižší + nejvyšší součet
            // 3 - počty bankovek a mincí, potřebných k vyplacení (5000, 2000, 1000, 500, 200, 100, 150, 
            // 4 - výpis pro každého
            // 5 - aspoň 2 bankovky

            /*

            suma je 5351

            1 5000
            1 200
            1 100
            1 50
            1 1
            

            */

           
        }



        static void getDivision(int[] arr){
            for (var i = 0; i < arr.Length; i++){
                Console.WriteLine("Rozdělení částky: " + arr[i]);
                smartDivide(arr[i]);
                Console.WriteLine("-----------------------");
               // Console.WriteLine("Suma " + arr[i] + " lze rozdělit na " + res + "Kč");
            }
        }


        static int smartSubstr(int m)
        { // kolik chceš bankovek ?
            int ret = 0;

            int[] barr = { 5000, 2000, 1000, 500, 200, 100 };
            int[] coins = { 50, 20, 10, 5 };


            for (var i = 0; i < barr.Length; i++)
            {
                int lts = 0;
                if (m >= barr[i])
                {
                    lts += barr[i];
                }
            }

            return ret;
        }



        static int largestSubstr(int m)
        {


            int temp = m;

            int lts = 0; // largest valze to substract

            if (temp >= 5000)
            {
                lts = 5000;
            }
            else if (temp >= 2000)
            {
                lts = 2000;
            }
            else if (temp >= 1000)
            {
                lts = 1000;
            }
            else if (temp >= 500)
            {
                lts = 500;
            }
            else if (temp >= 200)
            {
                lts = 200;
            }
            else if (temp >= 100)
            {
                lts = 100;
            }


            // Console.WriteLine("Largest value that canbe subtracted without going to negative values is " + lts);
            return lts;
        }




        static void smartDivide(int m){
            //  string stop = "n";

            int n = m;
            int c5000 = 0;
            int c2000 = 0;
            int c1000 = 0;
            int c500 = 0;
            int c200 = 0;
            int c100 = 0;
            int c50 = 0;
            int c20 = 0;
            int c10 = 0;
            int c5 = 0;


            while (n != 0){
                if (n >= 5000){
                    n = n - 5000;
                    c5000++;
                }

                if (n >= 2000)
                {
                    n = n - 2000;
                    c2000++;
                }

                if (n >= 1000)
                {
                    n = n - 1000;
                    c1000++;
                }

                if (n >= 500)
                {
                    n = n - 500;
                    c500++;
                }

                if (n >= 200)
                {
                    n = n - 200;
                    c200++;
                }

                if (n >= 100)
                {
                    n = n - 100;
                    c100++;
                }

                if (n >= 50)
                {
                    n = n - 50;
                    c50++;
                }

                if (n >= 20)
                {
                    n = n - 20;
                    c20++;
                }


                if (n >= 10)
                {
                    n = n - 10;
                    c10++;
                }


                if (n >= 5)
                {
                    n = n - 5;
                    c5++;
                }
            }

            // 129 ???

            Console.WriteLine("5000 x " + c5000);
            Console.WriteLine("1000 x " + c1000);
            Console.WriteLine("500 x " + c500);
            Console.WriteLine("200 x " + c200);
            Console.WriteLine("100 x " + c100);
            Console.WriteLine("50 x " + c50);
            Console.WriteLine("20 x " + c20);
            Console.WriteLine("10 x " + c10);
            Console.WriteLine("5 x " + c5);

        }


 

        static int sum(int[] arr)
        {

            int sum = 0;
            for (var i = 0; i < arr.Length; i++)
            {
                sum += arr[i];
            }

            return sum;
        }



        static void minMax(int[] arr)
        {
            int currmin = arr[0];
            int currmax = arr[0];

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

        static int getAvg(int[] arr){
            int sum = 0;
            int res = 0;

            if (!isEmpty(arr))
            {
                for (var i = 0; i < arr.Length; i++)
                {
                    sum += arr[i];
                }

                 res = sum / arr.Length;
            }
            return res;
        }

        static bool isEmpty(int[] arr){
            if (arr.Length == 0) {
                return true;
            } else {
                return false;
            }
        }
    }
}
