Feature: Agency Protocol Governed Real-Time Synchronization
  In order to ensure digital twin agents accurately reflect their physical counterparts through accountable processes
  As a Data Integrator, interacting with promise-making agents
  I want to ingest live telemetry and apply verifiable reconciliation policies.

  Background:
    Given an active "Digital Twin Agent" named "Twin-B" promising "State Synchronization" in domain "asset_telemetry/Asset-67890"
    And an active "Telemetry Ingestion Agent" promising "Accurate Data Mapping and Processing" for external ID "Asset-67890"
    And the "Telemetry Ingestion Agent" has staked on its "Policy Adherence Promise"

  Scenario: Ingesting a telemetry data point via an accountable Ingestion Agent
    Given a telemetry data point { timestamp: PT, metrics: { temperature: 75 } } for "Asset-67890", where PT is now
    When the "Telemetry Ingestion Agent" processes this data point
    Then the "Telemetry Ingestion Agent" should fulfill its "Promise to Map Data to Correct Twin" (i.e., "Twin-B")
    And "Twin-B" should fulfill its "Promise to Update Reported State" with temperature 75 at timestamp PT
    And a "DataIngestedEvent" for "Twin-B" with PT and temperature 75 should be emitted as evidence for assessing synchronization

  Scenario Outline: Verifiable reconciliation policy adherence for out-of-order data by Ingestion Agent
    Given "Twin-B" last reported state timestamp is "<last_timestamp>"
    And the "Telemetry Ingestion Agent" is configured with reconciliation policy "<policy_name>" for out-of-order data
    When a telemetry data point for "Twin-B" arrives with timestamp "<incoming_timestamp>"
    Then the "Telemetry Ingestion Agent" should fulfill its "Policy Adherence Promise for <policy_name>" by ensuring the data is "<expected_action>"
    And evidence of this "<expected_action>" should be recorded in the ingestion logs

    Examples:
      | last_timestamp             | incoming_timestamp         | policy_name | expected_action          |
      | 2025-05-21T10:00:00Z       | 2025-05-21T09:59:59Z       | reject      | rejected_and_logged      |
      | 2025-05-21T10:00:00Z       | 2025-05-21T11:00:00Z       | accept      | accepted_and_applied     |
      | 2025-05-21T10:00:00Z       | 2025-05-21T09:59:59Z       | reorder     | buffered_for_reordering  |