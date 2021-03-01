Feature: Team maintenance
  Scenario: I create a team
    Given a league called 'Test league' exists
    And I am logged in as a user
    And I visit the 'Test league' league page
    When I click link 'Create a team'
    Then I am on the 'Create a new team' page
    When I fill 'Name' with 'Test team'
    And I click 'Create Team'
    Then I am on the 'Test league' page
    And 'Test team' is present

  Scenario: I delete a team
    Given a league called 'Test league' exists
    And I am logged in as a user
    And I visit the 'Test league' league page
    When I click link 'Create a team'
    Then I am on the 'Create a new team' page
    When I fill 'Name' with 'Test team'
    And I click 'Create Team'
    Then I am on the 'Test league' page
    And 'Test team' is present
    When I click link 'Test team'
    Then I am on the 'Test team' page
    When I click 'Delete' and accept the alert
    Then I am on the 'Test league' page
    And 'Test team' is not present

  Scenario: I draft a rider
    Given I have created a league called 'Test league' with a team called 'Test team'
    And I visit the 'Test league' league page
    And I click 'Start' and accept the alert
    And I click link 'Test team'
    Then I am on the 'Test team' page
    And 'Available riders' is present
    And 'My team' is not present
    When I click 'Draft' and accept the alert
    Then 'My team' is present
    And my team has one rider
    And there are no riders to draft
