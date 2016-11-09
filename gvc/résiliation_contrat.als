-- résiliation contrat (alloy 4.2)

open util/ordering[Date]
open util/relation

sig Date {}
sig Texte {}

-----------
sig Contrat
{
  date_résiliation: lone Date,
  motif_résiliation: lone Texte
}

pred Contrat.est_invalide_résiliation
{
  ! one this.date_résiliation <=> one this.motif_résiliation
}

pred Contrat.est_invalide
{
  this.est_invalide_résiliation
}

pred contexte_contrat
{
  Texte in ran[motif_résiliation]
}

find_avec_résiliation: run {contexte_contrat && one Contrat.date_résiliation && !Contrat.est_invalide} for 3 but exactly 1 Contrat, exactly 0 Action, 1 Date expect 1
find_sans_résiliation: run {contexte_contrat && no  Contrat.date_résiliation && !Contrat.est_invalide} for 3 but exactly 1 Contrat, exactly 0 Action, 1 Date expect 1

----------
sig Action
{
  date: Date,
  pre:  Contrat,
  post: Contrat
}
{
  !pre.est_invalide
  pre != post
}

pred Action.isa_modif_résiliation
{
  one this.pre.date_résiliation
  { pre.date_résiliation  != post.date_résiliation or
    pre.motif_résiliation != post.motif_résiliation }
}

pred Action.modif_résiliation_invalide
{
  this.isa_modif_résiliation
  gt[this.date, this.pre.date_résiliation]
}

pred Action.est_invalide
{
  this.post.est_invalide or
  this.modif_résiliation_invalide
}

pred contexte_action
{
  Texte in ran[motif_résiliation]
}

-- 2a- Le gestionnaire doit pouvoir modifier les données liées à la résiliation tant que la date de résiliation n'est pas échue
pred Action.Case2a
{
  this.isa_modif_résiliation
  !this.post.est_invalide
  lte[this.date, this.pre.date_résiliation]
}
check_Case2a: run {contexte_action && Action.Case2a && Action.est_invalide} for 3 but exactly 1 Action, 2 Contrat, 2 Texte, 3 Date expect 0

-- 2b- Y compris la remise à blanc de ces 2 données.
pred Action.Case2b
{
  this.Case2a
  no this.post.date_résiliation && no this.post.motif_résiliation
}
check_Case2b: run {contexte_action && Action.Case2b && Action.est_invalide} for 3 but exactly 1 Action, 2 Contrat, 2 Texte, 3 Date expect 0


































