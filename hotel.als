abstract sig ITime {}
sig Lock {}
sig Key {}

-- modele
one sig Time extends ITime
{
	compatibles: Lock -> Key	
}

pred sont_les_compatibles[T:Time, L:Lock, K:Key]
{
		compatibles[T, L] = K
}

-- verif modele
assert alwaysOneGoodKey
{
  all T: Time, L: Lock |
		one K: Key |
			sont_les_compatibles[T, L, K]
}
check alwaysOneGoodKey



/*
assert
{
  all T: Time, L: Lock, K: Key |
		sont-compatibles[T, L, K] and issue_key[T, L, K']
		=>
		sont-compatibles[T, L, K']
}
*/

run {}
