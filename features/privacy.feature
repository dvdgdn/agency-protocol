Feature: Data Management and Privacy

  Agents can manage access to their data, ensuring privacy and control within the decentralized system.
  The Agency Protocol allows agents to include data in their promises and agent states, with mechanisms for secure sharing.

  Background:
    Given agents can include data references in their promises and agent states
    And data can be encrypted and shared securely between agents
    And agents can define access control policies for their data

  Scenario: Agent Controls Access to Personal Data
    Given "Agent A" has data "Data X" encrypted and stored at a known location
    And "Agent A" wants to share "Data X" with "Agent B"
    When "Agent A" encrypts "Data X" with "Agent B"'s public key
    And provides the encrypted data reference in a promise to "Agent B"
    Then "Agent B" can access and decrypt "Data X" using their private key
    And other agents cannot access "Data X" without authorization

  Scenario: Agent Revokes Access to Data
    Given "Agent A" has previously shared "Data Y" with "Agent B"
    When "Agent A" decides to revoke "Agent B"'s access to "Data Y"
    Then "Agent A" updates their agent state, indicating that "Data Y" is no longer shared
    And communicates the revocation to "Agent B"
    And "Agent B" is expected to comply with the revocation as per the protocol's rules

  Scenario: Secure Data Sharing Agreements
    Given "Agent C" wants to share data under specific conditions
    When "Agent C" creates a promise "Promise D" outlining the data sharing terms
    And "Agent D" accepts the promise by acknowledging it in their agent state
    Then "Agent C" shares the data securely with "Agent D"
    And both agents have a recorded agreement in their respective agent states

  Scenario: Confidential Data Transmission
    Given "Agent E" needs to send sensitive data to "Agent F"
    When "Agent E" encrypts the data with "Agent F"'s public key
    And includes the encrypted data in a promise or message
    Then only "Agent F" can decrypt and access the data
    And data confidentiality is maintained

  Scenario: Agent Requests Data Deletion
    Given "Agent G" has shared data with "Agent H"
    When "Agent G" requests that "Agent H" deletes the shared data
    Then "Agent H" acknowledges the request and updates their agent state accordingly
    And "Agent G" records the request and "Agent H"'s acknowledgment

  Scenario: Agents Define Data Usage Policies in Promises
    Given "Agent I" includes specific data usage policies in their promise when sharing data
    When "Agent J" accepts the promise and accesses the data
    Then "Agent J" is expected to adhere to the data usage policies as per the agreement
    And any violations can be assessed and recorded by "Agent I"

  Scenario: Transparency in Data Sharing Agreements
    Given all data sharing promises and acknowledgments are recorded in the agents' states
    When agents review their interactions
    Then they have a clear record of data shared, promises made, and agreements established
    And transparency is maintained throughout the system

  Scenario: Agent Updates Shared Data
    Given "Agent K" has shared "Data Z" with "Agent L"
    When "Agent K" updates "Data Z" to a new version "Data Z1"
    And informs "Agent L" of the update through a new promise
    Then "Agent L" can access "Data Z1" as per the updated agreement
    And the change is recorded in both agents' states

  Scenario: Secure Data References in Promises
    Given "Agent M" wants to reference external data in a promise
    When "Agent M" includes a secure hash or content address of the data in the promise
    Then other agents can verify the integrity of the data when accessing it
    And ensure that the data has not been tampered with

  Scenario: Agents Handling Data Retention Policies
    Given "Agent N" shares data with "Agent O" with a retention policy of 30 days
    When 30 days have passed
    Then "Agent O" is expected to delete the data as per the agreement
    And "Agent N" can verify compliance through assessments or requests

  Scenario: Agent Compliance with Data Sharing Agreements
    Given "Agent P" has agreed to specific terms when accessing data from "Agent Q"
    When "Agent P" uses the data in accordance with the terms
    Then the data sharing relationship remains in good standing
    And both agents maintain trust within the system

  Scenario: Agent Encrypts Data with Symmetric Key Shared Securely
    Given "Agent R" wants to share large data efficiently with "Agent S"
    When "Agent R" encrypts the data using a symmetric key
    And securely shares the symmetric key encrypted with "Agent S"'s public key
    Then "Agent S" can decrypt the symmetric key and then the data
    And data sharing is performed securely and efficiently

  Scenario: Preventing Unauthorized Data Access Attempts
    Given "Agent T" has data protected by access controls
    When "Malicious Agent" attempts to access "Agent T"'s data without permission
    Then the system logs the unauthorized access attempt
    And "Malicious Agent" is denied access to the data
