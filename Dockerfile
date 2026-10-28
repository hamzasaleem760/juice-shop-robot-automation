FROM python:3.11-slim

ENV PYTHONUNBUFFERED=1 \
    NODE_PATH=/usr/local/lib/node_modules

# Install system dependencies for Playwright/Browser library
RUN apt-get update && apt-get install -y --no-install-recommends \
    nodejs \
    npm \
    curl \
    libnss3 \
    libnspr4 \
    libatk1.0-0 \
    libatk-bridge2.0-0 \
    libcups2 \
    libdrm2 \
    libxkbcommon0 \
    libxcomposite1 \
    libxdamage1 \
    libxfixes3 \
    libxrandr2 \
    libgbm1 \
    libpango-1.0-0 \
    libcairo2 \
    libasound2 \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
RUN rfbrowser init --skip-browsers && npx playwright install --with-deps chromium

COPY . .

CMD ["pabot", "--processes", "2", "--outputdir", "results", "tests"]