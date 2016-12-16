-- GVC / vehicule remplacé v2

open util/boolean

sig Time {}

sig Vehicule 
{
  est_remplacé:   Time -> lone Bool,
  est_modifiable: Time -> lone Bool,
}

-- Q1: Ensemble des véhicules remplacés à instant T
fun Q1 : Time->Vehicule
{
  -- {T: Time, V: Vehicule | V.est_remplacé[T] = True}
  ~(est_remplacé.True)
}

-- projeter sur Time et rechercher les véhicules ($Q1)
Q1: run
{
} for 3 but exactly 2 Vehicule, exactly 1 Time

-- R1: un véhicule remplacé ne peut pas être modifié 
-- cad un véhicule remplacé n'est pas modifiable
pred R1
{
  --all V: Vehicule, T: Time | (V.est_remplacé[T]=True) => (V.est_modifiable[T]=False)
  est_remplacé.True in est_modifiable.False
}

-- projeter sur Vehicule et rechercher les booléens (_est_remplacé) et (_est_modifiable)
R1: run
{
 R1
} for 3 but exactly 1 Vehicule, exactly 2 Time









