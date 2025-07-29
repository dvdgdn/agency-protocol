Feature: Vouching and Assessing Agents
  Agents can bootstrap initial trust through vouching and can assess each other's promises to build merit over time.

  Background:
    Given a decentralized ledger recording all promises and assessments immutably
    And agents have unique content-based addresses derived from their public keys
    And agents sign their promises, vouches, and assessments
    And merit in each domain is calculated from assessment chains and vouching relationships

  ### Vouching Scenarios ###

  Scenario: Bootstrapping Trust Through Vouching
    Given Agent A is a new agent in domain D
    And Agent B has established merit in domain D
    When Agent B vouches for Agent A
    Then Agent B creates a signed vouching statement containing:
      | Field        | Value               |
      | Voucher      | B's address         |
      | Vouched For  | A's address         |
      | Domain       | D's address         |
      | Signature    | B's signature       |
    And Agent A's initial merit in domain D is set based on Agent B's merit
    And Agent B's merit is at risk proportional to their vouching



  ### Integration of Vouching and Assessing ###

  Scenario: Vouching Agent's Merit Affected by Vouched-for Agent's Actions
    Given Agent B has vouched for Agent A in domain D
    And Agent A breaks promises assessed as "BROKEN" by multiple agents
    When the batch update occurs
    Then Agent B's merit in domain D decreases due to Agent A's poor performance
    And Agent B is notified: "Your merit has decreased due to the actions of agents you've vouched for."

  Scenario: Assessing Vouched-for Agent's Promise
    Given Agent B has vouched for Agent A in domain D
    And Agent C assesses Agent A's promise P as "BROKEN"
    When the batch update occurs
    Then Agent A's merit decreases
    And Agent B's merit may also decrease due to the vouching relationship

  Scenario: Vouching as an Initial Assessment
    Given Agent B vouches for Agent A in domain D
    Then the system considers this vouch as an implicit positive assessment of Agent A's general reliability
    And Agent B's merit is influenced by Agent A's future performance

