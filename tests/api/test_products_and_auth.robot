*** Settings ***
Documentation       REST API contract and status tests.

Resource            ../../resources/keywords/api_keywords.resource

Suite Setup         Create Juice Shop API Session


*** Test Cases ***
Verify User Authentication Returns Valid JWT
    [Documentation]    Ensures login endpoint yields token with expected claims.
    [Tags]    api    smoke
    ${response}=    Authenticate Via API    ${VALID_USER}${VALID_PASSWORD}
    Should Be Equal As Integers    ${response.status_code}    200
    ${token}=    Set Variable${response.json()['authentication']['token']}
    ${claims}=    Decode Jwt Payload${token}
    Dictionary Should Contain Key    ${claims}    data

Get Product Catalog Without Authentication
    [Documentation]    Verifies product list is publicly accessible.
    [Tags]    api    regression
    ${products}=    Fetch All Products
    Should Not Be Empty    ${products}
    ${first_item}=    Set Variable${products[0]}
    Dictionary Should Contain Key    ${first_item}    id
    Dictionary Should Contain Key    ${first_item}    name
    Dictionary Should Contain Key    ${first_item}    price

Unauthorized Access To Basket Returns 401
    [Documentation]    Accessing user baskets without a token must be rejected.
    [Tags]    api    security    regression
    ${resp}=    GET On Session    juiceshop    /rest/basket/1    expected_status=401
    Should Be Equal As Integers    ${resp.status_code}    401
