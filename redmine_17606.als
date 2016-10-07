/*
  J'ai modifié le niveau de franchise du contrat à partir de l'espace de travail. Il est ensuite impossible de supprimer ce changement.
*/

-------------------------------------------------------------
open util/ordering[Time]
open util/ordering[Date]
open util/ordering[Action]

sig Date {}
sig Time
	{ date: Date }
fact
	{ all t1, t2 : Time | lt[t1, t2] => lte[t1.date, t2.date] }
-------------------------------------------------------------

sig Action
	{	before: Time, after: Time }
fact
	{ before[first] = first
    all a: Action-first | before[a] = after [a.prev]
	  all a: Action-last       | after [a] = before[a].next
		--after[last] = before[last].next
  }

check {} for 4

/*
sig NiveauFranchise {}

one sig Contrat {}

pred modifier_niv_franchise( A: Action, T: Time, C: Contrat, V: NiveauFranchise, D: Date )
{
	A in ModificationNivFranchise
	A.time = T
	A.date = D
	A.contrat = C
	A. = 
	A.resultat = 
}


-------------------------------------------------------------
assert redmine_17606
{
	--all A: Action, T: Time, C: Contrat, V: NiveauFranchise, D: Date |
	--	modifier_niv_franchise[ A, T, C, V, D ]
	all A1: ModifNivFranchise, A2:  |
		A1.resultat = OK
	  =>
		A2.resultat = OK
			
	-- 
  
}

check redmine_17606
*/

//run {} for 2 but 3 Time
//run {} for 3 but 4 Time
run { #Action = 2 } for 3
