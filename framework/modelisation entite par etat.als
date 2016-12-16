-- GVC / Remplacement d'un véhicule

open util/boolean

sig Time {}

sig Vehicule 
{
}

fun etat : Vehicule->Time->EtatVehicule
{
  {V: Vehicule, T: Time, EV: EtatVehicule | EV._véhicule = V && EV._time = T}
}
fact
{
  etat in Vehicule-> some (Time-> lone EtatVehicule)
}

fun est_remplacé : Vehicule->Time->Bool
{
  etat._est_remplacé
}

fun est_modifiable : Vehicule->Time->Bool
{
  etat._est_modifiable
}


sig EtatVehicule
{
  _véhicule: Vehicule,
  _time: Time,
  _est_remplacé: Bool,
  _est_modifiable: Bool,
}

-- Q1: Ensemble des véhicules remplacés à instant T
fun Q1 : Time->Vehicule
{
  {T: Time, V: Vehicule | isTrue[ V.est_remplacé[T] ]}
}

-- projeter sur Time et rechercher les véhicules ($Q1)
Q1: run
{
} for 3 but exactly 2 Vehicule, exactly 1 Time

-- R1: un véhicule remplacé ne peut pas être modifié 
-- cad un véhicule remplacé n'est pas modifiable
pred R1
{
  all V: Vehicule, T: Time | isTrue[V.est_remplacé[T]] => isFalse[V.est_modifiable[T]]
}

-- projeter sur EtatVehicule et rechercher les booléens (_est_remplacé) et (_est_modifiable)
R1: run
{
 R1
} for 3 but exactly 2 Vehicule, exactly 2 Time









