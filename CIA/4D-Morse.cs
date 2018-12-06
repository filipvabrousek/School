// 6.12.2018

using System;
using System.IO;

namespace MorseCode
{
    class MainClass
    {
        public static void Main(string[] args)
        {

            // get input from file
            string text = "";
            Console.WriteLine("Zadejte 1 pro načtení ze souboru a 3 pro přímý vstup 2");

            int option = int.Parse(Console.ReadLine());

            if (option == 1){ // get contens of file
                Console.WriteLine("Zadejte název souboru ve kořenové složce porjektu");

                var name = Console.ReadLine();
                var path = Path.Combine(Directory.GetCurrentDirectory(), "//" + name + "");
               
                if (File.Exists(path)){
                    StreamReader sr = new StreamReader(path);
                    string contents = sr.ReadToEnd();
                    Console.WriteLine("Contents are " + contents);
                } else {
                    Console.WriteLine("File doesn't exist. DEFAULT text was used.");   
                }

                text = "DEFAULT";
              

            } else if (option == 2){
                Console.WriteLine("Enter text you would like to convert to morse code");
                text = Console.ReadLine();
            }


            // Decide how to convert 
           
            string res = "";

            StreamWriter sw = null;

            string[] alphabet = { "A", "B", "C", "D", "E", "F", "G", "H", "CH", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", " " };
            string[] morse = { ".-", "-...", "-.-.", "-..", ".", "..-.", "--.", "....", "----", "..", ".---", "-.-", ".-..", "--", "-.", "---", ".--.", "--.-", ".-.", "...", "-", "..-", "...-", ".--", "-..-", "-.--", "--..", " " };
            // .-||-...||-.-.||-..||.||..-.||--.||....||----||..||.---||-.-||.-..||--||-.||---||.--.||--.-||.-.||...||-||..-||...-||-..-||-.--||--..|"


            char[] characters = text.ToCharArray();


            for (var i = 0; i < characters.Length; i++){

                var ch = characters[i].ToString().ToUpper();
                // get index of letter in Alphabet field
                // add letter from morse array in morse field


                if (alphabet.Length == morse.Length){
                    var idx = Array.IndexOf(alphabet, ch);
                   // Console.WriteLine("Character is " + ch + " idx is " + idx);
                    res += morse[idx] + "|";
                } else {
                    Console.WriteLine("Length is invalid");
                }

            }


            Console.WriteLine(text + " to morse is " + res);


            // Beep
            char[] reschar = res.ToCharArray();
            for (var i = 0; i < reschar.Length; i++){
                var s = reschar[i].ToString();


                switch (s){
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


            // Convert back to normal text

            var everystr = "";
            for (var i = 0; i < reschar.Length; i++) // ..-.|..|.-..|..|.--.|
            {
                var ch = reschar[i].ToString();
                everystr += ch;
            }
             
            var resa = "";

            string[] split = everystr.Split('|'); // Single quotes character

            for (var i = 0; i < split.Length; i++){ 

                var idx = Array.IndexOf(morse, split[i]);

                if (idx != -1) {
                    resa += alphabet[idx];
                }
            }

            Console.WriteLine(everystr + " to text is " + resa);

            // Write to file

            sw = new StreamWriter("inmorseq.txt");

            for (var i = 0; i < resa.Length; i++)
            {
                sw.Write(resa[i]);
            }

            sw.Close();

        }
    }
}
