# features/ap_analytics.feature
Feature: Agency Protocol Built-in Analytics Agents
  In order to deliver first-class insights without external tools
  As a Platform Operator
  I want Analytics Agents for anomaly detection, trend-forecasting and predictive maintenance

  Background:
    Given an Anomaly Detection Agent promising “Real-Time Outlier Identification”
    And a Trend Analysis Agent promising “Historical Trend Forecasting”
    And a Predictive Maintenance Agent promising “Failure Prediction”

  Scenario: Detecting a temperature spike anomaly
    Given Twin “AN-300” reports temperature series: [70,71,72, 90,73] over 5 points
    When the Anomaly Detection Agent runs
    Then it should flag 90 as an anomaly
    And emit an AnomalyDetectedEvent with detectedValue=90 and timestamp

  Scenario: Generating a 24h trend forecast
    Given Twin “TR-400” has 30 days of throughput history
    When the Trend Analysis Agent runs a 24-hour forecast
    Then it should produce an array of 24 predicted values
    And emit a TrendForecastEvent containing the forecast

  Scenario Outline: Predicting next failure window
    Given Twin “PM-<id>” has recent vibration data trending upward
    And the Predictive Maintenance Agent promises “MTBF prediction within ±10%”
    When I request a failure prediction over horizon "<horizon_days>" days
    Then the agent should deliver a predicted failure window in days
    And emit a PredictiveMaintenanceEvent with predictedWindow and confidence

    Examples:
      | id | horizon_days |
      | 500 | 7            |
      | 501 | 30           |
