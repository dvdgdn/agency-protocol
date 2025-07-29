Feature: Research Funding Transparency and Accountability
  As a scientific community
  We want to ensure research funding is transparent and merit-based
  So that valuable research isn't blocked by profit motives

  Background:
    Given the Agency Protocol is implemented for scientific research
    And researchers can make promises about their work
    And funding sources are tracked as agents
    And all assessments are publicly recorded

  Scenario: Independent Researcher Proposing Novel Theory
    Given a researcher "Dr. Smith" has a novel theory about quantum mechanics
    And "Dr. Smith" has accumulated merit in quantum physics research
    And "Dr. Smith" makes the following promises about their research:
      | Promise Type      | Promise Content                                    |
      | Methodology      | Will use rigorous mathematical proofs              |
      | Reproducibility  | Will provide complete mathematical derivations     |
      | Transparency     | Will publish all assumptions and limitations       |
    When "Dr. Smith" submits the research proposal to the community
    Then all qualified researchers can assess the proposal based on merit
    And funding decisions are based on promise quality and past merit
    And the assessment process is publicly visible
    And funding sources must declare any conflicts of interest

  Scenario: Corporate-Funded Research Transparency
    Given a pharmaceutical company funds research on a new drug
    When they create a research funding agent
    Then they must make explicit promises including:
      | Promise Type           | Promise Content                                 |
      | Data Transparency     | All trial data will be publicly available      |
      | Methodology Freedom   | Researchers can publish negative results        |
      | Conflict Declaration  | All financial interests will be disclosed       |
    And these promises are assessed by independent researchers
    And breaking these promises reduces corporate merit score
    And affects future research funding opportunities

Feature: Evidence Assessment Without Paradigm Bias
  As a scientific community
  We want to fairly evaluate evidence regardless of current paradigms
  So that valid new ideas aren't dismissed without proper consideration

  Scenario: Evaluating Unconventional Research
    Given a researcher proposes an unconventional theory
    And they provide detailed evidence and methodology
    When they submit their work to the AP system
    Then their submission is assessed based on:
      | Assessment Criteria        | Weight |
      | Methodological Rigor      | High   |
      | Quality of Evidence       | High   |
      | Logical Consistency       | High   |
      | Paradigm Conformity       | Low    |
    And assessors must justify their evaluations
    And their assessment merit affects their influence
    And multiple perspectives are considered

  Scenario: Challenging Established Theory
    Given an established theory has high merit in the system
    When new contradictory evidence is presented
    Then the evidence is evaluated independently of the established theory
    And assessment weight is based on:
      | Factor                    | Consideration                              |
      | Methodological Merit      | Quality of research methods               |
      | Evidence Strength        | Robustness of data and analysis           |
      | Reproducibility          | Ability for others to verify              |
    And the established theory's merit may be adjusted based on new evidence
    And the community is notified of significant merit changes

Feature: Quality Control Through Merit-Based Assessment
  As a scientific community
  We want to ensure research quality through accountability
  So that poor quality work doesn't contaminate the scientific record

  Scenario: Poor Quality Research Detection
    Given a researcher submits a paper with methodological flaws
    When expert reviewers assess the paper
    Then they can flag specific broken promises such as:
      | Promise Type           | Broken Promise Detail                        |
      | Methodology           | Statistical analysis is incorrect            |
      | Data Quality          | Raw data contains inconsistencies           |
      | Reproducibility       | Methods section is incomplete               |
    And their assessments affect the paper's merit score
    And the author's merit in relevant domains
    And other researchers are warned about potential issues

  Scenario: Research Quality Improvement
    Given a researcher receives negative assessments
    When they address the identified issues
    Then they can submit an improved version
    And show how they've fixed each broken promise
    And rebuild their merit through validated improvements
    And maintain a public record of their response to criticism

Feature: Publication Incentives Alignment
  As a scientific community
  We want to align publication incentives with scientific quality
  So that researchers aren't pushed to publish prematurely

  Scenario: Quality Over Quantity in Publication
    Given a researcher is evaluating whether to publish their findings
    When they consider their options in the AP system
    Then their merit is affected by:
      | Factor                    | Impact                                    |
      | Publication Quality      | High positive impact if promises kept     |
      | Premature Publication    | High negative impact if promises broken   |
      | Publication Quantity     | Minimal impact                           |
    And their domain-specific merit accumulates based on kept promises
    And rushed or poor quality work reduces their merit
    And this affects their influence in the scientific community

  Scenario: Negative Results Publication
    Given a researcher has obtained negative results
    When they publish these results in the AP system
    Then they can gain merit for:
      | Promise Type           | Promise Content                             |
      | Transparency          | Complete disclosure of methods and data     |
      | Scientific Value      | Helping others avoid unproductive paths    |
      | Resource Efficiency   | Preventing duplicate negative work         |
    And other researchers can build on this knowledge
    And research efficiency is improved
    And scientific integrity is maintained

Feature: Addressing Replication Crisis
  As a scientific community
  We want to ensure research results are reproducible
  So that scientific findings are reliable and trustworthy

  Scenario: Replication Attempt Tracking
    Given a published study makes specific promises about results
    When other researchers attempt to replicate the study
    Then each replication attempt is recorded with:
      | Aspect                | Detail                                      |
      | Methods Match        | How closely original methods were followed  |
      | Results Match        | How closely results matched original        |
      | Deviations          | Any necessary protocol changes              |
    And successful replications increase original study's merit
    And failed replications trigger review of original promises
    And all attempts contribute to understanding result reliability

  Scenario: Methodological Transparency
    Given a researcher publishes a new study
    Then they must make explicit promises about:
      | Promise Type           | Promise Content                             |
      | Method Detail         | Complete protocol documentation            |
      | Data Availability     | Raw data access for verification           |
      | Analysis Code         | Reproducible analysis scripts              |
    And breaking any of these promises reduces study merit
    And makes future promises less credible
    And affects researcher's domain-specific merit

Feature: Conflict Resolution in Scientific Disputes
  As a scientific community
  We want to resolve scientific disputes fairly and transparently
  So that scientific progress isn't blocked by unproductive conflicts

  Scenario: Competing Theories Resolution
    Given two researchers propose competing theories
    When they engage in scientific debate through the AP system
    Then they must make explicit promises about:
      | Promise Type           | Promise Content                             |
      | Evidence Quality      | Providing robust supporting data           |
      | Logical Consistency   | Demonstrating internal consistency         |
      | Predictive Power      | Making testable predictions               |
    And the community can assess each promise independently
    And merit accumulates based on kept promises
    And consensus emerges through merit-weighted assessments

  Scenario: Resolving Methodology Disputes
    Given researchers disagree about appropriate methodology
    When they debate through the AP system
    Then each must specify:
      | Aspect                | Detail                                      |
      | Method Promises      | What their method can achieve              |
      | Limitations          | What their method cannot do                |
      | Context              | When their method is appropriate           |
    And the community can assess each method in its proper context
    And multiple valid approaches can coexist with clear scope
    And researchers can choose methods based on merit and context


    
Feature: Progressive Replication Evidence Requirements
  As a scientific community
  We want to ensure replications are properly verified
  Based on the replicating lab's existing merit in the domain

  Scenario: Lab Replication Evidence Requirements
    Given a lab attempts to replicate study S in domain "neuroscience/optogenetics"
    And the replication is high-impact with many citations
    Then evidence requirements are based on lab's domain merit:
      | Merit Range | Required Evidence                                    |
      | Below 60    | - Live video feed of all experimental procedures    |
                    | - Raw data streams directly from lab equipment      |
                    | - Independent observer from high-merit lab present  |
                    | - Daily protocol adherence logs                     |
                    | - Equipment calibration certificates               |
    
      | 60-80       | - Sample video recordings of key procedures         |
                    | - Raw data with equipment timestamps               |
                    | - Weekly protocol adherence logs                   |
                    | - Equipment calibration records                    |
    
      | Above 80    | - Standard lab notebook documentation              |
                    | - Raw data submissions                            |
                    | - Protocol variance reports                       |

  Scenario: Failed Replication Assessment
    Given a lab fails to replicate a high-impact finding
    When they submit their negative results
    Then evidence requirements increase for all merit levels:
      | Merit Range | Additional Requirements                             |
      | Below 60    | - Third party lab must attempt same replication   |
                    | - Original authors must review protocol            |
                    | - Equipment cross-validation required              |
    
      | 60-80       | - Independent review of protocol differences       |
                    | - Detailed comparison with original methods       |
                    | - Equipment validation records                    |
    
      | Above 80    | - Documented consultation with original authors    |
                    | - Analysis of potential differences               |

Feature: Extraordinary Claims Evidence Requirements
  As a scientific community
  We want to prevent errors and fraud in groundbreaking claims
  So that time and resources aren't wasted on false leads

  Scenario: Room Temperature Superconductor Claim
    Given a researcher claims room temperature superconductivity
    When they submit their findings
    Then they must provide live verification including:
      | Evidence Type        | Requirements                               |
      | Raw Data            | - Direct from measurement devices          |
                           | - With device serial numbers               |
                           | - With calibration certificates           |
                           | - With timestamp integrity proofs         |
      
      | Live Demonstration  | - Multiple independent labs present       |
                           | - Video from multiple angles              |
                           | - Live data feeds                         |
                           | - Documented setup process                |

      | Materials          | - Sample preparation recorded             |
                           | - Material composition analysis          |
                           | - Chain of custody documentation        |
                           | - Samples provided to verifiers         |

      | Replications       | - Must be replicated in 3+ independent labs|
                           | - Using separate equipment                |
                           | - With independent materials             |
                           | - Before publication accepted            |

  Scenario: Unexpected Material Properties Claim
    Given a researcher claims dramatically unexpected material properties
    When their merit in materials science is below 95
    Then extraordinary evidence is required:
      | Merit Range    | Additional Requirements                        |
      | Below 80      | - Daily lab monitoring                         |
                      | - All experiments recorded                     |
                      | - External observers present                   |
                      | - Equipment inspected by experts              |
      
      | 80-95        | - Weekly lab monitoring                        |
                      | - Key experiments recorded                    |
                      | - Equipment logs verified                     |
                      | - Methods pre-registered                      |

      | Above 95     | - Standard extraordinary claim protocols       |
                      | - Independent replication required            |

  Scenario: Failed Replication of Major Claim
    Given a major physics claim fails replication attempts
    When multiple labs report negative results
    Then original lab must provide:
      | Evidence Type     | Requirements                                |
      | Complete Data    | - All raw data including "failed" runs      |
                        | - Equipment maintenance logs                 |
                        | - Calibration history                       |
                        | - Personnel training records                |

      | Protocol Detail | - Minute-by-minute procedures               |
                        | - All environmental conditions              |
                        | - Every parameter setting                   |
                        | - Every material source                     |

      | Verification    | - Allow site visits from critics            |
                        | - Ship equipment for testing                |
                        | - Provide all materials                     |
                        | - Submit to blind tests                     |

  Scenario: Merit Loss for Non-Reproducible Claims
    Given a groundbreaking claim is proven false
    When investigating the original evidence
    Then merit penalties are applied:
      | Violation Type      | Merit Impact                              |
      | Honest Error       | - Temporary merit reduction               |
                          | - Must demonstrate improved methods       |
                          | - Can rebuild through valid work          |

      | Negligence         | - Major merit reduction                   |
                          | - Extended probation period               |
                          | - Higher evidence requirements            |
                          | - Limited to lower-impact claims          |

      | Fraud             | - Permanent merit loss in domain          |
                          | - Flagged in all related domains         |
                          | - Cannot make extraordinary claims       |
                          | - All past work re-examined              |
