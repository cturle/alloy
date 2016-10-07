-- framework_modelisation

-- Domain
one sig Domain  { r: set Concept }
sig Concept {}

-- Counter examples
pred CtrEx1[]
{
	#r = 3
}

-- Model
-- pred Model[] {	#r <= 3 } -- KO model 
-- pred Model[] { #r <= 2 } -- OK model

assert le_modele_respecte_les_specifications
{ 
	-- list counter examples here
	CtrEx1[] => not Model[]
}
check le_modele_respecte_les_specifications for 3 but 1 Domain

-- run model to see if generated samples are all OK
run { Model[] } for 3 but 1 Domain
