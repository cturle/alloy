-- check : il doit être possible d'ajouter n'importe quelle garantie autorisée à un risque

open util/relation
--open util/boolean

sig Contrat
{
}
fun Contrat.risques : set RisqueContrat
{
	(RisqueContrat <: contrat).this
}


sig RisqueContrat
{
	contrat: Contrat
}
fun RisqueContrat.garanties_ajoutables : set GarantieRisque
{
	GarantieRisque - garanties[this]
}
fun RisqueContrat.garanties : set GarantieRisque
{
	(GarantieRisque <: risque).this
}


sig GarantieRisque
{
	risque: lone RisqueContrat
}

---------------------------------------------------------------------
sig SetOfGarantieRisque
{
	elts: set GarantieRisque
}
fact id_SetOfGarantieRisque
{
	all disj S1, S2: SetOfGarantieRisque | S1.elts != S2.elts
}

fun power_set[Xs: set GarantieRisque] : set SetOfGarantieRisque
{
	{S: SetOfGarantieRisque | S.elts in Xs}
}
---------------------------------------------------------------------

sig AjoutGaranties
{
	contrat: Contrat,
  risque: RisqueContrat,
  garanties: some GarantieRisque
}
{
  risque in risques[contrat]
  garanties in garanties_ajoutables[risque]
}
pred AjoutGaranties.est_valide
{
}
fact id_AjoutGaranties
{
	all disj AG1, AG2: AjoutGaranties |
  {  AG1.contrat != AG2.contrat or AG1.risque != AG2.risque or AG1.garanties != AG2.garanties }
}

sig CheckAjoutGarantie
{
	contrat: Contrat,
  risque: RisqueContrat,
  garantie: GarantieRisque,
  ajouts: SetOfGarantieRisque -> AjoutGaranties
}
{
  risque in risques[contrat]
  garantie in garanties_ajoutables[risque]
  ajouts in power_set[garanties_ajoutables[risque] - garantie] -> one AjoutGaranties
	all AG: ran[ajouts] |
  {  AG.contrat = contrat
     AG.risque  = risque }
  all SG: dom[ajouts] | 
	{	 ajouts[SG].garanties = garantie + SG.elts }
}
fun CheckAjoutGarantie.ajout_garanties : set AjoutGaranties
{
	ran[this.ajouts]
}
pred CheckAjoutGarantie.est_valide
{
	some AG: ajout_garanties[this] | est_valide[AG]
}
--run {}
check { est_valide[CheckAjoutGarantie] }
for 0 but exactly 1 Contrat, exactly 1 RisqueContrat, exactly 3 GarantieRisque, exactly 8 SetOfGarantieRisque, 8 AjoutGaranties, exactly 1 CheckAjoutGarantie

























