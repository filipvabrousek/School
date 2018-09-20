// 16.5.2018 test

double sum = 0, average = 0, numberOfShots = 0;
int shot1 = 0;
Console.WriteLine("Vítejte ve střelecké hře");
Console.WriteLine("Zadejte hodnoty jednotlivých střel. Pro ukončení zadej číslo 11");


int ans2 = 0;
string answer = "a";
while (answer == "a") {

 if (ans2 != 11 /* answer != "n" && */ /*shot1 != 11*/ ) {
  Console.WriteLine("Zadejte hodnotu střely");
  shot1 = int.Parse(Console.ReadLine());

  if (shot1 != 11) {
   numberOfShots += 1;
   sum += shot1;
   Console.WriteLine("Hodnota střely " + numberOfShots + "je " + shot1);
  } else {
   answer = "n";
  }



 }


 average = sum / numberOfShots;
 Console.WriteLine("Průměr je: " + average);
}
