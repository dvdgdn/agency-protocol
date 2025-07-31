#!/bin/bash

# Build packages in dependency order
echo "Building Agency Protocol packages..."

cd packages

# Build base packages first
echo "Building agent-base..."
cd agent-base && npm run build && cd ..

echo "Building agent-merit..."
cd agent-merit && npm run build && cd ..

echo "Building agent-credit..."
cd agent-credit && npm run build && cd ..

# Build UI core
echo "Building agent-ui-core..."
cd agent-ui-core && npm run build && cd ..

# Build UI packages
echo "Building agent-merit-ui..."
cd agent-merit-ui && npm run build && cd ..

echo "Building agent-credit-ui..."
cd agent-credit-ui && npm run build && cd ..

# Build registry
echo "Building agent-registry..."
cd agent-registry && npm run build && cd ..

echo "All packages built successfully!"