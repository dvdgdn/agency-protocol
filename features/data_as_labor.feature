Feature: Data as Labor
  Agents can make promises about sharing and using data
  Data sharing promises can be assessed in relevant domains
  Merit in data handling domains affects stake requirements
  All data operations are based on signed promises

  Background:
    Given the system supports data-related intentions
    And promises can reference encrypted data
    And merit accumulates in data handling domains
    And batch updates process assessments of data promises

  Scenario: Data Sharing Promise Creation
    Given Agent A has data D they want to share
    When they create a promise P:
      | Component        | Content                           |
      | Intention       | "Share dataset D with terms T"    |
      | Data Reference  | Encrypted location of D           |
      | Access Key      | Encrypted with recipient's key    |
      | Signature       | A's signature                     |
    Then P has a unique content-based address
    And can be assessed in data sharing domains

  Scenario: Data Access Revocation
    Given Agent A made promise P1 to share data with B
    When A creates new promise P2:
      | Component        | Content                           |
      | Intention       | "Revoke access to data D"         |
      | References      | P1's address                      |
      | Signature       | A's signature                     |
    Then P2 invalidates P1
    And becomes assessable in data handling domains

  Scenario: Data Usage Promise
    Given Agent B receives access to data D
    When they make promise P:
      | Component        | Content                           |
      | Intention       | "Use data D according to terms T" |
      | References      | Original sharing promise          |
      | Credit Stake    | Based on data handling merit     |
    Then P becomes assessable for compliance
    And affects B's merit in data handling

  Scenario: Data Handling Merit
    Given Agent B has made multiple data usage promises
    When these promises are assessed
    Then B's merit is calculated in domains:
      | Domain           | Aspects Assessed                  |
      | data_handling   | General compliance                |
      | data_privacy    | Privacy protection                |
      | data_security   | Security measures                 |

  Scenario: Data Promise Assessment
    Given Agent A shared data with Agent B
    When Agent A assesses B's data handling
    Then they create an assessment:
      | Component        | Content                           |
      | Promise         | B's data usage promise            |
      | Domain          | Relevant data handling domain     |
      | Status          | KEPT or BROKEN                    |
      | Signature       | A's signature                     |
    And affects B's merit in next batch update

  Scenario: Group Data Sharing
    Given Agents A, B, C want to share data collectively
    When they create linked promises:
      | Agent           | Promise Content                    |
      | A              | Share data A with group            |
      | B              | Share data B with group            |
      | C              | Share data C with group            |
    Then each promise:
      | Aspect          | Requirement                       |
      | References     | Other agents' promises            |
      | Stakes         | Based on data sharing merit       |
      | Assessment     | In collective sharing domain      |

  Scenario: Data Misuse Consequences
    Given Agent B promised to use data appropriately
    When their promise is assessed as BROKEN
    Then in next batch update:
      | Effect          | Result                            |
      | Credit         | Stake is lost                     |
      | Merit          | Decreases in data domains         |
      | Future Stakes  | Higher requirements               |
      | Access         | New promises may be invalid       |

  Scenario: Data Format Standards
    Given Agent A shares data D
    When creating the sharing promise
    Then they must specify:
      | Aspect          | Requirement                       |
      | Format         | Standard supported format         |
      | Schema         | Clear data structure              |
      | Validation     | Format checking method            |
    And this becomes part of the assessable promise

  Scenario: Data Deletion Promise
    Given Agent A requests data deletion
    When creating deletion promise P:
      | Component        | Content                           |
      | Intention       | "Delete data D"                   |
      | References      | Original sharing promise          |
      | Deadline        | Timeframe for compliance          |
    Then recipients must acknowledge with counter-promise
    And both promises become assessable
