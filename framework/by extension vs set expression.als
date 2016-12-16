-- by extension vs set expression
-- which one is more efficient and why ?

abstract sig Status {}
one sig Actif, Inactif extends Status {}

sig Entity { status: lone Status }

run
{
  -- constraint expressed by extension
  -- 59 vars. 9 primary vars. 85 clauses. 0ms.
  one {E: Entity | status[E] = Actif}

  -- same constraint expressed by set expression
  -- 53 vars. 9 primary vars. 67 clauses. 0ms.
  one status.Actif
} for 3 but exactly 1 Entity
