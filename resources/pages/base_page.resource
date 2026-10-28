*** Settings ***
Documentation       Foundational browser setup and shared modal dismissals.

Library             Browser
Resource            ../config/env_local.resource


*** Keywords ***
Open Juice Shop Application
    [Documentation]    Initializes browser context and loads main URL.
    [Arguments]    ${url}=${BASE_URL}
    New Browser    browser=${BROWSER}    headless=${HEADLESS}
    New Context    viewport={'width': 1280, 'height': 800}
    New Page    ${url}
    Dismiss Welcome Banners

Dismiss Welcome Banners
    [Documentation]    Dismisses initial overlays and cookie dialogs if present.
    VAR    ${dismiss_btn}    button[aria-label="Close Welcome Banner"]
    Run Keyword And Ignore Error    Wait For Elements State    ${dismiss_btn}    visible    timeout=3s
    Run Keyword And Ignore Error    Click    ${dismiss_btn}
    VAR    ${cookie_btn}     a[aria-label="dismiss cookie message"]
    Run Keyword And Ignore Error    Click    ${cookie_btn}
