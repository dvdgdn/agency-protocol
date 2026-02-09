Feature: Promise Evidence Requirements
  Different types of promises require different levels of evidence verification
  Evidence requirements affect credit stakes and merit calculations
  Some promises can be automatically verified while others need human validation

  Background:
    Given the system supports multiple evidence types
    And agents can be validators in specific domains
    And evidence can be automatically or manually verified
    And batch processing handles assessments

  Scenario: Automatic Evidence Verification
    Given a restaurant makes promise P:
      | Field          | Value                                |
      | Intention      | "Delivery within 45 minutes"         |
      | Evidence       | "automated_timestamps"               |
      | Domain         | "food/delivery/speed"                |
      | Verification   | "automatic"                          |
    When an order is delivered
    Then system automatically records:
      | Data           | Source                              |
      | Order time     | System timestamp                    |
      | Delivery time  | Delivery app GPS timestamp          |
      | Duration       | Calculated difference               |
    And creates an assessment based on timestamps
    And affects merit in "food/delivery/speed"

  Scenario: Required Evidence with Validation
    Given a restaurant makes promise P:
      | Field          | Value                                |
      | Intention      | "Fresh ingredients delivered daily"  |
      | Evidence       | "supplier_receipts,daily_photos"     |
      | Domain         | "food/ingredients/freshness"         |
      | Verification   | "validator_group"                    |
    When they submit daily evidence:
      | Type           | Content                             |
      | Receipt        | Supplier delivery document          |
      | Photos         | Ingredient freshness photos         |
      | Timestamp      | Evidence submission time            |
    Then validator group must:
      | Action         | Requirement                         |
      | Review         | At least 3 validators               |
      | Merit          | >85 in ingredients verification     |
      | Timeframe      | Within 24 hours                     |
    And affects restaurant's merit in "food/ingredients/freshness"

  Scenario: Experience-Based Assessment
    Given a restaurant makes promise P:
      | Field          | Value                                |
      | Intention      | "Authentic Italian taste"            |
      | Evidence       | "customer_experience"                |
      | Domain         | "food/cuisine/italian"               |
      | Verification   | "customer_assessment"                |
    When customers submit assessments
    Then no formal evidence is required
    But assessments are weighted by:
      | Factor         | Weight                              |
      | Assessor merit | In cuisine assessment               |
      | Past accuracy  | Of assessor's judgments             |
      | Assessment age | Recent counts more                  |

  Scenario: Mixed Evidence Requirements
    Given a medical practitioner makes promise P:
      | Field          | Value                                |
      | Intention      | "Same day test results"              |
      | Evidence       | "automated,documented"               |
      | Domain         | "healthcare/labs/turnaround"         |
    When they process test results
    Then system checks:
      | Type           | Verification                         |
      | Test time      | Automated timestamp                  |
      | Result time    | System timestamp                     |
      | Documentation  | Lab report existence                 |
    And requires validator confirmation for outliers
    
  Scenario: Progressive Evidence Requirements
    Given an agent's merit is below 80 in domain D
    When they make a promise P in domain D
    Then they must provide additional evidence:
      | Merit Range    | Extra Requirements                   |
      | Below 60      | Independent verification             |
      | 60-80         | Extra documentation                  |
      | Above 80      | Standard evidence                    |

  Scenario: Evidence Quality Affects Merit
    Given agent A submits evidence E for promise P
    When validators assess evidence quality:
      | Aspect         | Rating                              |
      | Completeness   | 1-5 scale                          |
      | Timeliness     | 1-5 scale                          |
      | Verifiability  | 1-5 scale                          |
    Then merit change is affected by:
      | Quality        | Merit Impact                        |
      | High (4-5)     | Full positive change                |
      | Medium (3)     | Reduced positive change             |
      | Low (1-2)      | No change or negative               |

  Scenario: Validator Group Formation
    Given domain D requires validated evidence
    When forming validator group:
      | Requirement    | Value                               |
      | Min size      | 3 validators                        |
      | Merit threshold| 85 in domain                        |
      | Stake required| Based on promise impact             |
    Then each validator must:
      | Action         | Requirement                         |
      | Stake credit   | Proportional to promise value      |
      | Prove merit    | In relevant domain                 |
      | Commit time    | To validation window               |

  Scenario: Evidence Batch Processing
    Given multiple evidence submissions for domain D
    When batch window closes
    Then system processes evidence:
      | Step           | Action                              |
      | Collection     | Group by evidence type              |
      | Validation     | Route to appropriate verifiers      |
      | Assessment     | Calculate consensus results         |
      | Merit Update   | Apply changes based on evidence     |

  Scenario: Evidence Storage and Access
    Given evidence E is submitted for promise P
    When storing evidence:
      | Type           | Storage                             |
      | Public         | Available to all                    |
      | Private        | Encrypted for validators            |
      | Sensitive      | Special access controls             |
    Then access is controlled by:
      | Role           | Access Level                        |
      | Public        | Public evidence only                |
      | Validators    | Based on domain merit              |
      | Admins        | Based on sensitivity               |

@phase1 @evidence
Feature: Evidence artifacts are content-addressed and pointer-grounded

  Background:
    Given an Evidence Store exists
    And evidence artifacts are stored by SHA-256 hash

  @phase1 @evidence @submit
  Scenario: Submit an evidence artifact and reference it from a PromiseCard
    Given PromiseCard "P1" requires evidence type "message_timestamp_log"
    When "Agent A" submits an evidence artifact "E1" with hash "H1"
    Then "E1" is retrievable by "H1"
    And "Agent A" can append an EvidenceReference to "P1" containing:
      | evidence_id | pointer   | span_start | span_end |
      | H1          | $.items[0] | 0          | 128      |

  @phase2 @entailment @deterministic
  Scenario: Deterministic entailment for a structured evidence rule
    Given an entailment rule "message_within_24h" exists
    And evidence artifact "E1" contains a response timestamp "T_response"
    And the PromiseCard deadline timestamp is "T_deadline"
    When entailment is computed for "message_within_24h"
    Then the entailment result is ENTAILS if T_response <= T_deadline
    And CONTRADICTS if T_response > T_deadline
