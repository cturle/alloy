-- redmine 16454

open util/boolean

-- model
abstract sig Status { } one sig EstActif, EstInactif extends Status { }

sig Instant
{
  status: (Risque + GarantieRisque) -> one Status
}

sig Risque
{  garanties: set GarantieRisque }

sig GarantieRisque
{  }

-- assertion
pred redmine16454
{
  all T: Instant, R: Risque when R.(status[T]) = EstActif | { some G: garanties[R] | G.(status[T]) = EstActif }
}

-- test cases when assertion should hold
case1: run
{
  let  G0 = GarantieRisque,
       I0 = Instant,
       R0 = Risque |
  {  R0.garanties = G0
     I0.status = R0->EstActif + G0->EstActif }
  redmine16454
}
for 3 but exactly 1 Risque, exactly 1 Instant, exactly 1 GarantieRisque expect 1

-- test cases when assertion should not hold
case2: run
{
  no garanties[Risque]
  !redmine16454
}
for 3 but exactly 1 Risque expect 1
