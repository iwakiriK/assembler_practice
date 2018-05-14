#include<bits/stdc++.h>
using namespace std;

int main () {
  int ans = 0;
  unsigned int n = 4294967291;
  if (n < 2) ans = 1;
  unsigned int goal = 65536;
  if (n < goal) goal = n;
  for (unsigned int i = 2; i < goal; i++) {
    if (n % i == 0) {
      ans = 1;
    }
  }
  cout << ans << endl;
  return 0;
}
//          1: 1
//          2: 0
//          3: 0
//          4: 1
//  331133113: 0
// 3311331133: 1
// 4294967291: 0
