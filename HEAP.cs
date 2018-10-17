using System;

namespace HeapSort
{
    public class HeapSort
    {

        // Driver program 
        public static void Main()
        {
          
            int[] arr = { 4, 10, 3, 5, 1 };
            int length = arr.Length ;


            // heap is ordered binary tree
            // max heap = PARENT NODE value is LARGER than CHILD node value
            HeapSort ob = new HeapSort();
            ob.sort(arr);

            Console.WriteLine("Sorted array is: ");
            printArray(arr);
        }


        public void sort(int[] arr)
        {
            int  length = arr.Length ;

            // funkce "heapify()" řadí prvky pole odleva nakonec
            // 
            for (int i = length / 2 - 1; i >= 0; i--) { // A - loop
                Console.WriteLine("--- work of LOOP A (posunutí největšího prvku na začátek pole)-------------");
                heapify(arr, length, i); 
            }

            // One by one extract an element from heap 
            for (int i =  length - 1; i >= 0; i--) // 6 elements (cyklus proběhne 
            {
                Console.WriteLine("--- work of LOOP B -----working with value " + arr[i] + " ---------");
                // Move current root to end 
                int temp = arr[0];
                arr[0] = arr[i];
                arr[i] = temp;

                // call max heapify on the reduced heap (oblast se kvůli i-- zužuje)
                heapify(arr, i, 0);
            }
        }

        // To heapify a subtree rooted with node i which is 
        // an index in arr[].  length is size of heap 
        void heapify(int[] arr, int length, int i)
        {
            
            Console.WriteLine("Funkce heapify  " +  length + "i " + i);
            int largest = i; // Initialize largest as root (
            int l = 2 * i + 1; // left = 2*i + 1 
            int r = 2 * i + 2; // right = 2*i + 2 

            // LEFT CHILD > ROOT
            if (l <  length && arr[l] > arr[largest])
                largest = l;

            // RIGHT CHILD > THAN LARGEST SO FAR
            if (r <  length && arr[r] > arr[largest])
                largest = r;

            // If largest is not root 
            if (largest != i)
            {
                int swap = arr[i];
                arr[i] = arr[largest];
                arr[largest] = swap;

                // Recursively heapify the affected sub-tree 
                heapify(arr, length, largest);
                printArray(arr);

            }
        }

        /* A utility function to print array of size  length */
        static void printArray(int[] arr)
        {
            int  length = arr.Length ;
            for (int i = 0; i < length; ++i)
                Console.Write(arr[i] + " ");
            Console.ReadKey();
        }


    }
}
