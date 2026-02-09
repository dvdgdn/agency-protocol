From Stdlib Require Import Reals Lra Ranalysis1.
Open Scope R_scope.

Section T12.
  Lemma pow_le_bound :
    forall r eps : R,
      0 < r < 1 ->
      0 < eps < 1 ->
      forall k : nat,
        INR k >= ln eps / ln r ->
        r ^ k <= eps.
  Proof.
    intros r eps [Hr_pos Hr_lt1] [Heps_pos Heps_lt1] k Hk.
    assert (Hlnr_neg : ln r < 0).
    { rewrite <- ln_1. apply ln_increasing; lra. }
    assert (Hk_le : ln eps / ln r <= INR k) by lra.
    assert (Hk' : INR k * ln r <= ln eps).
    { apply Rmult_le_compat_neg_l with (r := ln r) in Hk_le.
      2: lra.
      unfold Rdiv in Hk_le.
      field_simplify in Hk_le; try lra.
    }
    apply Rnot_gt_le.
    intro Hgt.
    assert (Hpow_pos : 0 < r ^ k) by (apply pow_lt; lra).
    assert (Hln_lt : ln eps < ln (r ^ k)).
    { apply ln_increasing; lra. }
    rewrite ln_pow in Hln_lt by lra.
    lra.
  Qed.

  Theorem finite_horizon_cooperation :
    forall delta ratio : R,
      0 < delta < 1 ->
      0 < ratio < 1 ->
      forall k : nat,
        INR k >= ln ratio / ln delta ->
        delta ^ k <= ratio.
  Proof.
    intros delta ratio Hdelta Hratio k Hk.
    eapply pow_le_bound; eauto.
  Qed.
End T12.
