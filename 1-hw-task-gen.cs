  // zkoušení žáků
            Random rnd = new Random();

            int wrong = 0;
            int correct = 0;

            double count = 0;
            double ans = 0;
           

            Console.WriteLine("Zadejte, kolik chcete příkladů:");
            count = int.Parse(Console.ReadLine());
            Console.WriteLine("Zadejte limit čísel");


            for (var i = 0; i < count; i++){
                 int n1 = rnd.Next(1, 10);
                 int n2 = rnd.Next(1, 10);
                string task = n1 + "+" + n2 + "=?";
                int res = n1 + n2;
                Console.WriteLine(task);

                ans = int.Parse(Console.ReadLine());

                if (ans == res){
                    correct += 1;
                } else {
                    wrong += 1;
                }

            }


            Console.WriteLine("You have " + correct / count * 100 + "% correct");
            Console.ReadKey();
