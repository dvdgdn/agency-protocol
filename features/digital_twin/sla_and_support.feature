# features/ap_sla_and_support.feature
Feature: Agency Protocol SLA & Support Agents
  In order to guarantee enterprise-grade uptime and response
  As a Platform Customer
  I want SLA Agents that stake on RTO/RPO and escalate to human teams

  Background:
    Given an SLA Agent promising “RTO≤1 hr” and “RPO≤5 min”
    And a Support Agent promising “Initial Response ≤1 hr” and “Resolution ≤4 hr”

  Scenario: Automated RTO/RPO monitoring
    Given Twin “SL-T1” is under SLA RTO=1 hr, RPO=5 min
    And a simulated outage begins at 2025-05-21T00:00:00Z
    When the system restores partial service at 2025-05-21T00:45:00Z
    Then the SLA Agent should fulfill its “Promise to Meet RTO”
    And emit an RTOComplianceEvent with actualRTO=45 min
    And no SLA breach event

  Scenario: SLA breach escalation
    Given a complete outage of Twin “SL-T2” lasts >1 hr
    When the SLA Agent detects RTO>1 hr
    Then it should emit an SLABreachEvent
    And trigger the Support Agent’s “Escalate to Human Ops” promise
    And Support Agent should emit a SupportEscalationEvent within 1 hr

  Scenario Outline: Support response and resolution times
    Given a support ticket is opened for Twin “SL-<id>”
    When the ticket is created at "<opened_at>"
    Then the Support Agent should respond by "<response_by>"
    And resolve by "<resolve_by>"

    Examples:
      | id | opened_at           | response_by           | resolve_by            |
      | 10 | 2025-05-21T08:00:00Z | 2025-05-21T09:00:00Z | 2025-05-21T12:00:00Z |
      | 11 | 2025-05-21T22:30:00Z | 2025-05-22T23:30:00Z | 2025-05-23T02:30:00Z |
