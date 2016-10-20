-- modélisation cas de tarification

one sig AppelDeCot
{
  contrat: Contrat
  avenant: lone Avenant
	date_debut: Date
  date_fin: Date
  date_comptable: Date
  periodes_assurance: set PeriodeAssurance
}

one sig Contrat
{
	date_echeance: Date
  date_etab: Date
	date_effet: Date
}

sig PeriodeAssurance
{
	debut: Date
  fin:   Date
}

sig Avenant
{
}


pred enoncé_cas1
{
}

pred résultat_cas1
{
}

check
{
	enoncé_cas1[] => résultat_cas1[]
  -- other cases
} for 0

