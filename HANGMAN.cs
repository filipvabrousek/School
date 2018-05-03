            string text = ""; // use enters the string

            int tries = 0;
            char guess = 'O';

            Console.WriteLine("Zadejte text");
            text = Console.ReadLine(); // string
            char[] empty = new char[text.Length]; // string where will be our guess
            Console.WriteLine("Zadejte počet pokusů (tolik jako písmen. Pokud slovo obsahuje písmeno 2x nebo vícekrát počítá se jako jedno");
            Console.WriteLine("tzv. na slove Filip stačí 4 pokusy");
            tries = int.Parse(Console.ReadLine());
            int correct = 0;

            for (var i = 0; i < tries; i++)
            {
                Console.WriteLine("Zadejte písmeno");

                guess = char.Parse(Console.ReadLine());
                for (var n = 0; n < text.Length; n++)
                {
                    if (text[n].ToString().ToUpper() == guess.ToString().ToUpper())
                    {
                        empty[n] = guess;
                        correct += 1;
                        if (correct == text.Length) {
                            Console.WriteLine("Vyhráli jste!");
                    }
                    }

                }

            
                Console.WriteLine(new string(empty));
                Console.WriteLine(empty.Length);

            }

       
            Console.ReadKey();
        
