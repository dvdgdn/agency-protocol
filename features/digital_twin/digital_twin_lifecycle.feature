Feature: Agency Protocol Enhanced Digital Twin Lifecycle Management
  In order to reliably model and manage physical assets using Agency Protocol
  As a Platform Operator, relying on accountable agents
  I want to register, update, snapshot, and retire digital twins with verifiable commitments.

  Background:
    Given the "Digital Twin Registry Agent" is active and stakes on its operational promises
    And the "Digital Twin Platform Agent" promises to emit domain-specific events
    And each physical asset has a unique external identifier

  Scenario: Registering a new Digital Twin Agent
    Given a physical asset with external ID "Asset-12345"
    When I request the "Digital Twin Registry Agent" to create a digital twin for "Asset-12345"
    Then the "Digital Twin Registry Agent" should fulfill its "Promise to Assign Unique Twin ID"
    And a new "Digital Twin Agent" with a unique ID should exist
    And the "Digital Twin Agent" should fulfill its "Promise to Initialize in ACTIVE State"
    And the "Digital Twin Platform Agent" should emit a "TwinRegisteredEvent" containing the new twin ID and its "ACTIVE" status as evidence

  Scenario: Updating a Digital Twin Agent’s attested metadata
    Given an active "Digital Twin Agent" named "Twin-A" with metadata version 1
    When I request "Twin-A" to update its metadata to "{ 'location': 'Plant-7', 'model': 'X100' }"
    Then "Twin-A" should fulfill its "Promise to Increment Metadata Version" to 2
    And "Twin-A" should fulfill its "Promise to Make New Metadata Retrievable" showing "{ 'location': 'Plant-7', 'model': 'X100' }"
    And the "Digital Twin Platform Agent" should emit a "TwinMetadataUpdatedEvent" for "Twin-A" with version 2 as evidence

  Scenario: Snapshotting a Digital Twin Agent's state with verifiable integrity
    Given an active "Digital Twin Agent" named "Twin-A"
    When I request the "Snapshot Service Agent" to snapshot "Twin-A" at timestamp "2025-05-21T10:00:00Z"
    Then the "Snapshot Service Agent" should fulfill its "Promise to Create Verifiable Snapshot" named "Snapshot-A-1"
    And "Snapshot-A-1" should reference "Twin-A" and its last known state at the specified timestamp
    And the content hash of "Snapshot-A-1" should be verifiable

  Scenario: Retiring a Digital Twin Agent and its commitments
    Given an active "Digital Twin Agent" named "Twin-A"
    When I request the "Digital Twin Registry Agent" to retire "Twin-A"
    Then "Twin-A" should fulfill its "Promise to Transition to RETIRED State"
    And "Twin-A" should uphold its "Promise to Cease Data Ingestion and Sync when RETIRED"
    And the "Digital Twin Platform Agent" should emit a "TwinRetiredEvent" for "Twin-A" as evidence