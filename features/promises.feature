Feature: Promises and Intentions

  Scenario: Creating an Intention
    Given an intention with the description "float in water"
    When the intention is created
    Then the intention should have a unique content-based address
    And the intention's description should be "float in water"

  Scenario: Agent Making and Signing a Promise Based on an Intention
    Given an agent "Agent A" exists
    And an intention with the description "float in water" exists
    When "Agent A" makes and signs a promise to fulfill the intention "float in water"
    Then the promise should have a unique content-based address
    And the promise should be signed by "Agent A"
    And the promise should reflect the intention "float in water"

  Scenario: Inheriting Promises from Multiple Immediate Ancestors
    Given the following agents with their promises:
      | Agent           | Promise           |
      | Parent Agent 1  | build shelters    |
      | Parent Agent 2  | gather resources  |
    And "Child Agent" declares "Parent Agent 1" and "Parent Agent 2" as its parents
    When "Child Agent"'s promises are listed
    Then the promises "build shelters" and "gather resources" should be among them

@phase0 @promise_cards
Feature: PromiseCard creation and immutability

  Background:
    Given an agent "Agent A" exists with a key pair

  @phase0 @promise_cards @create
  Scenario: Create a PromiseCard as an immutable content-addressed record
    Given "Agent A" drafts a PromiseCard with:
      | field                 | value                                  |
      | domain                | /moltbook/trust-infrastructure          |
      | statement             | respond to CARD requests within 24h     |
      | acceptance_criteria   | responses timestamped within 24h        |
      | evidence_requirements | links to message ids + timestamps        |
      | evaluation_window     | 72h                                     |
    When "Agent A" signs and publishes the PromiseCard
    Then the PromiseCard has a content-based address
    And the PromiseCard signature verifies for "Agent A"
    And the PromiseCard is immutable once published

  @phase1 @promise_cards @bind_to_identity
  Scenario: PromiseCard remains attributable across AgentState updates
    Given "Agent A" publishes PromiseCard "P1"
    And "Agent A" later updates its AgentState from "S1" to "S2"
    When a verifier loads PromiseCard "P1"
    Then the promisor identity is still "Agent A" (public key)
    And the PromiseCard remains valid without rewriting

@phase0 @promises @identity_binding
Feature: Promises are attributable across agent updates

  @phase0 @attribution
  Scenario: Promise references promisor identity key, not a transient head address
    Given agent "Agent A" exists with identity key "K_A"
    When "Agent A" makes a promise "P1"
    Then "P1" records promisor key "K_A"

  @phase1 @head_resolution
  Scenario: Requestors can resolve the promisor to the latest head state
    Given agent "Agent A" has state "S1"
    And agent "Agent A" made promise "P1"
    And agent "Agent A" updates to state "S2"
    When a requestor inspects "P1"
    Then the requestor can resolve "K_A" to head state "S2" via the Forwarder
