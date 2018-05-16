using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Game {
 class Program {
  static void Main(string[] args) {

   int rand = 0;
   int answer = 0;
   int playerScore = 0;
   int computerScore = 0;
   string carryOn = "n";
   Random gen = new Random();




   carryOn = "a";

   while (carryOn == "a") {

    rand = gen.Next(1, 11);
    Console.WriteLine(rand); // 8

    Console.WriteLine("Myslím si číslo, hádej jaké ?");
    answer = int.Parse(Console.ReadLine());


    if (answer == rand) {
     Console.WriteLine("Dobře ty!, chceš hrát dál? (a/n");
     carryOn = Console.ReadLine();
     playerScore += 1;
    } 
	
	else {
     computerScore += 1;
     if ((answer - rand) >  1 || (answer - rand) <  -1) {
      Console.WriteLine("Chyba! Jsi hodně mimo(" + (answer - rand) + ")");
     } else {
      Console.WriteLine("Chyba! Jsi o trochu mimo (" + (answer - rand) + ")");
     };

     carryOn = "n";
    }


    Console.WriteLine("Computer: " + computerScore + " " + "player: " + playerScore);
   }





  }
 }
}
