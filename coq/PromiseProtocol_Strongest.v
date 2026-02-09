From Stdlib Require Import Reals Lra Psatz List.
Import ListNotations.
Open Scope R_scope.

Section SingleRoundIncentives.
  Variables alpha beta : R.
  Hypothesis H_alpha_pos : alpha > 0.

  Variables S_p C_op G_p DeltaM_keep DeltaM_break : R.

  Definition DeltaU_keep : R :=
    alpha * (- C_op) + beta * DeltaM_keep.

  Definition DeltaU_break : R :=
    alpha * (G_p - S_p) + beta * DeltaM_break.

  Theorem keep_is_best_response :
    G_p < S_p - C_op + (beta / alpha) * (DeltaM_keep - DeltaM_break) ->
    DeltaU_keep > DeltaU_break.
  Proof.
    unfold DeltaU_keep, DeltaU_break.
    intro Hcond.
    assert (Hscaled :
      alpha * G_p <
      alpha * (S_p - C_op + (beta / alpha) * (DeltaM_keep - DeltaM_break))).
    { apply Rmult_lt_compat_l; lra. }
    assert (Hscaled' :
      alpha * G_p <
      alpha * (S_p - C_op) + beta * (DeltaM_keep - DeltaM_break)).
    { unfold Rdiv in Hscaled.
      field_simplify in Hscaled; lra. }
    assert (Hdiff :
      alpha * (- C_op) + beta * DeltaM_keep
      - (alpha * (G_p - S_p) + beta * DeltaM_break) > 0).
    { lra. }
    lra.
  Qed.

  Corollary min_stake_suffices :
    S_p > G_p + C_op - (beta / alpha) * (DeltaM_keep - DeltaM_break) ->
    DeltaU_keep > DeltaU_break.
  Proof.
    intro Hstake.
    apply keep_is_best_response.
    nra.
  Qed.
End SingleRoundIncentives.

Section RepeatedGameStability.
  Variables DeltaK DeltaB delta Loss : R.
  Hypothesis H_delta : 0 < delta < 1.
  Hypothesis H_loss : Loss > DeltaB - DeltaK.

  Definition U_coop : R := DeltaK / (1 - delta).
  Definition U_defect_once : R := (DeltaB - Loss) + delta * U_coop.

  Theorem one_step_deviation_unprofitable :
    U_defect_once < U_coop.
  Proof.
    unfold U_defect_once, U_coop.
    assert (Hden_neq : 1 - delta <> 0) by lra.
    replace ((DeltaB - Loss) + delta * (DeltaK / (1 - delta)))
      with (DeltaK / (1 - delta) + (DeltaB - Loss - DeltaK)).
    2: { field; lra. }
    lra.
  Qed.

  Definition profitable_one_step : Prop := U_defect_once > U_coop.

  Theorem stationary_keep_is_spe_narrow :
    ~ profitable_one_step.
  Proof.
    unfold profitable_one_step.
    intro Hprofit.
    pose proof one_step_deviation_unprofitable as Hnoprofit.
    lra.
  Qed.
End RepeatedGameStability.

Section CoalitionResistance.
  Record Agent := {
    U_keep_i : R;
    U_dev_i : R
  }.

  Variable universe : list Agent.
  Hypothesis H_individual_unprofitable :
    forall a, In a universe -> U_dev_i a < U_keep_i a.

  Definition coalition_pareto_improves (C : list Agent) : Prop :=
    forall a, In a C -> U_dev_i a > U_keep_i a.

  Theorem nonempty_coalition_cannot_pareto_improve :
    forall C,
      C <> [] ->
      Forall (fun a => In a universe) C ->
      ~ coalition_pareto_improves C.
  Proof.
    intros C Hnonempty Hsubset Hpareto.
    destruct C as [|a tl].
    - contradiction.
    - rewrite Forall_forall in Hsubset.
      assert (Hin_universe : In a universe).
      { apply Hsubset. left. reflexivity. }
      specialize (H_individual_unprofitable a Hin_universe).
      specialize (Hpareto a (or_introl eq_refl)).
      lra.
  Qed.
End CoalitionResistance.

Section MeritInvariantAndLyapunov.
  Definition update_merit (m delta : R) : R :=
    Rmax 0 (Rmin 1 (m + delta)).

  Lemma update_merit_bounded :
    forall m d, 0 <= update_merit m d <= 1.
  Proof.
    intros m d.
    unfold update_merit.
    set (x := Rmin 1 (m + d)).
    assert (Hx_le_1 : x <= 1).
    { subst x. unfold Rmin.
      destruct (Rle_dec 1 (m + d)); lra. }
    unfold Rmax.
    destruct (Rle_dec 0 x); lra.
  Qed.

  Fixpoint update_merit_list (merits deltas : list R) : list R :=
    match merits, deltas with
    | m :: ms, d :: ds => update_merit m d :: update_merit_list ms ds
    | _, _ => []
    end.

  Lemma update_merit_list_bounded :
    forall merits deltas,
      Forall (fun x => 0 <= x <= 1) merits ->
      Forall (fun x => 0 <= x <= 1) (update_merit_list merits deltas).
  Proof.
    induction merits as [|m ms IH]; intros deltas Hbounded.
    - destruct deltas; simpl; constructor.
    - destruct deltas as [|d ds].
      + simpl. constructor.
      + simpl. inversion Hbounded; subst.
        constructor.
        * apply update_merit_bounded.
        * apply IH. assumption.
  Qed.

  Fixpoint apply_updates (merits : list R) (steps : list (list R)) : list R :=
    match steps with
    | [] => merits
    | ds :: tl => apply_updates (update_merit_list merits ds) tl
    end.

  Theorem merit_invariant :
    forall init steps,
      Forall (fun x => 0 <= x <= 1) init ->
      Forall (fun x => 0 <= x <= 1) (apply_updates init steps).
  Proof.
    intros init steps Hinit.
    revert init Hinit.
    induction steps as [|ds tl IH]; intros init Hbounded; simpl.
    - assumption.
    - apply IH.
      apply update_merit_list_bounded.
      assumption.
  Qed.

  Fixpoint rsum (l : list R) : R :=
    match l with
    | [] => 0
    | x :: xs => x + rsum xs
    end.

  Definition V (l : list R) : R := INR (length l) - rsum l.

  Lemma rsum_componentwise_le :
    forall l l',
      Forall2 (fun x y => x <= y) l l' ->
      rsum l <= rsum l'.
  Proof.
    intros l l' Hcomp.
    induction Hcomp; simpl; nra.
  Qed.

  Lemma rsum_strict_increase :
    forall l l',
      Forall2 (fun x y => x <= y) l l' ->
      (exists i x y,
        nth_error l i = Some x /\
        nth_error l' i = Some y /\
        x < y) ->
      rsum l < rsum l'.
  Proof.
    intros l l' Hcomp.
    induction Hcomp as [|x y xs ys Hxy Hrest IH]; intros Hstrict.
    - destruct Hstrict as [i [a [b [Hi _]]]].
      destruct i; simpl in Hi; discriminate.
    - destruct Hstrict as [i [a [b [Hi [Hi' Hlt]]]]].
      destruct i as [|i'].
      + simpl in Hi, Hi'.
        inversion Hi; inversion Hi'; subst.
        simpl.
        assert (Htail : rsum xs <= rsum ys).
        { apply rsum_componentwise_le. exact Hrest. }
        lra.
      + simpl in Hi, Hi'.
        simpl.
        apply Rle_lt_trans with (r2 := y + rsum xs).
        * apply Rplus_le_compat_r. exact Hxy.
        * apply Rplus_lt_compat_l.
          apply IH.
          exists i', a, b.
          repeat split; assumption.
  Qed.

  Theorem V_decreases_under_componentwise_improvement :
    forall cur nxt,
      Forall2 (fun x y => x <= y) cur nxt ->
      (exists i x y,
        nth_error cur i = Some x /\
        nth_error nxt i = Some y /\
        x < y) ->
      V nxt < V cur.
  Proof.
    intros cur nxt Hcomp Hstrict.
    pose proof (Forall2_length Hcomp) as Hlen.
    pose proof (rsum_strict_increase cur nxt Hcomp Hstrict) as Hsum.
    unfold V.
    rewrite <- Hlen.
    nra.
  Qed.

  Lemma rsum_le_length_on_bounded_merits :
    forall l,
      Forall (fun x => 0 <= x <= 1) l ->
      rsum l <= INR (length l).
  Proof.
    intros l Hbounded.
    induction Hbounded as [|x xs Hx Hxs IH]; simpl.
    - lra.
    - destruct Hx as [_ Hx_le_1].
      destruct xs as [|x0 xs0]; simpl in *; lra.
  Qed.

  Theorem V_nonnegative_on_bounded_merits :
    forall l,
      Forall (fun x => 0 <= x <= 1) l ->
      0 <= V l.
  Proof.
    intros l Hbounded.
    unfold V.
    pose proof (rsum_le_length_on_bounded_merits l Hbounded) as Hsum.
    lra.
  Qed.
End MeritInvariantAndLyapunov.

Section BoundedRationality.
  Variables DeltaC DeltaD epsilon : R.
  Hypothesis H_DeltaC_pos : DeltaC > 0.
  Hypothesis H_DeltaD_pos : DeltaD > 0.
  Hypothesis H_epsilon : 0 < epsilon < DeltaC / (DeltaC + DeltaD).

  Definition EU_coop : R := (1 - epsilon) * DeltaC.
  Definition EU_defect : R := epsilon * DeltaD.

  Theorem error_tolerance_bound :
    EU_coop > EU_defect.
  Proof.
    unfold EU_coop, EU_defect.
    destruct H_epsilon as [Hep_pos Hep_bound].
    assert (Hden_pos : DeltaC + DeltaD > 0) by lra.
    assert (Hmul :
      epsilon * (DeltaC + DeltaD) <
      (DeltaC / (DeltaC + DeltaD)) * (DeltaC + DeltaD)).
    { apply Rmult_lt_compat_r; lra. }
    replace ((DeltaC / (DeltaC + DeltaD)) * (DeltaC + DeltaD)) with DeltaC in Hmul.
    2: { field; lra. }
    lra.
  Qed.
End BoundedRationality.

Section DetectionGrowth.
  Variables kappa d : R.
  Hypothesis H_kappa_pos : kappa > 0.
  Hypothesis H_d_pos : d > 0.

  Definition P_detect (n : nat) : R :=
    1 - exp (- kappa * d * INR n).

  Theorem detection_probability_strictly_increasing :
    forall n m, (n < m)%nat -> P_detect n < P_detect m.
  Proof.
    intros n m Hlt.
    unfold P_detect.
    assert (Hkd_pos : 0 < kappa * d) by nra.
    assert (Hlin : kappa * d * INR n < kappa * d * INR m).
    { apply Rmult_lt_compat_l.
      - exact Hkd_pos.
      - apply lt_INR. exact Hlt.
    }
    assert (Hexp : exp (- kappa * d * INR m) < exp (- kappa * d * INR n)).
    { apply exp_increasing. nra. }
    nra.
  Qed.

  Theorem detection_probability_bounded :
    forall n, 0 <= P_detect n < 1.
  Proof.
    intro n.
    unfold P_detect.
    assert (Hnonneg_n : 0 <= INR n) by apply pos_INR.
    assert (Hkd_pos : kappa * d > 0) by nra.
    assert (Hprod_nonneg : 0 <= kappa * d * INR n).
    { apply Rmult_le_pos; lra. }
    assert (Harg_nonpos : - kappa * d * INR n <= 0) by lra.
    assert (Hexp_le_1 : exp (- kappa * d * INR n) <= 1).
    { destruct (Req_dec (- kappa * d * INR n) 0) as [Heq | Hneq].
      - rewrite Heq. rewrite exp_0. lra.
      - assert (Harg_lt : - kappa * d * INR n < 0) by lra.
        rewrite <- exp_0.
        apply Rlt_le.
        apply exp_increasing.
        exact Harg_lt.
    }
    split.
    - nra.
    - assert (Hexp_pos : 0 < exp (- kappa * d * INR n)).
      { apply exp_pos. }
      nra.
  Qed.
End DetectionGrowth.
