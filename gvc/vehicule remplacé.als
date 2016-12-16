-- GVC / véhicule remplacé

open util/boolean
open util/relation

sig Time {}

enum Status { Avenir, Actif, Résilié }

sig Vehicule
{
  vehicules_remplacement: Time -> Vehicule,
  status: Time -> lone Status,
}
{
  this !in ran[vehicules_remplacement]
}

fact
{
  no V: vehicules_remplacement[Vehicule, Time] | some vehicules_remplacement[V, Time]
}

pred remplacé[V: Vehicule, D: Time]
{
  status[V, D] = Actif
  one vehicules_remplacement[V, D] & status.Actif.D
  --one vehicules_remplacement[V, D] & {V2: Vehicule | status[V2,D]=Actif}
  --one V2: vehicules_remplacement[V, D] | status[V2, D] = Actif
  --one {V2: Vehicule | V->D->V2 in vehicules_remplacement && status[V2,D]=Actif}
}


run remplacé for 3 but exactly 1 Time
