@phase1 @forks
Feature: Fork detection and deterministic routing

  Background:
    Given a Forwarder service exists
    And the Forwarder uses a deterministic tie-break rule "lowest_content_address_wins"

  @phase1 @detect
  Scenario: Detect a fork when two states reference the same previous
    Given agent "Agent A" has state "S1"
    When state "S2" is published referencing "S1"
    And state "S3" is published referencing "S1"
    Then the system records a fork at "S1"
    And emits anomaly "FORK_DETECTED" linking "S2" and "S3"

  @phase1 @route
  Scenario: Forwarder routes deterministically during a fork
    Given a fork exists between "S2" and "S3"
    When a requestor resolves "Agent A"
    Then the Forwarder returns the tie-break winner
    And includes "fork_present=true" with competing heads

  @phase2 @repair
  Scenario: Repair a fork by publishing a new head that supersedes a competing branch
    Given a fork exists between "S2" and "S3"
    When "Agent A" publishes state "S4" referencing "S2"
    And "S4" declares it supersedes "S3"
    Then the Forwarder sets head to "S4"
    And the fork is marked resolved
