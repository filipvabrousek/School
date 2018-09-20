 // 18.1.2018
 
 double people, onePerson, volume, result;

 Console.WriteLine("Zadejte počet lidí ");
 people = double.Parse(Console.ReadLine());

 Console.WriteLine("Zadejte objem cisterny (l)");
 volume = double.Parse(Console.ReadLine());


 Console.WriteLine("Zadejte průměrnou spotřebu na 1 den na 1 obyvatele (l) ");
 onePerson = double.Parse(Console.ReadLine());
 // number of routes
 result = onePerson * people / volume;




 Console.WriteLine("Cisterna musí přijet " + result + "krát denně");


 Console.WriteLine("Cisterna musí přijet každou / každých " + 24 / result + "hodin (y)");
 if (result / 24 >= 1) {
  Console.WriteLine("Cisterna musí přijet každou hodinu / častěji");
 } else {
  Console.WriteLine("Cisterna nemusí přijet každou hodinu / častěji");
 }




 if (volume >= result * 7) {
  Console.WriteLine("Stačí když přijedou jednou týdně");
 } else {

  Console.WriteLine("Nestačí když přijedou jednou týdně");

 }
 Console.ReadKey();
