From Stdlib Require Import Reals Lra.
Open Scope R_scope.

Section StakeFunction.
  Variables alpha beta S_base : R.
  Hypothesis H_alpha_pos : alpha > 0.
  Hypothesis H_S_base_pos : S_base > 0.

  Variable w : R -> R.
  Hypothesis w_range : forall M, 0 <= M -> M <= 1 -> 0 <= w M <= 1.
  Hypothesis w_increasing :
    forall M1 M2, 0 <= M1 -> M1 <= M2 -> M2 <= 1 -> w M1 <= w M2.

  Definition stake_function (M : R) : R := S_base * (1 - w M).

  Lemma stake_nonnegative :
    forall M, 0 <= M -> M <= 1 -> 0 <= stake_function M.
  Proof.
    intros M H0 H1.
    unfold stake_function.
    destruct (w_range M H0 H1) as [_ Hw_le1].
    apply Rmult_le_pos.
    - lra.
    - lra.
  Qed.

  Lemma stake_decreases_with_merit :
    forall M1 M2,
      0 <= M1 -> M1 <= M2 -> M2 <= 1 ->
      stake_function M2 <= stake_function M1.
  Proof.
    intros M1 M2 HM1 HM12 HM2.
    unfold stake_function.
    apply Rmult_le_compat_l.
    - lra.
    - pose proof (w_increasing M1 M2 HM1 HM12 HM2) as Hw.
      lra.
  Qed.

  Variables C_op G_max DeltaM_gap : R.

  Hypothesis H_min_bound :
    stake_function 1 - C_op + (beta / alpha) * DeltaM_gap >= G_max.

  Theorem stake_satisfies_condition :
    forall M G,
      0 <= M -> M <= 1 ->
      0 <= G -> G <= G_max ->
      stake_function M - C_op + (beta / alpha) * DeltaM_gap >= G.
  Proof.
    intros M G HM0 HM1 HG0 HGmax.
    assert (Hmono : stake_function 1 <= stake_function M).
    { apply stake_decreases_with_merit; lra. }
    assert (Htarget :
      stake_function M - C_op + (beta / alpha) * DeltaM_gap >= G_max).
    { lra. }
    lra.
  Qed.
End StakeFunction.
