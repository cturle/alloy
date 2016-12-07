-- tarif evol taxes 2

open util/ordering[Date]

one sig Contexte
{
  taux_initial: Tx,
  debut_echeance: Date,
  chgt_taux: Date,
  effet_modif: lone Date,
}
{
 lte[debut_echeance, chgt_taux]
 lte[debut_echeance, effet_modif]
}

fun Contexte.dates_utilisées : set Date
{
  this.(debut_echeance+chgt_taux+effet_modif)
}

sig Date {}

sig Tx {} -- version du taux de taxe

-- general return type = GarantieRisque -> Taxe -> Date -> Tx
-- simplifié car une GarantieRisque et une Taxe
fun version_taux_taxe [C: Contexte] : Date -> Tx
{
  (C.dates_utilisées)->(C.taux_initial)
}

fact
{
}

check
{
  let r = version_taux_taxe[Contexte] |
  {
    r in Contexte.dates_utilisées -> one Tx
  }
} for 3 but exactly 2 Tx
