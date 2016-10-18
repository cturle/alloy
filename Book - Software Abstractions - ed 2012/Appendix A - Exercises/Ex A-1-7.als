module exercises/ring

open util/relation

-- modular def
sig Node {}
pred directed_ring [R: Node->Node] {
  some R    -- non empty
  no R & ~R -- directed, irreflexive
  let DOMAIN = (dom[R]+ran[R]) |
  {  all N: DOMAIN | one N.R && one R.N }
}
run directed_ring for 0 but exactly 4 Node

-- 
sig Node2 {next: set Node2}
pred isRing [] {
	(Node2 <: next) in Node2 one -> one Node2
  all n: Node2 | n.*(Node2 <: next) = Node2
}
run isRing for exactly 4 Node
