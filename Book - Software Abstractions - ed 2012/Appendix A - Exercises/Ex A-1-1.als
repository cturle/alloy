run {
	some r: univ -> univ {
		some r -- nonempty
		--r.r in r -- transitive
		no iden & r -- irreflexive
		~r in r -- symmetric
		~r.r in iden -- functional
		r.~r in iden -- injective
		univ in r.univ -- total
		univ in univ.r -- onto
	}
} for 4
