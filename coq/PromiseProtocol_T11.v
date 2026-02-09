From Stdlib Require Import Reals Lra.
Require Import PromiseProtocol_Strongest.
Open Scope R_scope.

Section T11.
  Variables DeltaC DeltaD epsilon : R.
  Hypotheses
    (H_DeltaC_pos : DeltaC > 0)
    (H_DeltaD_pos : DeltaD > 0)
    (H_epsilon : 0 < epsilon < DeltaC / (DeltaC + DeltaD)).

  Definition EU_coop : R := (1 - epsilon) * DeltaC.
  Definition EU_def : R := epsilon * DeltaD.

  Lemma T11_error_bound :
    EU_coop > EU_def.
  Proof.
    exact (PromiseProtocol_Strongest.error_tolerance_bound
      DeltaC DeltaD epsilon H_DeltaC_pos H_DeltaD_pos H_epsilon).
  Qed.
End T11.
