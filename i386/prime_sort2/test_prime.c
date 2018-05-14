#include <stdio.h>      /* scanf, printfのために必要 */

extern int isPrime(unsigned int);

int main()
{
  unsigned int x;
  while (scanf("%u", &x) != EOF) {
    if (isPrime(x)) {
      printf("prime\n");
    } else {
      printf("not prime\n");
    }
  }
  return 0;
}
