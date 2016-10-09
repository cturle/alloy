-- experiences

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
	all S1, S2: State |
	  S1->S2 in State<:next => action1[S1, S2] or action2[S1, S2]
//	all S1->S2: State<:next => Action1[S1, S2] or Action2[S1, S2]
}

run {}
