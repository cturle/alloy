-- modèle sur les subordonnées dans le catalogue produit

open util/relation
open util/boolean

-------------------------
-- Paramétrage produit --
-------------------------
sig ParametrageProduit
{
	subordonnées : Garantie -> Garantie
--  subordonnées_tarifantes : Garantie -> Garantie
--  incluses : Garantie -> Garantie
--  interdites : Garantie -> Garantie
--  produit : some Produit
--  garanties : Produit -> some Garantie
}
{
	acyclic[subordonnées, Garantie]
}

sig Garantie
{
}

sig TypeRisque
{
}

sig Produit
{
}

---------
-- GVC --
---------
sig Etat
{
  contrat : Contrat,
  risques : some RisqueContrat
}

pred etat_est_valide[E: Etat]
{
	let subordonnantes = ~(E.contrat.parametrage.subordonnées) | 
		all R: E.risques, G: R.garanties | G.type.subordonnantes in R.garanties.type
}

sig GarantieRisque
{
	type : Garantie
}

sig RisqueContrat
{
  type : TypeRisque,
	garanties : some GarantieRisque
}

sig Contrat
{
  parametrage : ParametrageProduit,
  types_garanties_formule : some Garantie
}

sig AjoutGaranties
{
  contrat: Contrat,
	pre: Etat,
  post: Etat,
  risque: RisqueContrat,
  garanties: some GarantieRisque
}
{
  let subordonnantes = ~(pre.contrat.parametrage.subordonnées) |
	{
	  -- preconditions de définition
    pre.contrat = contrat
		etat_est_valide[pre]
	  risque in pre.risques
	  no garanties & risque.garanties
    garanties.type in pre.contrat.types_garanties_formule
		-- preconditions de cohérence
	  garanties.type.subordonnantes in (garanties.type + risque.garanties.type)
	  -- postconditions
		post.contrat = contrat
	  one R: (RisqueContrat - risque) |
		{ post.risques = (pre.risques - risque) + R
	    R.type = risque.type
	    R.garanties = risque.garanties + garanties }
	}
}

check
{
	all AG: AjoutGaranties | etat_est_valide[AG.post]
} for 3 but exactly 1 ParametrageProduit, exactly 2 Etat, exactly 1 AjoutGaranties, exactly 2 RisqueContrat, exactly 1 Contrat, exactly 3 GarantieRisque

check
{
	all C: Contrat, G: C.types_garanties_formule | (some AG: AjoutGaranties | ((AG.contrat = C) and (G in AG.garanties.type)))
} for 3 but exactly 1 ParametrageProduit, exactly 2 Etat, exactly 1 AjoutGaranties, exactly 2 RisqueContrat, exactly 1 Contrat, exactly 3 GarantieRisque

run
{
 #Contrat.types_garanties_formule = 2
 no Contrat.parametrage.subordonnées
 AjoutGaranties.contrat = Contrat
 one G: Contrat.types_garanties_formule | G in AjoutGaranties.garanties.type
} for 3 but exactly 1 ParametrageProduit, exactly 2 Etat, exactly 1 AjoutGaranties, exactly 2 RisqueContrat, exactly 1 Contrat, exactly 3 GarantieRisque


-- cas intéressants
fact 
{
	-- some Produit
	-- some Garantie
	-- all G : Garantie | some (Produit <: garanties).G
  all TR: TypeRisque | some type.TR
}



























