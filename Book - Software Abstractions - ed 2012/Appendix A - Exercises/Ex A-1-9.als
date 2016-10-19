-- A.1.9 Axiomatizing Transitive Closure
module exercises/closure

pred transCover (R, r: univ -> univ)
{
  --… your constraints here
  r in R
  R.R in R
}

pred transClosure [R, r: univ -> univ]
{
	transCover[R, r]
  --… your constraints here
  all x,y: univ | (x->y in R) => (let R' = R - x->y | not transCover[R', r])
}

assert Equivalence
{
	all R, r: univ -> univ | transClosure[R, r] iff R = ^r
}
check Equivalence for 3

---INSTANCE---
--univ={Univ$0, Univ$1, Univ$2}
--skolem $Equivalence_R={Univ$0->Univ$0, Univ$0->Univ$2, Univ$1->Univ$0, Univ$1->Univ$1, Univ$1->Univ$2, Univ$2->Univ$0, Univ$2->Univ$2}
--skolem $Equivalence_r={Univ$0->Univ$2, Univ$1->Univ$1, Univ$2->Univ$0}

-- BUG EXPLANATION :
-- false hypothesis : if you remove a link from a non transitive relation you already get a non transitive relation
-- so here, it stops whenever a non transitive relation is found. Removing a second link will give a new transitive relation.

-- using errata
pred transClosure' [R, r: univ -> univ, C: univ -> univ -> univ] {
	-- def C
	all x, y, z, u: univ {
		x -> x -> y not in C
		x -> y -> u in C and y -> z -> u in C => x -> z -> u in C
		x -> y -> y in C and y -> z -> z in C and x != z => x -> z -> z in C
		x -> y in r and x != y => x -> y -> y in C
		x -> y -> y in C => some v: univ | x -> v in r and x -> v -> y in C
		x -> y -> z in C and y != z => y -> z -> z in C
	}
	R = {x, y: univ | x -> y -> y in C or x = y}
}

assert Equivalence' {
	all R, r: univ -> univ, C: univ -> univ -> univ |
		transClosure'[R, r, C] implies R = *r
}
check Equivalence' for 3

-- Note that the check cannot be bidirectional. Can you see why? Replace implies by iff to generate a counterexample, and explain what’s going on.
-- => not done
