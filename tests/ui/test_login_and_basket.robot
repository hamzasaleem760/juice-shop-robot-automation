*** Settings ***
Documentation       End-to-end UI user flows using Playwright Browser library.

Resource            ../../resources/pages/base_page.resource
Resource            ../../resources/pages/login_page.resource

Test Setup          Open Juice Shop Application
Test Teardown       Close Browser


*** Test Cases ***
Valid User Should Log In Successfully
    [Documentation]    Verify registered user can access the account menu.
    [Tags]    ui    smoke
    Navigate To Login Page
    Submit Credentials    ${VALID_USER}    ${VALID_PASSWORD}
    Assert Successful Login

Invalid Credentials Should Display Error
    [Documentation]    Data-driven template validation for rejection cases.
    [Tags]    ui    regression
    [Template]    Attempt Login With Invalid Data
    invalid_user@test.local    wrongpass
    admin@juice-sh.op    ${EMPTY}
    ${EMPTY}    somepassword


*** Keywords ***
Attempt Login With Invalid Data
    [Documentation]    Attempts login action chain with arbitrary test parameters.
    [Arguments]    ${email}    ${password}
    Navigate To Login Page
    Submit Credentials    ${email}    ${password}
    Assert Login Failure
