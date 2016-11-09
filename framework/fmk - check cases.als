-- Framework to check cases :
-- define a Case signature to define structure of cases
-- define Cases signatures to set specific properties of the case

sig Case { pp: set A } -- pp is any property not just one over A

sig Case1 extends A {} {one pp} -- Case wording
sig Case2 extends A {}

check {some pp} for 0 but exactly 1 Case1 expect 0 -- properties of Case to check
check {some pp} for 0 but exactly 1 Case2 expect 1

-- s'inspirer aussi du principe : génération (espace de toutes les possibilités) + filtre (prédicats sur les sous espaces invalides) (cf résiliation contrat)
