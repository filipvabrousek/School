using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace tester2 {
 class Program {
  static void Main(string[] args) {
   double correct, bad, a, b, input, question, task;

   // 3 příklady vyzkoušet

   Random rand = new Random();
   a = rand.Next(1, 11);
   b = rand.Next(1, 11);

   task = a + b;
   correct = 0;


   Console.WriteLine("Kolik je " + a + "+" + b + "?");
   input = int.Parse(Console.ReadLine());


   if (input == task) {
    correct += 1;
    Console.WriteLine("Correct. Answer is " + input);
   } else {
    Console.WriteLine("False. Answer is " + task);
   }
   Console.ReadKey();


  }
 }
}
