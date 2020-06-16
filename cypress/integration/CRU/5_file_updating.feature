@test_case_2.5
@files_view
# ./node_modules/.bin/cypress-tags run -e TAGS='@test_case_2.5'

Feature:  File updating
  As an owner or editor, I want to update the file so that the correct version could be used.

  Background: Create a user before starting the tests
    Given Register without UI
    When Login as new user without UI
    Then The user upload "test.pem" without UI

  Scenario: 1 File updating
    Given Update file "test.pem"
#      Given The user has access to the file with owner or editor rights
    When The user press the Actions button in "test.pem" file
    And The user press the Update button in "test.pem" file
    And Choose the needed "test.pem" file from its PC directory for update
    Then Message "File updated successfully"
    Then The user press the Actions button in "test.pem" file
    And The new version of the file "test.pem" is updated
    And The last version remains in the system

  Scenario: 2 File updating with other name
    Given Update file "test.pem"
#      Given The user has access to the file with owner or editor rights
    When The user press the Actions button in "test.pem" file
    And The user press the Update button in "test.pem" file
    And Choose the needed "test.pem" for update to file with "txtFile.txt" name
    Then Message "File updated successfully"
    Then The user press the Actions button in "test.pem" file
    And The new version of the file "test.pem" is updated
    And The last version remains in the system

#  TODO Scenario: 3 User can not update txt file to image