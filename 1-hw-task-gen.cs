
            // zkoušení žáků
            Random rnd = new Random();

            int wrong = 0;
            int correct = 0;

            double count = 0;
            double ans = 0;
            int limit = 0;
            int randop = 0;
           // int srOperand = "";


            Console.WriteLine("Zadejte, kolik chcete příkladů:");
            count = int.Parse(Console.ReadLine());
            Console.WriteLine("Zadejte horní hranici čísel");
            limit = int.Parse(Console.ReadLine());

            for (var i = 0; i < count; i++)
            {
                randop = rnd.Next(1, 4);

                int n1 = rnd.Next(1, limit);
                int n2 = rnd.Next(1, limit);
                string task = "";
                int res = n1 + n2;

                switch (randop){
                    case 1:
                       // srOperand = "+";

                        task = n1 + "+" + n2 + "=?";
                        res = n1 + n2;
                        break;
                       
                    case 2:
                       // srOperand = "-";
                        task = n1 + "-" + n2 + "=?";
                        res = n1 - n2;
                        break;
                       
                    case 3:
                        task = n1 + "*" + n2 + "=?";
                        res = n1 * n2;
                        break;
                      
                    case 4:
                        task = n1 + "/" + n2 + "=?";
                        if (n2 > 0) {
                            res = n1 / n2;
                        } else {
                            Console.WriteLine("vyšlo záporné číslo.");
                        }
                        break;
                        
                }



                Console.WriteLine(task);


                ans = int.Parse(Console.ReadLine());

                if (ans == res)
                {
                    correct += 1;
                }
                else
                {
                    wrong += 1;
                }

            }


            Console.WriteLine("Máte " + Math.Round(correct / count * 100) + "% správně");
            Console.ReadKey();
