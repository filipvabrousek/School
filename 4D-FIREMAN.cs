using System;

namespace Forest
{
    class MainClass
    {
        static int size = 10;
        static string[,] forest = new string[size, size];
        static Random gen = new Random();


        public static void Main(string[] args)
        {
            initBoard(size, forest);
            write(size, size, forest);
            getRescuePoints(size, forest);
            getSumOf3x3(size, forest);
            write(size, size, forest);
            Console.ReadKey();
        }

        static void initBoard(int size, string[,] arr)
        {
            var s = 0;
            var r = 0;

            for (r = 0; r < size; r++)
            {
                for (s = 0; s < size; s++)
                {
                    arr[s, r] = "" + gen.Next(0,9) + ""; // fill - in  with random number

                }
            }



        }


        static void write(int x, int y, string[,] arr)
        {
            var s = 0;
            var r = 0;

            for (r = 0; r < x; r++)
            {
                for (s = 0; s < y; s++)
                {
                    Console.Write(arr[s, r]);
                }
                Console.WriteLine();
            }

        }


        static void getSumOf3x3(int size, string[,] arr){
            int s = 0;
            int r = 0;
            int sum = 0;


            for (r = 0; r < size - 7; r++){
                for (s = 0; s < size - 7; s++){
                    Console.Write(arr[s, r]);

                    sum += Int32.Parse(arr[s, r]); // sum of first region
                    arr[s, r] = "0";
                   

                    // search 3 + 3 regions in Both dimensions

                    /*
                    XXXXXX
                    XXXXXX
                    XXXXXX
                    XXXXXX
                    XXXXXX
                    XXXXXX
                    



                    */



                }
                Console.WriteLine("----");
            }

            Console.WriteLine("Sum " + sum);
        }






        static void getRescuePoints(int size, string[,] arr)
        {
            int[] fire = new int[2]; // will contain maximum temperature

            int max = 0;
            int m = 0;
            int r = 0;
            int s = 0;

            for (r = 0; r < size; r++)
            {
                for (s = 0; s < size; s++)
                {

                     m = Int32.Parse(arr[s, r]);
                     if (m > max)
                     {
                        fire[0] = s;
                        fire[1] = r;
                        max = Int32.Parse(arr[s, r]);

                    } // fill - in  with random number

                }
            }

            Console.WriteLine("Max [" + fire[0] + ", " + fire[1] + "] " + "Number " + m);
            Console.ReadKey();
        }


        /*

Místo kde je nelepší hasit 3 x 3
Výběr
Upravit čísla

        */



    }
}
