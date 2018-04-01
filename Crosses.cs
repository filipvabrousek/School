
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;



namespace avga
{
    class Programa
    {
        static void Main(string[] args)
        {
            int player = 1, score1 = 0, score2 = 0, index = 0;
            int circlei = 0, crossi = 0;
            int[] fields = new int[] {1, 2, 3, 4, 5, 6, 7, 8, 9}


           

            Console.WriteLine("Vítejte ve hře piškvorky. Hrají křížky.");
   
            string ans = "a", choice = "X";

            
            while (ans == "a"){
    
             score1 += 1;
             index += 1;
             choice = string.Parse(Console.ReadLine());
             
            fields[index] = choice;


             if (player == 1) {player = 2;} else {player = 1}
             

             if (fields.length == 8){ ans == "n"}



             // ans = "n"

            }


    static void check(){  
     for (var i = 0; i < 8; i++){
        if(fields[i] == "X"){
        crossi += 1;
        }

        if(fields[i] == "0"){
        circlei += 1;
        }

        
     }
    }
     

     static void Board(){
         COnsole.WriteLine(" | |")
         Console.WriteLine(fields[0], fields[1], fields[2])
         Console.WriteLine(fields[3], fields[4], fields[5])
         Console.WriteLine(fields[6], fields[7], fields[8])
         Console.WriteLine(" | |");
     }
Console.WriteLine(fields[0], fields[1]);

        
static checkWin(){
   
   // horizontal winning conditions
    if (fields[0] == fields[1] && fields[1] == fields[2]){ return 1;}

    else if (fields[3] == fields[4] && fields[4] == fields[5]){return 1;}

    else if (fields[4] == fields[5] && fields[5] == fields[6]){return 1;}

    else if (fields[6] == fields[7] && fields[7] == fields[8]){ return 1;}




    // vertical winning conditions, EDIT
     if (fields[0] == fields[1] && fields[1] == fields[2]){ return 1;}

    else if (fields[3] == fields[4] && fields[4] == fields[5]){return 1;}

    else if (fields[4] == fields[5] && fields[5] == fields[6]){return 1;}

    else if (fields[6] == fields[7] && fields[7] == fields[8]){ return 1;}
}

        }
    }
}
