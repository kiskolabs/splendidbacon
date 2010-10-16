Feature: Account creation

  # TODO: This might duplicate invite features
  Scenario: Creating a new account
    Given I am not authenticated
    When I go to registration page
    And fill and submit registration form
    Then I should see "Your account was successfully created. Welcome to Splendid Bacon"
