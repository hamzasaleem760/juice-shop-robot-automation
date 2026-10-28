*** Settings ***
Documentation       Basic defensive security checks: headers, method handling, and auth boundaries.

Resource            ../../resources/keywords/api_keywords.resource
Resource            ../../resources/keywords/security_keywords.resource

Suite Setup         Create Juice Shop API Session


*** Test Cases ***
Verify Essential Security Headers On Landing Page
    [Documentation]    Ensures anti-framing and MIME sniffing protection headers are present.
    [Tags]    security    smoke
    ${resp}=    GET On Session    juiceshop    /    expected_status=200
    ${headers}=    Set Variable${resp.headers}
    Assert Security Header Present    ${headers}    X-Content-Type-Options
    Assert Security Header Present    ${headers}    X-Frame-Options

Admin Endpoint Rejects Non-Admin Requests
    [Documentation]    Attempts to hit administration route without bearer token.
    [Tags]    security    regression
    ${resp}=    GET On Session
    ...    juiceshop
    ...    /rest/admin/application-version
    ...    expected_status=any
    # Juice Shop either enforces 401/403 or serves a custom 401 wrapper
    Should Contain Any    ${resp.status_code}    401    403
