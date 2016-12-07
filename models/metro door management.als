-- Metro Door Management (from VDM) and "lightweight approach to model 98.pdf"

sig Metro
{
  train: Train
  door:  Door
}

pred is_valid[ M: Metro ]
{
  !(M.train=Moving && M.door!=Closed)
}

fun transitions: Door->Button->Train
{
  
}

check
{
  is_valid[
} for exactly 2 Metro

abstract sig Train {}
one sig Stopped, Moving extends Train {}

abstract sig Door {}
one sig Open, Closed, Halfopen {}

