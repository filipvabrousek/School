  int[] n = new int[6];
            int odd = 0;
            int even = 0;

            for (var i = 0; i < n.Length; i++)
            {
                Console.WriteLine("Zadejte hodnotu hodu " + (i + 1));
                n[i] = int.Parse(Console.ReadLine());
            }



            for (var i = 0; i < n.Length; i++)
            {

                if (n[i] % 2 == 0){
                    odd += 1;
                } else {
                    even += 1;
                }


                /*

                    if (n[0] == n[1] == n[2]){
                        Console.WriteLine("Padly 3 stejné kostky.");
                    }*/

                Console.Write(n[i] + ", ");
            }

            // Console.Write("Average is " + sum / len);
          
            if (even == 6){
                Console.WriteLine("Všechna čísla jsou lichá.");
            }

            if (odd == 6){
                Console.WriteLine("Všechna čísla jsou sudá.");
            }

            Console.WriteLine("Hodili jste " + even + " liché (ých) čísel");
            Console.WriteLine(" Hodili jste " + odd + " sudé (ých) čísel.");
                
            Console.ReadKey();
