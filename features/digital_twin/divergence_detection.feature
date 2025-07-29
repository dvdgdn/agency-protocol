Feature: Agency Protocol Enhanced Digital Twin Divergence Assessment
  In order to assess the synchronization promise of a Digital Twin Agent
  As a Platform Operator, relying on a "Divergence Detection Agent"
  I want automated divergence checks resulting in formal assessments and alerts.

  Background:
    Given an active "Digital Twin Agent" named "Twin-C" promising "Synchronization Fidelity for Pressure" within domain "industrial_sensors/pressure"
    And "Twin-C" has staked credits on this promise
    And a "Divergence Detection Agent" is active, promising "Accurate Divergence Calculation and Assessment" for "Twin-C"
    And the "Divergence Detection Agent" has configured a divergence threshold of 5% for "Twin-C"'s "pressure" metric
    And the "Divergence Detection Agent" uses KL-Divergence or equivalent information-theoretic measures for nuanced drift analysis

  Scenario: Assessing and flagging a divergence from a synchronization promise
    Given "Twin-C"'s last reported pressure is 100 (this is H, the Twin's asserted state)
    And "Twin-C"'s validated physical model predicts pressure should be 104 (this contributes to T, the expected ground truth)
    When new telemetry arrives reporting physical pressure as 110 (this updates T, the ground truth)
    Then the "Divergence Detection Agent" should calculate the divergence between reported/predicted state H and ground truth T for "pressure" (e.g., (110-104)/104 ≈ 5.8%)
    And since the calculated divergence of 5.8% exceeds the 5% threshold
    The "Divergence Detection Agent" should assess "Twin-C"'s "Synchronization Fidelity for Pressure Promise" as "AT_RISK" or "PARTIALLY_BROKEN"
    And record verifiable evidence including the calculated divergence, H, and T
    And emit a "DivergenceAlertEvent" for "Twin-C" based on this assessment

  Scenario: Confirming synchronization promise is kept (no alert within threshold)
    Given "Twin-C" is promising "Synchronization Fidelity for Vibration" with a 10% threshold
    And "Twin-C"'s model predicts vibration at 0.50 (contributes to T)
    When telemetry arrives reporting physical vibration at 0.52 (updates T), and twin reports 0.52 (this is H)
    Then the "Divergence Detection Agent" should calculate divergence (e.g., 4%)
    And assess "Twin-C"'s "Synchronization Fidelity for Vibration Promise" as "KEPT" for this interval
    And no "DivergenceAlertEvent" should be emitted

  Scenario: Upholding alert suppression window promise
    Given a "DivergenceAlertEvent" was emitted by the "Divergence Detection Agent" for "Twin-C" (pressure) less than 5 minutes ago
    And the "Divergence Detection Agent" promises "Alert Suppression for 5 Minutes Post-Alert"
    When another divergence for "Twin-C" (pressure) exceeding its threshold occurs
    Then the "Divergence Detection Agent" should fulfill its suppression promise by not emitting a new alert
    And log the suppressed event as evidence of upholding the suppression promise