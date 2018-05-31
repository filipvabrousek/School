using System;

namespace test
{
    class MainClass
    {
        public static void Main(string[] args)
        {


            /*
            Kinosál zadat (10 x 10)
            Zadat kolik lidí vedle sebe chcete ? (3)
            v array arr zjistí zda jsou 3 volná vedle sebe            
            */

            int x, y, r, s;

            x = 10;
            y = 10;


            int success = 0, fail = 0, percent = 0;
            int xPosition = 0;
            int yPosition = 0;
            int count = 0;
            char[,] seats = new char[10, 10];


            // 1 - fill in seats by empty 
            fillSeats(10, 10, seats);
            writeSeats(10, 10, seats);

            // get ROW  and SEAT
            for (var i = 0; i < 3; i++)
            {
                Console.WriteLine("Zadejte řadu."); //2*2, 1*1
                xPosition = int.Parse(Console.ReadLine());
                Console.WriteLine("Zadejte sedadlo"); //2*2, 1*1
                yPosition = int.Parse(Console.ReadLine());

                Console.WriteLine("Kolik sedadel chcete vedle sebe ?");
                count = int.Parse(Console.ReadLine());

                // is the seat free
                if (seats[xPosition, yPosition] != 'X')
                {
                    seats[xPosition, yPosition] = 'X'; // "."
                }



                else
                {
                    Console.WriteLine("Sedadla jsou obsazena.");
                }

                writeSeats(10, 10, seats);

            }

            Console.ReadKey();
        }


        static char[,] fillSeats(int x, int y, char[,] arr)
        {

            // každá vstupenka jedinečné číslo
            var s = 0;
            var r = 0;

            for (r = 0; r < x; r++)
            {
                for (s = 0; s < y; s++)
                {
                    arr[s, r] = 'O'; // emtpy seats
                    //Console.Write(arr[s, r]);
                }
            }
            Console.WriteLine("Filled in seats");

            return arr;
        }



        static void writeSeats(int x, int y, char[,] arr)
        {

            // každá vstupenka jedinečné číslo
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
            Console.WriteLine("Wrote in seats");

            //return arr;
        }



        static void isFree(int x, int y, char[,] arr)
        {

            // každá vstupenka jedinečné číslo
            var s = 0;
            var r = 0;

            for (s = 0; s < x; r++)
            {

                Console.Write(arr[s, 0]);
                /*
                for (s = 0; s < y; s++)
                {
                    Console.Write(arr[s, r]);
                }
                Console.WriteLine();
            }
            Console.WriteLine("Wrote in seats");
            */

            }

        }

    }

}
