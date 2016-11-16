-- propriété non modifiable

--open util/ordering[Time]
open util/boolean
open util/relation

abstract sig Property
{
  from: set Entity,
	to:   set Entity,
  modifiable: Bool
}
{
  (univ.pp_value).univ.univ in from
  univ.(univ.(univ.pp_value)) in to
	isFalse[modifiable] =>
    all E1: from | let R = { T: Time, E2: to | T->E1->this->E2 in pp_value } | dom[R]=Time && #ran[R]=1
}

one sig contrat_of_VersionContrat extends Property
{
}
{
  from = VersionContrat
  to = Contrat
	modifiable = False
}

abstract sig Entity
{
--  creation: Time
}

sig Contrat extends Entity {}
sig VersionContrat extends Entity {}

sig Time
{
  pp_value: Entity->Property->Entity
}


run
{
} for 3 but exactly 2 Contrat, exactly 1 VersionContrat



















