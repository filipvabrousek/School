
            
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
