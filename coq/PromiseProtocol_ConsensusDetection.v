From Stdlib Require Import Reals Lra.
Require Import PromiseProtocol_Strongest.
Open Scope R_scope.

Section ConsensusDetection.
  Variable noise_bound dishonest_deviation : R.
  Hypotheses
    (H_noise_pos : noise_bound > 0)
    (H_dishonest_gap : dishonest_deviation > 3 * noise_bound).

  Definition min_divergence_per_dishonest : R :=
    dishonest_deviation * dishonest_deviation / (8 * noise_bound).

  Lemma min_divergence_positive :
    min_divergence_per_dishonest > 0.
  Proof.
    unfold min_divergence_per_dishonest.
    apply Rdiv_lt_0_compat.
    - apply Rmult_gt_0_compat; lra.
    - lra.
  Qed.

  Definition total_divergence (n : nat) : R :=
    min_divergence_per_dishonest * INR n.

  Theorem consensus_yields_divergence :
    forall n, (n > 0)%nat -> total_divergence n > 0.
  Proof.
    intros n Hn.
    unfold total_divergence.
    apply Rmult_gt_0_compat.
    - apply min_divergence_positive.
    - apply lt_0_INR. exact Hn.
  Qed.

  Definition detection_probability (kappa : R) (n : nat) : R :=
    P_detect kappa min_divergence_per_dishonest n.

  Theorem detection_with_concrete_divergence :
    forall kappa,
      kappa > 0 ->
      forall n m, (n < m)%nat ->
      detection_probability kappa n < detection_probability kappa m.
  Proof.
    intros kappa Hkappa n m Hlt.
    unfold detection_probability.
    eapply detection_probability_strictly_increasing; eauto.
    apply min_divergence_positive.
  Qed.
End ConsensusDetection.
