#include<bits/stdc++.h>
using namespace std;

int main () {
  int ans = 0;
  int n = 255;
  for (; n > 1; n--) {
    for (int j = 2; j < n; j++) {
      if(n % j == 0) goto next;
    }
    ans++;
  next:
    ;
  }
  cout << ans << endl;
  return 0;
}
