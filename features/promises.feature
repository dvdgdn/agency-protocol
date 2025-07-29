Feature: Promises and Intentions

  Scenario: Creating an Intention
    Given an intention with the description "float in water"
    When the intention is created
    Then the intention should have a unique content-based address
    And the intention's description should be "float in water"

  Scenario: Agent Making and Signing a Promise Based on an Intention
    Given an agent "Agent A" exists
    And an intention with the description "float in water" exists
    When "Agent A" makes and signs a promise to fulfill the intention "float in water"
    Then the promise should have a unique content-based address
    And the promise should be signed by "Agent A"
    And the promise should reflect the intention "float in water"

  Scenario: Inheriting Promises from Multiple Immediate Ancestors
    Given the following agents with their promises:
      | Agent           | Promise           |
      | Parent Agent 1  | build shelters    |
      | Parent Agent 2  | gather resources  |
    And "Child Agent" declares "Parent Agent 1" and "Parent Agent 2" as its parents
    When "Child Agent"'s promises are listed
    Then the promises "build shelters" and "gather resources" should be among them
