#!/bin/bash

echo "🚀 Starting Agency Protocol Platform (Development Mode)..."
echo ""
echo "This script will help you run the platform using the standard npm scripts."
echo ""

# Check if .env file exists
if [ ! -f .env ]; then
    echo "⚠️  No .env file found!"
    echo "For now, we'll run without database connection."
    echo "To connect to a database later, copy .env.example to .env and add your credentials."
    echo ""
fi

echo "Instructions:"
echo "1. Open a new terminal window for the API server"
echo "2. Open another terminal window for the web app"
echo ""
echo "Terminal 1 - API Server:"
echo "  cd packages/agent-server && npm run dev"
echo ""
echo "Terminal 2 - Web App:"
echo "  cd packages/agent-web-ui && npm run dev"
echo ""
echo "The API will be available at: http://localhost:3000/api"
echo "The web app will be available at: http://localhost:3000 (Next.js default)"
echo ""
echo "Note: The web app is configured to look for the API at http://localhost:3000/api"