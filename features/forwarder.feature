@phase0 @forwarder
Feature: Forwarder resolves an agent to its latest valid state

  Background:
    Given a Registry service exists
    And a Forwarder service exists
    And the Forwarder subscribes to agent REGISTER and FORWARD events
    And the Forwarder validates AgentState signatures and previous pointers

  @phase0 @resolution
  Scenario: Resolve an agent to its current head state
    Given agent "Agent A" has head state "S1"
    When a requestor resolves "Agent A"
    Then the Forwarder returns state "S1"

  @phase0 @advance
  Scenario: Advance head on a valid update
    Given agent "Agent A" has head state "S1"
    When the Registry emits REGISTER for "S2" referencing previous "S1"
    Then the Forwarder sets head for "Agent A" to "S2"

  @phase1 @broken_chain
  Scenario: Do not advance head if the chain link is missing
    Given agent "Agent A" has head state "S1"
    When the Registry emits REGISTER for "S2" referencing previous "S_UNKNOWN"
    Then the Forwarder does not set head to "S2"
    And an anomaly "BROKEN_CHAIN_LINK" is recorded

  @phase1 @idempotent
  Scenario: Resolving is stable and idempotent
    Given agent "Agent A" has head state "S2"
    When a requestor resolves "Agent A" twice
    Then both responses return "S2"
