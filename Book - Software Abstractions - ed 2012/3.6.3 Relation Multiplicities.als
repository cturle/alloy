-- 3.6.3 Relation Multiplicities, regression 4.1 => 4.2

sig Book {}
sig Name {}
sig Addr {}

one sig Test
{
-- p79, Example. The declaration
  addr: (Book -> Name) -> lone Addr
-- says that the relation addr associates at most one address with each address book and name pair.  
}

check { all b: Book, n: Name | lone Test.addr[b,n] }

