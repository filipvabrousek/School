 /*nefunguje mi zadávání lodí přes 2 pole, lze zadat jen jako souřadnici x, y
 vyhodnocení funguje jako porovnání souřadnic požadových střel a zásahů */


            int x, y, r, s, pom;
            double sum, avg, percent;

            x = 10;
            y = 10;
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
                    arr[s, r] = 'O'; // "."
                }
            }

            /*--------------------------------- SHIP 1 --------------------------------- */
            Console.WriteLine("Zadejte X pozici  lodě 1 (0-10)"); //2*2, 1*1
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
            arr[xPosition, yPosition] = 'X'; 
            arr[xPosition + 1 , yPosition + 1] = 'X'; // 2 fields

            for (r = 0; r < x; r++)
            {
                for (s = 0; s < y; s++)
                {
                    Console.Write(arr[s, r]);
                }
                Console.WriteLine();
            }



            Console.WriteLine("Kam chcete vystřelit ? Zadejte všechny souřadnice na které chcete vystřelit");
            // int[,] shot = new int[y, x];

            Console.WriteLine("Zadejte X pozici  výstřelu"); //2*2, 1*1
            xPosition = int.Parse(Console.ReadLine());
            Console.WriteLine("Zadejte Y pozici  výstřelu"); //2*2, 1*1
            yPosition = int.Parse(Console.ReadLine());
            shot[xPosition, yPosition] = 'O'; // výstřel

            // check win
            for (r = 0; r < x; r++)
            {
                for (s = 0; s < y; s++)
                {
                    if (arr[s, r] == shot[xPosition, yPosition])
                    {
                        success += 1;
                    }
                    else
                    {
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
