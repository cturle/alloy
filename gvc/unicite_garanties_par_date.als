-- unicité garanties
-- ne prend pas en compte le status des garanties. Par exemple si une des garanties risque est annulée

open  util/ordering[Time]

one sig Risque
{
  garanties_risque : set GarantieRisque
}

sig GarantieRisque
{
  type: Garantie,
  debut, fin: Time,
}
{
  lte[debut, fin]
}

sig Garantie {}

sig Time {}


pred lte3[X,Y,Z: Time]
{
	lte[X, Y] and lte[Y, Z]
}

pred se_chevauchent[G1, G2 : GarantieRisque]
{
	let D1=debut[G1], F1=fin[G1],
			D2=debut[G2], F2=fin[G2] |
	 lte3[D2, D1, F2] or lte3[D2, F1, F2]
}

assert unicite_garantie
{
  no disj G1, G2 : Risque.garanties_risque | G1.type = G2.type and se_chevauchent[G1, G2]
}

check unicite_garantie for 3 but 6 Time

run {}
