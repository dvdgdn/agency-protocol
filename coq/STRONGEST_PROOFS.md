# Promise Protocol Strongest Mechanized Claims

This note identifies the highest-value claims (from the White Paper + Yellow Paper goals)
that are currently fully mechanized and compile under modern Coq.

Source file: `PromiseProtocol_Strongest.v`

## Protocol Goal (from papers)

Create a decentralized trust system where rational agents are economically pushed toward
honest promise-keeping, and where that cooperative state is stable and manipulation-resistant.

## Strongest proved claims

1. `keep_is_best_response`
- Single-round incentive compatibility: if stake/merit inequality holds, keeping a promise strictly dominates breaking.

2. `stationary_keep_is_spe_narrow`
- Repeated-game stability: with sufficient loss-on-defection, one-step deviation is unprofitable, so always-keep is SPE in the narrow model.

3. `nonempty_coalition_cannot_pareto_improve`
- Coalition resistance: if every individual deviation is unprofitable, no non-empty coalition can make all members strictly better off.

4. `merit_invariant`
- Safety invariant: merit updates keep merit scores in `[0,1]` for any update sequence.

5. `V_decreases_under_componentwise_improvement`
- Lyapunov-style dynamic stability: the candidate potential function strictly decreases when merits move componentwise upward with at least one strict gain.

6. `error_tolerance_bound`
- Bounded-rationality robustness: cooperation remains utility-superior when error rate stays below the derived threshold.

7. `detection_probability_strictly_increasing` and `detection_probability_bounded`
- Information-theoretic monitoring property: detection probability increases with coalition size and remains a valid probability in `[0,1)`.

## Reproduce

```bash
coqc coq/PromiseProtocol_Strongest.v
```
