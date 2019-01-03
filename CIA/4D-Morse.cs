using System;
using System.IO;

namespace MorseCode
{
    class MainClass
    {
        public static void Main(string[] args)
        {


            string[] alphabet = { "A", "B", "C", "D", "E", "F", "G", "H", "CH", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", " " };
            string[] morse = { ".-", "-...", "-.-.", "-..", ".", "..-.", "--.", "....", "----", "..", ".---", "-.-", ".-..", "--", "-.", "---", ".--.", "--.-", ".-.", "...", "-", "..-", "...-", ".--", "-..-", "-.--", "--..", " " };
            // .-||-...||-.-.||-..||.||..-.||--.||....||----||..||.---||-.-||.-..||--||-.||---||.--.||--.-||.-.||...||-||..-||...-||-..-||-.--||--..|"
            string name = "";
            /*

1 - Create the file
2 - Load it

            */

            // get input from file
            string text = "";
            int dec = 0;
            Console.ForegroundColor = ConsoleColor.Green;
            Console.WriteLine("Volby:");
            Console.ForegroundColor = ConsoleColor.White;

            Console.WriteLine("1 - načtení ze souboru ");
            Console.WriteLine("2 - přímý vstup");
            int opt = 0;

            int option = int.Parse(Console.ReadLine());


            // get contents of file
            if (option == 1){ // get contens of file
                Console.WriteLine();
                Console.ForegroundColor = ConsoleColor.DarkGreen;
                Console.WriteLine("Načtení ze souboru");
                Console.ForegroundColor = ConsoleColor.White;



                Console.WriteLine("Zadejte název souboru ve kořenové složce projektu bez txt");

                // /Users/filipvabrousek/Projects/MorseCode/MorseCode/bin/Debug/
                name = Console.ReadLine();
                var path = Directory.GetCurrentDirectory() + "/" + name + ".txt"; 
               


                Console.WriteLine("Je soubor v morseovce (8) nebo v textu (9)");
                 dec = int.Parse(Console.ReadLine());

                // CHECK THE PATH 
                // var path = Directory.GetCurrentDirectory() + "/" + nameb; 
                var patha = Directory.GetCurrentDirectory() + "/" + name + ".txt";
                if (File.Exists(patha)){
                    Console.WriteLine("Soubor " + name + "již existuje. Chcete jej přepsat ? (a / n)");

                    var ans = Console.ReadLine();
                    if (ans == "a"){
                        Console.WriteLine("Soubor bude přepsán"); 
                    } else {
                        Console.WriteLine("Zadejte prosím jiný název. (bez .txt)");
                        name = Console.ReadLine();
                    }
                } 

               
                if (File.Exists(path)){
                    StreamReader sr = new StreamReader(path); // here we can define our custom path
                    string contents = sr.ReadToEnd();
                    text = contents;
                    Console.WriteLine("Contents are " + contents);
                } else {
                    Console.WriteLine("Soubor neexistuje.");
                    text = "DEFAULT";
                }

                // text = "DEFAULT";
              

            } else if (option == 2){
                Console.WriteLine();
                Console.ForegroundColor = ConsoleColor.DarkGreen;
                Console.WriteLine("Přímý vstup");
                Console.ForegroundColor = ConsoleColor.White;



                Console.WriteLine("Zadejte název souboru do kterého bude text zapsán (bez .txt)");

                 name = Console.ReadLine();


                // CHECK THE PATH 
                // var path = Directory.GetCurrentDirectory() + "/" + nameb; 
                var patha = Directory.GetCurrentDirectory() + "/" + name;
                if (File.Exists(patha)){
                    Console.WriteLine("Soubor " + name + "již existuje. Chcete jej přepsat ? (a / n)");

                    var ans = Console.ReadLine();
                    if (ans == "a"){
                        Console.WriteLine("Soubor bude přepsán"); 
                    } else {
                        Console.WriteLine("Zadejte prosím jiný název. (bez .txt)");
                        name = Console.ReadLine();
                    }
                } 


                Console.WriteLine("3 - Převod textu do morseovky. ");
                Console.WriteLine("4 - Převod morseovky do textu. ");
                opt = int.Parse(Console.ReadLine());


                if (opt == 3){
                    Console.WriteLine("Zadejte text, který chcete převést do morseovky.");
                    text = Console.ReadLine();
                }

            }



           


            if (opt == 3 || (option == 1 && dec == 9)){ // second if ( option == 1 && totext == 2) add another if
                string res = "";

              


                char[] characters = text.ToCharArray();


                for (var i = 0; i < characters.Length; i++)
                {

                    var ch = characters[i].ToString().ToUpper();
                    // get index of letter in Alphabet field
                    // add letter from morse array in morse field


                    if (alphabet.Length == morse.Length)
                    {
                       

                        var idx = Array.IndexOf(alphabet, ch);
                        // Console.WriteLine("Character is " + ch + " idx is " + idx);
                       
                        if (idx > - 1) {
                            res += morse[idx] + "|";
                        } else {
                            res += "■";
                        }
                       
                    }
                    else
                    {
                        Console.WriteLine("Length is invalid");
                    }
                }

                StreamWriter sw = null;

                sw = new StreamWriter(name);

                for (var i = 0; i < res.Length; i++)
                {
                    sw.Write(res[i]);
                }

                sw.Close();

                Console.ForegroundColor = ConsoleColor.Green;
                Console.WriteLine(text + " v morseovce " + res);
                Console.ForegroundColor = ConsoleColor.White;






        
                Console.WriteLine("Text byl převeden do morseovky a zapsán do souboru " + name + ".txt");
      


            // Beep
                char[] reschar = res.ToCharArray();
                for (var i = 0; i < reschar.Length; i++)
                {
                    var s = reschar[i].ToString();


                    switch (s)
                    {
                        case ".":
                            Console.Beep(100, 200); // should beep short
                            break;
                        case "-":
                            Console.Beep(50, 200); // Should beep long
                            break;

                        default:
                            //  Console.WriteLine("Not the case");
                            break;
                    }
                }
            }



            if (opt == 4 || (option == 1 && dec == 8)) {

                string res = "";
                    
                if (dec != 8){
                    Console.WriteLine("Zadejte morseovku oddělenou | pro převedení na text.");
                        res = Console.ReadLine();
                    } else {
                    res = text;
                    }


              
           
                char[] reschar = res.ToCharArray();


                StreamWriter sw = null;

                var everystr = "";
                for (var i = 0; i < reschar.Length; i++) // ..-.|..|.-..|..|.--.|
                {
                    var ch = reschar[i].ToString();
                    everystr += ch;
                }

                var resa = "";



                string[] split = everystr.Split('|'); // Single quotes character

                for (var i = 0; i < split.Length; i++)
                {

                    var idx = Array.IndexOf(morse, split[i]);

                    if (idx != -1)
                    {
                        resa += alphabet[idx];
                    }
                }

                Console.ForegroundColor = ConsoleColor.Green;
                Console.WriteLine(everystr + " v textu " + resa);
                Console.ForegroundColor = ConsoleColor.White;

                // Write to file

                sw = new StreamWriter("" + name + "");

                for (var i = 0; i < resa.Length; i++)
                {
                    sw.Write(resa[i]);
                }

                sw.Close();


                Console.WriteLine("Morseovka byla převedena do textu a zapsána do souboru " + name + ".txt");
               

            }
           








            // Convert back to normal text



        }
    }
}
