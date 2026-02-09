Feature: Agent Registration

  Scenario: Registration with the Registry Service
    Given an agent "Agent X" has been created and has a content-based address
    When the agent registers with the Registry service
    Then a REGISTER event is emitted, announcing that an agent with address "X" has come online
    And other agents and services are informed of the new agent's existence

@phase0 @identity @strict_chain
Feature: Registration enforces strict-chain invariants

  Background:
    Given a Registry service exists
    And the system stores AgentState objects by content-address

  @phase0 @identity @single_previous
  Scenario: Genesis registration has no previous reference
    Given an agent "Agent A" has a genesis AgentState "S0"
    When "Agent A" registers "S0" with the Registry
    Then "S0" MUST NOT include a "previous" reference

  @phase1 @identity @previous_exists
  Scenario: Registration rejects updates that reference a missing previous state
    Given an agent "Agent A" has no stored AgentState "S_UNKNOWN"
    When the Registry receives AgentState "S2" with previous "S_UNKNOWN"
    Then the Registry rejects "S2"
    And records an anomaly "MISSING_PREVIOUS_STATE"

  @phase1 @identity @monotonic_head
  Scenario: Registry does not advance head for out-of-order updates
    Given an agent "Agent A" has head state "S2"
    When the Registry receives AgentState "S1" referencing "S0"
    Then the Registry keeps head at "S2"
    And records an anomaly "OUT_OF_ORDER_UPDATE"
