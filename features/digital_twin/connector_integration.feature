# features/ap_connector_integration.feature
Feature: Agency Protocol Connector Agent Integration
  In order to ingest from diverse systems out-of-the-box
  As a Data Engineer
  I want Connector Agents for MQTT, OPC-UA, REST, SNMP, and JDBC

  Background:
    Given Connector Agents are available for protocols: MQTT, OPC-UA, REST, SNMP, JDBC

  Scenario Outline: Ingest from <connector> source
    Given a <connector> Connector Agent promising “Protocol-Specific Data Mapping” for Twin “CX-200”
    And that agent has configuration:
      | sourceEndpoint     | config                                  |
      | "<endpoint>"       | <configParams>                          |
    When the <connector> Connector Agent connects and pulls a sample payload
    Then it should fulfill its “Promise to Map Data to Twin” for “CX-200”
    And emit a ConnectorIngestedEvent with connector="<connector>"

    Examples:
      | connector | endpoint                | configParams                                                 |
      | MQTT      | mqtt://broker/topic     | { qos:1, clientId: "cn-mqtt" }                               |
      | OPC-UA    | opc.tcp://server:4840   | { nodeId: "PressureSensor/1" }                               |
      | REST      | https://api.example/v1  | { method: GET, authToken: "abc" }                            |
      | SNMP      | udp://10.0.0.1:161      | { community: "public", oid: "1.3.6.1.4.1.XXX" }               |
      | JDBC      | jdbc:postgresql://db:5432 | { user: "app", password: "***", query: "SELECT * FROM sens" } |
