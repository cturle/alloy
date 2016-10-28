-- modélisation tarification évolution des taxes

open util/boolean
open util/relation
open util/ordering[Date]

sig Date {
--	cot_AE: Taxe,
  cot_AVT: ValeurTaxe,
  param_taxe: lone ValeurTaxe
}

one sig DE extends Date
{}

fact
{
	DE in min[Date]
	Date in DE + AE.date_chgt + AVT.dates_modif + dom[param_taxe]
}

abstract sig Etat {}

one sig AE extends Etat
{
	date_chgt: Date
}
{
  -- no date_chgt & DE
}

one sig AVT extends Etat
{
	dates_modif: set Date
}
{
}


sig ValeurTaxe
{
}

run {} for 0 but exactly 2 ValeurTaxe, 4 Date



