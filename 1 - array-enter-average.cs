 double sum = 0;

            Console.WriteLine("Zadejte délku pole:");
            int len = int.Parse(Console.ReadLine());
            int[] n = new int[len];
          
            for (var i = 0; i < n.Length; i++) {
                Console.WriteLine("Zadejte hodnotu střely");
                n[i] = int.Parse(Console.ReadLine());
            }



            for (var i = 0; i < n.Length; i++){
                sum += n[i];
                Console.Write(n[i] + ", ");
            }

            Console.Write("Average is " + sum / len);

            Console.ReadKey();
