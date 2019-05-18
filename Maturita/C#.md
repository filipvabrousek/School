# C#

## 22 Větvení :)
```csharp

            // 22 - if, else, switch, for

            int x = 0;
            switch (x){
                case 0:
                    Console.WriteLine("x is 0");
                    break;
                default:
                    Console.WriteLine("Else");
                    break;
            }



            double[] ar = { 20.0, 30.0, 40.0 };
            int[] arr = new int[3];
            arr[0] = 1;
            arr[1] = 3;
            arr[2] = 4;


            int sum = 0;
            for (int i = 0; i < arr.Length; i++){
                sum += arr[i];
            }

            Console.WriteLine("Sum is " + sum);
```          
## 23 Funkce (metoda)
```csharp
            // 23 - global, local
           

            void n(){
                Console.WriteLine("N");
            }

            n();

            void sq(ref int a){
                a = a * a;
            }

            int we = 2;
            sq(ref we);
            Console.WriteLine(we);


``` 
## 24 Pole
```csharp
            // 24 - 1D, a
            double[] ara = { 20.0, 30.0, 40.0 };
            int[] xa = new int[3];
            xa[0] = 1;
            xa[1] = 3;
            xa[2] = 4;


            int[,] multi = new int[10, 10]; // matice
            multi[0, 1] = 2;

            List<int> groceries = new List<int>(); // using system.collection.generic;
            groceries.Add(2);



            int len = arr.Length;
            int i, j, helper = 0;

            int res = 0;
```
## 25 Bubble Sort
```csharp
            // 1 - bubble sort (seřazení a výpis)
            for (j = 0; j < len - 1; j++)
            {

                for (i = 0; i < (len - j - 1); i++) // -j optimalizace
                {
                    if (arr[i] > arr[i + 1])
                    {
                        helper = arr[i];
                        arr[i] = arr[i + 1];
                        arr[i + 1] = helper;
                    }

                }

                Console.Write(arr[i] + " ");
            }
```
