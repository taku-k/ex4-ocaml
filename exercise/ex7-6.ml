(*
 * let x = ref [];;
 * を評価すると、参照の型は'_a型のリストである。
 * 一度リストの型が決まれば別の型としては使えない。
 * x := [1];;
 * を評価した時点でxの型'_a はintに特定される。
 * したがって、
 * true :: !x;;
 * はboolはintのリストにconsで追加することはできない。
 * *)


