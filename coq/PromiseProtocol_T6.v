From Stdlib Require Import Reals Lra.
Require Import PromiseProtocol_Strongest.
Open Scope R_scope.

Section T6.
  Variables kappa d : R.
  Hypotheses
    (H_kappa_pos : kappa > 0)
    (H_d_pos : d > 0).

  Definition P (n : nat) : R := P_detect kappa d n.

  Lemma P_strict_increasing :
    forall n m, (n < m)%nat -> P n < P m.
  Proof.
    intros n m Hlt.
    unfold P.
    eapply detection_probability_strictly_increasing; eauto.
  Qed.

  Lemma P_bounded :
    forall n, 0 <= P n < 1.
  Proof.
    intro n.
    unfold P.
    eapply detection_probability_bounded; eauto.
  Qed.
End T6.
