-- Ex A-1-10.als
-- AA 4.2

module exercises/addressBook1

abstract sig Name {
  address: set Addr + Name
}

sig Alias, Group extends Name {}

sig Addr {}

fact {
  --(a) There are no cycles; if you resolve a name repeatedly, you never reach the same name again.
  no ^address & iden

  --(b) All names eventually map to an address.
  all n: Name | some n.^address & Addr
}

run {
--… simulation constraints
}
