-- 3.6.3 Relation Multiplicities

open util/ternary

/* rule :

r: A m -> n B 

can be written as :
 all a: A | n a.r
 all b: B | m r.b

*/

sig E {}
sig SubE extends E {}
sig E2 {}
sig E3 {}

sig Binary { r: E->E2 }
run
{
	Binary.r in (E one -> E2)
  && !
  {
    all b: E2 | one (Binary.r).b
  }
} for 3 but exactly 1 Binary, exactly 0 Ternary
run
{
  let members = Binary.r |
  {
    members in (E lone -> some E2)
    && !
    {
      all g: E | some g.members
      all a: E2 | lone members.a
    }
  }
} for 3 but exactly 1 Binary, exactly 0 Ternary

sig Ternary { r: E->E2->E3, r2: E->E->E }
T_lone_E: run
{
  let addr = Ternary.r2 |
  {
    addr in (E -> E) -> lone E
    && !
    {
      all book: E, name: E | lone addr[book, name]
    }
  }
} for 3 but exactly 0 Binary, exactly 1 Ternary
T_lone_E123: run
{
  let addr = Ternary.r |
  {
    addr in (E -> E2) -> lone E3
    && !
    {
      all book: E, name: E2 | lone addr[book, name]
    }
  }
} for 3 but exactly 0 Binary, exactly 1 Ternary
run
{
  let addr = Ternary.r |
  {
    addr in E -> (E2 lone -> E3)
    && !
    {
      all b: E | b.addr in (E2 lone -> E3)
    }
  }
} for 3 but exactly 0 Binary, exactly 1 Ternary
run
{
  let R = Ternary.r |
  {
    R in (E -> E2) -> one E3
    && !
    {
      all x1: E, x2: E2 | one R[x1, x2]
    }
  }
} for 3 but exactly 0 Binary, exactly 1 Ternary


pred assert5_2[T: E->E2->E3, X1:E, X2: E2]
{
  one T[X1, X2]
}

run
{
  let T = Ternary.r, B = Binary.r |
  {
    T in (SubE <: B) -> one E3 && !
    {
      select12[T] = (SubE <: B)
      all x1: E, x2: E2 | x1->x2 in select12[T] => assert5_2[T, x1, x2]
      --all x1: E, x2: E2 when x1->x2 in select12[T] | assert5_2[T, x1, x2]
    }
  }
} for 3 but exactly 1 Binary, exactly 1 Ternary


























