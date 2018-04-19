
            
            double sum = 0, res = 0;
            Console.WriteLine("Zadejte délku pole.");
            int maxLen = int.Parse(Console.ReadLine());

            while (maxLen > 20)
            {
                Console.WriteLine("Zadejte menší číslo");
            }
            int[] arr = new int[maxLen];
            /* */

            for (int i = 0; i < maxLen; i++)
            {
                Console.WriteLine("Zadejte známku");
                arr[i] = int.Parse(Console.ReadLine());
                sum += arr[i];

            }
            res = sum / maxLen;
            Console.WriteLine("Průměr je " + res);

            Console.ReadKey();
/*
         /*
            // deklarace
            int[, ] kinosal = new int[5, 5];
            // naplnění daty
            kinosal[2, 2] = 1; // Prostředek

            for (int i = 1; i < 4; i++) // 4. řádek
            {
             kinosal[i, 3] = 1;
            }
            for (int i = 0; i < 5; i++) // Poslední řádek
            {
             kinosal[i, 4] = 1;
            }

            for (int j = 0; j < kinosal.GetLength(1); j++) {
             for (int i = 0; i < kinosal.GetLength(0); i++) {
              Console.Write(kinosal[i, j]);
             }
             Console.WriteLine();
            }
             
             */

*/
