*** Settings ***
Documentation       Page Object representing the user basket and checkout views.

Library             Browser
Resource            base_page.resource


*** Variables ***
${BTN_CHECKOUT}     id=checkoutButton


*** Keywords ***
Verify Basket Page Loaded
    [Documentation]    Confirms presence of the checkout control on basket page.
    Wait For Elements State    ${BTN_CHECKOUT}    visible    timeout=${TIMEOUT}
