
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
            int player = 1, score1 = 0, score2 = 0, index = 0, place = 0;
            int circlei = 0, crossi = 0, iterations = 0;
            int[] fields = new int[] {1, 2, 3, 4, 5, 6, 7, 8, 9};
            //List<int> taken = new List<int>();

            Console.WriteLine("Vítejte ve hře piškvorky. Hrají křížky.");
   
            string ans = "a", choice = "A";

            while (ans == "a"){
            Console.WriteLine("Hraje hráč číslo " + player + " zadejte pozici na kterou chcete přidat váš symbol.");
            place = Console.ReadLine(); 
            

            for (var i = 0; i < 9; i++){
                if (place == taken[i]){
                    Console.WriteLine("Toto pole je zabrané.");
                } else {
                    if (player == 1){
                fields[place] = "X";
                taken[place] = desired;
                    }
                    
                }
            }
             
        

             if (player == 1) {player = 2;} else {player = 1}


            if (checkWin() == "true"){
            Console.WriteLine("Někdo vyhrál.")
            plot();
            } else {
                plot();
            }
             if (fields.length == 8){ ans == "n"}


            }


  
     

     static void plot(){
         Console.WriteLine(" | |")
         Console.WriteLine(fields[0], fields[1], fields[2])
         Console.WriteLine(fields[3], fields[4], fields[5])
         Console.WriteLine(fields[6], fields[7], fields[8])
         Console.WriteLine(" | |");
     }
// Console.WriteLine(fields[0], fields[1]);

bool IsLine(int index0, int index1, int index2, string piece){
return fields[index0] == piece && fields[index1] == piece && fields[index2] == piece;
    }


bool IsAnyLine(int index0, int index1, int index2){
        return IsLine(index0, index1, index2, Pos[index0]);
    }


static checkWin(){
// horizontal
if(IsAnyLine(1, 2, 3)) {
return true;
        }
        if(IsAnyLine(4, 5, 6)){
            return true;
        }
        if(IsAnyLine(7, 8, 9)){
            return true;
        }

// Diagonal
        if(IsAnyLine(1, 5, 9)){
            return true;
        }
        if(IsAnyLine(7, 5, 3)){
            return true;
        }

// Columns
        if(IsAnyLine(1, 4, 7)){
            return true;
        }
        if(IsAnyLine(2, 5, 8)){
            return true;
        }
        if(IsAnyLine(3, 6, 9)){
            return true;
        }

        return false;
}




        }
    }
}
