-- modèle sur l'indexation dans le catalogue produit

open util/ordering[Date]
open util/relation

sig Date {}

one sig E
{
	table_indices: TypeIndice->Date->Valeur
}
{
  all TI: TypeIndice | TI.table_indices in (Date one -> lone Valeur)
}

enum TypeIndice { T1 }

sig Valeur {}

fun f[T: TypeIndice, D: Date] : Date
{
	max[{D': dom[T.(table_indices[E])] | lte[D', D]}]
}

pred p[T: TypeIndice, D, now: Date]
{
	now !in dom[univ.(E.table_indices)]
	D = f[T, now]
}

run p
