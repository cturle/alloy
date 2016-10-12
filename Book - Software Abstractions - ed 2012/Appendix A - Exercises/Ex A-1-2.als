assert ReformulateNonEmptiness {
	all r: univ -> univ |
		some r iff (some x, y: univ | x -> y in r)
}
check ReformulateNonEmptiness

assert ReformulateTransitive {
	all r: univ -> univ |
		r.r in r iff (all x, y, z: univ | ((x->y in r and y->z in r) => (x->z in r)))
}
check ReformulateTransitive

assert ReformulateIrreflexive {
	all r: univ -> univ |
		(no iden & r) iff (all x: univ | (x->x !in r))
}
check ReformulateIrreflexive

assert ReformulateSymmetric {
	all r: univ -> univ |
		(~r in r) iff (all x, y: univ | (x->y in r) => (y->x in r))
}
check ReformulateSymmetric

assert ReformulateFunctionnal {
	all r: univ -> univ |
		(~r.r in iden) iff (all x, y, z: univ | ((x->y in r) and (x->z in r)) => (y = z))
}
check ReformulateFunctionnal

assert ReformulateFunctionnal2 {
	all r: univ -> univ |
		(~r.r in iden) iff (all x: univ | #x.r <= 1)
}
check ReformulateFunctionnal2

assert ReformulateFunctionnal3 {
	all r: univ -> univ |
		(~r.r in iden) iff (all x, y: univ | (x->y in r) => (no z: univ-y | (x->z in r)))
}
check ReformulateFunctionnal3

assert ReformulateFunctionnal4 {
	all r: univ -> univ |
		(~r.r in iden) iff (all x, y: univ | (x->y in r) => #x.r = 1)
}
check ReformulateFunctionnal4

assert ReformulateFunctionnal5 {
	all r: univ -> univ |
		(~r.r in iden) iff (no x: univ, disj y, z: univ | (x->y in r) and (x->z in r))
}
check ReformulateFunctionnal5

assert ReformulateInjective {
	all r: univ -> univ |
		(r.~r in iden) iff (all x, y, z: univ | (x->y in r) and (z->y in r) => (x = z))
}
check ReformulateInjective

assert ReformulateInjective2 {
	all r: univ -> univ |
		(r.~r in iden) iff (no disj x, z: univ, y: univ | (x->y in r) and (z->y in r))
}
check ReformulateInjective2

assert ReformulateTotal {
	all r: univ -> univ |
		(univ in r.univ) iff (all x: univ | some y: univ | x->y in r)
}
check ReformulateTotal

assert ReformulateOnto {
	all r: univ -> univ |
		(univ in univ.r) iff (all y: univ | some x: univ | x->y in r)
}
check ReformulateOnto
































