Feature: Agent Name System (ANS)

  Background:
    Given the Agent Name System is operational within the Agency Protocol
    And agents can register with names and tags
    And tags can inherit from other tags to form a hierarchy
    And namespaces are used to organize and resolve agent names

  Scenario: Registering an agent with a name and tags
    Given an agent "Agent A" has a public key "PubKeyA"
    When "Agent A" creates a base agent state including a promise to have the name "Service X"
    And "Agent A" includes tags "service", "category1", "featureA"
    And "Agent A" registers with the Agent Name System
    Then the Agent Name System records "Agent A" under the namespace "Service X"
    And associates the tags "service", "category1", "featureA" with "Agent A"
