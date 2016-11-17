-- identifiants
-- id-user d'une garantie-risque

open util/relation

sig Texte
{}
{
  lone libellé.this
}

sig Garantie
{
  libellé: Texte
}

-- hypothèse : ce sont toutes des GR du même risque
sig GarantieRisque
{
  garantie: Garantie,
}
fun id_user: GarantieRisque->Texte
{
  garantie.libellé
}

pred identifiant[R: univ->univ]
{
  all X: ran[R] | one R.X
}

fact interesting_cases
{
  Garantie in ran[garantie]
  Texte    in ran[libellé]
}

check
{
  identifiant[id_user]
} for 2 but exactly 1 Garantie, exactly 2 GarantieRisque

run
{
} for 2 but exactly 1 Garantie, exactly 2 GarantieRisque

