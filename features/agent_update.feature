Feature: Agent Updates

  Scenario: Updating the Agent's Promises
    Given an agent "Agent X" has an existing state at address "X"
    When "Agent X" wishes to change its promises
    And "Agent X" emits an UPDATE event to signal this intention
    And "Agent X" creates a new agent state "X'" that includes the updated promises
    And "X'" includes a `previous` attribute referencing address "X"
    And "Agent X" signs the new state "X'" with its private key
    Then a REGISTER event is emitted for "X'", indicating the new state is online
    And a FORWARD event is emitted, specifying that requests to "X" should be forwarded to "X'"
    And the chain of agent states is maintained, ensuring identity continuity

@phase0 @identity @strict_chain
Feature: Strict linked-list agent identity

  Background:
    Given a Registry service exists
    And a Forwarder service exists
    And the system stores AgentState objects by content-address

  @phase0 @identity @integrity
  Scenario: AgentState content address matches canonical serialization
    Given an agent "Agent A" has an AgentState payload
    When the payload is canonically serialized
    Then the AgentState content address equals HASH(canonical_payload)

  @phase0 @identity @immutability
  Scenario: Stored AgentState is immutable
    Given an AgentState "S1" exists in storage
    When a client attempts to mutate any field of "S1"
    Then the mutation is rejected
    And the stored bytes for "S1" remain unchanged

  @phase0 @identity @strict_chain
  Scenario: A new AgentState must reference exactly one previous state when updating
    Given an agent "Agent A" has a current AgentState "S1"
    When "Agent A" publishes a new AgentState "S2" as an update
    Then "S2" MUST include a "previous" field equal to the address of "S1"
    And "S2" MUST NOT include multiple previous references

  @phase0 @identity @signature
  Scenario: AgentState update signature must verify against the agent key
    Given an agent "Agent A" has a key pair
    And "Agent A" has a current AgentState "S1" signed by "Agent A"
    When "Agent A" publishes a new AgentState "S2" referencing "S1"
    Then "S2" MUST be signed by the same agent key
    And the signature verification MUST succeed

  @phase1 @identity @replay
  Scenario: Reject replay of identical state publication
    Given an AgentState "S1" exists in storage
    When a client re-submits the identical AgentState bytes for "S1"
    Then the system accepts it as idempotent
    And no duplicate events are emitted

  @phase1 @identity @signature_continuity
  Scenario: Reject update signed by a different key
    Given an agent "Agent A" has AgentState "S1" signed by key "K_A"
    When an entity publishes AgentState "S2" referencing "S1" signed by key "K_B"
    Then the system rejects "S2"
    And the system records an anomaly "IDENTITY_KEY_MISMATCH"

@phase0 @forwarder
Feature: Forwarder resolves an agent to its latest valid state

  Background:
    Given a Forwarder service exists
    And the Forwarder subscribes to Registry events
    And the Forwarder stores a mapping from agent_public_key -> current_head_state

  @phase0 @forwarder @resolution
  Scenario: Resolve agent to head state
    Given an agent "Agent A" has current AgentState "S1"
    And the Forwarder mapping for "Agent A" points to "S1"
    When a requestor asks the Forwarder to resolve "Agent A"
    Then the Forwarder returns "S1"

  @phase0 @forwarder @update_events
  Scenario: Forwarder updates head on REGISTER of a newer valid state
    Given an agent "Agent A" has AgentState "S1" as head
    When the Registry emits a REGISTER event for AgentState "S2" referencing "S1"
    Then the Forwarder updates the head for "Agent A" to "S2"

  @phase1 @forwarder @missing_link
  Scenario: Forwarder does not advance head if previous state is missing
    Given the Forwarder head for "Agent A" is "S1"
    When the Registry emits REGISTER for "S2" referencing missing state "S_UNKNOWN"
    Then the Forwarder MUST NOT set head to "S2"
    And the Forwarder emits an anomaly "BROKEN_CHAIN_LINK"

  @phase1 @forwarder @stale_cache
  Scenario: Forwarder can recompute head by walking the chain
    Given the Forwarder has no cached head for "Agent A"
    And AgentStates "S1" and "S2" exist where "S2" references "S1"
    When a requestor asks the Forwarder to resolve "Agent A"
    Then the Forwarder walks from "S2" backward to verify chain integrity
    And the Forwarder returns "S2" as head

@phase1 @forks
Feature: Fork detection and handling in strict-chain mode

  Background:
    Given a Forwarder service exists
    And the Forwarder validates AgentState signatures and previous pointers

  @phase1 @forks @detect
  Scenario: Detect a fork when two states reference the same previous
    Given an agent "Agent A" has AgentState "S1"
    When AgentState "S2" is published referencing "S1"
    And AgentState "S3" is published referencing "S1"
    Then the system records a fork at previous "S1"
    And emits an anomaly "FORK_DETECTED" linking "S2" and "S3"

  @phase1 @forks @deterministic_routing
  Scenario: Forwarder chooses a deterministic routing head during a fork
    Given a fork exists between AgentStates "S2" and "S3" both referencing "S1"
    When a requestor asks the Forwarder to resolve "Agent A"
    Then the Forwarder returns the deterministic winner by canonical tie-break
    And the response includes "fork_present=true" and the competing heads

  @phase2 @forks @repair
  Scenario: Agent publishes an authoritative repair state after a fork
    Given a fork exists between "S2" and "S3"
    When "Agent A" publishes a new AgentState "S4" referencing "S2"
    And "S4" includes metadata "supersedes" listing "S3"
    Then the Forwarder sets head to "S4"
    And the anomaly "FORK_DETECTED" is marked "resolved"
