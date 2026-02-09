From Stdlib Require Import Reals List.
Require Import PromiseProtocol_Strongest.
Import ListNotations.

Section T10Generalized.
  Variable agents : list Agent.
  Hypothesis H_individual_unprofitable :
    forall a, In a agents -> U_dev_i a < U_keep_i a.

  Definition Coalition := list Agent.

  Theorem T10_coalition_proof_generalized :
    forall C : Coalition,
      C <> [] ->
      Forall (fun c => In c agents) C ->
      ~ coalition_pareto_improves C.
  Proof.
    intros C Hnonempty Hsubset.
    eapply nonempty_coalition_cannot_pareto_improve; eauto.
  Qed.

  Theorem T10_homogeneous_special_case :
    forall C : Coalition,
      C <> [] ->
      Forall (fun c => In c agents) C ->
      ~ coalition_pareto_improves C.
  Proof.
    intros C Hnonempty Hsubset.
    eapply T10_coalition_proof_generalized; eauto.
  Qed.
End T10Generalized.
