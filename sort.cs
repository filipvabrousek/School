 /*
             počet oprvků
             random
             setřídit
             největší, nejmenší
             */
            int[] arr = new int[6];
            int i;
            int j;
            int helper = 0;

            Console.WriteLine("zadejte 6 čísel");
            for ( i = 0; i < 6; i++) {
             arr[i] = int.Parse(Console.ReadLine());
            }

         


            Console.WriteLine("výpis");
            for (j = 0; j < 6 - 1; j++ )
            {

                for (i = 0; i < (6 - j - 1); i++)
                {
                    if (arr[i] > arr[i + 1]){
                        helper = arr[i];
                        arr[i] = arr[i + 1];
                        arr[i + 1] = helper;
                    }

                }

                Console.Write(arr[i] + " ");


            }
            
            Console.ReadKey();
