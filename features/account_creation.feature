Feature: Account creation

  # TODO: This might duplicate invite features
  Scenario: Creating a new account
    Given I am not authenticated
    When I go to registration page
    And fill and submit registration form
    Then I should see "Your account was successfully created. Welcome to Splendid Bacon"

  Scenario: Creating a demo account
    Given I am not authenticated
    When I go to the home page
    And follow "Try the Demo"
    Then I should see "You are currently using the demo mode"
    And I should see "Dashboard"

  Scenario: First selecting demo account and then creating real one
    Given I am not authenticated
    When I go to the home page
    And follow "Try the Demo"
    And follow "Sign up here."
    And fill and submit registration form
    Then I should see "Your account was successfully created. Welcome to Splendid Bacon"
