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


            for (var i = 0; i < money.Length; i++) {
                Console.Write(money[i] + ", ");
            }

            int sumo = sum(money);
            Console.WriteLine("Celková suma je " + sumo);

            int avg = getAvg(money);
            Console.WriteLine("Průměr je " + avg);





            int res = getCount(sumo); // rozkládám sumu výplat na bankovky
            Console.WriteLine("The result is " + res);

            minMax(money); // vypíše ve funkci




            // 1 - načíst platy zamětanců
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

        static int smartSubstr(int m){ // number and a
            int ret = 0;

            int[] barr = { 5000, 2000, 1000, 500, 200, 100 };
            int[] coins = { 50, 20, 10, 5 };


            for (var i = 0; i < barr.Length; i++){
                int lts = 0;
                if (m >= barr[i]){
                    lts += barr[i];
                }
            }

            return ret;
        }



        static int largestSubstr(int m){


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


        static int getCount(int m){


            int temp = m;

            int res = largestSubstr(temp); // 
            Console.WriteLine("Largest subsctractable value " + res);

            int rem = temp % res;
            Console.WriteLine("Largest subtractable value is " + rem);

            int stopper = 0;
            while (rem > 0 && stopper < 3){ // will run only twice
                rem = largestSubstr(rem);
                Console.WriteLine("Remaining " + rem);
                stopper += 1;
            }
           



             
          //  Console.WriteLine("Largest value that canbe subtracted without going to negative values is " + m);


         
            return rem;
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
