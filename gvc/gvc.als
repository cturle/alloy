-- modèle du catalogue Produit

open util/relation
open util/boolean
open catalogue_produit

sig Contrat
{
	produit: lone Produit
}
fun Contrat.gamme : lone Gamme
{
	this.produit.gamme
}
