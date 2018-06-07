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
            int count = 3;
            int id = 0;
            int size = 4; // 4 - 8
            int player = 1;

            string[,] seats = new string[0, 0];


            Console.WriteLine("Dobrý den, vítá vás program Dáma");
            Console.WriteLine("Jak velké chcete hrací pole? povoleny jsou pouze hodnoty v rozmezí 4 - 8");
           size = int.Parse(Console.ReadLine());

           
            if (size >= 4 && size <= 8){
               
                seats = new string[size, size];
                initBoard(size, seats);
                fillSeatsf(size, 1, seats);
                fillSeatsl(size, 2, seats);
                writeSeats(size, size, seats);



                for (var i = 0; i < count; i++)
                {
                    //  id = id + 1;
                    if (player == 1) { player = 2; } else { player = 1; }
                    Console.WriteLine("Na jakou pozici chcete posunout váš kámen. hraje hráč číslo " + player);
                    Console.WriteLine("Zadejte řadu"); //2*2, 1*1
                    yp = int.Parse(Console.ReadLine()) - 1;
                    Console.WriteLine("Zadejte sloupec."); //2*2, 1*1
                    xp = int.Parse(Console.ReadLine()) - 1;



                    moveStone(xp, yp, player, seats);

                    writeSeats(size, size, seats);
                    //request(xp, yp, size, id, seats);
                }
            
            } else {
                Console.WriteLine("Zadejte menší velikost pole.");
            }
        }



        static void moveStone(int x, int y, int player, string[,] arr){
         
            var res = Convert.ToString(player);
            // pozice existuje
            // protivník
            string contra = "";
               
            if (res == "1"){
                contra = "2";
                } else {
                contra = "1";
                }



            if (arr[x, y] == "O" || arr[x, y] == "1" || arr[x, y] == "2"){

                Console.WriteLine("Jsem zde");
            

                if (arr[x, y] == contra){
                    Console.WriteLine("Obsadil jste protivníka.");
                    arr[x, y] = res;
                } else if (arr[x, y] == res){
                    Console.WriteLine("Chcete zabrat sám sebe? To jako fakt?");
                } else if (arr[x, y] == "O") {
                    Console.WriteLine("Nikdo tam není.");
                    arr[x, y] = res;
                }

               
            }


        }

      



        static string[,] fillSeatsf(int count, int id, string[,] arr)
        {
            for (var i = 0; i < count; i++){
                arr[i, 0] = Convert.ToString(id);
                //arr[0, count - 1] = Convert.ToString(id);
            }
            return arr;
        }


        static string[,] fillSeatsl(int count, int id, string[,] arr)
        {
            for (var i = 0; i < count; i++)
            {
                arr[i, count - 1] = Convert.ToString(id);
                //arr[0, count - 1] = Convert.ToString(id);
            }
            return arr;
        }


        static void initBoard(int size, string[,] arr){
            var s = 0;
            var r = 0;

            for (r = 0; r < size; r++)
            {
                for (s = 0; s < size; s++)
                {
                    arr[s, r] = "O"; 
                   
                }
            }
        }


        static void writeSeats(int x, int y, string[,] arr)
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


    }

}
