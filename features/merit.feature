Feature: Merit System
  Merit represents domain-specific trustworthiness
  Merit is non-transferrable and derived from assessed promises
  Merit accumulates in specific namespaces based on fulfilled promises

  Background:
    Given the system has registered agents with unique addresses
    And agents can make and sign promises
    And promises reference specific intentions
    And agents can assess others' promises as KEPT or BROKEN
    And assessments must be signed and include domain addresses
    And the system has a Cycle Detector component

  Scenario: Recording First Promise Assessment
    Given Agent A has fulfilled a promise P in domain D
    When Agent B assesses P as "KEPT"
    Then the system records an assessment containing:
      | Field           | Value                     |
      | Promise        | P's address               |
      | Assessor       | Agent B's address         |
      | Domain         | D's address               |
      | Status         | "KEPT"                    |
      | Signature      | B's signature             |
    And Agent A begins accumulating merit in domain D

  Scenario: Concrete Merit Calculation Example
    Given Agent A (address: 0xA) has made promises in web_development domain (address: 0xWD)
    And the following assessments exist:
      | Timestamp | Promise Address | Assessor Address | Status | Assessor Merit at Time |
      | 1        | 0xP1           | 0xB             | KEPT   | 0.0                    |
      | 2        | 0xP2           | 0xC             | KEPT   | 0.4                    |
      | 3        | 0xP3           | 0xB             | BROKEN | 0.2                    |
      | 4        | 0xP4           | 0xD             | KEPT   | 0.8                    |
      | 5        | 0xP5           | 0xC             | KEPT   | 0.5                    |
    When calculating A's current merit in web_development
    Then for each assessment:
      | Time | Status | Weighted Impact                        | Running Score |
      | 1    | KEPT   | +0.2 (base weight due to no merit)    | 0.2          |
      | 2    | KEPT   | +0.3 (weighted by 0.4 assessor merit) | 0.5          |
      | 3    | BROKEN | -0.2 (weighted by 0.2 assessor merit) | 0.3          |
      | 4    | KEPT   | +0.4 (weighted by 0.8 assessor merit) | 0.7          |
      | 5    | KEPT   | +0.3 (weighted by 0.5 assessor merit) | 0.8          |
    And applying time decay:
      | Factor     | Calculation                              | Result       |
      | Current    | 0.8 (raw score from assessments)         | 0.8         |
      | Age Decay  | Most recent promise was T periods ago    | * 0.9^T     |
    And reaches final merit score of 0.72

  Scenario: Different Observers Calculate Same Merit
    Given the same assessment chain for Agent A
    When Agent B calculates A's merit
    And Agent C calculates A's merit
    Then both reach exactly 0.72
    And can reproduce their calculations for others

  Scenario: Merit Verification
    Given Agent A claims merit in domain D
    When another agent verifies this claim
    Then they can inspect:
      | Evidence        | Verification              |
      | Assessments    | Signed by assessors       |
      | Promises       | Linked to assessments     |
      | Domain         | Matches claimed domain    |
      | Calculations   | Reproducible from chain   |

  Scenario: Domain-Specific Merit
    Given Agent A has high merit in domain D1
    When they make promises in domain D2
    Then their merit in D1 does not affect:
      | Aspect              | In Domain D2              |
      | Stake Requirements | Calculated fresh          |
      | Assessment Weight  | Based only on D2          |
      | Trust Level        | Must be earned in D2      |

  Scenario: Merit Assessment Requirements
    Given a promise P exists in domain D
    When Agent B wants to assess P
    Then they must provide:
      | Component      | Requirement               |
      | Signature     | Valid signature from B     |
      | Domain        | Valid domain address       |
      | Status        | KEPT or BROKEN            |
      | Timestamp     | When assessment made      |
    And the assessment must be properly signed

  Scenario: Merit Decay
    Given Agent A has merit in domain D
    When they stop making promises in D
    Then their merit score gradually decreases based on:
      | Factor         | Effect                    |
      | Time Inactive  | Decay rate increases      |
      | Prior Score    | Higher scores decay faster|
      | Domain Type    | Domain-specific rates     |

  Scenario: Cross-Domain Assessment
    Given a promise involves multiple domains D1 and D2
    When an assessment is made
    Then separate merit calculations occur for:
      | Domain         | Based On                  |
      | D1            | D1-specific aspects       |
      | D2            | D2-specific aspects       |
    And each domain's merit updates independently

  Scenario: Merit Impact on Stake Requirements
    Given Agent A has merit score M in domain D
    When they make a new promise in D
    Then their required stake is adjusted by:
      | Merit Score Range | Stake Multiplier        |
      | 0.0 to 0.2       | 1.0 (full stake)        |
      | 0.2 to 0.5       | 0.8                     |
      | 0.5 to 0.8       | 0.5                     |
      | 0.8 to 1.0       | 0.2 (minimum stake)     |

  Scenario: Assessment Weight by Assessor Merit
    Given Agent B has merit score M in domain D
    When they assess a promise in domain D
    Then their assessment weight is influenced by:
      | Factor             | Impact                      |
      | Merit Score        | Higher merit = more weight  |
      | Assessment History | Prior accuracy              |
      | Stake Amount       | Higher stake = more weight  |

  Scenario: Merit History Preservation
    Given Agent A updates their promises
    When they create a new agent state
    Then their merit history is preserved through:
      | Mechanism      | Effect                    |
      | Previous Link | Chains states together    |
      | Merit Scores   | Carried forward           |
      | Assessments    | Remain valid              |
    And the merit scores can be verified across updates

  # New Scenarios for Cycle Detection and Management in Merit System

  Scenario: Preventing Inheritance Cycles
    Given Agent A inherits from Agent B
    And Agent B inherits from Agent C
    When Agent C attempts to inherit from Agent A
    Then the Cycle Detector should identify a cycle involving Agent A, Agent B, and Agent C
    And the inheritance assignment should be rejected
    And Agent C should be notified of the cycle detection

  Scenario: Preventing Mutual Merit Dependencies
    Given Agent A assesses Agent B's promise P1
    And Agent B assesses Agent A's promise P2
    When the system attempts to calculate merit based on these assessments
    Then the Cycle Detector should identify a merit dependency cycle between Agent A and Agent B
    And the merit calculation process should be aborted
    And Agents A and B should be notified of the cycle detection

  Scenario: Resolving Inheritance Cycles
    Given a cycle has been detected involving Agent X, Agent Y, and Agent Z
    When the system initiates cycle resolution
    Then the system should break the cycle by removing the most recent inheritance assignment
    And the system should notify Agents X, Y, and Z of the resolution action

  Scenario: Resolving Merit Dependency Cycles
    Given a merit dependency cycle has been detected between Agent M and Agent N
    When the system initiates cycle resolution
    Then the system should break the cycle by removing the most recent merit assessment
    And the system should notify Agents M and N of the resolution action

  Scenario: Logging and Auditing Cycle Detection Events in Merit System
    Given a cycle has been detected and resolved
    When the system processes the cycle detection event
    Then the system should log the details of the cycle including involved agents or assessments
    And the system should store the resolution actions taken
