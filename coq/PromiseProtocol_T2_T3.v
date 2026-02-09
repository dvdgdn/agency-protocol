From Stdlib Require Import Reals Lra.
Open Scope R_scope.

Section T2T3.
  Inductive strat : Type := Keep | Break.

  Variables DeltaU_keep_A DeltaU_break_A : R.
  Variables DeltaU_keep_B DeltaU_break_B : R.

  Definition U_A (sA sB : strat) : R :=
    match sA with
    | Keep => DeltaU_keep_A
    | Break => DeltaU_break_A
    end.

  Definition U_B (sA sB : strat) : R :=
    match sB with
    | Keep => DeltaU_keep_B
    | Break => DeltaU_break_B
    end.

  Definition Nash (sA sB : strat) : Prop :=
    U_A sA sB >= U_A Break sB /\
    U_B sA sB >= U_B sA Break.

  Hypotheses
    (H_A_pref : DeltaU_keep_A > DeltaU_break_A)
    (H_B_pref : DeltaU_keep_B > DeltaU_break_B).

  Theorem T2_Nash :
    Nash Keep Keep.
  Proof.
    unfold Nash, U_A, U_B; split; lra.
  Qed.

  Variables P_detect penalty_merit future_cost : R.
  Hypotheses
    (H_Pd_pos : 0 < P_detect <= 1)
    (H_pen_pos : penalty_merit > 0)
    (H_fut_pos : future_cost > 0).

  Definition EU_honest : R := 0.
  Definition EU_dishonest : R := - P_detect * penalty_merit - future_cost.

  Theorem T3_Honesty :
    EU_honest > EU_dishonest.
  Proof.
    unfold EU_honest, EU_dishonest.
    assert (P_detect * penalty_merit > 0).
    { apply Rmult_lt_0_compat; lra. }
    lra.
  Qed.
End T2T3.
