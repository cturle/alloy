-- Status des contrats

open util/ordering[Date]

sig Date {}

--============================================================================

sig Contrat ------------------------------------------------------------------
{
	date_debut: Date,
	date_resiliation: lone Date,
  date_terme: lone Date,
  -- propriétés dérivées
  date_fin: lone Date,
}
{
  -- définition propriétés dérivées
	date_fin = min[date_terme + date_resiliation]
	-- contraintes
  date_debut = min[date_debut + date_resiliation + date_fin]
  date_resiliation = min[date_resiliation + date_terme]
}

--============================================================================

abstract sig Status {} -------------------------------------------------------
one sig EnVigueur, Annulé, Résilié, Clos extends Status {}


one sig StatusContrat --------------------------------------------------------
{
	contrat: Contrat,
	date_du_jour: Date,
	status: set Status
}
{
  EnVigueur in status iff
  	{  lte[contrat.date_debut, date_du_jour]
       date_du_jour = min[date_du_jour + contrat.date_fin] }
	Résilié in status iff
  	{  one contrat.date_resiliation
       lt[contrat.date_resiliation, date_du_jour] }
	Clos in status iff
		{  one contrat.date_terme
       lt[contrat.date_terme, date_du_jour] }
}

check
{
	one StatusContrat.status
}
for 0 but exactly 1 Contrat, exactly 4 Date




































