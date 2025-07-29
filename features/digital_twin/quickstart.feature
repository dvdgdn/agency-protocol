# features/ap_quickstart.feature
Feature: Agency Protocol QuickStart Agent
  In order to onboard assets in minutes, not hours
  As a Platform Operator
  I want a QuickStart Agent that auto-wires all registry, metadata and promise events in one step

  Background:
    Given a QuickStart Agent is active and stakes on its onboarding promises

  Scenario: One-step twin provisioning
    Given I submit a single payload:
      | externalId    | name        | metadata                               |
      | Asset-QS-001  | “Pump-A”    | { location: “Plant-1”, type: “pump” }  |
    When the QuickStart Agent processes this payload
    Then it should create a Digital Twin Agent for “Asset-QS-001” within 5 minutes
    And fulfill its “Promise to Assign Unique Twin ID”
    And fulfill its “Promise to Initialize in ACTIVE State”
    And emit a TwinRegisteredEvent as evidence

  Scenario: Idempotent onboarding
    Given the QuickStart Agent has already created a twin for “Asset-QS-001”
    When I resubmit the same payload
    Then the QuickStart Agent should recognize the existing twin
    And return the same twin ID without emitting duplicate events
