-- gten = gte with nullable domain

open util/ordering[X]

sig X {}

pred P[_X1, _X2: lone X]
{
  (one _X1 && one _X2 && lte[_X1, _X2]) ||
  (no  _X1 && no  _X2) ||
  (no  _X1 && one _X2) ||
  (one _X1 && no  _X2)
}

pred lten[X1, X2: lone X]
{
  X1 in min[X1+X2]
}

check
{
  all X1, X2: lone X | P[X1,X2] <=> lten[X1,X2]
} for exactly 2 X
