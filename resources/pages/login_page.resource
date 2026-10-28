*** Settings ***
Documentation       Page Object representing the Juice Shop Login View.

Library             Browser
Resource            base_page.resource


*** Variables ***
${NAV_ACCOUNT}          id=navbarAccount
${NAV_LOGIN}            id=navbarLoginButton
${INPUT_EMAIL}          id=email
${INPUT_PASSWORD}       id=password
${BTN_SUBMIT}           id=loginButton
${LBL_USER_PROFILE}     button[aria-label="Go to user profile"]
${ALERT_ERROR}          div.error


*** Keywords ***
Navigate To Login Page
    [Documentation]    Opens navigation menu and selects login action.
    Click    ${NAV_ACCOUNT}
    Click    ${NAV_LOGIN}
    Wait For Elements State    ${INPUT_EMAIL}    visible    timeout=${TIMEOUT}

Submit Credentials
    [Documentation]    Inputs login credentials and triggers form submission.
    [Arguments]    ${email}    ${password}
    Fill Text    ${INPUT_EMAIL}    ${email}
    Fill Text    ${INPUT_PASSWORD}    ${password}
    Click    ${BTN_SUBMIT}

Assert Successful Login
    [Documentation]    Verifies profile element is visible after authenticated session.
    Wait For Elements State    ${LBL_USER_PROFILE}    visible    timeout=${TIMEOUT}

Assert Login Failure
    [Documentation]    Verifies appearance of visual error feedback on rejection.
    Wait For Elements State    ${ALERT_ERROR}    visible    timeout=${TIMEOUT}
