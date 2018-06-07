using System;

namespace test
{
    class MainClass
    {
        
        public static void Main(string[] args)
        {




          
            int xp = 0;
            int yp = 0;
            int count = 3;
            int id = 0;
            int size = 4; // 4 - 8
            int player = 2;
            int oneindex = 3;
            int zeroindex = 3;
            int wx = 0;
            int wy = 0;

            string[,] seats = new string[0, 0];


            Console.WriteLine("Dobrý den, vítá vás program Dáma");
            Console.WriteLine("Jak velké chcete hrací pole? povoleny jsou pouze hodnoty v rozmezí 4 - 8");
           size = int.Parse(Console.ReadLine());
            Console.WriteLine("Kolik chcete povolit tahů ?");
            count = int.Parse(Console.ReadLine());



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


                    Console.WriteLine("Vyberte x pozici kamene se kterým chcete pohnout? hraje hráč číslo " + player);
                    wx = int.Parse(Console.ReadLine()) - 1;
                    Console.WriteLine("Vyberte y pozici kamene se kterým chcete pohnout");
                    wx = int.Parse(Console.ReadLine()) - 1;




                    Console.WriteLine("Na jakou pozici chcete posunout váš kámen?");
                    Console.WriteLine("Zadejte řadu"); //2*2, 1*1
                    yp = int.Parse(Console.ReadLine()) - 1;
                    Console.WriteLine("Zadejte sloupec."); //2*2, 1*1
                    xp = int.Parse(Console.ReadLine()) - 1;


                
                    moveStone(xp, yp, player, seats, wx, wy);

                    writeSeats(size, size, seats);
                    //request(xp, yp, size, id, seats);
                }
            
            } else {
                Console.WriteLine("Zadejte menší velikost pole.");
            }
        }



        static void moveStone(int x, int y, int player, string[,] arr, int wx, int wy){
         
            var res = Convert.ToString(player);
  
            // protivník
            string contra = "";
               
            if (res == "1"){
                contra = "2";
                } else {
                contra = "1";
                }

            // chci pohnout s kamenem
      

            if (arr[x, y] == "O" || arr[x, y] == "1" || arr[x, y] == "2"){

                Console.WriteLine("Jsem zde");

                if (arr[wx, wx] == res){
                    Console.WriteLine("Můžete táhnout.");
                    arr[wx, wy] = "O";
                } else {
                    Console.WriteLine("Na této pozici nemáte kámen.");
                }



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

      


        // vyplnění první řady 0
        static string[,] fillSeatsf(int count, int id, string[,] arr)
        {
            for (var i = 0; i < count; i++){
                arr[i, 0] = Convert.ToString(id);
       
            }
            return arr;
        }


        // vyplnění druhé řady 1
        static string[,] fillSeatsl(int count, int id, string[,] arr)
        {
            for (var i = 0; i < count; i++)
            {
                arr[i, count - 1] = Convert.ToString(id);

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
