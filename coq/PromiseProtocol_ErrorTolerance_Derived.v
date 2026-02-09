From Stdlib Require Import Reals Lra.
Require Import PromiseProtocol_Strongest.
Open Scope R_scope.

Section ErrorToleranceDerived.
  Variables alpha beta : R.
  Variables C_op G_max DeltaM_plus DeltaM_minus : R.
  Hypotheses
    (H_alpha_pos : alpha > 0)
    (H_beta_nonneg : beta >= 0)
    (H_G_max_pos : G_max > 0)
    (H_DeltaM_plus_pos : DeltaM_plus > 0)
    (H_DeltaM_minus_nonzero : DeltaM_minus <> 0).

  Variable stake_function : R -> R.

  Definition DeltaC_derived (M : R) : R :=
    alpha * (stake_function M - C_op) + beta * DeltaM_plus.

  Definition DeltaD_derived : R :=
    alpha * G_max + beta * Rabs DeltaM_minus.

  Lemma DeltaD_derived_positive :
    DeltaD_derived > 0.
  Proof.
    unfold DeltaD_derived.
    assert (H1 : alpha * G_max > 0) by (apply Rmult_gt_0_compat; lra).
    assert (Habs_nonneg : 0 <= Rabs DeltaM_minus) by apply Rabs_pos.
    assert (H2 : 0 <= beta * Rabs DeltaM_minus) by nra.
    lra.
  Qed.

  Hypothesis H_DeltaC_pos :
    forall M, DeltaC_derived M > 0.

  Definition error_tolerance_bound (M : R) : R :=
    DeltaC_derived M / (DeltaC_derived M + DeltaD_derived).

  Theorem error_tolerance_protocol :
    forall M eps,
      0 < eps < error_tolerance_bound M ->
      (1 - eps) * DeltaC_derived M > eps * DeltaD_derived.
  Proof.
    intros M eps Heps.
    unfold error_tolerance_bound in Heps.
    eapply PromiseProtocol_Strongest.error_tolerance_bound.
    - apply H_DeltaC_pos.
    - apply DeltaD_derived_positive.
    - exact Heps.
  Qed.
End ErrorToleranceDerived.
