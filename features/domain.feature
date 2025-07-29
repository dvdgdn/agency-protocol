Feature: Domain
  A domain categorizes goals and related promises within specific areas of expertise or activity.
  Domains are managed as immutable entities and associated with intentions and promises through their unique addresses.
  
  Background:
    Given the system has registered intentions with unique content-based addresses
    And users can set and manage goals within specific domains
    And protocols are associated with domains
    And the system maintains a registry of domains with unique content-based addresses
    And the system has a Cycle Detector component

  Scenario: Creating a New Domain
    Given an administrator wants to establish a new domain "software_development"
    When the administrator creates domain "software_development" with address "0xDomainSD1" and description "Software Development and Engineering"
    Then "0xDomainSD1" is stored immutably in the system
    And the domain "software_development" is available for association with goals and promises

  Scenario: Associating a Goal with a Domain
    Given a goal "launch mobile app" with address "0xGoalO1" exists
    And domain "software_development" exists with address "0xDomainSD1"
    When User P sets goal "launch mobile app" and assigns it to domain "software_development"
    Then "0xGoalO1" is associated with "0xDomainSD1"
    And all promises related to "0xGoalO1" reference "0xDomainSD1" for domain context

  Scenario: Preventing Domain Modification
    Given domain "marketing" exists with address "0xDomainM1"
    When an agent attempts to modify the description of "0xDomainM1"
    Then the system should reject the modification
    And notify the agent that domains are immutable

  Scenario: Referencing Domain in Promise Creation
    Given User Q has a goal "increase social media presence" in domain "marketing" with address "0xGoalQ1"
    And intention "0xIntentQ1" exists with description "run social media campaigns"
    When User Q creates a promise "0xPromiseQ1" referencing "0xIntentQ1" and associates it with domain "marketing"
    Then "0xPromiseQ1" includes a reference to domain "0xDomainM1"
    And "0xPromiseQ1" is stored immutably in the system

  Scenario: Domain Immutability Through References
    Given domain "finance" exists with address "0xDomainF1"
    When User R sets a new goal "secure funding" in domain "finance"
    Then the goal "0xGoalR1" references "0xDomainF1"
    And all associated promises for "0xGoalR1" maintain references to "0xDomainF1"
    And the system ensures domain references remain immutable
