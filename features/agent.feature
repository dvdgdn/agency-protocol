Feature: Agent Creation and Lifecycle Process

  Background:
    Given the system has a Cycle Detector component
    And the Cycle Detector can analyze inheritance and promise dependency graphs
    And the system maintains an inheritance graph and a promise dependency graph


  Scenario: Creating an Intention
    Given an intention with the description "float in water"
    When the intention is created
    Then the intention should have a unique content-based address
    And the intention's description should be "float in water"

  Scenario: Agent Creation
    Given a key pair
    When an agent is created from this key pair
    Then the agent has a content-based address derived from its base state
    And the agent's public key can be retrieved from this address
    And the agent's signature of the hashed contents of their promises can be retrieved and verified

  Scenario: Registration with the Registry Service
    Given an agent "Agent X" has been created and has a content-based address
    When the agent registers with the Registry service
    Then a REGISTER event is emitted, announcing that an agent with address "X" has come online
    And other agents and services are informed of the new agent's existence

  Scenario Outline: Agent Making and Signing a Promise Based on an Intention
    Given an agent "Agent A" exists
    And an intention with the description "<Intention Description>" exists
    When "Agent A" makes and signs a promise to fulfill the intention "<Intention Description>"
    Then the promise should have a unique content-based address
    And the promise should be signed by "Agent A"
    And the promise should reflect the intention "<Intention Description>"

    Examples:
      | Intention Description |
      | float in water        |
      | deliver messages      |
    
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

  # Additional scenarios related to inheritance assignment with cycle detection
  Scenario: Assigning Inheritance Without Creating a Cycle
    Given Agent A exists
    And Agent B exists
    When Agent B is assigned to inherit from Agent A
    Then the inheritance should be recorded successfully
    And no cycle should be detected

  Scenario: Attempting to Assign Inheritance That Creates a Cycle
    Given Agent A inherits from Agent B
    And Agent B inherits from Agent C
    When Agent C attempts to inherit from Agent A
    Then the inheritance assignment should be rejected
    And Agent C should be notified of the cycle detection


  Scenario: Verifying a Promise's Signature
    Given an agent "Agent B" exists
    When "Agent B" makes and signs a promise with the description "deliver messages"
    Then the promise's signature can be verified using "Agent B"'s public key

  Scenario: Inheriting Promises from Multiple Immediate Ancestors
    Given the following agents with their promises:
      | Agent           | Promise           |
      | Parent Agent 1  | build shelters    |
      | Parent Agent 2  | gather resources  |
    And "Child Agent" declares "Parent Agent 1" and "Parent Agent 2" as its parents
    When "Child Agent"'s promises are listed
    Then the promises "build shelters" and "gather resources" should be among them

  Scenario: Inheriting Promises Transitively Through Multiple Generations
    Given the following agents with their promises:
      | Agent             | Promise           |
      | Great-Grandparent | secure perimeter  |
      | Grandparent       | gather resources  |
      | Parent            | build shelters    |
    And "Parent" declares "Grandparent" as its parent
    And "Grandparent" declares "Great-Grandparent" as its parent
    And "Child" declares "Parent" as its parent
    When "Child"'s promises are listed
    Then the promises "secure perimeter", "gather resources", and "build shelters" should be among them


  Scenario Outline: Signature Verification Based on Agent Promises
    Given "<agent_name>" has made "<number_of_promises>" promises
    Then the signature at agent "<agent_name>"'s address should reflect "<expected_signature>"

    Examples:
      | agent_name | number_of_promises | expected_signature                                            |
      | A          | 0                  | The agent's public key                                        |
      | B          | 1 or more          | A combination of the agent's public key and promise addresses |

  Scenario: Agent Authentication When Making a Promise
    Given an agent "Agent A" has a valid key pair
    When "Agent A" makes a promise using their key pair
    Then the system verifies "Agent A"'s authenticity
    And the promise is accepted and recorded

  Scenario: Rejection of a Promise from an Unauthenticated Agent
    Given an entity "Entity X" without a valid key pair
    When "Entity X" attempts to make a promise
    Then the system rejects the promise
    And returns "Authentication failed"

  Scenario: Preventing Duplicate or Replay Attacks
    Given an agent "Agent B" has made a promise with a unique identifier
    When the same promise is submitted again
    Then the system detects the duplicate
    And rejects the second submission    



  Scenario: Agent's Promised Name Matches Expectations
    Given an agent "Agent N" promises to have the name "Promised Name"
    When agents interact with "Agent N" using the name "Promised Name"
    Then "Agent N" recognizes and responds appropriately
    And the name promise is upheld

  Scenario: Agent's Promised Name Does Not Match Expectations
    Given an agent "Agent N" promises to have the name "Expected Name"
    But other agents expect "Agent N" to answer to "Unexpected Name"
    When an interaction occurs using the name "Unexpected Name"
    Then "Agent N" fails to respond
    And the promise of having the name "Expected Name" is assessed as broken

  Scenario: Multiple Agents Share the Same Promised Name
    Given agents "Agent X" and "Agent Y" both promise to have the name "Common Name"
    When agents search for "Common Name"
    Then a conflict resolution mechanism is triggered to clarify which agent is intended
    And agents may provide additional identifiers if necessary

  Scenario: Agent Changes Its Promised Name
    Given an agent "Agent Q" initially promises to have the name "Initial Name"
    And later updates its promise to have the name "New Name"
    When agents interact with "Agent Q" using the name "New Name"
    Then "Agent Q" recognizes and responds appropriately
    And the name change is recognized as an update, not a broken promise


