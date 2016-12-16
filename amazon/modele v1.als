-- AMAZON, modele v1

open util/boolean

enum OptionMarchandise {sans_etiquette_mis_en_commun}

sig Marchandise
{
  options: set OptionMarchandise,
  a_etiqueter: Bool
}
{
  sans_etiquette_mis_en_commun !in options => isTrue[a_etiqueter]
}

run
{
} for 3 but exactly 1 Marchandise
