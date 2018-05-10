 int a = 0;
            int b = 0;
            /* Console.WriteLine(separator(100000)); */
            Console.WriteLine("Součet /a a /b je: " + super(ref a, ref b)); // passed by reference
            Console.WriteLine("a je " + a);
            Console.WriteLine("b je " + b);
            Console.ReadKey();

        }

        static int load(int count){
           
            Console.WriteLine("Zadejte " + count + " cislo");
            int number = Int32.Parse(Console.ReadLine());
            return number;
        }

      

        static void separator(int count) {
             for (var i = 0; i < count; i++){
                Console.Write("-");
            }
        }

        static int super(ref int a, ref int b){
            Console.WriteLine("Zadejte prvni cislo");
            a = Int32.Parse(Console.ReadLine());

            Console.WriteLine("Zadejte druhe cislo");
            b = Int32.Parse(Console.ReadLine());
            return a+b;
        }


        /*
         zadat kolik chce příkladů 
         napíše mu příklad, zkontroluje
         kolik dobře, kolik špatně
         */
