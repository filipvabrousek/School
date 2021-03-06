using System;

namespace test
{
    class MainClass
    {

        public static void Main(string[] args)
        {

            // velikost pole (4 - 8)
            int size = 4;
            int player = 2;

            int wx = 0;
            int wy = 0;

            string[,] seats = new string[0, 0];

            int option = 0;

            string finished = "n";
            string carryon = "a";

            // ---------------------------- ptát se tak dlouho dokud není hodnota v rozmezí 4 - 8
            while (carryon == "a")
            {

                Console.WriteLine("Dobrý den, vítá vás program Dáma");
                Console.WriteLine("Jak velké chcete hrací pole? povoleny jsou pouze hodnoty v rozmezí 4 - 8");
                size = int.Parse(Console.ReadLine());


                if (size >= 4 && size <= 8)
                {
                    carryon = "n";
                    seats = new string[size, size];
                    initBoard(size, seats); // vyplní sedadla symbolem "O"
                    fillSeatsf(size, 1, seats); // vyplnění 1. řady 1
                    fillSeatsl(size, 2, seats); // vyplnění 2. řady 2
                    writeSeats(size, size, seats);
                }
                else
                {
                    Console.WriteLine("Zadejte menší velikost pole.");
                }

            }



            while (finished != "a")
            {
                //  střídání hráčů
                if (player == 1)
                {
                    player = 2;
                }
                else
                {
                    player = 1;
                }


                //  (x musí být mezi 1 až velikost pole), (y musí být 1), 
                Console.WriteLine("Vyberte x pozici kamene se kterým chcete pohnout? hraje hráč číslo " + player);
                wx = int.Parse(Console.ReadLine()) - 1;
                Console.WriteLine("Vyberte y pozici kamene se kterým chcete pohnout");
                wy = int.Parse(Console.ReadLine()) - 1;



                Console.WriteLine("Na jakou pozici chcete posunout váš kámen?");


                Console.WriteLine("kam chcete pohnout s vaším kamenem?");
                Console.WriteLine("Doprava úhlopříčka - 1");
                Console.WriteLine("Doleva úhlopříčka - 2");
                Console.WriteLine("Rovně - 3");
                option = int.Parse(Console.ReadLine());


                moveInDir(seats, player, option, wx, wy); // wx, wy bude myX, myY
                writeSeats(size, size, seats);


                // vyhodnocení konce hry (horní i dolní řada jsou prázdné)
                bool done = endGame(size, seats);

                if (done == true)
                {
                    finished = "a";
                }
            }

        }



        // -------------------------------- posune kámen v požadovaném směru
        static void moveInDir(string[,] arr, int player, int option, int myX, int myY)
        {

            var res = Convert.ToString(player);


            if (arr[myX, myY] != res)
            {
                Console.WriteLine("Na této pozici nemáte kámen.");
            }
            else

            {

                // nechat zmizet hráče z místa se kterým jsme táhli.
                arr[myX, myY] = "O";


                // protivník
                string contra = "";

                if (res == "1")
                {
                    contra = "2";
                }
                else
                {
                    contra = "1";
                }



                // :::::::::::::::::::::::::::::::::::::::::::::::::::::: DOPRAVA (OPTION IS 1)
                if (option == 1)
                {

                    // --------------------------------------- hraje hráč číslo 1 SHORA DOPRAVA DOLŮ
                    // je VPRAVO DOLE protivník ?
                    if (contra == "2")
                    {
                        if (arr[myX + 1, myY + 1] == contra)
                        {
                            Console.WriteLine("vpravo dole je protivník hrače 1. Zabíráte ho.");
                            arr[myX + 1, myY + 1] = res;
                        }
                        else
                        {
                            Console.WriteLine("vpravo dole jste nikoho jste nezabrali. ");
                            arr[myX + 1, myY + 1] = res;
                        }
                    }


                    // --------------------------------------- hraje hráč číslo 2 ZDOLA DOPRAVA NAHORU
                    // je VPRAVO NAHOŘE protivník ?
                    else if (contra == "1")
                    {

                        if (arr[myX + 1, myY - 1] == contra)
                        {
                            Console.WriteLine("vpravo nahoře je protivník hrače 2. Zabíráte ho.");
                            arr[myX + 1, myY - 1] = res;
                        }
                        else
                        {
                            Console.WriteLine("vpravo dole jste nikoho jste nezabrali. ");
                            arr[myX + 1, myY - 1] = res;
                        }
                    }


                }




                // :::::::::::::::::::::::::::::::::::::::::::::::::::::: DOLEVA (OPTION IS 2)
                if (option == 2)
                {

                    // --------------------------------------- hraje hráč číslo 1 SHORA DOLEVA DOLŮ
                    // je VLEVO DOLE protivník ?
                    if (contra == "2")
                    {
                        if (arr[myX - 1, myY + 1] == contra)
                        {
                            Console.WriteLine("vlevo dole je protivník hrače 1. Zabíráte ho.");
                            arr[myX - 1, myY + 1] = res;
                        }
                        else
                        {
                            Console.WriteLine("vlevo dole jste nikoho jste nezabrali. ");
                            arr[myX - 1, myY + 1] = res;
                        }
                    }


                    // --------------------------------------- hraje hráč číslo 2 ZDOLA DOLEVA NAHORU
                    // je VLEVO NAHOŘE protivník ?
                    else if (contra == "1")
                    {

                        if (arr[myX - 1, myY - 1] == contra)
                        {
                            Console.WriteLine("vlevo nahoře je protivník hrače 2. Zabíráte ho.");
                            arr[myX - 1, myY - 1] = res;
                        }
                        else
                        {
                            Console.WriteLine("vlevo dole jste nikoho jste nezabrali. ");
                            arr[myX - 1, myY - 1] = res;
                        }
                    }


                }






                // :::::::::::::::::::::::::::::::::::::::::::::::::::::: KOLMO (OPTION IS 3)
                if (option == 3)
                {

                    // --------------------------------------- hraje hráč číslo 1 SHORA KOLMO DOLŮ
                    // je KOLMO dole protivník ?
                    if (contra == "2")
                    {
                        if (arr[myX, myY + 1] == contra)
                        {
                            Console.WriteLine("kolmo dole je protivník hrače 1. Zabíráte ho.");
                            arr[myX, myY + 1] = res;
                        }
                        else
                        {
                            Console.WriteLine("kolmo dole jste nikoho jste nezabrali. ");
                            arr[myX, myY + 1] = res;
                        }
                    }


                    // --------------------------------------- hraje hráč číslo 2 ZDOLA KOLMO NAHORU
                    // je KOLMO NAHOŘE protivník ?
                    else if (contra == "1")
                    {

                        if (arr[myX, myY - 1] == contra)
                        {
                            Console.WriteLine("kolmo nahoře je protivník hrače 2. Zabíráte ho.");
                            arr[myX, myY - 1] = res;
                        }
                        else
                        {
                            Console.WriteLine("kolmo dole jste nikoho jste nezabrali. ");
                            arr[myX, myY - 1] = res;
                        }
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


        // ---------------------------------------- HRA KONČÍ POKUD ZBYDE JEN JEDEN KÁMEN 
        // JEHO NÁZEV  ("1" nebo "2") JE VÍTĚZ
        static bool endGame(int count, string[,] arr)
        {

            bool end = false;


            int onecount = 0;
            int twocount = 0;


            var s = 0;
            var r = 0;

            for (r = 0; r < count; r++)
            {
                for (s = 0; s < count; s++)
                {

                    if (arr[s, r] == "1")
                    {
                        onecount += 1;
                    }

                    if (arr[s, r] == "2")
                        twocount += 1;
                }


            }



            if (onecount == 1 && twocount == 0)
            {
                Console.WriteLine("zvítězil hráč číslo 1.");
            }

            if (twocount == 1 && onecount == 0)
            {
                Console.WriteLine("zvítězil hráč číslo 2.");
            }
            else
            {
                Console.WriteLine("Zatím nikdo nezvítězil.");
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

    }

}
