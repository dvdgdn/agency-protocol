Feature: Healthcare Provider Trust Network
  As a healthcare community
  We want to establish decentralized trust through vouching and assessments
  So that quality of care can be verified without central authority

  Background:
    Given a decentralized network of healthcare providers exists
    And providers can vouch for and assess each other
    And all vouches and assessments are cryptographically signed
    And merit accumulates through vouching chains and kept promises

  Scenario: Established Physician Vouches for New Provider
    Given Dr. Chen has accumulated merit in "internal_medicine" domain
    And Dr. Rodriguez is a new provider joining the network
    And Dr. Chen has directly supervised Dr. Rodriguez during residency
    When Dr. Chen vouches for Dr. Rodriguez
    Then a signed vouching statement is created containing:
      | Field           | Value                                         |
      | Voucher        | Dr. Chen's address                           |
      | Vouched For    | Dr. Rodriguez's address                      |
      | Domain         | internal_medicine                            |
      | Basis          | "Direct supervision during residency"        |
      | Stake          | 20% of Dr. Chen's domain merit              |
    And Dr. Rodriguez gains initial merit proportional to Dr. Chen's stake
    And Dr. Chen's merit is now partially dependent on Dr. Rodriguez's performance

  Scenario: Teaching Hospital Trust Network Formation
    Given University Hospital has multiple established attending physicians
    When they form a teaching hospital trust network
    Then each attending physician can vouch for:
      | Vouchee Type     | Vouching Requirements                         |
      | Residents       | Direct supervision for >6 months              |
      | Fellows         | Collaboration on >10 cases                    |
      | New Attendings  | Joint practice for >3 months                 |
    And each vouch must include:
      | Component       | Requirement                                   |
      | Evidence       | Documented collaboration history              |
      | Stake          | Minimum 15% of voucher's domain merit        |
      | Scope          | Specific clinical domains                     |

  Scenario: Multi-Domain Healthcare Vouching
    Given Dr. Lee is a cardiologist with high merit in multiple domains
    When Dr. Lee vouches for Dr. Park
    Then separate vouching statements are created for each domain:
      | Domain                  | Required Evidence                            |
      | cardiology             | Direct case collaboration                    |
      | medical_research       | Joint published papers                       |
      | patient_care          | Observed patient interactions                |
    And Dr. Lee's stake is domain-specific:
      | Domain                  | Stake Percentage                            |
      | cardiology             | 25% of domain merit                         |
      | medical_research       | 15% of domain merit                         |
      | patient_care          | 20% of domain merit                         |

  Scenario: Vouching Chain Impact on Patient Care
    Given Dr. Adams vouched for Dr. Baker in "surgical_care"
    And Dr. Baker vouched for Dr. Clark in "surgical_care"
    When Dr. Clark's surgical outcomes are assessed as poor
    Then the merit impact propagates through the chain:
      | Provider        | Merit Impact                                  |
      | Dr. Clark      | Direct negative impact                        |
      | Dr. Baker      | 20% of Clark's negative impact               |
      | Dr. Adams      | 5% of Clark's negative impact                |
    And future vouching requirements increase for all involved

  Scenario: Emergency Department Merit Network
    Given an ED requires 24/7 coverage by verified providers
    When establishing the ED trust network
    Then each attending physician must:
      | Requirement            | Specification                               |
      | Initial Vouching      | At least 2 existing ED attendings          |
      | Cross-Coverage       | Vouching from multiple shifts              |
      | Specialty Coverage    | Relevant specialty domain vouches         |
    And emergency response merit is tracked separately:
      | Metric Type           | Assessment Method                           |
      | Response Times       | Peer assessment of critical cases           |
      | Protocol Adherence   | Review of emergency interventions          |
      | Team Coordination    | Multi-provider assessments                 |

  Scenario: Specialty Certification Through Vouching
    Given Dr. Wilson seeks recognition in "advanced_cardiology"
    Then they must obtain vouches from:
      | Voucher Type          | Minimum Requirements                        |
      | Domain Experts       | 3 high-merit cardiologists                 |
      | Case Experience      | 50 documented complex cases                |
      | Research Impact      | 2 research-active vouchers                 |
    And each vouch must stake:
      | Component            | Requirement                                 |
      | Merit Stake         | >25% of voucher's cardiology merit         |
      | Duration            | Minimum 1 year commitment                   |
      | Assessment Duty     | Regular case review obligation             |

  Scenario: Patient Outcome Assessment Chain
    Given Dr. Johnson has vouched for Dr. Thompson
    And Dr. Thompson treats patient P with condition C
    When the treatment outcome is assessed
    Then the assessment affects merit across the chain:
      | Actor               | Merit Impact                                 |
      | Dr. Thompson       | Direct impact based on outcome              |
      | Dr. Johnson        | Proportional impact through vouch           |
      | Other Vouchers     | Diminishing impact through chain            |
    And successful outcomes strengthen the vouching relationship

  Scenario: Cross-Institutional Vouching Network
    Given hospitals H1 and H2 want to establish cross-privileges
    When creating cross-institutional vouches
    Then each vouch requires:
      | Component            | Requirement                                 |
      | Institution Merit   | Both hospitals maintain high merit          |
      | Provider Vouches    | Multiple existing staff vouches            |
      | Domain Coverage     | Specific department/specialty focus        |
      | Quality Metrics     | Shared outcome measurement                 |
    And merit flows between institutions through provider networks

  Scenario: Handling Broken Trust Chains
    Given Dr. Young vouched for Dr. Zhang
    And Dr. Zhang is found to have falsified records
    When this breach is verified by multiple assessors
    Then the following actions occur:
      | Action              | Effect                                      |
      | Merit Impact       | Severe reduction in Zhang's merit           |
      | Vouch Invalidation | Young's vouch is marked as compromised     |
      | Chain Review       | All Zhang's vouches are re-evaluated       |
      | Future Vouching    | Increased requirements for all parties     |



      Scenario: Surgical Procedure Verification 
  Given a surgeon makes promise P:
    | Field     | Value                               |
    | Intention | "Perform laparoscopic appendectomy" |
    | Domain    | "surgery/laparoscopic/appendix"     |
    
  Then evidence requirements based on merit:
    | Merit Range | Required Evidence                             |
    | Below 60    | - Direct supervision by high-merit surgeon   |
                  | - Video recording of procedure               |
                  | - Detailed operative notes                   |
                  | - Patient outcome documentation             |
                  | - Follow-up care records                    |
    
    | 60-80       | - Peer review of operative notes            |
                  | - Photo documentation of key steps          |
                  | - Patient outcome documentation             |
                  | - Follow-up care records                    |
    
    | Above 80    | - Standard operative notes                  |
                  | - Patient outcome documentation             |      
