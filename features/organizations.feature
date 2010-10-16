Feature: Users can do bunch of stuff with organizations

  Scenario: User can add an organization
    Given I am authenticated as "userx@example.com"
    When I go to organizations page
    And follow "Add an organization"
    And fill in "Name" with "My Company"
    And press "Create Organization"
    Then I should see "Organization was successfully created"
    And I should be part of "My Company" organization

  Scenario: Member can edit an organization
    Given I am authenticated as "userx@example.com"
    And I am part of "Company X" organization
    When I go to "Company X" organization page
    And follow "Edit"
    And fill in "Name" with "Company Z"
    And press "Update Organization"
    Then I should see "Organization was successfully updated"
    And I should see "Company Z"
    
  Scenario: Member can destroy an organization
    Given I am authenticated as "userx@example.com"
    And I am part of "Company X" organization
    When I go to "Company X" organization page
    And follow "Delete"
    Then I should see "Organization was successfully deleted"
    And I should not see "Company X"
    And organization "Company X" should not exist
