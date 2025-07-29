Feature: User
  A user is an immutable agent within the Agency Protocol responsible for setting and managing goals.
  Users interact by creating promises that reference intentions, ensuring accountability for their commitments.
  
  Background:
    Given the system has registered intentions with unique content-based addresses
    And agents have unique content-based addresses derived from their public keys
    And promises are immutable and reference intentions

  Scenario: User Registration
    Given a new agent "AgentUserA" generates a key pair
    When AgentUserA creates their initial promise "0xPromiseUserA1" referencing intention "0xIntentUserA1"
    Then "0xPromiseUserA1" must include:
      | Component        | Content                            |
      | Intention Address| "0xIntentUserA1"                     |
      | Agent Address    | "0xAgentUserA"                      |
      | Signature        | Signed with AgentUserA's private key |
    And "0xPromiseUserA1" is stored immutably in the system
    And User A is assigned the unique content-based address "0xAgentUserA"

  Scenario: User Creating a Promise
    Given User B with address "0xAgentUserB" exists
    And intention "0xIntentB1" exists with description "complete market analysis"
    When User B creates a new promise "0xPromiseUserB1" referencing "0xIntentB1"
    Then "0xPromiseUserB1" must include:
      | Component        | Content                            |
      | Intention Address| "0xIntentB1"                         |
      | Agent Address    | "0xAgentUserB"                       |
      | Signature        | Signed with User B's private key      |
    And "0xPromiseUserB1" is stored immutably in the system
