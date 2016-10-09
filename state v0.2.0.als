-- state v0.1.0
-- how to specify arbre d'état

open util/ordering[State]

sig State {prevState: lone State, action: lone Int}

pred init[S: State]
{
	no S.prevState
    no S.action
}

pred action1[S1, S2: State]
{
	S2.prevState = S1
	S2.action = 1
}

pred action2[S1, S2: State]
{
	S2.prevState = S1
	S2.action = 2
}

fact states
{
	init[first]
	all S1: State-last |
		let S2=S1.next |
	  		action1[S1, S2] or action2[S1, S2]
}

run {}
