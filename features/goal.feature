Feature: Goal
  A goal represents a specific objective that a user aims to achieve within a defined domain.
  Goals drive the creation of promises and assessments, contributing to merit and credit accumulation.
  Goals are immutable; updates involve creating new goals referencing previous ones.
  
  Background:
    Given users are immutable agents who can set and manage goals
    And the system maintains a chain of promises to reflect goal progress
    And goals are immutable entities identified by unique content-based addresses

  Scenario: User Setting a New Goal
    Given User C with address "0xAgentUserC" wants to set a new goal "launch online course" in domain "education"
    When User C creates goal "0xGoalC1" with description "launch online course" and associates it with domain "0xDomainEducation1"
    Then "0xGoalC1" is stored immutably in the system
    And User C can create promises referencing "0xGoalC1"

  Scenario: Tracking Goal Progress Through Promises
    Given User D has a goal "increase sales" with address "0xGoalD1" in domain "sales"
    And intention "0xIntentD1" exists with description "reach monthly sales target"
    When User D creates a promise "0xPromiseD1" referencing "0xIntentD1" for goal "0xGoalD1"
    Then "0xPromiseD1" is stored immutably in the system
    And User D's progress towards "increase sales" is updated based on promise fulfillment

  Scenario: Achieving a Goal by Creating a New Promise
    Given User E has a goal "develop mobile app" with address "0xGoalE1" in domain "technology"
    And intention "0xIntentE1" exists with description "release MVP of mobile app"
    And User E creates a promise "0xPromiseE1" referencing "0xIntentE1"
    When User E fulfills the promise "0xPromiseE1"
    Then Agent F assesses "0xPromiseE1" as "KEPT" with evidence "release_notes.pdf"
    And User E's goal "0xGoalE1" is marked as achieved
    And User E's merit and credit in "technology" are updated accordingly

  Scenario: Goal Immutability and Reference to Previous Goals
    Given User F has an existing goal "optimize website performance" with address "0xGoalF1"
    When User F decides to set a new goal "enhance website scalability"
    Then User F creates a new goal "0xGoalF2" referencing "0xGoalF1"
    And "0xGoalF2" is stored immutably in the system
    And User F's latest goal reference is updated to "0xGoalF2"
