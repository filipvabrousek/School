using System;

namespace test
{
    class MainClass
    {

        public static void Main(string[] args)
        {


            int xp = 0;
            int yp = 0;

            int size = 4; // 4 - 8
            int player = 2;

            int wx = 0;
            int wy = 0;
           
            string[,] seats = new string[0, 0];



            string finished = "n";
            string carryon = "a";

            while(carryon == "a"){

                Console.WriteLine("Dobrý den, vítá vás program Dáma");
                Console.WriteLine("Jak velké chcete hrací pole? povoleny jsou pouze hodnoty v rozmezí 4 - 8");
                size = int.Parse(Console.ReadLine());
            

                if (size >= 4 && size <= 8)
                {
                    carryon = "n";
                    seats = new string[size, size];
                    initBoard(size, seats); // vyplní sedadla symbolem "O"
                    fillSeatsf(size, 1, seats);  // vyplnění 1. řady 1
                    fillSeatsl(size, 2, seats); // vyplnění 2. řady 2
                    writeSeats(size, size, seats);
                }
                else {
                    Console.WriteLine("Zadejte menší velikost pole.");
                }

            }



            while (finished != "a")
            {
                //  střídání hráčů
                if (player == 1) { player = 2; } else { player = 1; }

                Console.WriteLine("Vyberte x pozici kamene se kterým chcete pohnout? hraje hráč číslo " + player);
                wx = int.Parse(Console.ReadLine()) - 1;
                Console.WriteLine("Vyberte y pozici kamene se kterým chcete pohnout");
                wy = int.Parse(Console.ReadLine()) - 1;



                Console.WriteLine("Na jakou pozici chcete posunout váš kámen?");
                Console.WriteLine("Zadejte řadu"); //2*2, 1*1
                yp = int.Parse(Console.ReadLine()) - 1;
                Console.WriteLine("Zadejte sloupec."); //2*2, 1*1
                xp = int.Parse(Console.ReadLine()) - 1;



                moveInDir(xp, yp, seats, player, wx, wy);
                writeSeats(size, size, seats);


                // vyhodnocení konce hry
                bool done = endGame(size, seats);

                if (done == true){
                    finished = "a";
                }
            }

        }

    


        static void moveInDir(int x, int y, string[,] arr, int player, int myX, int myY){
         
        var res = Convert.ToString(player);

            if (arr[myX, myY] != res)
            {
                Console.WriteLine("Není to váš kámen");
            }
            else
            {
                // protivník
                string contra = "";

                if (res == "1") { contra = "2"; } else { contra = "1"; }


                // --------------------------------------- hraje hráč číslo 1 SHORA
                if (contra == "2")
                {
                    Console.WriteLine("Player 2");


                    // je vpravo nahoře protivník ?
                    if (arr[x - 1, y - 1] == contra)
                    {
                        Console.WriteLine("Vpravo nahoře je protivník.");
                    }
                    else
                    {
                        arr[x - 1, y - 1] = res; // pohnout vpravo nahoru (jde to)
                    }


                    // je vlevo nahoře protivník ?
                    if (arr[x + 1, y - 1] == contra)
                    {
                        Console.WriteLine("Vlevo nahoře je protivník.");
                    }
                    else
                    {
                        arr[x + 1, y - 1] = res; // pohnout dopředu (jde to)
                    }

                    if (arr[x, y - 1] == contra)
                    {
                        Console.WriteLine("Kolmo nahoře je protivník");
                    }
                    else
                    {
                        arr[x, y - 1] = res;
                    }
                }




                // ------------------------------------ hraje hráč číslo 2 ZESPODU
                if (contra == "1")
                {
                    Console.WriteLine("Player 1");


                    // je vpravo nahoře protivník ?
                    if (arr[x + 1, y + 1] == contra)
                    {
                        Console.WriteLine("Vpravo nahoře je protivník.");
                    }
                    else
                    {
                        arr[x + 1, y + 1] = res; // pohnout vpravo nahoru (jde to)
                    }


                    // je vlevo nahoře protivník ?
                    if (arr[x - 1, y + 1] == contra)
                    {
                        Console.WriteLine("Vlevo nahoře je protivník.");
                    }
                    else
                    {
                        arr[x - 1, y + 1] = res; // pohnout dopředu (jde to)
                    }

                    if (arr[x, y + 1] == contra)
                    {
                        Console.WriteLine("Kolmo nahoře je protivník");
                    }
                    else
                    {
                        arr[x, y + 1] = res;
                    }

                }
            }
        }


        // ---------------------------------------- VYPLNĚNÍ HORNÍ ŘADY ČÍSLEM 1
    static string[,] fillSeatsf(int count, int id, string[,] arr)
    {
        for (var i = 0; i < count; i++)
        {
            arr[i, 0] = Convert.ToString(id);
        }
        return arr;
    }



        // ---------------------------------------- VYPLNĚNÍ DOLNÍ ŘADY ČÍSLEM 2
    static string[,] fillSeatsl(int count, int id, string[,] arr)
    {
        for (var i = 0; i < count; i++)
        {
            arr[i, count - 1] = Convert.ToString(id);
        }
        return arr;
    }
       

        // ---------------------------------------- HRA KONČÍ POKUD JE HORNÍ A DOLNÍ ŘADA PRÁZDNÁ
    static bool endGame(int count, string[,] arr){

            bool end = false;

            for (var i = 0; i < count; i++)
            {
                // dolní řada prázdná
                if ( arr[i, 0] == "O"){
                    end = true;
                }

                // horní řada prázdná 
                else if (arr[i, count - 1] == "O")
                {
                    end = true;
                }

                // jinak hra ještě neskončila
                else {
                    end = false; 
                }



            }

            return end;
        }



        // ---------------------------------------- VYPLNĚNÍ HRACÍHO POLE "O"
    static void initBoard(int size, string[,] arr)
    {
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


       // ---------------------------------------- VÝPIS HRACÍHO POLE
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







        static void moveStone(int x, int y, int player, string[,] arr, int wx, int wy)
        {

            var res = Convert.ToString(player);

            // protivník
            string contra = "";

            if (res == "1") { contra = "2"; } else { contra = "1"; }

            // chci pohnout s kamenem

            if (arr[x, y] == "O" || arr[x, y] == "1" || arr[x, y] == "2")
            {

                Console.WriteLine("Jsem zde");

                if (arr[wx, wx] == res)
                {
                    Console.WriteLine("Můžete táhnout.");
                    arr[wx, wy] = "O";
                }
                else
                {
                    Console.WriteLine("Na této pozici nemáte kámen.");
                }



                if (arr[x, y] == contra)
                {
                    Console.WriteLine("Obsadil jste protivníka.");
                    arr[x, y] = res;
                }
                else if (arr[x, y] == res)
                {
                    Console.WriteLine("Chcete zabrat sám sebe? To jako fakt?");
                }

                else if (arr[x, y] == "O")
                {
                    Console.WriteLine("Nikdo tam není.");
                    arr[x, y] = res;
                }


            }


        }


}

}


