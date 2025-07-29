Feature: Protocol
  A protocol defines the structured methods and rules for achieving specific types of goals within the Agency Protocol.
  Protocols are immutable and referenced by promises to ensure consistency and accountability.
  Updating protocols involves creating new protocols that replace previous ones without modifying existing protocols.
  
  Background:
    Given the system supports multiple protocols associated with specific domains
    And protocols are immutable entities with unique content-based addresses
    And agents can create and reference promises that adhere to protocols
    And the system maintains a registry of protocols
    And the system has a Cycle Detector component

  Scenario: Creating a New Protocol
    Given an administrator wants to establish a new protocol "agile_project_management" for domain "software_development"
    When the administrator defines the protocol "agile_project_management" with address "0xProtocolAPM1" and specific rules
    Then "0xProtocolAPM1" is stored immutably in the system
    And "agile_project_management" protocol is available for association with relevant goals and promises

  Scenario: Assigning a Protocol to a Goal
    Given a goal "develop agile mobile app" with address "0xGoalS1" exists in domain "software_development"
    And protocol "agile_project_management" exists with address "0xProtocolAPM1"
    When User S assigns protocol "agile_project_management" to goal "0xGoalS1"
    Then "0xGoalS1" is associated with protocol "0xProtocolAPM1"
    And all promises related to "0xGoalS1" must adhere to the rules defined in "0xProtocolAPM1"

  Scenario: Preventing Protocol Modification
    Given protocol "0xProtocolAPM1" exists for domain "software_development"
    When an agent attempts to modify the rules of "0xProtocolAPM1"
    Then the system should reject the modification
    And notify the agent that protocols are immutable

  Scenario: Creating a New Protocol to Update Existing Procedures
    Given protocol "0xProtocolAPM1" exists with specific rules for "software_development"
    When an administrator wants to update the protocol rules
    Then the administrator must create a new protocol "agile_project_management_v2" with address "0xProtocolAPM2" reflecting the updated rules
    And "0xProtocolAPM2" is stored immutably in the system
    And agents can transition to using "0xProtocolAPM2" for new goals without altering existing "0xProtocolAPM1" promises

  Scenario: Referencing Protocol in Promise Creation
    Given protocol "0xProtocolPM1" exists for domain "project_management"
    And intention "0xIntentPM1" exists with description "plan project timeline"
    When User T creates a promise "0xPromiseT1" referencing "0xIntentPM1" and protocol "0xProtocolPM1"
    Then "0xPromiseT1" must include:
      | Component        | Content                             |
      | Intention Address| "0xIntentPM1"                       |
      | Protocol Address | "0xProtocolPM1"                     |
      | Agent Address    | "0xAgentUserT"                      |
      | Signature        | Signed with User T's private key      |
    And "0xPromiseT1" is stored immutably in the system
    And "0xPromiseT1" adheres to the rules defined in "0xProtocolPM1"

  Scenario: Transitioning to a New Protocol
    Given protocol "0xProtocolPM1" is in use for domain "project_management"
    And a new protocol "0xProtocolPM2" is created with updated rules
    When a goal setter assigns "0xProtocolPM2" to a new goal "0xGoalT2"
    Then all new promises under "0xGoalT2" reference "0xProtocolPM2"
    And existing goals and promises using "0xProtocolPM1" remain unchanged and continue to adhere to "0xProtocolPM1"



Scenario: Associate LLM Goal Assistant with a new protocol
  Given I have created a new LLM goal assistant called "GTD Assistant" 
    And a protocol called "GTD" exists with address "0xProtocolGTD1"
  When I associate "GTD Assistant" with the "GTD" protocol
  Then the association is stored immutably in the system
    And I should receive a confirmation message "LLM Goal Assistant has been successfully associated with the 'GTD' protocol."
