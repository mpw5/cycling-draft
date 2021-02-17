Feature: Team maintenance
  Scenario: I create a team
    Given a league called 'Test league' exists
    And I visit the 'Test league' league page
    When I click link 'Create a team'
    Then I am on the 'Create a new team' page
    When I fill 'Name' with 'Test team'
    And I click 'Create Team'
    Then I am on the 'Test league' page
    And 'Test team' is present

  Scenario: I delete a team
    Given a league called 'Test league' exists
    And I visit the 'Test league' league page
    When I click link 'Create a team'
    Then I am on the 'Create a new team' page
    When I fill 'Name' with 'Test team'
    And I click 'Create Team'
    Then I am on the 'Test league' page
    And 'Test team' is present
    When I click link 'Test team'
    Then I am on the 'Test team' page
    When I click the 'Delete' button and accept the alert
    Then I am on the 'Test league' page
    And 'Test team' is not present
