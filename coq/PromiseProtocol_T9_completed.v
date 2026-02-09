From Stdlib Require Import Reals Lra List.
Require Import PromiseProtocol_Strongest.
Require Import PromiseProtocol_MeritUpdate.
Import ListNotations.
Open Scope R_scope.

Section T9.
  Definition rsum := PromiseProtocol_Strongest.rsum.
  Definition V := PromiseProtocol_Strongest.V.

  Definition coop_step (cur nxt : list R) : Prop :=
    length cur = length nxt /\
    Forall2 (fun x y => x <= y) cur nxt /\
    exists i x y, nth_error cur i = Some x /\ nth_error nxt i = Some y /\ x < y.

  Lemma rsum_nonneg :
    forall l, Forall (fun x => 0 <= x) l -> 0 <= rsum l.
  Proof.
    induction l as [|x xs IH]; intros Hall; simpl.
    - lra.
    - inversion Hall as [|? ? Hx Hxs]; subst.
      specialize (IH Hxs).
      lra.
  Qed.

  Lemma rsum_componentwise_le :
    forall l l',
      Forall2 (fun x y => x <= y) l l' ->
      rsum l <= rsum l'.
  Proof.
    exact PromiseProtocol_Strongest.rsum_componentwise_le.
  Qed.

  Lemma rsum_strict_increase :
    forall l l',
      Forall2 (fun x y => x <= y) l l' ->
      (exists i x y,
        nth_error l i = Some x /\ nth_error l' i = Some y /\ x < y) ->
      rsum l < rsum l'.
  Proof.
    exact PromiseProtocol_Strongest.rsum_strict_increase.
  Qed.

  Lemma V_decreases :
    forall cur nxt,
      coop_step cur nxt -> V nxt < V cur.
  Proof.
    intros cur nxt [Hlen [Hcomp Hstrict]].
    apply PromiseProtocol_Strongest.V_decreases_under_componentwise_improvement; assumption.
  Qed.

  Lemma merit_bounded :
    forall init steps,
      Forall (fun x => 0 <= x <= 1) init ->
      Forall (fun x => 0 <= x <= 1) (apply_updates init steps).
  Proof.
    apply PromiseProtocol_MeritUpdate.merit_invariant.
  Qed.

  Lemma rsum_le_length :
    forall l, Forall (fun x => 0 <= x <= 1) l -> rsum l <= INR (length l).
  Proof.
    exact PromiseProtocol_Strongest.rsum_le_length_on_bounded_merits.
  Qed.

  Lemma V_monotone_bounded :
    forall l,
      Forall (fun x => 0 <= x <= 1) l ->
      0 <= V l.
  Proof.
    exact PromiseProtocol_Strongest.V_nonnegative_on_bounded_merits.
  Qed.
End T9.
