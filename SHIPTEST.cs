
            /*nefunguje mi zadávání lodí přes 2 pole, lze zadat jen jako souřadnici x, y
 vyhodnocení funguje jako porovnání souřadnic požadových střel a zásahů */


            int x, y, r, s, pom;
            double sum, avg, percent;

            x = 3;
            y = 3;
            r = 0;
            s = 0;
            sum = 0;
            percent = 0;
            int success = 0;
            int fail = 0;
            // char[,] pole = new char[sloupcu, radku];
            int xPosition = 0;
            int yPosition = 0;
            char[,] arr = new char[x, y];
            int[,] shot = new int[y, x];


           

            for (r = 0; r < x; r++)
            {
                for (s = 0; s < y; s++)
                {
                    arr[s, r] = '.'; // "."
                }
            }

            /*--------------------------------- SHIP 1 --------------------------------- */
            Console.WriteLine("Zadejte X pozici  lodě 1 (0-2)"); //2*2, 1*1
            xPosition = int.Parse(Console.ReadLine());
            Console.WriteLine("Zadejte Y pozici  lodě 1"); //2*2, 1*1
            yPosition = int.Parse(Console.ReadLine());
            arr[xPosition, yPosition] = 'X'; // "."



            Console.WriteLine("Zadejte X pozici  lodě 2"); //2*2, 1*1
            xPosition = int.Parse(Console.ReadLine());
            Console.WriteLine("Zadejte Y pozici  lodě 2"); //2*2, 1*1
            yPosition = int.Parse(Console.ReadLine());
            arr[xPosition, yPosition] = 'X'; // "."


            Console.WriteLine("Zadejte X pozici  lodě 3"); //2*2, 1*1
            xPosition = int.Parse(Console.ReadLine());
            Console.WriteLine("Zadejte Y pozici  lodě 3"); //2*2, 1*1
            yPosition = int.Parse(Console.ReadLine());
            arr[xPosition, yPosition] = 'X'; // "."






            Console.WriteLine("Kam chcete vystřelit ? Zadejte všechny souřadnice na které chcete vystřelit");
           // int[,] shot = new int[y, x];
            for (r = 0; r < x; r++)
            {
                for (s = 0; s < y; s++)
                {
                    shot[s, r] = int.Parse(Console.ReadLine());
                }
            }



            Console.WriteLine(shot);
            
          
            // write board on the screen
            for (r = 0; r < x; r++)
            {
                for (s = 0; s < y; s++)
                {
                    Console.Write(arr[s, r]);
                }
                Console.WriteLine();
            }


            // check win
            for (r = 0; r < x; r++)
            {
                for (s = 0; s < y; s++)
                {
                    if (arr[s, r] == shot[s, r])
                    {
                        Console.Write(" Zásah na souřadnici " + arr[s, r]);
                        success += 1;
                    }
                    else
                    {
                        Console.Write("Mimo :)");
                        fail += 1;
                    }

                    if (success > fail)
                    {
                        percent = (fail / success) * 100;
                    }
                    else
                    {
                        percent = (success / fail) * 100;
                    }
                }
                Console.WriteLine();
            }



            Console.WriteLine("Výpis:");
            Console.WriteLine("Zasáhli jste " + success + " minuli jste " + fail + " zasáhli jste " + percent + " lodí" + " minuli jste " + (100 - percent) + " % lodí");

            Console.ReadKey();
