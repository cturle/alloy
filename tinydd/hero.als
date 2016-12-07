-- tinydd / hero.als
-- hola-0.2.jar

one sig World
{
  archetypes: (Race->Sex->Class) one -> one Archetype
}

sig Hero {}
sig Race {}
sig Sex  {}
sig Class {}

fun race : Hero->Race
{
  {H, R: univ | some S,C: univ | R->S->C->H in World.archetypes}
}

run
{
  some Archetype
} for 2
