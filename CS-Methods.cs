 static void Main(string[] args)
        {

            first();
            int x = getNumber();
            int[] nums = getField();

            Console.WriteLine("Zadaná čísla");

            for (int i = 0; i < nums.Length; i++)
            {
                Console.WriteLine(nums[i]);
            }

            Console.WriteLine("Vrácené číslo je " + x);
            Console.ReadKey();
        }





        static void first(){
            Console.WriteLine("Zdraví tě tvá 1. metoda");
        }

        static int getNumber(){
            Console.WriteLine("Zadejte číslo");
            int number = Int32.Parse(Console.ReadLine());
            return number;
        }

        static int[] getField(){
            Console.WriteLine("Zadej počet čísel");
            int count = Int32.Parse(Console.ReadLine());
            int[] numbers = new int[count];

            for (int i = 0; i < count; i++) {
                Console.WriteLine(i + ". Zadejte číslo");
                 numbers[i] = Int32.Parse(Console.ReadLine());
            }


            return numbers;
        }
