@current
Feature: Promise Fulfillment and Merit Calculation
  As an agent in the Agency Protocol
  I want to make promises and have them assessed
  So that I can build merit in specific domains

  Background:
    Given a clean Agency Protocol environment
    And an agent named "Alice" exists
    And an agent named "Bob" exists
    And an agent named "Charlie" exists
    And an intention with description "Deliver project on time" in domain "freelancing"
    And an intention with description "Provide quality code review" in domain "programming"
    And an intention with description "Respond to inquiry within 24 hours" in domain "customer-service"

  Scenario: Creating a promise
    When "Alice" makes a promise with intention "Deliver project on time"
    Then the promise should be successfully created

  Scenario: Creating a promise with stake
    When "Alice" makes a promise with intention "Deliver project on time" and stake 10
    Then the promise should be successfully created
    And the promise made by "Alice" regarding "Deliver project on time" should have the following properties:
      | stake | 10 |

  Scenario: Assessing a kept promise
    Given "Alice" makes a promise with intention "Deliver project on time"
    When "Bob" assesses the promise made by "Alice" regarding "Deliver project on time" as "KEPT"
    Then the assessment should be successfully created
    And the promise made by "Alice" regarding "Deliver project on time" should have 1 assessments

  Scenario: Assessing a broken promise
    Given "Alice" makes a promise with intention "Deliver project on time"
    When "Bob" assesses the promise made by "Alice" regarding "Deliver project on time" as "BROKEN"
    Then the assessment should be successfully created
    And the promise made by "Alice" regarding "Deliver project on time" should have 1 assessments

  Scenario: Assessing a promise with evidence
    Given "Alice" makes a promise with intention "Deliver project on time"
    When "Bob" assesses the promise made by "Alice" regarding "Deliver project on time" as "KEPT" with evidence:
      | description                     | dataUri                                   |
      | Project delivery confirmation   | evidence://delivery-confirmation-12345    |
      | Client satisfaction screenshot  | evidence://client-satisfaction-12345      |
    Then the assessment should be successfully created
    And the promise made by "Alice" regarding "Deliver project on time" should have 1 assessments

  Scenario: Building merit through kept promises
    Given "Alice" makes a promise with intention "Deliver project on time"
    And "Alice" makes a promise with intention "Provide quality code review"
    And "Bob" assesses the promise made by "Alice" regarding "Deliver project on time" as "KEPT"
    And "Charlie" assesses the promise made by "Alice" regarding "Provide quality code review" as "KEPT"
    Then "Alice" should have merit score of 1.0 in domain "freelancing"
    And "Alice" should have merit score of 1.0 in domain "programming"

  Scenario: Merit reflects mix of kept and broken promises
    Given "Alice" makes a promise with intention "Deliver project on time"
    And "Alice" makes a promise with intention "Respond to inquiry within 24 hours"
    And "Bob" assesses the promise made by "Alice" regarding "Deliver project on time" as "KEPT"
    And "Charlie" assesses the promise made by "Alice" regarding "Respond to inquiry within 24 hours" as "BROKEN"
    Then "Alice" should have merit score of 1.0 in domain "freelancing"
    And "Alice" should have merit score of 0.0 in domain "customer-service"

  Scenario: Merit calculation with multiple assessments
    Given "Alice" makes a promise with intention "Deliver project on time"
    And "Bob" assesses the promise made by "Alice" regarding "Deliver project on time" as "KEPT"
    And "Charlie" assesses the promise made by "Alice" regarding "Deliver project on time" as "BROKEN"
    Then "Alice" should have merit score of 0.5 in domain "freelancing"

  Scenario: An agent cannot assess their own promise
    Given "Alice" makes a promise with intention "Deliver project on time"
    When "Alice" assesses the promise made by "Alice" regarding "Deliver project on time" as "KEPT"
    Then the operation should fail with message containing "cannot assess own promise"
