// 16.1.2018 - together text (informatika)

namespace test1 {
 class Program {
  static void Main(string[] args) {

   int rideA = 0; // 10kč / km     <20 8kč /km
   int rideB = 0;
   int rideC = 0;
   int averageConsumption = 0; // calc
   int petrolPrice = 0;
   int finalPrice = 0;
   int numberOfRides = 0;
   int sumInKm = 0;

   Console.WriteLine("Zadejte počet jízd:");
   numberOfRides = int.Parse(Console.ReadLine());
   Console.WriteLine("Zadejte průměrnou spotřebu na 100km");
   averageConsumption = int.Parse(Console.ReadLine());
   Console.WriteLine("Zadejte cenu benzínu na 1 litr");
   petrolPrice = int.Parse(Console.ReadLine());


   if (numberOfRides == 1) {
    Console.WriteLine("Zadejte délku první jízdy ");
    rideA = int.Parse(Console.ReadLine());
    if (rideA > 20) {
     finalPrice += rideA * 8;
    } else {
     finalPrice += rideA * 10;
    }
    sumInKm = rideA;
    Console.WriteLine("Zaplatit provozovateli (kilometry * 3): " + sumInKm * 3);

    Console.WriteLine("Celková cena benzínu " + sumInKm * averageConsumption / 100 * petrolPrice);
    Console.ReadKey();
   } else if (numberOfRides == 2) {
    Console.WriteLine("Zadejte délku první jízdy ");
    rideA = int.Parse(Console.ReadLine());
    Console.WriteLine("Zadejte délku druhé jízdy ");
    rideB = int.Parse(Console.ReadLine());

    if (rideA > 20) {
     finalPrice += rideA * 8;
    } else {
     finalPrice += rideA * 10;
    }

    if (rideB > 20) {
     finalPrice += rideB * 8;
    } else {
     finalPrice += rideB * 10;
    }
    sumInKm = rideA + rideB;
    Console.WriteLine("Zaplatit provozovateli (kilometry * 3): " + sumInKm * 3);

    Console.WriteLine("Celková cena benzínu " + sumInKm * averageConsumption / 100 * petrolPrice);
    Console.ReadKey();
   } else if (numberOfRides == 3) {
    Console.WriteLine("Zadejte délku první jízdy ");
    rideA = int.Parse(Console.ReadLine());
    Console.WriteLine("Zadejte délku druhé jízdy ");
    rideB = int.Parse(Console.ReadLine());
    Console.WriteLine("Zadejte délku třetí jízdy ");
    rideC = int.Parse(Console.ReadLine());

    if (rideA > 20) {
     finalPrice += rideA * 8;
    } else {
     finalPrice += rideA * 10;
    }

    if (rideB > 20) {
     finalPrice += rideB * 8;
    } else {
     finalPrice += rideB * 10;
    }

    if (rideC > 20) {
     finalPrice += rideC * 8;
    } else {
     finalPrice += rideC * 10;
    }

    sumInKm = rideA + rideB + rideC;
    Console.WriteLine("Zaplatit provozovateli (kilometry * 3): " + sumInKm * 3);

    Console.WriteLine("Celková cena benzínu " + sumInKm * averageConsumption / 100 * petrolPrice);
    Console.ReadKey();
   }




  }
 }
}
