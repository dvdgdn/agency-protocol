Feature: Merit System Evolution
  Merit represents domain-specific trustworthiness derived from kept promises
  Merit calculation evolves from simple ratios to sophisticated algorithms
  Merit is non-transferrable and accumulates in specific domains
  Merit calculations adapt to system scale and manipulation threats

  Background:
    Given the system has registered agents with unique addresses
    And agents can make and sign promises
    And agents can assess others' promises as KEPT or BROKEN

  @stage0_realtime
  Scenario: Basic real-time merit calculation
    Given Agent A has made 10 promises in domain "web_development"
    And 8 promises were assessed as KEPT
    And 2 promises were assessed as BROKEN
    When another agent requests Agent A's merit score
    Then the system calculates it in real-time as 0.8
    And the calculation uses the simple formula: KEPT ÷ TOTAL
    And no batch processing is involved

  @stage0_realtime
  Scenario: Real-time merit impacts stake requirements
    Given Agent A has a current merit score of 0.7 in domain D
    When Agent A attempts to make a new promise in domain D
    Then their required stake is calculated in real-time
    And the stake requirement is reduced by 50 percent
    And no cached values are used

  @stage1_cached
  Scenario: Merit calculation with caching
    Given Agent A has a cached merit score of 0.8 in domain D
    When a new assessment of "BROKEN" is recorded for Agent A
    Then Agent A's merit is recalculated as 0.75
    And this new value is stored in the merit cache
    And subsequent merit requests use this cached value
    And no batch processing is involved

  @stage1_cached
  Scenario: Cache invalidation after multiple assessments
    Given Agent B has a cached merit score in domain D
    When multiple new assessments for Agent B are recorded
    Then the system invalidates Agent B's cached merit
    And the merit is recalculated on the next request
    And the new value reflects all recent assessments

  @stage2_basic_batch
  Scenario: First batch merit processing
    Given 50 new assessments have been recorded across various domains
    When the first scheduled batch processing cycle runs
    Then all affected merit scores are updated at once
    And the basic merit formula is still used: KEPT ÷ TOTAL
    And agents receive notifications about merit changes
    And a BatchProcessingCompletedEvent is emitted

  @stage2_basic_batch
  Scenario: Batch processing frequency
    Given domain "medical_services" requires frequent updates
    And domain "content_creation" requires less frequent updates
    When batch processing is configured
    Then domain "medical_services" is processed every 2 hours
    And domain "content_creation" is processed every 24 hours
    And each domain's batch timing is configurable

  @stage3_weighted_batch
  Scenario: Merit calculation with weighted assessments
    Given the following assessments for Agent A in domain D:
      | Assessor | Status | Assessor Merit | Stake |
      | Agent B  | KEPT   | 0.8           | 10    |
      | Agent C  | KEPT   | 0.3           | 5     |
      | Agent D  | BROKEN | 0.6           | 8     |
    When the batch processing cycle runs with weighting enabled
    Then assessments are weighted by combined assessor merit and stake
    And Agent B's assessment has the highest impact
    And Agent C's assessment has the lowest impact
    And a WeightedMeritCalculationEvent is emitted

  @stage3_weighted_batch
  Scenario: Weighted batch processing resists simple manipulation
    Given a low-merit agent makes multiple assessments of BROKEN
    And a high-merit agent makes a single assessment of KEPT
    When the weighted batch processing runs
    Then the high-merit assessment has more influence
    And the manipulation attempt has limited effect
    And the resulting merit score reflects assessment quality

  @stage4_temporal_batch
  Scenario: Merit calculation with time decay
    Given Agent A has the following assessments in domain D:
      | Promise Address | Status | Timestamp    | Age in Days |
      | 0xP1           | KEPT   | 1 day ago    | 1           |
      | 0xP2           | KEPT   | 30 days ago  | 30          |
      | 0xP3           | BROKEN | 90 days ago  | 90          |
    When the batch processing cycle runs with time decay enabled
    Then each assessment is weighted by time decay factor
    And recent assessments have more impact than older ones
    And the decay formula (0.9^timeperiods) is applied
    And a TemporalMeritCalculationEvent is emitted

  @stage4_temporal_batch
  Scenario: Merit decay for inactive agents
    Given Agent A has not received new assessments for 180 days
    When the temporal batch processing runs
    Then Agent A's merit score gradually decreases
    And the rate of decay follows the configured formula
    And a MeritDecayEvent is emitted

  @stage5_factorized_batch
  Scenario: Matrix factorization identifies assessment patterns
    Given domain D shows evidence of polarized assessment patterns
    When batch processing runs with matrix factorization enabled
    Then the system:
      | Action                   | Effect                                      |
      | Creates vote matrix      | Maps assessors to promises                  |
      | Performs factorization   | Identifies latent factors in voting         |
      | Identifies bias dimension| Maps users and promises in bias space       |
      | Calculates common ground | Finds agreement across different groups     |
    And a FactorizationCompletedEvent is emitted

  @stage5_factorized_batch
  Scenario: Merit with matrix factorization resists factional manipulation
    Given a coordinated group of agents all assess a promise as BROKEN
    And their assessment pattern shows strong bias correlation
    When batch processing runs with matrix factorization
    Then the system identifies the manipulation attempt
    And the factional assessments have reduced weight
    And the resulting merit calculation is resistant to gaming
    And the common ground factor has primary influence

  @stage6_multifactor_batch
  Scenario: Multi-dimensional factorization for complex patterns
    Given domain D has complex assessment patterns beyond simple polarization
    When 3D matrix factorization is applied during batch processing
    Then the system identifies multiple latent factors:
      | Dimension | Interpretation                 | Entropy |
      | First     | Political/ideological polarity | High    |
      | Second    | Expertise-based variation      | Medium  |
      | Third     | Common ground/helpfulness      | Low     |
    And merit calculations focus on the low-entropy dimension
    And a MultidimensionalFactorizationEvent is emitted

  @stage6_multifactor_batch
  Scenario: Advanced merit calculation with multiple factors
    Given complex assessment patterns exist in domain D
    When multi-factor batch processing runs
    Then merit is calculated using:
      | Component       | Source                           | Weight |
      | Common ground   | Low-entropy dimension            | High   |
      | Expertise       | Domain-specific qualification    | Medium |
      | Consensus       | Agreement across polarized groups| High   |
    And the system adapts weights based on domain characteristics
    And manipulation resistance is maximized
