-- risque cotisable
-- exemple de conception afin de gérer les règles qui s'appliquent par défaut
-- exigence : pouvoir ajouter les règles de façon incrémentale, sans changer les premières règles

open util/boolean
open util/relation
open util/ordering[Priorité]

one sig NA {}   -- not applicable : la règle ne s'applique pas
sig Priorité {}

abstract sig CotisableRule { priorité: Priorité }

-- règles initiales par défaut
one sig CotisableRule1 extends CotisableRule {}

sig Risque
{
	cotisable: set Bool,
  cotisable_rules: CotisableRule -> one (Bool + NA)
}
{
	CotisableRule1.cotisable_rules = True
  let best_rules = priorité.(max[(cotisable_rules.Bool).priorité]) |
    cotisable = cotisable_rules[best_rules]
}

-- règles à ajouter afin de créer un sous ensemble de risques 'non cotisable' par propriété/prédicat
one sig CotisableRule2 extends CotisableRule {}
{ gt[priorité, CotisableRule1.@priorité] }

sig Remplacement
{
  véhicule_de_remplacement: Risque
}

fact
{
	all R: Risque |
    cotisable_rules[R][CotisableRule2] = ((some véhicule_de_remplacement.R) => False else NA)
}

-- règles à ajouter afin de créer une sous classe de risques 'cotisable'
one sig CotisableRule3 extends CotisableRule {}
{ gt[priorité, CotisableRule2.@priorité] }

sig RisqueCotisable extends Risque {}

fact
{
	all R: Risque |
    cotisable_rules[R][CotisableRule3] = (R in RisqueCotisable => True else NA)
}

-- run & check
run {}
for 0 but 1 Remplacement, exactly 1 Risque, exactly 3 Priorité expect 1

check
{
  cotisable in Risque -> one Bool
  one RisqueCotisable => isTrue[Risque.cotisable]
  no RisqueCotisable and one Remplacement => isFalse[Risque.cotisable]
  no RisqueCotisable and no  Remplacement => isTrue[Risque.cotisable]
}
for 0 but 1 Remplacement, exactly 1 Risque, exactly 3 Priorité expect 0
