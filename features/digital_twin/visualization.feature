# features/ap_visualization.feature
Feature: Agency Protocol Real-Time Visualization Agent
  In order to deliver snappy dashboards
  As an Operator
  I want a Visualization Agent that guarantees >30 fps rendering of twin-state UIs

  Background:
    Given a Visualization Agent promising “Real-Time Dashboard Performance”

  Scenario: Rendering live telemetry dashboard
    Given Twin “VZ-100” emits state updates at 20 Hz
    When the Visualization Agent subscribes and draws the live chart
    Then it should maintain ≥30 fps rendering for a 60 second period
    And emit a RenderPerformanceEvent with measuredFps≥30

  Scenario: Dynamic binding of custom widgets
    Given a user configures a new KPI widget for “drift-rate”
    When the Visualization Agent applies the widget configuration
    Then it should fulfill its “Promise to Load Custom Widget” without reload
    And the new widget should appear on the dashboard within 500 ms
