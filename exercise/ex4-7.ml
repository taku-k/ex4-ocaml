(* s k k 1 で関数適用させると
 * k 1 (k 1) となり先頭のkを関数適用させることで
 * kは２つの引数のうち１つ目を返すので、1 が返る。
 * *)
let k x y = x;;
let s x y z = x z (y z);;

(* # (k (s k k)) 1 2
 * と評価すればよい。
 * *)
print_int((k (s k k)) 1 2);;

