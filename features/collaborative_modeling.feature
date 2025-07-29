Feature: Collaborative Logical Modeling
  Enable group sensemaking through merit-weighted contributions to shared models

  Background:
    Given agents can make claims about logical structures
    And claims require merit or credit stakes
    And corroboration affects merit scores
    And logical structures can evolve through consensus

  Scenario: Structural Claim Types
    Given an agent wants to contribute to a logical model
    When making structural claims
    Then allow:
      | Claim Type      | Description                                               |
      | Entity         | Node in logical structure                                 |
      | Relationship   | Causal link between entities                             |
      | Property       | Attribute of entity or relationship                      |
      | Operator       | Logical combination (AND, OR, etc)                       |
    And require for each:
      | Requirement    | Implementation                                            |
      | Description   | Clear statement of claim                                  |
      | Evidence      | Supporting reasoning/data                                 |
      | Stake         | Merit or credit commitment                               |
      | Scope         | Context boundary                                         |

  Scenario: Stake Requirements
    Given an agent makes a structural claim
    When determining required stake
    Then consider:
      | Factor         | Impact                                                    |
      | Fundamentality | How basic/axiomatic the claim                            |
      | Scope         | How much of model affected                               |
      | Novelty       | How different from existing claims                       |
      | Conflict      | Whether contradicts high-merit claims                    |
    And require:
      | Claim Level    | Minimum Stake                                            |
      | Basic Entity   | Low stake - easily testable                             |
      | Relationship   | Medium stake - needs validation                         |
      | Framework      | High stake - foundational claim                         |

Feature: Corroboration Process
  Enable reliable consensus formation

  Scenario: Direct Corroboration
    Given a structural claim exists
    When another agent corroborates
    Then require:
      | Element        | Verification                                              |
      | Independence  | No collusion/circular support                            |
      | Reasoning     | Original supporting logic                                |
      | Evidence      | Additional support data                                  |
      | Stake         | Proportional commitment                                  |
    And process:
      | Action         | Implementation                                            |
      | Verification   | Check all requirements met                               |
      | Recording      | Document corroboration                                   |
      | Merit Update   | Adjust scores based on outcome                          |

  Scenario: Indirect Corroboration
    Given a claim has dependent claims
    When dependencies are corroborated
    Then calculate:
      | Factor         | Contribution                                              |
      | Support       | How dependencies strengthen claim                         |
      | Coverage      | What aspects are supported                               |
      | Consistency   | How well parts fit together                              |
    And update:
      | Aspect         | Change                                                    |
      | Claim Merit    | Increased by support                                     |
      | Dependencies   | Strengthened connections                                 |
      | Confidence     | Adjusted uncertainty                                     |

Feature: Consensus Formation
  Enable emergence of shared understanding

  Scenario: Merit Accumulation
    Given claims receive corroboration
    When calculating consensus weight
    Then consider:
      | Factor         | Measure                                                   |
      | Direct Merit   | Corroboration quality                                    |
      | Network Merit  | Supporting structure                                     |
      | Time Stability | Sustained acceptance                                     |
      | Challenge      | Survived critical tests                                  |
    And apply:
      | Threshold      | Effect                                                    |
      | Low Merit      | Remains alternative view                                 |
      | Medium Merit   | Considered viable option                                 |
      | High Merit     | Becomes canonical view                                   |
      | Top Merit      | Reference structure                                      |

  Scenario: Alternative Views
    Given multiple conflicting claims exist
    When managing diversity
    Then allow:
      | State          | Handling                                                  |
      | Exploration   | All views initially accepted                             |
      | Competition   | Merit-based influence                                    |
      | Resolution    | Natural selection via stakes                             |
      | Preservation  | Minority views maintained                                |

Feature: Conflict Resolution
  Enable productive handling of disagreement

  Scenario: Claim Challenges
    Given an agent disputes a claim
    When raising challenge
    Then require:
      | Element        | Content                                                   |
      | Target        | Specific claim disputed                                  |
      | Reason        | Clear basis for challenge                                |
      | Alternative   | Better explanation                                       |
      | Stake         | Matching original stake                                  |
    And process:
      | Phase          | Action                                                    |
      | Validation    | Check challenge legitimacy                               |
      | Notification  | Alert stakeholders                                       |
      | Resolution    | Merit-based outcome                                      |

  Scenario: Resolution Process
    Given a legitimate challenge exists
    When resolving dispute
    Then evaluate:
      | Aspect         | Assessment                                                |
      | Evidence      | Support strength                                         |
      | Logic         | Reasoning validity                                       |
      | Utility       | Practical value                                         |
      | Integration   | Structural fit                                          |
    And determine:
      | Outcome        | Process                                                   |
      | Original Wins  | Challenge stake lost                                     |
      | Challenge Wins | Original stake lost                                      |
      | Synthesis      | Combined insight                                         |
      | Coexistence   | Maintain both views                                      |

Feature: Model Evolution
  Enable continuous improvement of shared understanding

  Scenario: Structure Refinement
    Given a logical model exists
    When improving over time
    Then track:
      | Aspect         | Evolution                                                 |
      | Detail        | Increasing precision                                     |
      | Coverage      | Expanding scope                                          |
      | Integration   | Better connections                                       |
      | Utility       | Practical value                                         |
    And maintain:
      | Quality        | Method                                                    |
      | Coherence     | Logical consistency                                      |
      | Simplicity    | Minimal complexity                                       |
      | Usefulness    | Practical application                                    |
      | Adaptability  | Easy updating                                            |

  Scenario: Knowledge Capture
    Given model evolution occurs
    When preserving insights
    Then record:
      | Element        | Content                                                   |
      | Claims        | All structural elements                                  |
      | Evidence      | Supporting material                                      |
      | Process       | Development history                                      |
      | Context       | Environmental factors                                    |
    And enable:
      | Use            | Support                                                   |
      | Learning      | Pattern extraction                                       |
      | Transfer      | Knowledge sharing                                        |
      | Building      | Foundation for growth                                    |
