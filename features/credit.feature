Feature: Credit System Fundamentals
  Credit represents transferrable value in the system
  Credit can be staked on promises
  Credit balances update in batches unless expedited

  Background:
    Given the system has registered agents with unique addresses
    And agents can sign promises with their private keys
    And agents can accumulate merit in domains through assessments
    And credit can be obtained through fulfilled promises or transfers
    And intentions can extend base types for specific requirements
    And the system has a Cycle Detector component

  Scenario: Making a Payment Promise
    Given Agent A creates a promise
    And the promise references a payment intention of type "credit_payment"
    And the payment intention specifies 1000 credits
    When Agent A signs the promise with their private key
    Then the promise has a unique content-based address
    And the promise's signature can be verified with A's public key
    And the promise is registered in the system

  Scenario: Conditional Bilateral Promises
    Given Agent B creates a promise P1 with intention "build e-commerce website"
    And P1 is signed by Agent B
    And Agent A creates a promise P2 with intention "transfer 1000 credits to Agent B"
    And P2 is signed by Agent A
    When Agent A adds P1 as a condition of P2
    And Agent B adds P2 as a condition of P1
    Then each promise's fulfillment depends on the other's assessment
    And assessment of P1 as "KEPT" is necessary for P2's credit transfer
    And assessment of P2 as "KEPT" confirms the credit transfer completed

  Scenario: Batch Credit Updates
    Given multiple promises have received assessments
    When the regular batch update time arrives
    Then the system processes credit adjustments based on:
      | Factor               | Source                      |
      | Promise assessments | Kept or broken status       |
      | Staked amounts      | Original promise stakes     |
      | Domain relevance    | Assessment domains          |

  Scenario: Promise Assessment in Domain
    Given a promise has been made
    When an agent assesses the promise
    Then they create an assessment containing:
      | Field             | Content                    |
      | Promise Address   | Target promise             |
      | Assessor Address  | Assessing agent           |
      | Domain Address    | Relevant domain           |
      | Status           | KEPT or BROKEN             |
    And the assessment is signed by the assessor
    And merit updates in the domain await batch processing

  Scenario: Extending Payment Intentions
    Given a base payment intention type exists
    When an agent creates a specialized payment intention
    Then it can specify additional requirements like:
      | Type              | Examples                   |
      | bitcoin_payment   | BTC amount, address        |
      | credit_payment    | Credit amount, timeline    |
      | mutual_credit     | Credit line terms          |
    And merit accumulates specifically for that payment type

  Scenario: Credit Transfer Through Promises
    Given Agent A wants to transfer credit to Agent B
    When Agent A creates a promise referencing a credit_transfer intention
    Then the promise specifies:
      | Component         | Detail                     |
      | Intention        | Type: credit_transfer      |
      | Amount           | Transfer amount            |
      | Recipient        | Agent B's address          |
    And requires A's signature
    And processes in the next batch update

  Scenario: Mutual Credit Line Establishment
    Given Agent A and B want to establish mutual credit
    When they create reciprocal promises with mutual_credit intentions
    Then each promise specifies:
      | Component         | Detail                     |
      | Credit Limit     | Maximum negative balance    |
      | Settlement Terms | When/how to settle         |
      | Duration         | Time period                |
    And both promises must be signed
    And both promises must include the other as a condition

  Scenario: Merit Accumulation in Payment Domains
    Given an agent makes multiple payment promises
    When these promises are assessed as kept
    Then merit accumulates specifically in:
      | Domain Type        | Examples                   |
      | general_payment    | All payment types          |
      | bitcoin_payment    | BTC specific               |
      | mutual_credit     | Credit line handling       |
    And stake requirements adjust based on domain-specific merit

  Scenario: Promise Verification
    Given a promise exists in the system
    When verifying the promise
    Then the system checks:
      | Factor            | Verification                |
      | Signature        | Matches agent's public key  |
      | Address          | Content-based hash matches  |
      | Intention        | Exists and is valid         |
      | Conditions       | All references resolve      |
    And the promise is only valid if all checks pass

  # New Scenarios for Cycle Detection and Management in Credit System

  Scenario: Preventing Credit Transfer Cycles
    Given Agent A transfers credit to Agent B through Promise P1
    And Agent B transfers credit to Agent C through Promise P2
    When Agent C attempts to transfer credit back to Agent A through Promise P3
    Then the Cycle Detector should identify a credit transfer cycle involving P1, P2, and P3
    And the credit transfer Promise P3 should be rejected
    And Agent C should be notified of the cycle detection

  Scenario: Resolving Credit Transfer Cycles
    Given a credit transfer cycle has been detected involving Promises P4, P5, and P6
    When the system initiates cycle resolution for credit transfers
    Then the system should break the cycle by removing the most recent credit transfer Promise P6
    And the system should notify Agents involved in Promises P4, P5, and P6 of the resolution

  Scenario: Logging and Auditing Credit Transfer Cycles
    Given a credit transfer cycle has been detected and resolved
    When the system processes the cycle resolution event
    Then the system should log the details of the cycle including involved promises and agents
    And the system should store the resolution actions taken
