-- 3.6.3 Relation Multiplicities, regression 4.2 (4.1 ok)
-- fixed with "alloy4.2_2013-01-28.jar" build
-- cf http://stackoverflow.com/questions/14560589/semantic-change-in-4-2/14567167#14567167

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

