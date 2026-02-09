From Stdlib Require Import Reals Lra Logic.PropExtensionality.
Open Scope R_scope.

Section T5.
  Variables coalition_w W_total theta : R.

  Definition can_flip : Prop := coalition_w > (1 - theta) * W_total.

  Theorem T5_threshold :
    coalition_w <= (1 - theta) * W_total ->
    can_flip = False.
  Proof.
    intros Hc.
    unfold can_flip.
    apply propositional_extensionality.
    split.
    - intros Hgt. lra.
    - intros Hfalse. contradiction.
  Qed.

  Theorem T5_contrapositive :
    can_flip -> coalition_w > (1 - theta) * W_total.
  Proof.
    intro H.
    exact H.
  Qed.
End T5.
