using System;
using System.IO;

namespace MorseCode
{
    class MainClass
    {
        public static void Main(string[] args)
        {
            // https://supermartas.cz/aplikace/online/prekladac-morseovky/

            string[] alphabet = { "A", "B", "C", "D", "E", "F", "G", "H", "CH", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", " ", "." };
            string[] morse = { ".-", "-...", "-.-.", "-..", ".", "..-.", "--.", "....", "----", "..", ".---", "-.-", ".-..", "--", "-.", "---", ".--.", "--.-", ".-.", "...", "-", "..-", "...-", ".--", "-..-", "-.--", "--..", "||", ".-.-.-." };
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

            Console.WriteLine("Zadejte 1 pro načtení ze souboru ");
            Console.WriteLine("Zadejte 2 pro přímý vstup");
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

                if (File.Exists(path)) { 
                    
                } else {
                    Console.WriteLine("Soubor nenalezen.");
                }
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


               
                var patha = "/Users/filipvabrousek/Desktop/morse/" + name + ".txt";
              
                if (File.Exists(patha)){
                    Console.WriteLine("Soubor " + name + "již existuje. Chcete jej přepsat přloženým souborem ? (a / n)");

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
              

                /*
                ::::::::::::::::::::::::::: Přímý vstup

                */
            } else if (option == 2){
                Console.WriteLine();
                Console.ForegroundColor = ConsoleColor.DarkGreen;
                Console.WriteLine("Přímý vstup");
                Console.ForegroundColor = ConsoleColor.White;

                Console.WriteLine("Zadejte název souboru do kterého bude text zapsán (bez .txt)");

                name = Console.ReadLine();


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

               


                Console.WriteLine("Zadejte 3 pro převod textu do morseovky.");
                Console.WriteLine("Zadejte 4 pro převod morseovky do textu.");
                opt = int.Parse(Console.ReadLine());
               

                if (opt == 3){
                    Console.WriteLine("Zadejte text, který chcete převést do morseovky.");
                    text = Console.ReadLine();

                    var eqtottext = "";

                    // remove diacritics
                    foreach (char m in text){
                        eqtottext += longToShort(m.ToString().ToUpper());
                    }



                    text = eqtottext;

                    // EQTEXT
                    Console.WriteLine("Text" + eqtottext);

                }

            }



           

                /*
            ::::::::::::::::::::::::::: Převod textu na morseovku

            */

            if (opt == 3 || (option == 1 && dec == 9)){ // second if ( option == 1 && totext == 2) add another if
                string res = "";

              


                char[] characters = text.ToCharArray();

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
                   // Console.WriteLine("Ch pre:" + ch);
                    ch = longToShort("" + ch + "");
                
                    Console.WriteLine("Ch CONVERTED: " + ch);

                    // get index of letter in Alphabet field
                    // add letter from morse array in morse field


                    if (alphabet.Length == morse.Length)
                    {
                     //   Console.WriteLine("Char " + ch);




                        var idx = Array.IndexOf(alphabet, ch);
                        // Console.WriteLine("Character is " + ch + " idx is " + idx);
                       
                        if (idx > - 1) {
                            res += morse[idx] + "/";
                        } else {
                            if (ch == "Γ")
                            {
                                res += ".-.-.-.";
                            }
                            else if (ch == "Δ")
                            {
                                res += "||"; // 237 is space two ||
                            }
                            else
                            {
                                Console.WriteLine("DO NOT FIRE");

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



                /*
                ::::::::::::::::::::::::::: Zápis do souboru

                */


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
                Console.WriteLine(text + " v morseovce (275) " + res);
                Console.ForegroundColor = ConsoleColor.White;






        
                Console.WriteLine("Text byl převeden do morseovky a zapsán do souboru" + name + ".txt");
                Console.WriteLine("Cesta k souboru je " + "/Users/filipvabrousek/Desktop/morse" + "/" + name + ".txt");



               

               

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
                      /*  case  "⬛":
                            
                            break;

                        case " ":
                           
                            break;

                        case "|":
                            break;
                            // case black square nothing
                        case "/":
                            break;*/

                        default:
                            //  Console.WriteLine("Not the case");
                            break;
                    }
                }
            }



            if (opt == 4 || (option == 1 && dec == 8)) {

                string res = "";
                    
                if (dec != 8){
                    Console.WriteLine("Zadejte morseovku oddělenou / pro převedení na text.");
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



                if (everystr.Contains(".-.-.-.")){
                    everystr.Replace(".-.-.-.", "Γ"); // .
                } 
                // ../.-/--//
                if (everystr.Contains("/")){
                      everystr.Replace("/", "Δ");  
                  
                }

                // ../.-/--//
              
                Console.WriteLine(everystr);

                string[] split = everystr.Split('/'); // Single quotes character

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
                           /* if (i != everystr.Length - 1){
                                resa += "⬛";
                            }*/

                        }
                    }
                }

                Console.ForegroundColor = ConsoleColor.Green;
                Console.WriteLine(everystr + " v textu (399)\t" + resa);
                Console.ForegroundColor = ConsoleColor.White;

                // Write to file

                sw = new StreamWriter("/Users/filipvabrousek/Desktop/morse" + "/" + name + "-morse.txt");

                for (var i = 0; i < resa.Length; i++)
                {
                    sw.Write(resa[i]);
                }

                sw.Close();


                Console.WriteLine("Morseovka byla převedena do textu a zapsána do souboru " + name + "-morse.txt");
               

            }
           








            // Convert back to normal text



        }

        // VÍTEJTE !!!

        static string longToShort(string a){


            string ret = "";


            switch (a){
                case "Á":
                    ret = "A";
                    break;

                case "Č":
                    ret = "C";
                    break;

                case "Ď":
                    ret = "A";
                    break;

                case "É":
                    ret = "E";
                    break;

                case "Ě":
                    ret = "E";
                    break;

                case "Í":
                    ret = "I";
                    break;

                case "Ň":
                    ret = "N";
                    break;

                case "Ó":
                    ret = "O";
                    break;

                case "Ř":
                    ret = "R";
                    break;

                case "Š":
                    ret = "S";
                    break;

                case "Ú":
                    ret = "U";
                    break;

                case "Ů":
                    ret = "U";
                    break;

                case "Ý":
                    ret = "Y";
                    break;

                case "Ž":
                    ret = "Z";
                    break;



                
                default:
                    ret = a;
                    break;
            
            
            }

            return ret;
        }
    }
}
