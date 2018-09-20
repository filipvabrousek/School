## My own bad
// 7.2.2018
```cs
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Game {
	class Program {
		static void Main(string[] args) {

/*--------------------------------------------SETUP-------------------------------------------- */
			int cardValue = 0, sum1 = 0, sum2 = 0, player = 1; // 1 - 11
			string answer = "";
			Console.WriteLine("Vítej v programu FlapJack!");
			Random gen = new Random();

			answer = "a"; // default value (to enter while)


/*--------------------------------------------MAIN WILE LOOP-------------------------------------------- */
			while (answer == "a") {
				Console.WriteLine("Hraje hráč " + player);
				cardValue = gen.Next(1, 11);
				Console.WriteLine("Číslo na kartě je: " + cardValue);


/*-----------PLAYER 1----------------------------------------------------------------------- */
				if (player == 1) {
					sum1 += cardValue;
				} else {
					sum2 += cardValue;
				}


				// sum is less than 21
				if (sum1 < 21) {
					Console.WriteLine("Hraje hráč " + player);
					Console.WriteLine("Dosavadní součet je: " + sum1);
					Console.WriteLine("Chceš další kartu?");
					answer = Console.ReadLine();
					if (answer == "n") {
						player = 2;
					}

					if (answer == "a") {
						player = 1;
					}
				}

				// if sum is equal to 21 you lose, or you win
				else {
					if (sum1 == 21) {
						Console.WriteLine("GRATULUJI, Dosáhl jste nejvyššího skóre " + sum1);
						Console.WriteLine("Vyhrál hráč 1 se skóre " + sum1);
					} else {
						Console.WriteLine("Smutný příběh - celkový součet je " + sum1 + ". vyhrál hráč 2");
					}
					answer = "n";
				}



/*-----------PLAYER 2----------------------------------------------------------------------- */
				if (player == 2) {
					// sum 2 is less than 21
					if (sum2 < 21) {
						Console.WriteLine("Hraje hráč " + player);
						Console.WriteLine("Dosavadní součet je: " + sum1);
						Console.WriteLine("Chcete další kartu? (a/n)");
						answer = Console.ReadLine();
						if (answer == "n") {
							player = 1;
						}

						if (answer == "a") {
							player = 2;
						}
						// if (player == 1){ player = 2; } else { player = 1; }
					}

					// if sum is bigger than 21 you lose
					else {
						if (sum2 == 21) {
							Console.WriteLine("GRATULUJI, Dosáhl jste nejvyššího skóre " + sum2);
							Console.WriteLine("Vyhrál hráč 2 se skóre " + sum2);
						} else {
							Console.WriteLine("Smutný příběh - celkový součet je " + sum2 + ". vyhrál hráč 1");
						}
						answer = "n";
					}

				}
			} // while



			/* 
            RULES:
            1) Welcome
			2) generace hodnoty karty vyzmeme z balíku kartu a zjistíme její hodnotu
		    3) Chcete další? -> ano - vypíše skóre
			   -> ne - druhý hráč (back to 2)
			 */





		}
	}
}

```




## Teachers
```cs
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Flapjack {
 class Program {
  static void Main(string[] args) {
   /*--------------------------------------------SETUP-------------------------------------------- */
   int cardValue = 0, sum1 = 0, sum2 = 0, player = 1; // 1 - 11
   string answerA = "";
   string answerB = "";
   Console.WriteLine("Vítej v programu FlapJack!");
   Random gen = new Random();

   answerA = "a"; // default value (to enter while)
   answerB = "a";

   /*--------------------------------------------MAIN WILE LOOP-------------------------------------------- */
   while ((answerA == "a") || (answerB == "a")) {
    Console.WriteLine("Hraje hráč " + player);
    cardValue = gen.Next(1, 11);
    Console.WriteLine("Číslo na kartě je: " + cardValue);

    if (player == 1) {
     sum1 += cardValue;
     Console.WriteLine("Dosavadní součet je: " + sum1);

     if (sum1 < 21) {
      Console.WriteLine("Chceš další kartu?");
      answerA = Console.ReadLine();
     } else {
      answerA = "n";
     }



     if (answerA == "a") {
      player = 2;
     }
    } else {
     sum2 += cardValue;
     Console.WriteLine("Dosavadní součet je: " + sum2);
     if (sum2 < 21) {
      Console.WriteLine("Chceš další kartu?");
      answerA = Console.ReadLine();
     } else {
      answerB = "n";
     }
     if (answerB == "a") {
      player = 1;
     }
    }
   } // while

   if ((sum1 > sum2) && (sum1 <= 21)) {
    Console.WriteLine("Vyhrál hráč 1");
   }
   if ((sum1 < sum2) && (sum2 <= 21)) {
    Console.WriteLine("Vyhrál hráč 2");
   }
   if ((sum1 == sum2) && (sum2 <= 21)) {
    Console.WriteLine("Nastala remíza");
   }
   if ((sum1 > 21) && (sum2 > 21)) {
    Console.WriteLine("Vyhrál bankéř");
   }
   if ((sum1 <= 21) && (sum2 > 21)) {
    Console.WriteLine("Vyhrál hráč 1");
   }
   if ((sum2 <= 21) && (sum1 > 21)) {
    Console.WriteLine("Vyhrál hráč 2");
   }

   Console.ReadKey();
   /* 
            RULES:
            1) Welcome
			2) generace hodnoty karty vyzmeme z balíku kartu a zjistíme její hodnotu
		    3) Chcete další? -> ano - vypíše skóre
			   -> ne - druhý hráč (back to 2)
			 */

   /*
    1) kolik karet si každý hráč vzal ?
    2) hra myslím si číslo, o kolik se sekl
    3) chcete omezit počet čísel, které lze hádat
    bonus) if (diff < 10) {you are close} 
    */
  }
 }
}

```


