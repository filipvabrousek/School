// 11.12.2018

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



            // get input from file
            string text = "";
            Console.ForegroundColor = ConsoleColor.Green;
            Console.WriteLine("Volby:");
            Console.ForegroundColor = ConsoleColor.White;

            Console.WriteLine("1 - načtení ze souboru ");
            Console.WriteLine("2 - přímý vstup");
            int opt = 0;

            int option = int.Parse(Console.ReadLine());

            if (option == 1){ // get contens of file
                Console.WriteLine("Zadejte název souboru ve kořenové složce projektu");

                var name = Console.ReadLine();
                var path = Directory.GetCurrentDirectory() + "/" + name; // Path.Combine(Directory.GetCurrentDirectory(), "//" + name + "");
                // var path = Path.Combine(Directory.GetCurrentDirectory(), "//" + name + "");
                Console.WriteLine(path);
               
                if (File.Exists(path)){
                    StreamReader sr = new StreamReader(path);
                    string contents = sr.ReadToEnd();
                    text = contents;
                    Console.WriteLine("Contents are " + contents);
                } else {
                    Console.WriteLine("File doesn't exist. DEFAULT text was used.");
                    text = "DEFAULT";
                }

                // text = "DEFAULT";
              

            } else if (option == 2){

                Console.WriteLine("3 - Convert text 2 morse code. ");
                Console.WriteLine("4 - Convert morse code 2 text ");
                opt = int.Parse(Console.ReadLine());


                if (opt == 3){
                    Console.WriteLine("Enter text you would like to convert to morse code");
                    text = Console.ReadLine();
                }

            }



           


            if (opt == 3 || option == 1){ // second if ( option == 1 && totext == 2) add another if
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
                        res += morse[idx] + "|";
                    }
                    else
                    {
                        Console.WriteLine("Length is invalid");
                    }
                }

                StreamWriter sw = null;

                sw = new StreamWriter("texta3-to-morse.txt");

                for (var i = 0; i < res.Length; i++)
                {
                    sw.Write(res[i]);
                }

                sw.Close();

                Console.ForegroundColor = ConsoleColor.Green;
                Console.WriteLine(text + " to morse is " + res);
                Console.ForegroundColor = ConsoleColor.White;

        
                Console.WriteLine("Text byl převeden do morseovky a zapsán do souboru text3-to-morse.txt");
      


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



            if (opt == 4) {

                Console.WriteLine("Zadejte morseovku oddělenou | pro převedení na text.");
                string res = Console.ReadLine();
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
                Console.WriteLine(everystr + " to text is " + resa);
                Console.ForegroundColor = ConsoleColor.White;

                // Write to file

                sw = new StreamWriter("morse1-to-text.txt");

                for (var i = 0; i < resa.Length; i++)
                {
                    sw.Write(resa[i]);
                }

                sw.Close();


                Console.WriteLine("Morseovka byla převedena do textu a zapsána do souboru morse1-to-text.txt");
               

            }
           








            // Convert back to normal text



        }
    }
}
