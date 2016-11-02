-- remplacement d'un véhicule

open util/boolean
open util/ordering[Date]

sig Date
{
}

sig Remplacement
{
	date_debut: Date,
  date_fin: Date,
  vehicule_remplace: Vehicule,
  vehicule_de_remplacement: Vehicule
}
{
	lte[date_debut, date_fin]
  vehicule_remplace != vehicule_de_remplacement
  vehicule_de_remplacement.cotisable = False
}

sig Vehicule
{
	cotisable: Bool
}
{
	cotisable = 
}



run {} for 3 but exactly 1 Remplacement


