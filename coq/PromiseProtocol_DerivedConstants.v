From Stdlib Require Import Reals Lra.
Require Import PromiseProtocol_T12.
Open Scope R_scope.

Section DerivedConstants.
  Variables alpha S_base w_max P_min delta : R.
  Variable n_domains : nat.
  Variables V_task_max commission_rate_max : R.

  Hypotheses
    (H_alpha_pos : alpha > 0)
    (H_S_base_pos : S_base > 0)
    (H_wmax : 0 < w_max < 1)
    (H_P_min_pos : P_min > 0)
    (H_delta : 0 < delta < 1)
    (H_domains_pos : (0 < n_domains)%nat)
    (H_V_task_pos : V_task_max > 0)
    (H_commission : 0 < commission_rate_max < 1).

  Definition G_max_derived : R :=
    INR n_domains * V_task_max * commission_rate_max.

  Lemma G_max_derived_positive :
    G_max_derived > 0.
  Proof.
    unfold G_max_derived.
    apply Rmult_gt_0_compat.
    - apply Rmult_gt_0_compat.
      + apply lt_0_INR. exact H_domains_pos.
      + exact H_V_task_pos.
    - exact (proj1 H_commission).
  Qed.

  Definition min_stake_factor : R := 1 - w_max.

  Lemma min_stake_factor_bounds :
    0 < min_stake_factor < 1.
  Proof.
    unfold min_stake_factor.
    lra.
  Qed.

  Definition fov_ratio : R :=
    G_max_derived / (alpha * S_base * min_stake_factor * P_min).

  Hypothesis H_fov_ratio : 0 < fov_ratio < 1.

  Theorem yellow_paper_FOV_bound_corrected :
    forall k : nat,
      INR k >= ln fov_ratio / ln delta ->
      delta ^ k <= fov_ratio.
  Proof.
    intro k.
    apply (pow_le_bound delta fov_ratio H_delta H_fov_ratio k).
  Qed.

  Theorem yellow_paper_FOV_bound :
    forall k : nat,
      INR k >= ln fov_ratio / ln delta ->
      delta ^ k <= fov_ratio.
  Proof.
    exact yellow_paper_FOV_bound_corrected.
  Qed.
End DerivedConstants.
