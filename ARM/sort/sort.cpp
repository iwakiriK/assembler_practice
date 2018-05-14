#include<bits/stdc++.h>
using namespace std;

void print_array(int A[], int n) {
  for (int i = 0; i < n; i++) {
    if(i) cout << " ";
    cout << A[i];
  }
  cout << endl;
}

int partition(int A[], int low, int high) {
  int i = low - 1;
  int pivot = A[high];
  for (int j = low; j < high; j++) {
    if (A[j] < pivot) {
      i++;
      swap(A[i], A[j]);
    }
  }
  swap(A[i+1], A[high]);
  return i + 1;
}

void quicksort(int A[], int low, int high) {
  if (low < high) {
    cout << low << " " << high << endl;
    print_array(A, 12);
    int p = partition(A, low, high);
    quicksort(A, low, p - 1);
    quicksort(A, p + 1, high);
  }
}

int main() {
  int n = 12;
  int A[12] = {3, 1, 4, 1, 5, 9, 2, 6, 5, 3, 5, 8};
  quicksort(A, 0, n-1);
  print_array(A, n);
  return 0;
}
