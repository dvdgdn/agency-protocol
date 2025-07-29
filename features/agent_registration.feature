Feature: Agent Registration

  Scenario: Registration with the Registry Service
    Given an agent "Agent X" has been created and has a content-based address
    When the agent registers with the Registry service
    Then a REGISTER event is emitted, announcing that an agent with address "X" has come online
    And other agents and services are informed of the new agent's existence
