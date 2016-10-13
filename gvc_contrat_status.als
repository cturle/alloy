-- Status des contrats

open util/ordering[Date]

sig Date {}

sig Contrat ------------------------------------------------------------------
{
	date_debut_effet: Date,
	date_resiliation: lone Date,
  date_terme: lone Date,
  -- propriétés dérivées
  date_fin: lone Date,
}
{
  -- définition propriétés dérivées
	date_fin = min[date_terme + date_resiliation]
	-- contraintes
  date_debut_effet = min[date_debut_effet + date_resiliation + date_fin]
  date_resiliation = min[date_resiliation + date_terme]
}

------------------------------------------------------------------------------

abstract sig Status {} -------------------------------------------------------
one sig AVenir, EnVigueur, Annulé, Résilié, Clos extends Status {}


one sig StatusContrat --------------------------------------------------------
{
	contrat: Contrat,
	date_du_jour: Date,
	status: set Status
}
{
  AVenir in status iff
		{  no Annulé & status
       lt[date_du_jour, contrat.date_debut_effet] }
  EnVigueur in status iff
  	{  no Annulé & status
       lte[contrat.date_debut_effet, date_du_jour]
       date_du_jour = min[date_du_jour + contrat.date_fin] }
	Résilié in status iff
  	{  no Annulé & status
       one contrat.date_resiliation
       lt[contrat.date_resiliation, date_du_jour] }
	Clos in status iff
		{  no (Annulé+Résilié) & status
       one contrat.date_terme
       lt[contrat.date_terme, date_du_jour] }
}

check
{
	one StatusContrat.status
}
for 0 but exactly 1 Contrat, exactly 4 Date




































