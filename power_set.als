sig X {}
one sig R { set1, set2: set X }
{
 #set1 = 2
 #set2 = 3
}

sig SetOfX { elts: set X }
fact { all disj S1, S2: SetOfX | S1.elts != S2.elts }

fun power_set[Xs: set X] : set SetOfX
{
	{S: SetOfX | S.elts in Xs}
}

run
{
} for 0 but 4 X, exactly 16 SetOfX
