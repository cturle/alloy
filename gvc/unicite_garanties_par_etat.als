-- unicité de garantie en se basant sur les états

open util/relation


sig Time
{}

enum Status {Actif, Inactif}

sig Garantie
{
}
{
  ! unicité_garantie_CtrEx1[this]
}

pred unicité_garantie_CtrEx1[G: Garantie]
{
  some disj EGR1, EGR2: {EGR: EtatGarantieRisque | some GR: garantie.G, T: GR.période_validité | GR->T->EGR in etats}
                        & status.Actif |
    {  EGR1.garantie_risque != EGR2.garantie_risque
       EGR1.time = EGR2.time
    }
}

-- hypothèse : ce sont toutes des GR du même risque
sig GarantieRisque
{
  garantie: Garantie,
  période_validité: some Time,
  etats: période_validité -> EtatGarantieRisque
}
{
  etats in période_validité lone -> one EtatGarantieRisque
}

sig EtatGarantieRisque
{
  status: Status
}
{
  one this.garantie_risque
}
fun garantie_risque : EtatGarantieRisque->GarantieRisque
{
  {EGR: EtatGarantieRisque, GR: GarantieRisque | some T: Time | GR->T->EGR in etats }  
}
fun time : EtatGarantieRisque->Time
{
  {EGR: EtatGarantieRisque, T: Time | some GR: GarantieRisque | GR->T->EGR in etats }  
}

fact interesting_cases
{
  Garantie in ran[garantie]
  Time     in ran[période_validité]
}


run
{
} for 2 but exactly 1 Garantie, exactly 2 GarantieRisque

