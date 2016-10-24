-- modèle du catalogue Produit

open util/relation
open util/boolean


one sig Chaine -------------------------------------------------------------------
{
}

sig Branche ------------------------------------------------------------------
{
}

sig Garantie -----------------------------------------------------------------
{
  branches: some Branche,
	groupe : GroupeGarantie,
  interdites : set Garantie,
  subordonnées : set Garantie,
  --dependantes_tarifaires : set Garantie,
  --incluses : set Garantie,
	estIndexée : Bool
}
fact
{
  symmetric[interdites]
	acyclic[subordonnées, Garantie]
	--incluses in subordonnées
	--acyclic[dependantes_tarifaires, Garantie]
}
run {} for 0 but 3 Garantie, 3 GroupeGarantie

sig GroupeGarantie
{
}
{
	#garanties[this] > 0
}
fun GroupeGarantie.garanties : set Garantie
{
	groupe.this
}

sig Formule
{
	garanties : some Garantie
}
fact
{
	no disj F1, F2 : Formule | F1.garanties = F2.garanties
}

sig Gamme --------------------------------------------------------------------
{
	libellé_long: Chaine
}

sig Produit ------------------------------------------------------------------
{
	libellé_long: Chaine,
  gamme: Gamme,
	formules : set Formule,
	garanties : set Garantie,
	caracteres_garantie : Garantie -> one CaractereGarantie,
  estIndexé : Bool,
  type_indexation : Garantie -> one TypeIndexationGarantie
}
{
	some all_garanties[ this ]
  no garanties & formules.garanties
  dom[caracteres_garantie] = all_garanties[ this ]
  caracteres_garantie.GarFormule = formules.garanties
  dom[type_indexation] = all_garanties[ this ]
}

pred with_indexation_rules[ P : Produit ]
{
  isFalse[P.estIndexé] implies ran[P.type_indexation] in AucuneIndexation
  P.type_indexation[estIndexée.False] in AucuneIndexation
}
run
{
	all P:Produit | with_indexation_rules[P]
} for 0 but 3 Garantie, 3 GroupeGarantie, 1 Produit

fun all_garanties[P : Produit] : Garantie
{
	P.garanties + P.formules.garanties
}

abstract sig CaractereGarantie {}
one sig GarObligatoire, GarFormule, GarFacultative extends CaractereGarantie {}

abstract sig TypeIndexationGarantie {}
one sig AucuneIndexation, AutreIndexation extends TypeIndexationGarantie {}
