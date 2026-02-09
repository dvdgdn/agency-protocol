From Stdlib Require Import Reals Lra.
Require Import PromiseProtocol_Strongest.
Open Scope R_scope.

Section T1C1.
  Variables alpha beta C_op S_p G_p DeltaM_plus DeltaM_minus : R.
  Hypothesis H_alpha_pos : alpha > 0.

  Definition DeltaU_keep : R := alpha * (- C_op) + beta * DeltaM_plus.
  Definition DeltaU_break : R := alpha * (G_p - S_p) + beta * DeltaM_minus.

  Theorem T1_best_response :
    G_p < S_p - C_op + (beta / alpha) * (DeltaM_plus - DeltaM_minus) ->
    DeltaU_keep > DeltaU_break.
  Proof.
    intros Hcond.
    unfold DeltaU_keep, DeltaU_break.
    eapply keep_is_best_response; eauto.
  Qed.

  Theorem C1_min_stake :
    S_p > G_p + C_op - (beta / alpha) * (DeltaM_plus - DeltaM_minus) ->
    DeltaU_keep > DeltaU_break.
  Proof.
    intros Hstake.
    apply T1_best_response.
    lra.
  Qed.
End T1C1.
