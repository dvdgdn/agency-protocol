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



