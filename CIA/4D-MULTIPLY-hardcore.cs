using System;
using System.Collections;
using System.Collections.Generic;
using System.IO;
            
namespace h
{
    class MainClass
    {




        public static void Main(string[] args)
        {


            Console.WriteLine("Zadejte čísla 168 a 18.");
            Console.WriteLine("Kolik míst bude mít číslo, které chcete zadat ? (Méně než 10");
            int size = int.Parse(Console.ReadLine());
            int[] numbers = new int[size];


            Console.WriteLine("Zadejte číslo, které chcete násobit");

            int top = int.Parse(Console.ReadLine());
            string str = top.ToString();
            // Console.WriteLine("Zadali jste číslo " + top);

            for (var i = 0; i < str.Length; i++)
            {
                numbers[i] = int.Parse(str[i].ToString());

            }



            // Console.WriteLine("Number is " + numbers[0] + numbers[2]);









            Console.WriteLine("Kolik míst bude mít číslo, kterým chcete zadat ? (Méně než 10");
            int sizeb = int.Parse(Console.ReadLine());
            int[] numbersb = new int[sizeb];

            Console.WriteLine("Zadejte číslo, kterým chcete násobit");

            int topa = int.Parse(Console.ReadLine());
            string stra = topa.ToString();

            for (var i = 0; i < stra.Length; i++)
            {
                numbersb[i] = int.Parse(stra[i].ToString());

            }


            Console.WriteLine("Results from arrays");


            for (var i = 0; i < numbers.Length; i++)
            {
                Console.Write(numbers[i]);

            }

            Console.WriteLine();

            for (var i = 0; i < numbersb.Length; i++)
            {
                Console.Write(numbersb[i]);

            }


            /*tvorba násobení 

            test na 162 * 18 pod sebou
            */


            // shorter field
            int hold = 0;


            // getting "8 x 2 je 16 píšu 6 a 1 si držím"

            Console.WriteLine();
            Console.WriteLine("The loop should work " + numbersb.Length + "x");

            string firstline = "";

            int pr = 0;


            // MAIN COUNTING LOOP 
            for (var i = 0; i < numbers.Length; i++){
                hold = 0;

                int a = numbersb[numbersb.Length - 1]; // last number of 18 (8)

                if (i == 0)
                {
                    i = 1;
                }

                int b = numbers[numbers.Length - i]; // * every element of numbers

                int tempres = 0;
                int get = a * b + tempres;
                 hold = getHold(get);


               
                if (i != 1){
                    tempres = a * b + hold;
                    Console.WriteLine("yyy hold ");
                } else {
                    tempres = a * b;
                   
                    Console.WriteLine("xxx");
                }


                Console.WriteLine("================================================================================================================");
                Console.WriteLine("i is " + i + "a " + a + " * " + b + " is " + (a * b) + "  Result is " + tempres + " I am holding " + hold + " writing " + (tempres % 10));

                // I am writing last digit of tempres
                firstline += (tempres % 10);

            }



            Console.WriteLine("RESULT OF THE FIRST LINE: ");

            string res = rev(firstline);

            Console.WriteLine(res); // Should be 1344




            // Write to disc
            StreamWriter writer = new StreamWriter("loggera.txt");
            writer.WriteLine(res);
            writer.Close();


        }


        static int getHold(int a){
            
           

            int hold = 0;
            int res = a;

            // Console.WriteLine("Hold is called with value " + res);


            if (res >= 10 && res < 20)
            { // hold on
                hold = 1;
              //  Console.WriteLine("Called for 1");
            } else if (res >= 20 && res < 30){
                hold = 2;
            } else if (res >= 30 && res < 40){
                hold = 3;
            } else if (res >= 40 && res < 50){
                hold = 4;
            } else if (res >= 50 && res < 60){
                hold = 5;
            } else if (res >= 60 && res < 70){
                hold = 6;
                Console.WriteLine("Called for 6 because of " + res);

            } else if (res >= 70 && res < 80){
                hold = 7;
            } else if (res >= 80 && res < 90){
                hold = 8;
            } else if (res >= 90 && res < 100){
                hold = 9;
            } else {
                hold = 0;  
            }

            Console.WriteLine("Hold for  " + res + "is " + hold);

            return hold;
        }

        public static string rev(string str)
        {
            var arr = str.ToCharArray();
            Array.Reverse(arr);
            return new string(arr);
        }

        /*

 var ary = source.ToCharArray();
    Array.Reverse(ary);
    return new string(ary);
        */
    }



    /*
    1 - načíst vstup
    2 - velikost pole
    3 - odprava doleva násobení
    4 - výsledek do ".txt" souboru


-> 241
->  23

    241
    023
    */

}
   
