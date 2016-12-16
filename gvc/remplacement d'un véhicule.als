-- GVC / remplacement d'un véhicule

open util/boolean
open util/relation
open util/ordering[Date]

sig Date {}

sig Vehicule 
{
  debut: Date,
  fin:   lone Date,
}
{
  lte[debut, fin]
}

sig Remplacement
{
  debut: Date,
  fin:   Date,
  véhicule_remplacé:        Vehicule,
  véhicule_de_remplacement: Vehicule,
}

pred Remplacement.est_valide
{
  lte[this.debut, this.fin]
  this.véhicule_remplacé != this.véhicule_de_remplacement
  lte[this.véhicule_remplacé.debut, this.debut] && lte[this.fin,  this.véhicule_remplacé.fin]
  this.véhicule_de_remplacement.debut = debut[this]
  this.véhicule_de_remplacement.fin   = fin[this]
  --véhicule_remplacé[this] !in ran[véhicule_de_remplacement]
}

run
{
  all R: Remplacement | R.est_valide &&
  !{no ran[véhicule_remplacé] & ran[véhicule_de_remplacement]}
} for 3 but exactly 3 Vehicule, exactly 5 Date

-- Q1: Ensemble des véhicules remplacés à la date D
fun Q1 : Date->Vehicule
{
  {D: Date, V: Vehicule |
   some R: Remplacement |
   {
     R.véhicule_remplacé = V
     lte[R.debut, D] && lte[D, R.fin]
   }
  }
}

-- projeter sur Date
Q1: run
{
  Remplacement.est_valide
} for 3 but exactly 1 Remplacement, exactly 3 Vehicule, exactly 5 Date







