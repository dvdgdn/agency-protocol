From Stdlib Require Import Reals Lra List.
Import ListNotations.
Open Scope R_scope.

Section MeritUpdate.
  Definition update_merit (M delta : R) : R :=
    Rmax 0 (Rmin 1 (M + delta)).

  Lemma update_merit_bounded :
    forall M delta, 0 <= update_merit M delta <= 1.
  Proof.
    intros M delta.
    unfold update_merit.
    split.
    - unfold Rmax.
      destruct (Rle_dec 0 (Rmin 1 (M + delta))); lra.
    - unfold Rmax.
      destruct (Rle_dec 0 (Rmin 1 (M + delta))).
      + unfold Rmin.
        destruct (Rle_dec 1 (M + delta)); lra.
      + lra.
  Qed.

  Lemma update_merit_zero_lower :
    forall M delta, 0 <= update_merit M delta.
  Proof.
    intros M delta.
    apply (proj1 (update_merit_bounded M delta)).
  Qed.

  Lemma update_merit_one_upper :
    forall M delta, update_merit M delta <= 1.
  Proof.
    intros M delta.
    apply (proj2 (update_merit_bounded M delta)).
  Qed.

  Lemma update_merit_preserves_bounds :
    forall M delta,
      0 <= M <= 1 ->
      0 <= update_merit M delta <= 1.
  Proof.
    intros M delta _.
    apply update_merit_bounded.
  Qed.

  Fixpoint update_merit_list (merits deltas : list R) : list R :=
    match merits, deltas with
    | m :: ms, d :: ds => update_merit m d :: update_merit_list ms ds
    | _, _ => []
    end.

  Lemma update_merit_list_bounded :
    forall merits deltas,
      Forall (fun m => 0 <= m <= 1) merits ->
      Forall (fun m => 0 <= m <= 1) (update_merit_list merits deltas).
  Proof.
    induction merits as [|m ms IH]; intros deltas Hbounds.
    - destruct deltas; simpl; constructor.
    - destruct deltas as [|d ds].
      + simpl. constructor.
      + simpl.
        inversion Hbounds; subst.
        constructor.
        * apply update_merit_bounded.
        * apply IH. assumption.
  Qed.

  Fixpoint apply_updates (initial_merits : list R) (update_sequence : list (list R)) : list R :=
    match update_sequence with
    | [] => initial_merits
    | deltas :: rest => apply_updates (update_merit_list initial_merits deltas) rest
    end.

  Theorem merit_invariant :
    forall initial_merits update_sequence,
      Forall (fun m => 0 <= m <= 1) initial_merits ->
      Forall (fun m => 0 <= m <= 1) (apply_updates initial_merits update_sequence).
  Proof.
    intros initial_merits update_sequence Hinit.
    revert initial_merits Hinit.
    induction update_sequence as [|deltas rest IH]; intros merits Hbounds; simpl.
    - assumption.
    - apply IH.
      apply update_merit_list_bounded.
      assumption.
  Qed.

  Definition merit_coop_step (cur nxt : list R) : Prop :=
    exists deltas, nxt = update_merit_list cur deltas.

  Lemma merit_coop_step_preserves_bounds :
    forall cur nxt,
      Forall (fun m => 0 <= m <= 1) cur ->
      merit_coop_step cur nxt ->
      Forall (fun m => 0 <= m <= 1) nxt.
  Proof.
    intros cur nxt Hcur [deltas Heq].
    subst nxt.
    apply update_merit_list_bounded.
    assumption.
  Qed.

  Theorem merit_bounded_proved :
    forall seq : nat -> list R,
      (forall n, merit_coop_step (seq n) (seq (S n))) ->
      Forall (fun x => 0 <= x <= 1) (seq 0%nat) ->
      forall n, Forall (fun x => 0 <= x <= 1) (seq n).
  Proof.
    intros seq Hstep Hinit n.
    induction n.
    - exact Hinit.
    - apply merit_coop_step_preserves_bounds with (cur := seq n).
      + exact IHn.
      + apply Hstep.
  Qed.
End MeritUpdate.
