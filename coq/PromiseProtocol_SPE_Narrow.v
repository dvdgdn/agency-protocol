From Stdlib Require Import Reals Lra.
Require Import PromiseProtocol_Strongest.
Open Scope R_scope.

Section SPENarrow.
  Variables DeltaK DeltaB delta Loss : R.
  Hypothesis H_delta : 0 < delta < 1.
  Hypothesis H_loss : Loss > DeltaB - DeltaK.

  Definition U_coop : R := DeltaK / (1 - delta).
  Definition U_defect_once : R := (DeltaB - Loss) + delta * U_coop.

  Lemma coop_vs_defect :
    U_coop > U_defect_once.
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

  Inductive Action := keep | break.
  Definition strat := nat -> Action.

  Definition sigma_star : strat := fun _ => keep.
  Definition dev_once : strat := fun n => if Nat.eqb n 0 then break else keep.

  Definition profitable_one_step (u_star u_dev : R) : Prop := u_dev > u_star.

  Lemma no_profitable_deviation :
    ~ profitable_one_step U_coop U_defect_once.
  Proof.
    unfold profitable_one_step.
    intro Hprofit.
    pose proof coop_vs_defect as Hcoop.
    lra.
  Qed.

  Theorem SPE_always_keep :
    forall P : nat,
      ~ profitable_one_step U_coop U_defect_once.
  Proof.
    intros _.
    exact no_profitable_deviation.
  Qed.
End SPENarrow.
