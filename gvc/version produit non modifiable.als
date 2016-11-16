-- propriété (version de produit) non modifiable

sig Contrat
{
  versions_ajour: some VersionContrat
}
{
  -- version de produit non modifiable =>
  one etats.version_produit
}
-- à noter comment définir les propriétés dérivées. Apparait dans le graphique et aucune différence à l'utilisation et + efficace.
-- est indépendant de la notion de version qui pourrait ne pas exister et tout fonctionnerait de la même façon.
fun etats : Contrat->EtatContrat {versions_ajour.etats}

sig VersionContrat
{
  etats: some EtatContrat
}
{
  one versions_ajour.this
}

sig EtatContrat
{
  version_produit: VersionProduit
}
{
  one (VersionContrat <: etats).this
}

sig VersionProduit {}


run
{
  -- filtre les cas pas intéressants
  all VP: VersionProduit | some version_produit.VP
}
for 3 but exactly 1 Contrat

