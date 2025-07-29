Feature: Goal Setter
  A goal setter is a specialized type of user responsible for setting and managing goals within the Agency Protocol.
  Goal setters have permissions to create, reference, and oversee goals and associated promises.
  
  Background:
    Given the system has registered users with unique content-based addresses
    And users can set and manage goals through promises referencing intentions
    And goal setters are a type of user with additional permissions

  Scenario: Assigning Goal Setter Role to a User
    Given User G with address "0xAgentUserG" exists
    When an administrator assigns the role "goal_setter" to User G
    Then User G gains permissions to create and manage goals
    And User G can create promises that set and reference goals

  Scenario: Goal Setter Creating a New Goal
    Given User H is a goal setter with address "0xAgentUserH"
    When User H creates a new goal "increase customer engagement" with address "0xGoalH1" in domain "marketing"
    Then "0xGoalH1" is stored immutably in the system
    And User H can create promises referencing "0xGoalH1" to drive progress

  Scenario: Goal Setter Managing Multiple Goals
    Given Goal Setter User I has multiple goals:
      | Goal Address  | Description                  | Domain          |
      | "0xGoalI1"    | "launch email campaign"      | "marketing"     |
      | "0xGoalI2"    | "develop CRM system"         | "sales"         |
    When User I reviews progress on each goal
    Then the system displays the status and associated promises for "0xGoalI1" and "0xGoalI2"
    And User I can create new promises to advance each goal as needed
