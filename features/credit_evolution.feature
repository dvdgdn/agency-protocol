Feature: Credit System
  Credits control platform resource usage, enable promise staking,
  and provide incentives for honest assessment and promise keeping
  Credits remain within the platform ecosystem and cannot be converted to external value

  Background:
    Given the system has registered agents with unique addresses
    And the batch processing system is operational
    And matrix factorization algorithms are enabled for assessment weighting

  @bootstrap
  Scenario: New user receives initial free credits
    Given a new user creates an account on the platform
    When their account is successfully created
    Then they receive an initial allocation of 20 free credits
    And the credits have a 30-day expiration period
    And a CreditAddedEvent is emitted

  @bootstrap
  Scenario: User purchases credits
    Given a user has 10 remaining credits
    When they purchase a credit package of 100 credits for $10.00
    Then their balance increases to 110 credits
    And they receive a receipt stating credits have no cash value
    And a CreditAddedEvent is emitted

  @bootstrap
  Scenario: Enterprise subscription tier receives recurring credits
    Given an enterprise account has subscribed to the premium tier
    When the monthly billing cycle completes
    Then their account receives 500 fresh credits
    And existing credits do not expire while subscription is active
    And a CreditAddedEvent is emitted with subscription source tag

  @promise_staking
  Scenario: User stakes credits on a promise
    Given a user has 100 available credits
    When they create a promise "I will deliver project by Friday"
    And they stake 20 credits on this promise
    Then their available balance decreases to 80 credits
    And the 20 credits are held in escrow
    And the promise displays the staked amount
    And a CreditStakedEvent is emitted

  @promise_staking
  Scenario: Merit reduces stake requirements
    Given an agent has merit score 0.7 in domain "web_development"
    When they make a new promise in "web_development"
    Then their required credit stake is reduced by 50 percent
    And the stake reduction is displayed during promise creation
    And the original stake amount is recorded for merit calculation

  @promise_staking
  Scenario: Insufficient credits for staking
    Given a user has 5 available credits
    When they attempt to make a promise requiring 10 credits stake
    Then they are informed of insufficient credits
    And offered options to purchase more credits or reduce scope
    And the promise is not created

  @assessment_staking
  Scenario: User stakes credits on assessment
    Given a user has 50 credits
    When they assess a promise as "KEPT"
    And they stake 5 credits on this assessment
    Then their available balance decreases to 45 credits
    And the assessment displays the staked amount
    And a CreditStakedEvent is emitted
    And the assessment includes their stake amount in its metadata

  @assessment_staking
  Scenario: Assessment weight influenced by staked amount
    Given multiple assessments exist for a promise
    When the matrix factorization algorithm processes the assessments
    Then assessments with higher stakes receive proportionally higher weight
    And the factorization accounts for both stake amount and assessor merit
    And the resulting matrix maintains the common ground dimension

  @credit_return
  Scenario: Credits returned from kept promise
    Given a user has staked 20 credits on a promise
    When the promise is assessed as "KEPT" by sufficient assessors
    And the batch processing cycle completes
    Then their staked credits are returned to their balance
    And they receive a 10 percent reward of additional credits
    And they are notified of the credit return and reward
    And a CreditUnstakedEvent and CreditAddedEvent are emitted

  @credit_return
  Scenario: Credits returned for accurate assessment
    Given a user has staked 5 credits on an assessment
    When the assessment aligns with the final consensus determination
    And the batch processing cycle completes
    Then their staked credits are returned to their balance
    And they receive a small bonus based on their alignment score
    And a CreditUnstakedEvent is emitted

  @credit_loss
  Scenario: Credits lost from broken promise
    Given a user has staked 20 credits on a promise
    When the promise is assessed as "BROKEN" by sufficient assessors
    And the batch processing cycle completes
    Then 70 percent of their staked credits are lost
    And 30 percent are returned to their balance
    And they are notified of the credit loss
    And the loss details are recorded in their history
    And a CreditUnstakedEvent is emitted

  @credit_loss
  Scenario: Credits lost from inaccurate assessment
    Given a user has staked 5 credits on an assessment
    When the assessment contradicts the final consensus determination
    And the batch processing cycle completes
    Then a portion of their staked credits are lost
    And the loss percentage is proportional to their divergence
    And a CreditUnstakedEvent is emitted

  @credit_transfer
  Scenario: User transfers credits to another user
    Given User A has 100 credits
    When they transfer 25 credits to User B
    Then User A's balance decreases to 75 credits
    And User B's balance increases by 25 credits
    And a CreditTransferEvent is emitted
    And both users receive a notification of the transfer

  @credit_transfer
  Scenario: Conditional credit transfer through bilateral promises
    Given User A creates a promise to pay User B 50 credits
    And User B creates a promise to deliver a service to User A
    When User A adds User B's promise as a condition for payment
    And User B adds User A's promise as a condition for delivery
    Then each promise fulfillment depends on the other's assessment
    And credits transfer only when both promises are assessed as "KEPT"

  @data_as_labor
  Scenario: Credits earned for data sharing
    Given a user has valuable data in domain "market_research"
    When they create a data sharing promise with specific terms
    And other users access and utilize their shared data
    Then they earn credits based on usage metrics
    And credit earnings scale with data quality and uniqueness
    And a DataCreditEarnedEvent is emitted

  @data_as_labor
  Scenario: Data usage credit allocation
    Given a data provider has shared dataset D with terms T
    When a data consumer uses the dataset
    Then credits are allocated according to terms T
    And usage metrics are recorded in the system
    And the allocation appears in both users' transaction history

  @matrix_factorization
  Scenario: Matrix factorization improves credit allocation fairness
    Given multiple assessments exist with various biases
    When the multi-dimensional matrix factorization runs
    Then credit allocations are adjusted based on common ground factors
    And polarized assessments have reduced impact on credit outcomes
    And the system identifies the primary dimensions of assessment variation
    And credit allocations become resistant to factional manipulation
