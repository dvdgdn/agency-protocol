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
