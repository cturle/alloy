module appendixA/tree

open util/relation

pred isTree [r:univ->univ] {
  one ROOT: univ | no r.ROOT
  acyclic[r, univ]
	injective[r, univ]
}

run isTree for 4
