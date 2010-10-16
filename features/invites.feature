Feature: Invites

  # TODO: This might duplicate invite features
  Scenario: Creating a new invite
    Given I am authenticated as "User X"
    And I am part of "Company X" organization
    When I go to organizations page
    And I follow "Company X"
    And I follow "Invite"
    And I fill in "invite_email" with "user2@example.com"
    And I press "Send"
    Then I should see "Invite sent succesfully to user@example.com"

  Scenario: Accepting an invite as an user
    Given I am authenticated as "User Y"
    And have received invite to "invited-by-user@example.com" with token "secrettoken" to organization "Company X"
    When I go to the accept invitation page
    And I follow "Accept invitation"
    Then I should see "You are now part of Company X"
    And I should be part of "Company X" organization
    
  Scenario: Accepting an invite as a visitor
    Given I am not authenticated
    And have received invite to "invited-by-user@example.com" with token "secrettoken" to organization "Company X"
    When I go to the accept invitation page
    Then I should see "You need to be logged in for this action"
