*** Settings ***
Documentation       Global environment settings and shared variables.


*** Variables ***
${BASE_URL}             http://localhost:3000
${API_URL}              ${BASE_URL}/rest
${BROWSER}              chromium
${HEADLESS}             True
${TIMEOUT}              10s
${VALID_USER}           admin@juice-sh.op
${VALID_PASSWORD}       admin123
