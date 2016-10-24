-- modélisation tarification évolution des réglementaires

open util/boolean
open util/ordering[Date]

sig Date {}

one sig Exemple
{
  date_maj: Date,
  date_avt: Date,
  date_evol_reglementaire: Date,
  date_effet_modif: Date,
  prendre_en_compte_evol: Bool
}
{
  gte[date_avt, date_maj]
  -- §3.1.2.1, point 2b :
  -- "C'est la date de début de chaque période d'assurance qui permet de trouver la valeur de chaque taux à appliquer."
  isTrue[prendre_en_compte_evol] <=> gte[date_effet_modif, date_evol_reglementaire]
}

pred check_prendre_en_compte_evol[E: Exemple]
{
  isTrue[E.prendre_en_compte_evol] => gte[E.date_avt, E.date_evol_reglementaire]
}

check
{
  check_prendre_en_compte_evol[Exemple]
} for 4


