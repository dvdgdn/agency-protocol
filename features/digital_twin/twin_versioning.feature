Feature: Agency Protocol Enhanced Digital Twin Versioning, Rollback & Verifiable Audit Trail
  In order to maintain a clear, immutable history of Digital Twin Agent model changes with AP guarantees
  As a System Auditor, relying on the "Digital Twin Registry Agent"
  I want immutable versioning with clear accountability, trustworthy rollbacks, and complete audit logs.

  Background:
    Given an active "Digital Twin Registry Agent" promising "Version Control Integrity" and "Audit Trail Completeness"
    And a "Digital Twin Agent" named "Twin-E" exists with versions V1, V2 (each a content-addressed state) recorded by the Registry Agent

  Scenario: Retrieving a verifiable version history
    When I request the version history for "Twin-E" from the "Digital Twin Registry Agent"
    Then the "Digital Twin Registry Agent" should fulfill its "Promise to Provide Accurate Version List" [V1, V2]
    And each entry in the list must be verifiable (timestamp, author agent ID, content-addressed change summary)

  Scenario: Executing a trustworthy rollback to a prior version
    Given "Twin-E" is currently at version V2 (content hash H_V2)
    When I request the "Digital Twin Registry Agent" to rollback "Twin-E" to version V1 (content hash H_V1)
    Then the "Digital Twin Registry Agent" should fulfill its "Promise to Set Active Version" for "Twin-E" to V1 (H_V1)
    And the "Digital Twin Registry Agent" should fulfill its "Promise to Emit TwinRolledBackEvent" referencing V2 and V1 as evidence

  Scenario: Upholding integrity by preventing rollback if dependent snapshots exist
    Given a "Snapshot Agent" has recorded "Snapshot-E-2" which provably references "Twin-E" version V2 (H_V2)
    And the "Digital Twin Registry Agent" promises "Dependency-Aware Rollback Prevention"
    When I request the "Digital Twin Registry Agent" to rollback "Twin-E" to V1
    Then the "Digital Twin Registry Agent" should fulfill its promise by rejecting the operation
    And return verifiable evidence of the rejection, citing "Snapshot-E-2" dependency on version V2