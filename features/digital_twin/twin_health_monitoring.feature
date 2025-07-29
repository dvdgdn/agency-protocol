Feature: Agency Protocol Governed Digital Twin Health Assessment, KPI Monitoring & Accountability
  In order to verifiably track twin fidelity, system performance, and ensure accountability
  As a Platform Operator, relying on a "Twin Health Monitoring Agent"
  I want continuous health assessments, KPI calculations tied to promises, and threshold-based alerting.

  Background:
    Given an active "Digital Twin Agent" named "Twin-F"
    And an active "Twin Health Monitoring Agent" responsible for "Twin-F", promising "Accurate Health & KPI Assessment"
    And "Twin-F" promises "Operational Uptime of 99.5%" and "Average Telemetry Latency below 100ms"

  Scenario: Assessing Digital Twin Agent's overall health score based on its promises
    Given health metrics for "Twin-F" are: uptime 99.9%, avg-latency 80ms, error-rate 0.1%
    And the "Twin Health Monitoring Agent" promises "Weighted Health Score Calculation" (e.g., uptime=50%, latency=30%, errors=20%)
    When the "Twin Health Monitoring Agent" computes the health score for "Twin-F"
    Then the score should be accurately calculated (e.g., weighted sum) and be within the promised range [0, 1]
    And this score serves as an assessment of "Twin-F"'s overall operational promise fulfillment

  Scenario: Emitting a verifiable alert upon degraded health assessment
    Given "Twin-F"'s calculated healthScore is 0.65 (below a promised operational threshold of 0.7)
    When the "Twin Health Monitoring Agent" performs its health check
    Then the "Twin Health Monitoring Agent" should assess "Twin-F"'s operational promise as "DEGRADED"
    And emit a "TwinHealthDegradedEvent" as verifiable evidence, detailing the score and breached threshold

  Scenario Outline: Assessing KPI-specific promises and emitting alerts on breach
    Given "Twin-F" has made a specific "KPI Adherence Promise" for "<kpi_name>" with a threshold of "<kpi_threshold>"
    And the "Twin Health Monitoring Agent" promises "Accurate KPI Measurement and Threshold Assessment"
    When the "Twin Health Monitoring Agent" measures "<measured_value>" for "<kpi_name>" on "Twin-F"
    Then if "<measured_value>" breaches the "<kpi_threshold>"
      The "Twin Health Monitoring Agent" should assess "Twin-F"'s "KPI Adherence Promise for <kpi_name>" as "BROKEN"
      And emit a "KPIAlertEvent" with verifiable details of the breach
    Else
      The "Twin Health Monitoring Agent" should assess "Twin-F"'s "KPI Adherence Promise for <kpi_name>" as "KEPT"
      And no "KPIAlertEvent" related to this specific KPI promise should be emitted

    Examples:
      | kpi_name    | kpi_threshold | measured_value |
      | avg-latency | 100ms         | 120ms          |
      | error-rate  | 0.5%          | 0.2%           |
      | drift-rate  | 1% / hr       | 1.2% / hr      |