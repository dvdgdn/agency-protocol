Feature: Skin in the Game
  The Agency Protocol uses merit and credit to incentivize good faith participation
  Merit is domain-specific and updated in batches based on assessments
  Credit is transferrable and used for staking on promises
  All actions have consequences through credit stakes and merit effects

  Background:
    Given a decentralized ledger recording all promises and assessments immutably
    And agents have unique content-based addresses derived from their public keys
    And agents sign their promises and assessments
    And both credit and merit update in batch processes
    And merit in each domain is calculated from assessment chains

  Scenario: Batch Merit Update Process
    Given multiple new assessments have been made in domain D
    When the batch update time arrives
    Then the system:
      | Step           | Action                                  |
      | Collect       | All new assessments since last batch    |
      | Order         | Sort assessments by timestamp           |
      | Process       | Apply each assessment sequentially      |
      | Calculate     | New merit scores for affected agents    |
      | Record        | Batch update results with timestamp     |
    And agents can verify calculations from the assessment chain

  Scenario: Merit Calculation Between Batches
    Given Agent B wants to verify A's merit in domain D
    And the last batch update was at time T
    When calculating current merit
    Then they:
      | Step           | Action                                  |
      | Start         | Use merit from last batch at time T     |
      | Add           | Include pending assessments since T      |
      | Calculate     | Projected merit including pending items  |
    And this projection is used until next batch update

  Scenario: Making and Assessing a Promise in Domain
    Given Agent A creates a promise P with intention I in domain D
    And Agent A signs P with their private key
    And Agent A stakes S credits based on their last batched merit in D
    When Agent B assesses P as "KEPT"
    Then Agent B creates a signed assessment containing:
      | Field           | Value                     |
      | Promise        | P's address               |
      | Assessor       | B's address               |
      | Domain         | D's address               |
      | Status         | "KEPT"                    |
      | Signature      | B's signature             |
    And the assessment waits for next batch update to affect merit

  Scenario: Expedited Merit Update
    Given Agent A needs an immediate merit update in domain D
    When they pay the expedited processing fee
    Then the system:
      | Step           | Action                                  |
      | Process       | All pending assessments for A in D      |
      | Calculate     | New merit score                         |
      | Record        | Special off-cycle batch update          |
    And the new merit score is immediately available

  [rest of scenarios remain the same...]

  Scenario: Bilateral Promise with Credit Transfer
    Given Agent A promises to build website W
    And Agent B promises to transfer 1000 credits upon W's completion
    When they formalize these promises:
      | Promise         | Conditions                |
      | A's promise    | References B's payment    |
      | B's promise    | References A's delivery   |
    Then their required stakes are calculated from:
      | Agent    | Domain          | Merit Calculation           |
      | A       | web_development | Based on assessment chain   |
      | B       | payment        | Based on assessment chain   |

  Scenario: Merit Affects Stake Requirements
    Given Agent A makes a promise in domain D
    When calculating required stake
    Then the system:
      | Step           | Process                                 |
      | Get Chain     | Collect all assessments of A in D       |
      | Calculate Merit| Apply formula to assessment chain       |
      | Set Stake     | Higher merit = lower stake requirement  |
    And the calculation is reproducible by all agents

  Scenario: Assessment Weight Based on History
    Given Agent B wants to assess Agent A's promise
    When calculating B's assessment weight
    Then the system considers B's own merit in domain D:
      | Factor         | Source                                  |
      | Merit Score   | Calculated from B's assessment chain    |
      | Stake Amount  | Credits staked on this assessment       |
      | History       | Past assessment accuracy                |

  Scenario: Credit Lost Through Broken Promise
    Given Agent A has staked 100 credits on promise P
    When P is assessed as "BROKEN"
    Then in the next batch update:
      | Effect         | Result                                 |
      | Stake Lost    | A forfeits 100 credits                |
      | Merit Impact  | Assessment added to A's chain in D     |
      | Future Stakes | Requirement may increase               |

  Scenario: Multiple Domain Promises
    Given Agent A makes promise P involving domains D1 and D2
    When calculating stake requirements
    Then each domain is considered separately:
      | Domain    | Merit Calculation                        |
      | D1       | Based on D1 assessment chain             |
      | D2       | Based on D2 assessment chain             |
    And the higher stake requirement applies

  Scenario: Promise Assessment Affects Future Stakes
    Given Agent A has promises in domain D
    When calculating their merit-based stake requirement
    Then only completed assessments are considered:
      | Assessment Age | Weight                                 |
      | Recent        | Higher impact on calculation           |
      | Older         | Impact decreases with time             |
      | Very Old      | Minimal impact on current merit        |

  Scenario: Incentive Alignment Through Stakes
    Given Agent A considers making promise P
    When they evaluate required stake S
    Then S is high enough that:
      | Outcome        | Consequence                            |
      | Keep Promise  | Recover stake + potential reward       |
      | Break Promise | Lose stake + merit impact              |
    And honest fulfillment is most profitable strategy
