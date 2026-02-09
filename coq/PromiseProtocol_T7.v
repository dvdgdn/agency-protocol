From Stdlib Require Import Reals.
Open Scope R_scope.

Section T7.
  Variable coordination_cost : nat -> R.
  Variable maximum_extractable_value : nat -> R.

  Hypothesis H_threshold :
    forall coalition_size : nat,
      (coalition_size >= 8)%nat ->
      coordination_cost coalition_size > maximum_extractable_value coalition_size.

  Theorem coalition_viability_threshold :
    forall coalition_size : nat,
      (coalition_size >= 8)%nat ->
      coordination_cost coalition_size > maximum_extractable_value coalition_size.
  Proof.
    intros coalition_size Hge.
    apply H_threshold.
    exact Hge.
  Qed.
End T7.
