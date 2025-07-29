# features/ap_telemetry_performance.feature
Feature: Agency Protocol High-Performance Telemetry Ingestion
  In order to support industrial-scale streams
  As a Data Integrator
  I want ingestion agents to guarantee >10k msgs/sec and <50 ms end-to-end latency

  Background:
    Given an active Telemetry Ingestion Agent promising “High-Throughput Ingestion” and “Low-Latency Sync”

  Scenario: Sustained high throughput under load
    Given a burst of 20,000 telemetry messages for Twin “TP-1000” over 1 second
    When the Telemetry Ingestion Agent processes the burst
    Then observed throughput should be ≥10,000 msgs/sec
    And no message should be dropped
    And a DataThroughputEvent with throughput=≥10k should be emitted

  Scenario: Sub-50 ms state update latency
    Given a single telemetry message arrives for Twin “TP-1000”
    When the Telemetry Ingestion Agent processes it
    Then the twin’s reported state should be updated in ≤50 ms
    And an UpdateLatencyEvent with measuredLatency≤50 ms should be emitted

  Scenario: Batched-commit mode to optimize ledger writes
    Given the Telemetry Ingestion Agent is configured with batch size 100
    When 100 messages arrive within 10 ms
    Then the agent should commit all 100 state updates in a single ledger transaction
    And emit a BatchCommitEvent recording batchSize=100
