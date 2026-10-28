*** Settings ***
Documentation       Reusable security verification keywords.

Library             Collections
Library             RequestsLibrary
Resource            ../config/env_local.resource


*** Keywords ***
Assert Security Header Present
    [Documentation]    Asserts specific security header key exists in response header dictionary.
    [Arguments]    ${headers}    ${header_name}
    Dictionary Should Contain Key    ${headers}    ${header_name}
    ...    msg=Expected security header '${header_name}' was missing!

Verify Strict Transport Security
    [Documentation]    Verifies presence of HSTS header.
    [Arguments]    ${headers}
    Assert Security Header Present    ${headers}    Strict-Transport-Security
