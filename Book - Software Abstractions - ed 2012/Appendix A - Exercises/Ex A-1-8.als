module exercises/undirected

open util/relation

sig Node
{
	adjs: set Node
}

pred acyclic
{
  adjs = ~adjs                            -- undirected graph
  all disj N1, N2: Node | N1->N2 in ^adjs -- strongly connected graph
  no iden & adjs                          -- without self link
  -- your constraints here (higher order)
  no RING: adjs |
  {
	directed_ring[RING]      -- ring
  }
}
--run acyclic for 4
run acyclic for 0 but exactly 4 Node


/** graph is a ring */
pred directed_ring [R: Node->Node] {
  some R    -- non empty
  no R & ~R -- directed, irreflexive
  let DOMAIN = (dom[R]+ran[R]) |
  {  all N: DOMAIN | one N.R && one R.N }
}
run directed_ring for 0 but exactly 4 Node
