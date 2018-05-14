#include<bits/stdc++.h>
using namespace std;

int main () {
  int n = pow(2, 22);
  bool isprime[n+1];
  clock_t start = clock();    // start
  for (int i = 2; i <= n; i++) isprime[i] = true;
  for (int i = 2; i <= n; i++ ) {
    if(!isprime[i]) continue;
    cout << i << endl;
    for (int j = i + i; j <= n; j+= i) {
      isprime[j] = false;
    }
  }
  clock_t end = clock();     // end
  cout << "time: " << (double)(end - start) / CLOCKS_PER_SEC << "sec.\n";
  
  return 0;
}
