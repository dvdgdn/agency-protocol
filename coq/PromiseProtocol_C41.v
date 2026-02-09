From Stdlib Require Import Reals Lra.
Open Scope R_scope.

Section C41.
  Variables DeltaK DeltaB delta Loss : R.
  Hypothesis H_delta : 0 < delta < 1.
  Hypothesis H_loss : Loss > DeltaB - DeltaK.

  Definition U_coop : R := DeltaK / (1 - delta).
  Definition U_break : R := (DeltaB - Loss) / (1 - delta).

  Definition W_coop : R := 2 * U_coop.
  Definition W_bothB : R := 2 * U_break.
  Definition W_asym : R := U_break + U_coop.

  Lemma coop_vs_break_single :
    U_coop > U_break.
  Proof.
    unfold U_coop, U_break.
    assert (Hden : 1 - delta > 0) by lra.
    assert (Hden_neq : 1 - delta <> 0) by lra.
    apply Rmult_lt_reg_r with (r := 1 - delta); try lra.
    replace (DeltaK / (1 - delta) * (1 - delta)) with DeltaK by (field; lra).
    replace ((DeltaB - Loss) / (1 - delta) * (1 - delta)) with (DeltaB - Loss) by (field; lra).
    lra.
  Qed.

  Theorem C41_Pareto :
    W_coop > W_bothB /\ W_coop > W_asym.
  Proof.
    unfold W_coop, W_bothB, W_asym.
    split.
    - apply Rmult_lt_compat_l; [lra| exact coop_vs_break_single].
    - assert (Hsingle : U_coop > U_break) by exact coop_vs_break_single.
      lra.
  Qed.
End C41.
