module exercises/spanning

open util/relation

pred isTree [r: univ -> univ]
{
  one ROOT: univ | no r.ROOT
  acyclic[r, univ]
	injective[r, univ]
}

pred spans [r1, r2: univ -> univ]
{
	dom[r1]+ran[r1] = dom[r2]+ran[r2]
	r1 in r2
}

pred show [r, t1, t2: univ -> univ] {
	spans[t1, r] and isTree[t1]
	spans[t2, r] and isTree[t2]
	t1 not = t2
}
run show for 3
