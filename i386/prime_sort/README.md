## 各プログラム解説
* print_eax.s -- eaxの中身を10進数で出力するサブルーチン
* 10primes.s -- N(31 <= N < 2^20)以下の素数を大きい順に10個出力する
* sort.s -- 主記憶領域のダブルワード列をクイックソートで昇順ソートするサブルーチン

## makeコマンド
* make test_print -- print_eax.sの実行ファイルを生成
* make test_prime -- 10primes.sの実行ファイルを生成
* make test_sort -- sort.sの実行ファイルを生成
* make test -- 各プログラムが正しく動作するか検証（正しければ何も出力されない）
* make clean -- 一時ファイルと実行ファイルを削除