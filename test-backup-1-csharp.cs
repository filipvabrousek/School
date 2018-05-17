
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



                Console.Write(n[i] + ", ");
            }

            // Console.Write("Average is " + sum / len);
          
            if (even == 6){
                Console.WriteLine("Všechna čísla jsou lichá.");
            }

            if (odd == 6){
                Console.WriteLine("Všechna čísla jsou sudá.");
            }



            // 3 stejná čísla 
            for (var i = 0; i < n.Length - 2; i++){

                int first = n[i];
                int second = n[i + 1];
                int third = n[i + 2];


                if (first == second && second == third){
                    Console.WriteLine("Hodil jste 3 stejná čísla po sobě.");
                }
              

            }
           
            // nestihl jsem: čísla 1 - 6
            if (n[0] != n[1] && n[0] != n[2] && n[0] != n[3] && n[0] != n[4] && n[0] != n[5] 
              && n[1] != n[0] && n[1]!= n[2] && n[1] != n[3] && n[1] != n[4] && n[1] != n[5]
              && n[2] != n[0] && n[2] != n[1] && n[2] != n[3] && n[2] != n[4] && n[2] != n[5]
                && n[3] != n[0] && n[3] != n[0] && n[3] != n[4] && n[3] != n[4] && n[4] != n[5]
                && n[4] != n[0] && n[4] != n[0] && n[4] != n[5] && n[4] != n[4] && n[4] != n[5]
                && n[5] != n[0] && n[5] != n[0] && n[5] != n[3] && n[5] != n[6] && n[5] != n[7]
               )
            {
                Console.WriteLine("Hodili jste čísla 1 - 6");
               }


    


            Console.WriteLine("Hodili jste " + even + " liché (ých) čísel");
            Console.WriteLine(" Hodili jste " + odd + " sudé (ých) čísel.");
            Console.ReadKey();
