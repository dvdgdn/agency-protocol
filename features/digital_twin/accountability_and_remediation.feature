Feature: Agency Protocol Driven Accountability and Remediation for Digital Twins
  In order to ensure Digital Twin Agents maintain their promised performance and address failures
  As a System Operator or affected Stakeholder
  I want to see consequences for broken promises and trigger verifiable remediation actions.

  Background:
    Given "Digital Twin Agent" named "Critical-Turbine-Twin" is active
    And "Critical-Turbine-Twin" promises "Vibration Synchronization Fidelity < 2% Divergence" with a significant stake
    And "Critical-Turbine-Twin" also promises "Automated Recalibration if Merit in 'Vibration Sync' drops below 0.7"
    And a "Divergence Detection Agent" assesses "Critical-Turbine-Twin"'s vibration sync promise
    And an "AP Ledger Agent" records stakes, merit changes, and promise outcomes

  Scenario: Merit degradation and stake impact from repeated promise failures
    Given "Critical-Turbine-Twin"'s merit in "Vibration Sync" is initially 0.9
    And its current stake on the "Vibration Synchronization Fidelity Promise" is 1000 credits
    When the "Divergence Detection Agent" assesses the "Vibration Synchronization Fidelity Promise" as "BROKEN" three times consecutively due to divergence > 2%
    Then "Critical-Turbine-Twin"'s merit in "Vibration Sync" should decrease significantly (e.g., below 0.7) as recorded by the "AP Ledger Agent"
    And "Critical-Turbine-Twin" should forfeit a portion of its staked 1000 credits for each broken promise assessment, recorded by the "AP Ledger Agent"
    And evidence of these assessments and consequences should be verifiable

  Scenario: Triggering an automated remediation promise based on low merit
    Given "Critical-Turbine-Twin"'s merit in "Vibration Sync" has dropped to 0.65 (below the 0.7 threshold for its remediation promise)
    When the system processes this merit update
    Then "Critical-Turbine-Twin" should be assessed on its "Automated Recalibration Promise"
    And "Critical-Turbine-Twin" should initiate its promised "Automated Recalibration Sequence"
    And emit a "RecalibrationInitiatedEvent" as evidence of fulfilling this secondary promise

  Scenario: Assessing failure of a remediation promise
    Given "Critical-Turbine-Twin" initiated its "Automated Recalibration Sequence"
    And it promised "Recalibration Completes Successfully within 1 hour restoring Sync Fidelity"
    When 1 hour elapses and the "Divergence Detection Agent" continues to assess "Vibration Synchronization Fidelity Promise" as "BROKEN"
    Then an "AP Assessor Agent" should assess "Critical-Turbine-Twin"'s "Recalibration Completes Successfully Promise" as "BROKEN"
    And "Critical-Turbine-Twin" should incur further stake loss and merit reduction for this critical failure
    And a "CriticalSystemAlert" should be escalated to human operators