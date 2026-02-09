Feature: Assessment Creation and Retrieval

  Scenario: assess a promise as broken

    Given an agent "Agent X" assesses a promise made by "Agent Y"
    When "Agent X" marks the promise as "broken"
    Then the assessment is recorded in the system
    And "Agent Y" is notified of the broken promise assessment


  Scenario: assess a promise as kept

    Given an agent "Agent X" assesses a promise made by "Agent Y"
    When "Agent X" marks the promise as "kept"
    Then the assessment is recorded in the system
    And "Agent Y" is notified of the kept promise assessment

@phase1 @assessment
Feature: Independent assessment of PromiseCards

  Background:
    Given a PromiseCard "P1" exists
    And an agent "Assessor X" exists with a key pair

  @phase1 @assessment @publish
  Scenario: Publish an assessment with a signed verdict
    When "Assessor X" evaluates "P1" using referenced evidence
    Then "Assessor X" publishes an Assessment "A1" with:
      | field        | value                            |
      | promise      | P1                               |
      | verdict      | KEPT                             |
      | confidence   | 0.75                             |
      | rationale    | references evidence ids/pointers |
    And "A1" is signed by "Assessor X"
    And "A1" is immutable once published

  @phase2 @assessment @dispute
  Scenario: Promisor can dispute an assessment with counter-evidence
    Given Assessment "A1" exists with verdict "BROKEN"
    When "Agent A" publishes a Dispute "D1" referencing "A1"
    And "D1" includes counter-evidence references
    Then the system records "D1" as linked to "A1"
    And the promise status becomes "DISPUTED" pending review

@phase1 @assessment @signature
Feature: Assessments are signed and auditable

  Background:
    Given an agent "Assessor X" exists with a key pair
    And a promise "P1" exists made by "Agent Y"

  @phase1 @record
  Scenario: Publish a signed assessment
    When "Assessor X" marks "P1" as "kept"
    Then the assessment record includes:
      | promise | assessor | verdict |
      | P1      | X        | kept    |
    And the assessment is signed by "Assessor X"
    And the signature can be verified

  @phase2 @evidence_links
  Scenario: Assessment references evidence artifacts when required
    Given "P1" requires evidence
    When "Assessor X" assesses "P1"
    Then the assessment includes references to evidence addresses

Feature: Meritable Assessment

  Scenario Outline: Agent's Merit Changes Based on Assessment Corroboration
    Given an agent "Agent X" assesses a promise made by a named agent with their merit on the line
    When "Agent X" submits the assessment
    Then the system records the assessment as meritable
    And "Agent X"’s merit relative to this agent's name will "<change>" if future assessments "<outcome>"

    Examples:
      | change   | outcome          |
      | increase | tend to agree    |
      | decrease | tend to disagree |



      
# Feature: Disputable Assessment (Dispute) Creation and Retrieval


# These assessments can be created for promises that are disputable.  When a promise is disputed, this information is communicated to all agents.  

# Creating a dispute is riskier for agents than creating assessments.  For this reason, the reward is also greater if the dispute resolvers side with the disputer.

# Feature: Includable Assessment Creation and Retrieval

# These assessments can only be created by certain agents.

# Feature: Delayable Assessment Creation and Retrieval

# These assessments have a random delay that's adjustable, making it difficult to identify the assessor.

# Feature: Creditable Assessment Creation

# These assessments put credit on the line.

