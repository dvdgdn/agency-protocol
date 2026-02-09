From Stdlib Require Import Reals Lra.
Open Scope R_scope.

Section T8.
  Variable S_base : R.
  Hypothesis H_S_base_pos : S_base > 0.

  Variable w : R -> R.
  Hypothesis w_strict_inc :
    forall x y,
      0 <= x -> x <= 1 ->
      0 <= y -> y <= 1 ->
      x < y -> w x < w y.

  Definition Stake (M : R) : R := S_base * (1 - w M).

  Variables M Delta : R.
  Hypotheses
    (H_M0 : 0 <= M)
    (H_M1 : M <= 1)
    (H_Delta_pos : Delta > 0)
    (H_Mp0 : 0 <= M + Delta)
    (H_Mp1 : M + Delta <= 1).

  Lemma T8_stake_decreases :
    Stake (M + Delta) < Stake M.
  Proof.
    unfold Stake.
    apply Rmult_lt_compat_l; [lra|].
    pose proof (w_strict_inc M (M + Delta) H_M0 H_M1 H_Mp0 H_Mp1) as Hw.
    assert (M < M + Delta) by lra.
    specialize (Hw H).
    lra.
  Qed.
End T8.
