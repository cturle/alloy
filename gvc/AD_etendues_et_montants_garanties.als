-- AD_etendues_et_montants_garanties

one sig Contrat
{
	produit: Produit,
  formule: lone Formule
}
{
	formule in produit.formules
}
fun Contrat.ggs_oblig_regl : set GroupeGarantie
{
  gs.(gs_oblig_regl[this])
}
fun Contrat.gs_oblig_regl : set Garantie
{
  let Oblis = formule[this].ggs.gs + produit[this].gs_hf_obligatoires |
		Oblis + reglementaires[Oblis]
}


sig Produit
{
	formules: set Formule,
  gs_hf_obligatoires: set Garantie
}

sig Formule
{
	ggs: some GroupeGarantie
}

sig GroupeGarantie
{
	gs: some Garantie
}
fun GroupeGarantie.gs_oblig_regl_par_contrat[C: Contrat] : set Garantie
{
	gs[this] & gs_oblig_regl[C]
}

sig Garantie
{
}
fun Garantie.reglementaires : set Garantie
{
	-- TODO
	none
}

run
{
} for 3 but exactly 1 Produit


