module appendixA/distribution

assert union {
	all s: set univ, p, q: univ->univ | s.(p+q) = s.p + s.q
}

check union for 4


assert difference {
	all s: set univ, p, q: univ->univ | s.(p-q) = s.p - s.q
}

check difference for 2
/* {U0,U1}.({(U1,U1)}-{(U0,U1)})
   =  {U0,U1}.{(U1,U1)}
   = {(U1)}
   {U0,U1}.{(U1,U1)}-{U0,U1}.{(U0,U1)}
   = {U1}-{U1}
   = {}
*/


assert intersect {
	all s: set univ, p, q: univ->univ | s.(p&q) = s.p & s.q
}

check intersect for 2
/* {U0,U1}.({(U1,U1)}&{(U0,U1)})
   =  {U0,U1}.{}
   = {}
   {U0,U1}.{(U1,U1)}&{U0,U1}.{(U0,U1)}
   = {U1}&{U1}
   = {U1}
*/
