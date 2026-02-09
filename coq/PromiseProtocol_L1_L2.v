From Stdlib Require Import Reals Lra.
Open Scope R_scope.

Section L1L2.
  Variable K : R.
  Hypothesis K_pos : K > 0.

  Variable w : R -> R.
  Hypothesis w_strict_inc :
    forall x y,
      0 <= x -> x <= 1 ->
      0 <= y -> y <= 1 ->
      x < y -> w x < w y.

  Definition FOV (M : R) : R := K * w M.

  Lemma L1_FOV_monotone :
    forall M M',
      0 <= M -> M <= 1 ->
      0 <= M' -> M' <= 1 ->
      M < M' ->
      FOV M < FOV M'.
  Proof.
    intros M M' HM0 HM1 HM'0 HM'1 Hlt.
    unfold FOV.
    apply Rmult_lt_compat_l; [lra|].
    apply w_strict_inc; lra.
  Qed.

  Variables DeltaM_plus DeltaM_minus M0 : R.
  Hypotheses
    (H_plus_pos : DeltaM_plus > 0)
    (H_minus_neg : DeltaM_minus < 0)
    (H_range_plus0 : 0 <= M0 + DeltaM_plus)
    (H_range_plus1 : M0 + DeltaM_plus <= 1)
    (H_range_minus0 : 0 <= M0 + DeltaM_minus)
    (H_range_minus1 : M0 + DeltaM_minus <= 1).

  Lemma L2_FOV_difference_positive :
    FOV (M0 + DeltaM_plus) - FOV (M0 + DeltaM_minus) > 0.
  Proof.
    assert (Hlt : M0 + DeltaM_minus < M0 + DeltaM_plus) by lra.
    pose proof (L1_FOV_monotone
      (M0 + DeltaM_minus)
      (M0 + DeltaM_plus)
      H_range_minus0 H_range_minus1 H_range_plus0 H_range_plus1 Hlt) as HF.
    lra.
  Qed.
End L1L2.
