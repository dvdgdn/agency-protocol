Feature: Agency Protocol Governed Data Ingestion, Mapping & Transformation Pipelines with Accountability
  In order to ensure reliable and accurate data feeding for Digital Twin Agents through accountable processes
  As a Data Engineer, relying on a "Data Ingestion Agent"
  I want declarative mappings, verifiable schema validation, and trustworthy transformations.

  Background:
    Given an active "Digital Twin Agent" named "Twin-G" which expects data schema S:
      | field         | type    | required |
      | --            | --      | --       |
      | timestamp     | datetime| true     |
      | temperature   | number  | true     |
      | pressure      | number  | true     |
    And an active "Data Ingestion Agent" for "Twin-G", promising "Schema Compliant Data Delivery" and "Accurate Transformation Logic"
    And the "Data Ingestion Agent" has staked credits on these promises

  Scenario: Verifying incoming payload against Digital Twin Agent's promised schema
    Given the "Data Ingestion Agent" promises to validate payloads against schema S for "Twin-G"
    When data { timestamp: "bad-date", temperature: 70, pressure: 30 } arrives for "Twin-G"
    Then the "Data Ingestion Agent" should fulfill its validation promise by identifying the schema violation
    And record "Invalid timestamp format" as evidence of the failed validation and rejection of the payload
    And this event can be used to assess the data source's "Data Quality Promise", if one exists

  Scenario: Ensuring accurate field mapping as per Data Ingestion Agent's promise
    Given a source payload { rider_id: "RiderX", loc: [40.7,-74.0], ts: PT, vehicle_temp: 72, tire_psi: 31 }
    And the "Data Ingestion Agent" for "Twin-G" promises "Field Mapping" using config { ts → timestamp, vehicle_temp → temperature, tire_psi → pressure }
    When the "Data Ingestion Agent" processes the payload
    Then it should fulfill its "Field Mapping Promise" by transforming the data correctly
    And "Twin-G" should receive { timestamp: PT, temperature: 72, pressure: 31 } as verifiable evidence

  Scenario: Applying and verifying data enrichment transformation as per Data Ingestion Agent's promise
    Given an incoming payload for "Twin-G": { timestamp: PT, temperature: 80, pressure: 32 }
    And the "Data Ingestion Agent" promises "Data Enrichment Transformation" using rule: add metric "density_kg_m3" = pressure_Pa / (287.058 * (temperature_C + 273.15))
      | Note: Assuming pressure is in Pa and temperature in Celsius for a realistic density calculation.
      | This makes the transformation promise more specific and testable.
    When the "Data Ingestion Agent" ingests and transforms the data
    Then it should fulfill its "Data Enrichment Transformation Promise"
    And "Twin-G"'s record should include the accurately calculated "density_kg_m3" metric as verifiable evidence