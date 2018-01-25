using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Game
{
    class Program
    {
        static void Main(string[] args)
        {
           
            int cardValue = 0, sum=0, sum2 = 0, player; // 1 - 11
            string answer = "";

            Console.WriteLine("Vítej v programu FlapJack!");
            Console.WriteLine("hraje hráč číslo 1");
  
            Random gen = new Random();

            player = 1;

            answer = "a"; // default value (to enter while)

            while (answer == "a")
            {
                Console.WriteLine("Hraje hráč " + player);
                cardValue = gen.Next(1, 11);
                Console.WriteLine("Číslo na kartě je: " + cardValue);
                Console.WriteLine("Chceš další kartu?");
                sum += cardValue;
              
                if (sum < 21)
                {
                  Console.WriteLine("Dosavadní součet je: " + sum);
                answer = Console.ReadLine();
                   // player = player + 1;
                   if (player == 1){ player = 2; } else { player = 1; }
                } else
                {
                   if (sum == 21) {
                        Console.WriteLine("GRATULUJI, Dosáhl jste nejvyššího skóre ");
                    } else {
                        Console.WriteLine("Smutný příběh - celkový součet je ");
                    }
                    answer = "n";
                }

                // vyhodnotit hru na zíkladě skóre 1 a skóre 2
            } 
           


            /* 1) Welcome
             * 2) generace hodnoty karty vyzmeme z balíku kartu a zjistíme její hodnotu
               3) Chcete další? -> ano - vypíše skóre
               -> ne - druhý hráč (back to 2)
             
             
             */





        }
    }
}
