-- règles sur les dates de début / dates de fin

open util/relation
open util/ordering[Date]

sig Date {}

abstract sig Entité
{
  date_debut: Date,
  mere: lone Entité,
}

fun entités_filles : set Entité
{
  dom[mere]
}
fact
{
  all EF: entités_filles |
    gte[EF.date_debut, mere[EF].date_debut]
}

one sig Contrat extends Entité
{
  date_terme: lone Date,
  date_resiliation: lone Date,
  date_fin: lone Date,
}
{
  no mere
  one date_terme                           => gte[date_terme, date_debut]
  one date_resiliation                     => gte[date_resiliation, date_debut]
  (one date_resiliation && one date_terme) => lte[date_resiliation, date_terme]
  date_fin = min[date_resiliation + date_terme]
}

abstract sig Risque extends Entité
{
}
{
  one mere && mere in Contrat
}


sig RisqueTemporaire extends Risque
{
}

sig RisquePermanent extends Risque
{
}

fun date_effet : Contrat->Date
{
  Contrat <: date_debut
}

pred Contrat.est_valide
{
  one this.date_effet
  one this.date_fin => gte[this.date_fin, this.date_debut]
}

example: run
{
  Contrat.est_valide
}

counter_example: run
{
  !Contrat.est_valide
}
