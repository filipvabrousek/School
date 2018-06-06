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

          
            int xp = 0;
            int yp = 0;
            int count = 0;
            int id = 0;
            string[,] seats = new string[10, 10];


            Console.WriteLine("Dobrý den, vítá vás program na umisťování lidí do kinosálu.");
            Console.WriteLine("Volná místa jsou označena znakem 'O' ");
           
            // 1 - fill in seats by empty 
            fillSeats(10, 10, seats);
            writeSeats(10, 10, seats);

            // get ROW  and SEAT
            for (var i = 0; i < 3; i++)
            {
                id = id + 1;
                Console.WriteLine("Zadejte řadu"); //2*2, 1*1
                yp = int.Parse(Console.ReadLine()) - 1;
                Console.WriteLine("Zadejte sedadlo."); //2*2, 1*1
                xp = int.Parse(Console.ReadLine()) - 1;
                Console.WriteLine("Kolik sedadel chcete vedle sebe ?");
                count = int.Parse(Console.ReadLine());

                request(xp, yp, count, id, seats);
            }

           Console.ReadKey();
        }



        static void request(int xp, int yp, int count, int id, string[,] arr){

            var res = Convert.ToString(id);
            Console.WriteLine("sn: " + res);

            // is the seat free
            var i = 0;

            if (arr[xp, yp] == "O") // || != "X"
            {
                // Console.WriteLine("Entered values x:" + xp + " y:" + yp + "count: " + count);
                // x: 2, y: 3, count: 3

                // arr[xp, yp] = 'X'; // "."
                arr[xp, yp] = Convert.ToString(id);


                for (i = 0; i < count; i++)
                {
                    Console.WriteLine("Value of count " + count);
                    if (arr[xp + i, yp] == "O")
                    {
                        // arr[xp + i, yp] = 'X';
                        arr[xp + i, yp] = Convert.ToString(id);
                    }

                }

                writeSeats(10, 10, arr);

            }
            else
            {
                Console.WriteLine("Nelze zadat. Zadejte prosím jinou řadu.");
            }

        }



        static string[,] fillSeats(int x, int y, string[,] arr)
        {

            // každá vstupenka jedinečné číslo
            var s = 0;
            var r = 0;

            for (r = 0; r < x; r++)
            {
                for (s = 0; s < y; s++)
                {
                    arr[s, r] = "O"; 
                   
                }
            }
            return arr;
        }



        static void writeSeats(int x, int y, string[,] arr)
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
        }


    }

}
