  int x, y, r, s, pom;
            double sum, avg;

            x = 3;
            y = 3;
            r = 0;
            s = 0;
            sum = 0;

            int success = 0;
            int fail = 0;


            int[,] arr = new int[y, x];

            Console.WriteLine("Zadejte souřadnice v pořadí x, y");

            for (r = 0; r < x; r++)
            {
                for (s = 0; s < y; s++)
                {
                   arr[s, r] = int.Parse(Console.ReadLine());
                }
            }

            for (r = 0; r < x; r++)
            {
                for (s = 0; s < y; s++)
                {
                    Console.Write(arr[s, r]);
                }
                Console.WriteLine();
            }


            Console.WriteLine("Kam chcete vystřelit ? Zadejte všechny souřadnice na které chcete vystřelit");
            int[,] shot = new int[y, x];
            for (r = 0; r < x; r++)
            {
                for (s = 0; s < y; s++)
                {
                    shot[s, r] = int.Parse(Console.ReadLine());
                }
            }




            // zkontrolovat výhru
            for (r = 0; r < x; r++)
             {
                 for (s = 0; s < y; s++)
                 {
                     if (arr[s, r] == shot[s, r])
                     {
                         Console.Write(" Zásah na souřadnici " + arr[s, r]);
                        success += 1;
                     } else
                    {
                        Console.Write("Mimo :)");
                        fail += 1;
                    }
                }
                 Console.WriteLine();
             }









            Console.WriteLine("Výpis:");
            Console.WriteLine("Zasáhli jste " + success + " minuli jste " + fail);

            Console.ReadKey();


            /*
            for (s = 0; s < y; s++)
            {
                pom = arr[s, 0];
                sum = sum + pom;
            }
            avg = sum / y;
            Console.WriteLine(avg);


            Console.ReadKey();

    */
