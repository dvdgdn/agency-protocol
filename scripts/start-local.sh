#!/bin/bash

echo "🚀 Starting Agency Protocol Platform..."
echo ""

# Check if .env file exists
if [ ! -f .env ]; then
    echo "⚠️  No .env file found!"
    echo "Please copy .env.example to .env and configure your database URLs."
    echo ""
    echo "Run: cp .env.example .env"
    echo "Then edit .env with your Supabase credentials."
    exit 1
fi

# Check if node_modules exists
if [ ! -d "node_modules" ]; then
    echo "📦 Installing dependencies..."
    npm install
fi

# Generate Prisma client
echo "🔧 Generating Prisma client..."
npx prisma generate --schema=./packages/agent-adapter-prisma/src/infrastructure/prisma/schema.prisma

echo ""
echo "✅ Setup complete!"
echo ""
echo "To run the platform, open two terminal windows:"
echo ""
echo "Terminal 1 - Start the API server:"
echo "  nx serve agent-server"
echo ""
echo "Terminal 2 - Start the web app:"
echo "  nx serve agent-web-ui"
echo ""
echo "The API will be available at: http://localhost:3000/api"
echo "The web app will be available at: http://localhost:4200"
echo ""
echo "To seed the database with sample data:"
echo "  curl -X POST http://localhost:3000/api/merit/seed"