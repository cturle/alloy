-- V0.1.0 : Modelling systems, p14, modelling first paragraph of requirements
-- v0.2.0 : p14, modelling of individual requirements

open util/ordering[Period]

sig Period
{
}

sig Condition
{
}

sig Sensor
{
	raise_alarm_on : set Condition
}

sig Qualification
{
	conditions: some Condition
}
{
	no Q : Qualification-this | Q.@conditions = conditions
}

sig Expert
{
	qualifications : some Qualification
}

sig State
{
	current_period: Period,
  on_duty_experts: Period->Expert,
  called_experts: set Expert,
  onsite_experts: set Expert,
  current_alarms: set Condition
}

pred can_solve_all_alarms[ Es:Expert, Cs:Condition ]
{
	Cs in conditions[ qualifications[Es] ]
}

pred subseq_def[ S, S': set Period, FROM: Period, NB: Int ]
{
	S' in S
  #S' = NB
	min[ S' ] = FROM
	all E : S' | E = FROM or some E2 : S' | E = E2.next
}
run { some S,S': set Period, FROM: Period, NB: Int | NB=3 and subseq_def[S,S',FROM, NB] } for 0 but 5 Period
pred subseq[ S, S': set Period, START:Period, NB:Int ]
{
	subseq_def[S, S', START, NB]
}
check
{
  let S=Period |
		all S': set Period, FROM: Period |
			subseq[S,S',FROM, 3] => subseq_def[S,S',FROM, 3]
} for 0 but 5 Period

pred on_duty_experts_check[ S: State ]
{
	subseq[ Period, on_duty_experts[S].Expert, current_period[S], 4 ]
}

pred called_experts_check[ S: State ]
{
	can_solve_all_alarms[ onsite_experts[S] + called_experts[S], current_alarms[S] ]
  no called_experts[S] & onsite_experts[S]
	no E: called_experts[S] | can_solve_all_alarms[ onsite_experts[S] + (called_experts[S] - E), current_alarms[S] ]
}

/* operations :
	next_period
*/

run
{ -- cas de tests
	onsite_experts[State] + called_experts[State] = Expert
	some current_alarms[State]
	-- invariants à valider
	on_duty_experts_check[State]
	called_experts_check[State]
} for 2 but 1 State, 0 Sensor, 6 Period

