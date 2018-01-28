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
           
            int cardValue = 0, sum1=0, sum2 = 0, player; // 1 - 11
            string answer = "";

            Console.WriteLine("Vítej v programu FlapJack!");
            Console.WriteLine("hraje hráč číslo 1");
            Random gen = new Random();

            // set initilial player to 1
            player = 1;
            answer = "a"; // default value (to enter while)

            while (answer == "a")
            {
                Console.WriteLine("Hraje hráč " + player);
                cardValue = gen.Next(1, 11);
                Console.WriteLine("Číslo na kartě je: " + cardValue);
                Console.WriteLine("Chceš další kartu?");
               
               
            if (player == 1){ sum1 += cardValue; } else {sum2 += cardValue;}
              

              // sum is less than 21
                if (sum1 < 21){
                Console.WriteLine("Dosavadní součet je: " + sum1);
                answer = Console.ReadLine();
                if (player == 1){ player = 2; } else { player = 1; }
                }

                // if sum is bigger than 21 you lose
                 else {
                   if (sum1 == 21) {
                        Console.WriteLine("GRATULUJI, Dosáhl jste nejvyššího skóre " + sum1);
                          Console.WriteLine("Vyhrál hráč 1 se skóre " + sum1);
                    } else {
                        Console.WriteLine("Smutný příběh - celkový součet je " + sum1 + "vyhrál hráč 2");
                    }
                    answer = "n";
                }


if (player == 2){


                // sum 2 is less than 21
                if (sum2 < 21){
                Console.WriteLine("Dosavadní součet je: " + sum1);
                answer = Console.ReadLine();
                if (player == 1){ player = 2; } else { player = 1; }
                }

                // if sum is bigger than 21 you lose
                 else {
                   if (sum2 == 21) {
                        Console.WriteLine("GRATULUJI, Dosáhl jste nejvyššího skóre " + sum2);
                        Console.WriteLine("Vyhrál hráč 2 se skóre " + sum2);
                    } else {
                        Console.WriteLine("Smutný příběh - celkový součet je " + sum2 + "vyhrál hráč 1");
                    }
                    answer = "n";
                }
                /*
                
                int x = 1;
                string res = x == 9 ? "Wow" : "No";
                Console.WriteLine(res);
                 */
                // vyhodnotit hru na zíkladě skóre 1 a skóre 2
            }
            } // while
           


            /* 1) Welcome
             * 2) generace hodnoty karty vyzmeme z balíku kartu a zjistíme její hodnotu
               3) Chcete další? -> ano - vypíše skóre
               -> ne - druhý hráč (back to 2)
             
             
             */

    



        }
    }
}
