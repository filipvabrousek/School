using System;

namespace MorseCode
{
    class MainClass
    {
        public static void Main(string[] args)
        {
            // Convert text in Morse Code and beep
            Console.WriteLine("Enter text you would like to convert to morse code");
            string text = Console.ReadLine();
            string res = "";

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
                    Console.WriteLine("Character is " + ch + " idx is " + idx);
                    res += morse[idx] + "|";
                } else {
                    Console.WriteLine("Length is invalid");
                }

            }


            Console.WriteLine("Result is " + res);


            // Beep
            char[] reschar = res.ToCharArray();
            for (var i = 0; i < reschar.Length; i++){
                var s = reschar[i].ToString();

                Console.WriteLine("S is: " + s);
                switch (s){
                    case ".":
                        Console.Beep(600, 200);
                        Console.WriteLine("Should beep short");
                        break;
                    case "-": 
                        Console.Beep(600, 100);
                        Console.WriteLine("Should beep long");
                        break;

                    default:
                        Console.WriteLine("Not the case");
                        break;
                }
            }







// 1 - convert text to array
// 2 - 


        }





    }
}
