-- niveaux de franchise

open util/ternary

sig NiveauFranchise
{
  produit: Produit,
  garanties: Garantie -> TypeRisque -> ValeurFranchise
}

pred NiveauFranchise.est_valide
{
  -- works only with halo0.2 not alloy_4.2 (seems buggy)
  this.garanties in (this.produit.garanties <: types_risque) -> one ValeurFranchise
  --select12[this.garanties] = (this.produit.garanties <: types_risque)
  --this.garanties in (Garantie -> TypeRisque) -> lone ValeurFranchise
  --all G: this.produit.garanties_hors_options, TR: G.types_risque | one this.garanties[G, TR]
  --ii1[this.produit.garanties_hors_options <: this.garanties]
}

sig Produit
{
  garanties_hors_options: set Garantie,
  garanties_optionnelles: set Garantie,
  types_risque: set TypeRisque
}

fun garanties : Produit->Garantie { garanties_hors_options + garanties_optionnelles }

sig Garantie
{
  types_risque: set TypeRisque
}

sig TypeRisque {}

sig ValeurFranchise {}

run est_valide for 3 but exactly 1 Produit, exactly 1 NiveauFranchise, exactly 1 Garantie
