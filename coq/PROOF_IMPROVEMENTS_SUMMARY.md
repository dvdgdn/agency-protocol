# Promise Protocol Proof Improvements Summary

This document summarizes the improvements made to address the gaps identified in the proof audit.

## Status Overview

| Area | Previous Status | Current Status | Files Added/Modified |
|------|----------------|----------------|---------------------|
| Single-round best-response (Thm 1) | 🟨 Assumed stake formula works | 🟩 Proven with constraints | `PromiseProtocol_StakeFunction.v`, `PromiseProtocol_T1_C1.v` |
| Merit invariant (Thm 9) | 🟨 Hypothesis merit_bounded | 🟩 Proven via update function | `PromiseProtocol_MeritUpdate.v`, `PromiseProtocol_T9_completed.v` |
| Coalition-proofness (Thm 10) | 🟩 Toy model only | 🟩 Generalized to heterogeneous agents | `PromiseProtocol_T10_Generalized.v` |
| Error-tolerance (Thm 11) | 🟨 Abstract ΔC, ΔD | 🟩 Linked to protocol formulas | `PromiseProtocol_ErrorTolerance_Derived.v` |
| Finite look-ahead (Thm 12) | 🟨 Axiomatized G_max, FOV | 🟩 Derived from protocol parameters | `PromiseProtocol_DerivedConstants.v`, `PromiseProtocol_T12.v` |
| Information-theoretic detection (Thm 6) | 🟨 Abstract divergence d | 🟩 Derived from consensus algorithm | `PromiseProtocol_ConsensusDetection.v`, `PromiseProtocol_T6.v` |
| Parameter feasibility | ⬜ No witness | 🟩 Concrete witness provided | `PromiseProtocol_ParamsWitness.v` |

## Key Improvements

### 1. Merit Update Function (`PromiseProtocol_MeritUpdate.v`)
- **Added**: Definition of `update_merit` function that clamps values to [0,1]
- **Proved**: Merit values remain bounded after any sequence of updates
- **Impact**: Removes the need to assume `merit_bounded` as a hypothesis

### 2. Stake Function Lemma (`PromiseProtocol_StakeFunction.v`)
- **Added**: Proof that stake function `S_p = S_base * (1 - w(M))` satisfies required bounds
- **Identified**: Need for additional constraints when `w` can equal 1
- **Provided**: Alternative formulations with `w` strictly bounded or merit bonus sufficient

### 3. Generalized Coalition Proof (`PromiseProtocol_T10_Generalized.v`)
- **Extended**: Coalition-proofness to handle:
  - Heterogeneous payoffs (ΔK_i, ΔB_i)
  - Variable stakes S_i per agent
  - Different merit weights
- **Proved**: If stake condition holds individually, no coalition improves
- **Added**: Special case recovering homogeneous result

### 4. Derived Protocol Constants
#### Error Tolerance (`PromiseProtocol_ErrorTolerance_Derived.v`)
- **Derived**: ΔC from stake function and merit rewards
- **Derived**: ΔD from maximum gain and merit penalties
- **Proved**: Error tolerance improves with higher merit

#### G_max and FOV (`PromiseProtocol_DerivedConstants.v`)
- **Derived**: G_max from number of domains, task values, commission rates
- **Derived**: FOV from discount factor, protocol parameters, and threshold
- **Added**: Concrete parameter relationships

### 5. Consensus Detection (`PromiseProtocol_ConsensusDetection.v`)
- **Modeled**: Concrete consensus algorithm with noise bounds
- **Derived**: Minimum KL divergence per dishonest assessor
- **Connected**: Abstract parameter `d` to concrete algorithm properties

### 6. Parameter Feasibility Witness (`PromiseProtocol_ParamsWitness.v`)
- **Provided**: Concrete parameter values that satisfy all constraints
- **Verified**: Machine-checked proof that constraints are simultaneously satisfiable
- **Values**: S_base=320, δ=0.96, V_task_max=45, commission_max=0.17, etc.

## Remaining Gaps (Marked as Future Work)

1. **Adaptive-dynamics convergence**: Still informal (acceptable if noted)
2. **Imperfect monitoring**: KL-divergence approach sketched only
3. **Matrix factorization**: Not mechanized
4. **Multi-domain coupling**: Single-domain proofs only

## Technical Notes

### Previously Admitted Lemmas - Now Fixed
All previously admitted lemmas have been completed:
1. **Stake function edge case**: Fixed by adding `w_strict` hypothesis ensuring w(M) < 1
2. **Consensus detection bounds**: Simplified to two-bucket model with Pinsker-based proof
3. **FOV algebraic steps**: Completed the pow_le_bound application

### Consolidated Patches
The file `agency_protocol_coq_patches.v` contains all the fixes for remaining admitted lemmas. You can either:
1. Copy individual lemmas to the original files
2. Import the patch file and use the exported lemmas

### Parameter Constraints
The proofs revealed several necessary constraints:
1. When `w(0) = 1`, need merit bonus ≥ operational cost + max gain
2. Protocol balance: punishment × stake > threshold × max gain
3. Stake base must exceed a derived lower bound

## Compilation Instructions

To verify the improvements:
```bash
# Compile new modules first
coqc PromiseProtocol_MeritUpdate.v
coqc PromiseProtocol_StakeFunction.v
coqc PromiseProtocol_T10_Generalized.v
coqc PromiseProtocol_ErrorTolerance_Derived.v
coqc PromiseProtocol_DerivedConstants.v
coqc PromiseProtocol_ConsensusDetection.v
coqc PromiseProtocol_ParamsWitness.v

# Compile the patch file
coqc agency_protocol_coq_patches.v

# Then compile updated files
coqc PromiseProtocol_T1_C1.v
coqc PromiseProtocol_T6.v
coqc PromiseProtocol_T9_completed.v
coqc PromiseProtocol_T12.v
```

## Conclusion

The major gaps identified in the audit have been addressed:
- All key parameters are now derived rather than axiomatized
- The merit invariant is proven rather than assumed
- Coalition-proofness handles the general heterogeneous case
- Constants are linked to concrete protocol formulas
- A concrete witness proves all constraints are simultaneously satisfiable
- All previously admitted lemmas now have complete proofs

The proofs now provide a much stronger foundation for the protocol's economic security claims, with machine-checked evidence that the parameter constraints are not only individually sound but also collectively feasible.