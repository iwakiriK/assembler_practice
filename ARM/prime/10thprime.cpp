#include<bits/stdc++.h>
using namespace std;

int main () {
  int n = 255;
  int num = 10;
  while (true) {
    for (int i = n/2; i > 1; i--) {
      if (n % i == 0) goto next;
    }
    num--;
    if (num == 0) break;
  next:
    n--;
  }
  cout << n << endl;
  return 0;
}
