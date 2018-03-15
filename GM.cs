
// value of each shot
int  shot2, shot3, shot4, shot5, shot6, shot7, shot8, shot9, shot10;
string answer;
double sum = 0, average = 0, numberOfShots = 0;
int shot1 = 0;
Console.WriteLine("Vítejte ve střelecké hře");
Console.WriteLine("Zadejte hodnoty jednotlivých střel. Pro ukončení zadej číslo 11");


int ans2 = 0;
answer = "a";
while(answer == "a"){

if ( ans2 != 11  /* answer != "n" && */ /*shot1 != 11*/){
Console.WriteLine("Zadejte hodnotu střely");
shot1 = int.Parse(Console.ReadLine());
numberOfShots += 1;
sum += shot1;
Console.WriteLine("Hodnota střely " + numberOfShots + "je " + shot1);


Console.WriteLine("Chceš zadat další?");
ans2 = int.Parse(Console.ReadLine());

}



  }



average = sum / numberOfShots;
Console.WriteLine("Průměr je: " + average);



/*
 

Console.WriteLine("Kolik hodnot si přejete zadat?");
int limit = int.Parse(Console.ReadLine());
int actual = 0;
  while(actual < limit){
     
Console.WriteLine("Zadejte číslo 1");
      shot1 = int.Parse(Console.ReadLine());
 actual++;
Console.WriteLine(actual);

Console.WriteLine("Zadejte číslo 2");
      shot2 = int.Parse(Console.ReadLine());
  actual++;
Console.WriteLine(limit);

Console.WriteLine("Zadejte číslo 3");
      shot3 = int.Parse(Console.ReadLine());
      actual++;
Console.WriteLine(actual);

Console.WriteLine("Zadejte číslo 4");
      shot4 = int.Parse(Console.ReadLine());
      actual++;
Console.WriteLine(actual);
  }
*/
