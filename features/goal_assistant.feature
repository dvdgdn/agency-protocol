Feature: Goal Assistant
  A goal assistant is an entity that assists users in setting and achieving their goals.
  Goal assistants can be either users with specific roles or AI-driven agents designed to provide support.
  
  Background:
    Given the system has registered users and AI agents with unique content-based addresses
    And goal assistants can create and manage promises to support goal achievement
    And goal assistants reference intentions to drive user accountability

  Scenario: User Acting as a Goal Assistant
    Given User J with address "0xAgentUserJ" has the role "goal_assistant"
    And User K with address "0xAgentUserK" has a goal "complete certification" in domain "education"
    When User J creates a promise "0xPromiseJ1" referencing intention "0xIntentJ1" to support User K's goal
    Then "0xPromiseJ1" is stored immutably in the system
    And User K's progress towards "complete certification" is aided by "0xPromiseJ1"

  Scenario: AI Acting as a Goal Assistant
    Given an AI agent "AI_Assistant1" with address "0xAIAssistant1" is registered as a goal assistant
    And User L has a goal "develop machine learning model" in domain "technology"
    When "AI_Assistant1" creates a promise "0xPromiseAI1" referencing intention "0xIntentAI1" to assist User L
    Then "0xPromiseAI1" is stored immutably in the system
    And User L receives automated support through "0xPromiseAI1" to achieve the goal

  Scenario: Goal Assistant Managing Support Promises
    Given User M is a goal setter with a goal "organize webinar" in domain "marketing"
    And User N is assigned as a goal assistant to support User M
    When User N creates promises "0xPromiseN1" and "0xPromiseN2" referencing intentions "0xIntentN1" and "0xIntentN2" respectively
    Then "0xPromiseN1" and "0xPromiseN2" are stored immutably in the system
    And User M's goal "organize webinar" progresses through the support provided by "0xPromiseN1" and "0xPromiseN2"
