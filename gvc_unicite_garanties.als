open  util/ordering[Time]

one sig R { garanties : set Garantie }
sig Garantie   { debut, fin: Time, type: TypeGarantie }
	{ lte[debut, fin] }
sig TypeGarantie {}
sig Time {}


pred lte3[X,Y,Z: Time]
{
	lte[X, Y] and lte[Y, Z]
}

pred se_chevauchent[G1, G2 : Garantie]
{
	let D1=debut[G1], F1=fin[G1],
			D2=debut[G2], F2=fin[G2] |
	 lte3[D2, D1, F2] or lte3[D2, F1, F2]
}

assert unicite_garantie
{
  no disj G1, G2 : R.garanties | G1.type = G2.type and se_chevauchent[G1, G2]
}

check unicite_garantie for 3 but 6 Time

run {}
