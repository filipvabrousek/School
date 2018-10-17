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

          
            int n = arr.Length;

            heapSort(arr, n);

            // cout << "Sorted array is \n";
            printo(arr);


          
        }

        static void swap(int[] arr, int x, int y)//function to swap elements
        {
            int temp = arr[x];
            arr[x] = arr[y];
            arr[y] = temp;
        }

        static void heapify(int[] arr, int n, int i){
            int largest = i;
            int l = 2 * i + 1;
            int r = 2 * i + 2;

            // if left child is larger than root
            if (l < n && arr[l] > arr[largest])
                largest = l;

            // if right child is larger than largest so far
            if (r < n && arr[r] > arr[largest])
                largest = r;

            // if largest is not root
            if (largest != i)
            {
                swap(arr, arr[i], arr[largest]);

                // recursively heapify the affected sub-tree
                heapify(arr, n, largest);
            }

        }


       static void heapSort(int[] arr, int n)
        {
            // build heap (rearrange array)
            for (int i = n / 2 - 1; i >= 0; i--)
                heapify(arr, n, i);

            // one by one extract an element from heap
            for (int i = n - 1; i >= 0; i--)
            {
                // move current root to end
                swap(arr, arr[0], arr[i]);

                // call max heapify on the reduced heap
                heapify(arr, i, 0);
            }
        }

        static void printo(int[] arr){
            for (var i = 0; i < arr.Length; i++){
                Console.Write(arr[i] + ", ");
            }   
        }


    }
}
