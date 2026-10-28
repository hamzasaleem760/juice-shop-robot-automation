# Juice Shop QA & Security Automation Framework

[![CI Pipeline](https://github.com/yourname/juice-shop-robot-automation/actions/workflows/ci.yml/badge.svg)](https://github.com/yourname/juice-shop-robot-automation/actions)
[![Robot Framework](https://img.shields.io/badge/Robot%20Framework-7.0-blue.svg)](https://robotframework.org/)
[![Playwright](https://img.shields.io/badge/Powered%20By-Playwright%20Browser-green.svg)](https://marketsquare.github.io/robotframework-browser/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

An enterprise-ready end-to-end test automation framework built for [OWASP Juice Shop](https://owasp.org/www-project-juice-shop/), showcasing modern UI, API, and security smoke automation running deterministically in Docker with parallel execution and automated CI reporting.

---

## Architecture Overview

```text
               ┌──────────────────────────────┐
               │    GitHub Actions (CI/CD)    │
               │  Lint -> Smoke -> Nightly    │
               └──────────────┬───────────────┘
                              │
            ┌─────────────────┴─────────────────┐
            ▼                                   ▼
┌───────────────────────┐           ┌───────────────────────┐
│     Docker Target     │           │   pabot Test Runner   │
│   (OWASP Juice Shop)  │ ◄──────── │ (UI / API / Security) │
│       Port 3000       │           │  rfbrowser + Requests │
└───────────────────────┘           └───────────┬───────────┘
                                                │
                                    ┌───────────▼───────────┐
                                    │ HTML Log/Report & ZAP │
                                    │   via GitHub Pages    │
                                    └───────────────────────┘