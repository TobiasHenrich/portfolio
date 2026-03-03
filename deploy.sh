#!/bin/bash
# Deploy portfolio to VPS
# Run on the VPS host

set -e

PORTFOLIO_DIR="/opt/portfolio"
REPO_URL="https://github.com/TobiasHenrich/echo_files"

echo "🚀 Deploying portfolio..."

# Create directory
mkdir -p $PORTFOLIO_DIR
cd $PORTFOLIO_DIR

# Clone or pull
if [ -d ".git" ]; then
    echo "📥 Pulling latest changes..."
    git pull
else
    echo "📥 Cloning repository..."
    git clone $REPO_URL .
fi

# Copy portfolio files from workspace
echo "📦 Copying portfolio files..."
cp -r /data/.openclaw/workspace/portfolio/dist ./

# Start container
echo "🐳 Starting container..."
docker compose up -d --build

echo "✅ Portfolio deployed at http://localhost:3080"
echo "🌐 Make sure Caddy is running to route tobistack.tech"