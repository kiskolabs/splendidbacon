Feature: Invites

  # TODO: This might duplicate invite features
  Scenario: Creating a new invite
    Given I am authenticated as "userx@example.com"
    And I am part of "Company X" organization
    When I go to "Company X" organization page
    And I follow "Company X"
    And I fill in "invitation_email" with "user2@example.com"
    And I press "Send"
    Then I should see "Invitation sent to user2@example.com"

  Scenario: Accepting an invite as an user
    Given I am authenticated as "usery@example.com"
    And have received invite to "invited-by-user@example.com" with token "secrettoken" to organization "Company X"
    When I go to the accept invitation page
    And I press "Accept invitation"
    Then I should see "You are now part of Company X"
    And I should be part of "Company X" organization
    
  Scenario: Accepting an invite as a visitor
    Given I am not authenticated
    And have received invite to "invited-by-user@example.com" with token "secrettoken" to organization "Company X"
    When I go to the accept invitation page
    Then I should see "You need to sign in or sign up before continuing."
  
  Scenario: Removing membership
    Given I am authenticated as "userx@example.com"
    And I am part of "Company X" organization
    And user "dedede@dede.de" exists with access to organization "Company X" and project "Project Y"
    When I go to "Company X" organization page
    And I follow "Company X"
    And I click the last remove button
    Then I should see "User removed"
    And user "dedede@dede.de" should not have access to organization "Company X"
    And user "dedede@dede.de" should not have access to project "Project Y"
