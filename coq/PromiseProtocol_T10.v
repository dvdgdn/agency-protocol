From Stdlib Require Import Reals Lra List.
Require Import PromiseProtocol_Strongest.
Import ListNotations.
Open Scope R_scope.

Section IndividualDeviation.
  Variables DeltaK DeltaB delta Loss : R.
  Hypothesis H_delta : 0 < delta < 1.
  Hypothesis H_loss : Loss > DeltaB - DeltaK.

  Definition U_coop : R := DeltaK / (1 - delta).
  Definition U_defect_once : R := (DeltaB - Loss) + delta * U_coop.

  Lemma deviator_worse :
    U_defect_once < U_coop.
  Proof.
    unfold U_defect_once, U_coop.
    assert (Hden_neq : 1 - delta <> 0) by lra.
    replace ((DeltaB - Loss) + delta * (DeltaK / (1 - delta)))
      with (DeltaK / (1 - delta) + (DeltaB - Loss - DeltaK)).
    2: { field; lra. }
    apply Rplus_lt_reg_l with (r := - (DeltaK / (1 - delta))).
    assert (Hgap : DeltaB - Loss - DeltaK < 0) by lra.
    ring_simplify.
    exact Hgap.
  Qed.
End IndividualDeviation.

Section CoalitionProof.
  Variable universe : list Agent.
  Hypothesis H_individual_unprofitable :
    forall a, In a universe -> U_dev_i a < U_keep_i a.

  Definition all_better (C : list Agent) : Prop :=
    forall a, In a C -> U_dev_i a > U_keep_i a.

  Lemma coalition_not_all_improve :
    forall C,
      C <> [] ->
      Forall (fun c => In c universe) C ->
      ~ all_better C.
  Proof.
    intros C Hnonempty Hsubset.
    unfold all_better.
    eapply nonempty_coalition_cannot_pareto_improve; eauto.
  Qed.

  Theorem T10_coalition_proof :
    forall C,
      C <> [] ->
      Forall (fun c => In c universe) C ->
      ~ coalition_pareto_improves C.
  Proof.
    intros C Hnonempty Hsubset.
    eapply nonempty_coalition_cannot_pareto_improve; eauto.
  Qed.
End CoalitionProof.
