#include <stdio.h>      /* scanf, printfのために必要 */

extern int sort(void *array, int n, int width);

/* 整列対象配列の一例 */
struct Table {
  int score;
  double a;
  double b;
  double c;
}
table[] = {
  { 968, -10.1234567, -10.2345678, -10.3456789},
  { 897, -8.1234567, -8.2345678, -8.3456789},
  { 657, -6.1234567, -6.2345678, -6.3456789},
  { 542, 5.1234567, 5.2345678, 5.3456789},
  { 347, -2.1234567, -2.2345678, -2.3456789},
  { 391, 3.1234567, 3.2345678, 3.3456789},
  { 513, -4.1234567, -4.2345678, -4.3456789},
  { 938, 9.1234567, 9.2345678, 9.3456789},
  { 760, 7.1234567, 7.2345678, 7.3456789},
  { 344, 1.1234567, 1.2345678, 1.3456789}
};

/* 配列tableの要素数 */
#define N (sizeof(table) / sizeof(table[0]))

int main()
{
  unsigned int i;

  /* 整列 */
  sort(table, N, sizeof(table[0]));

  /* 整列結果を出力 */
  for (i = 0; i < N; i++) {
    printf("%d %f %f %f\n", table[i].score, table[i].a, table[i].b, table[i].c);
  }
  return 0;
}
