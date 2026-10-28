*** Settings ***
Documentation       Low-level & high-level REST API client keywords.

Library             Collections
Library             RequestsLibrary
Library             ../../libraries/AuthHelper.py
Resource            ../config/env_local.resource


*** Keywords ***
Create Juice Shop API Session
    [Documentation]    Initializes HTTP session against the target base URL.
    Create Session    juiceshop    ${BASE_URL}    verify=True

Authenticate Via API
    [Documentation]    Submits credentials to authentication endpoint and returns raw response.
    [Arguments]    ${email}=${VALID_USER}    ${password}=${VALID_PASSWORD}
    VAR    &{payload}    email=${email}    password=${password}
    ${resp}=    POST On Session    juiceshop    /rest/user/login    json=${payload}    expected_status=any
    RETURN    ${resp}

Get Valid Auth Token
    [Documentation]    Authenticates default valid user and extracts bearer token from response.
    ${resp}=    Authenticate Via API
    Should Be Equal As Integers    ${resp.status_code}    200
    VAR    ${token}    ${resp.json()['authentication']['token']}
    RETURN    ${token}

Fetch All Products
    [Documentation]    Queries the product catalog search endpoint with an empty query.
    ${resp}=    GET On Session
    ...    juiceshop
    ...    /rest/products/search?q=${EMPTY}
    ...    expected_status=200
    RETURN    ${resp.json()['data']}
