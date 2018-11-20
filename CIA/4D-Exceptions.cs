using System;

namespace Exceptions
{
    class MainClass
    {
        public static void Main(string[] args)
        {


            string input;



            while(true){
                try {
                    Console.WriteLine("Zadejte známku 1 až 5. nebo Enter pro ukončení.");
                    input = Console.ReadLine();

                    if (input == String.Empty){
                        break;
                    }

                    int mark = int.Parse(input);

                    if (mark < 1 || mark > 5) {
                        throw new IndexOutOfRangeException("Zadané číslo " + mark + " není platná známka");
                    }

                    Console.WriteLine("Ukládám známku {0}");
                }


                catch (IndexOutOfRangeException e){
                    Console.WriteLine("Exception of type IndexOutOfRangeException has been caught. {0}", e.Message);
                }


                catch (Exception e) {
                    Console.WriteLine("Zachycena výjimka typu " + e.Message); // even when I enter String
                }

                finally {
                    Console.WriteLine("Děkujeme za použití.");
                }
            }
        }
    }
}
