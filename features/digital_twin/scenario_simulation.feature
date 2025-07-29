Feature: Agency Protocol Governed Scenario Simulation and Model Validation for Digital Twins
  In order to reliably test hypothetical conditions and validate twin model fidelity using AP
  As an Engineer, interacting with a "Simulation Agent"
  I want to inject scenario parameters, run simulations, and assess the simulation model's predictive promises.

  Background:
    Given a "Digital Twin Agent" named "Twin-D"
    And an associated "Simulation Agent for Twin-D" promising "Accurate Simulation Execution" and "Predictive Fidelity" in specific simulation domains
    And the "Simulation Agent for Twin-D" has staked credits on its predictive fidelity promises

  Scenario: Executing a "what-if" scenario with verifiable outcomes
    Given a simulation scenario S1 with parameters { load: 120, speed: 3000 }
    When I request the "Simulation Agent for Twin-D" to execute S1
    Then the "Simulation Agent for Twin-D" should fulfill its "Promise to Run Simulation S1 to Completion"
    And fulfill its "Promise to Produce Results for S1" including metrics { temperature, vibration, throughput }
    And fulfill its "Promise to Store S1 Results Verifiably" under scenario ID "S1-Twin-D"

  Scenario Outline: Assessing the "Predictive Fidelity Promise" of the Simulation Agent via batch runs
    Given the "Simulation Agent for Twin-D" promises that for scenario type "<scenario_type>", the metric "<metric>" will be within range "<expected_range>"
    And a specific test scenario "<scenario_name>" of type "<scenario_type>" with parameter set <params>
    When I request the "Simulation Agent for Twin-D" to run "<scenario_name>"
    Then the simulation results for "<metric>" should be produced
    And an "AP Assessor Agent" should assess if the "<metric>" result is within the promised "<expected_range>"
    And this assessment contributes to the "Simulation Agent for Twin-D"'s merit in domain "simulation/predictive_fidelity/<scenario_type>/<metric>"

    Examples:
      | scenario_name | scenario_type | params                                | metric      | expected_range |
      | SO-Test1      | Overload      | { load: 200, ambient_temp: 25 }       | temperature | [80, 120]      |
      | SI-Test2      | Idle          | { load: 0, speed: 500, ambient_temp: 20 } | throughput  | [0, 10]        |
      | SP-Test3      | Peak          | { load: 150, speed: 4000, ambient_temp: 30 } | vibration   | [0.1, 0.5]     |