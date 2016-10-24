-- modèle sur l'indexation dans le catalogue produit

open util/relation
open util/boolean

sig Garantie
{
	estIndexée : Bool
}

sig Produit
{
	garanties : some Garantie,
  estIndexé : Bool,
  types_indexation : garanties -> one TypeIndexationGarantie
}

pred with_indexation_rules[ P : Produit ]
{
  all G: P.garanties | (P.types_indexation[G] = AucuneIndexation) <=> (isFalse[P.estIndexé] or isFalse[G.estIndexée])
}

run
{
	with_indexation_rules[ Produit ]
} for 1 but 1 Produit


abstract sig TypeIndexationGarantie {}
one sig AucuneIndexation, AutreIndexation extends TypeIndexationGarantie {}

fact -- cas intéressants
{
	some Produit
	some Garantie
	all G : Garantie | some (Produit <: garanties).G
}

