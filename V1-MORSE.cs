using System;
using System.IO;

namespace MorseCode
{
    class MainClass
    {
        public static void Main(string[] args)
        {


            string[] alphabet = { "A", "B", "C", "D", "E", "F", "G", "H", "CH", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", " ", "." };
            string[] morse = { ".-", "-...", "-.-.", "-..", ".", "..-.", "--.", "....", "----", "..", ".---", "-.-", ".-..", "--", "-.", "---", ".--.", "--.-", ".-.", "...", "-", "..-", "...-", ".--", "-..-", "-.--", "--..", " ", "|||" };
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
            if (option == 1){ 
                Console.WriteLine();
                Console.ForegroundColor = ConsoleColor.DarkGreen;
                Console.WriteLine("Načtení ze souboru");
                Console.ForegroundColor = ConsoleColor.White;



                Console.WriteLine("Zadejte název souboru ve složce morse' na ploše. (bez .txt)");

                // /Users/filipvabrousek/Projects/MorseCode/MorseCode/bin/Debug/
                // Get path
                name = Console.ReadLine();
                // var path = Directory.GetCurrentDirectory() + "/" + name + ".txt"; 
                var path = "/Users/filipvabrousek/Desktop/morse" + "/" + name + ".txt";

                // Je soubor 

                StreamReader sr = new StreamReader(path); // here we can define our custom path
                string contents = sr.ReadToEnd();
                var ctx = contents;
                Console.WriteLine("Contents are " + ctx);

              

                foreach (var letter in alphabet){
                    if (ctx.IndexOf(letter) > 0) {
                       
                        dec = 9;

                    } else {
                       
                        dec = 8;
                    }
                }

                if (dec == 9) {
                    Console.WriteLine("Soubor je v textu.");
                }

                if (dec == 8){
                    Console.WriteLine("Soubor je v morseovce.");
                }


               // Console.WriteLine("Je soubor v morseovce (8) nebo v textu (9)");
                // dec = int.Parse(Console.ReadLine());

                // CHECK THE PATH 
                // var path = Directory.GetCurrentDirectory() + "/" + nameb; 
                var patha = "/Users/filipvabrousek/Desktop/morse/" + name + ".txt"; // Directory.GetCurrentDirectory() + "/" + name + ".txt";
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
                    StreamReader sro = new StreamReader(path); // here we can define our custom path
                    string contentsa = sro.ReadToEnd();
                    text = contentsa;
                    Console.WriteLine("Contents are " + contentsa);
                } else {
                    Console.WriteLine("Soubor neexistuje.");
                   // text = "DEFAULT";
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
                var patha = "/Users/filipvabrousek/Desktop/morse/" + name + ".txt";
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



           
            // convert text 2 morse

            if (opt == 3 || (option == 1 && dec == 9)){ // second if ( option == 1 && totext == 2) add another if
                string res = "";

              


                char[] characters = text.ToCharArray();

                /*
          if (everystr.Contains("|||")){
                    everystr.Replace("|||", "Γ"); // .
                } 

                if (everystr.Contains("||")){
                    everystr.Replace("||", "Δ"); // 
                } 





                string[] split = everystr.Split('|'); // Single quotes character

                for (var i = 0; i < split.Length; i++)
                {

                    var idx = Array.IndexOf(morse, split[i]);

                    if (idx != -1)
                    {
                        resa += alphabet[idx];
                    } else {
                        if (split[i] == "Γ"){
                            resa += ".";
                        } else if (split[i] == "Δ"){
                            resa += " ";
                        }  else {
                            resa += "⬛";
                        }
                    }
                }
                */



                var stro = new String(characters);


                if (stro.Contains(".")){
                    stro.Replace(".", "Γ"); // .
                } 

                if (stro.Contains(" ")){
                    stro.Replace(" ", "Δ"); // 
                } 


                for (var i = 0; i < stro.Length; i++)
                {

                    // var ch = characters[i].ToString().ToUpper();
                    var ch = stro[i].ToString().ToUpper();
                    // get index of letter in Alphabet field
                    // add letter from morse array in morse field


                    if (alphabet.Length == morse.Length)
                    {
                        Console.WriteLine("Char " + ch);

                        var idx = Array.IndexOf(alphabet, ch);
                        // Console.WriteLine("Character is " + ch + " idx is " + idx);
                       
                        if (idx > - 1) {
                            res += morse[idx] + "|";
                        } else {
                            if (ch == "Γ")
                            {
                                res += "|||";
                            }
                            else if (ch == "Δ")
                            {
                                res += "||";
                            }
                            else
                            {
                                res += "⬛";
                            }
                            //res += "■";
                        }
                       
                    }
                    else
                    {
                        Console.WriteLine("Length is invalid");
                    }
                }

                StreamWriter sw = null;

                //  sw = new StreamWriter(name);
                //  var path = "/Users/filipvabrousek/Desktop/morse" + "/" + name + ".txt";
                sw = new StreamWriter("/Users/filipvabrousek/Desktop/morse" + "/" + name + "-morse.txt");
                for (var i = 0; i < res.Length; i++)
                {
                    sw.Write(res[i]);
                }

                sw.Close();

                Console.ForegroundColor = ConsoleColor.Green;
                Console.WriteLine(text + " v morseovce " + res);
                Console.ForegroundColor = ConsoleColor.White;






        
                Console.WriteLine("Text byl převeden do morseovky a zapsán do souboru " + name + ".txt");
                Console.WriteLine("Cesta k souboru je " + "/Users/filipvabrousek/Desktop/morse" + "/" + name + ".txt");
      


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



                if (everystr.Contains("|||")){
                    everystr.Replace("|||", "Γ"); // .
                } 

                if (everystr.Contains("||")){
                    everystr.Replace("||", "Δ"); // 
                } 





                string[] split = everystr.Split('|'); // Single quotes character

                for (var i = 0; i < split.Length; i++)
                {

                    var idx = Array.IndexOf(morse, split[i]);

                    if (idx != -1)
                    {
                        resa += alphabet[idx];
                    } else {
                        if (split[i] == "Γ"){
                            resa += ".";
                        } else if (split[i] == "Δ"){
                            resa += " ";
                        }  else {
                            if (i != everystr.Length - 1){
                                resa += "⬛";
                            }

                        }
                    }
                }

                Console.ForegroundColor = ConsoleColor.Green;
                Console.WriteLine(everystr + " v textu " + resa);
                Console.ForegroundColor = ConsoleColor.White;

                // Write to file

                sw = new StreamWriter("/Users/filipvabrousek/Desktop/morse" + "/" + name + "-morse.txt");

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
