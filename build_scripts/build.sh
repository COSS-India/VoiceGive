#!/bin/bash

# Build script for different environments
# Usage: ./build_scripts/build.sh [development|staging|production]

set -e

ENVIRONMENT=${1:-development}

echo "Building for environment: $ENVIRONMENT"

case $ENVIRONMENT in
  development)
    echo "Building development version..."
    flutter build apk --dart-define=ENVIRONMENT=development --debug
    ;;
  staging)
    echo "Building staging version..."
    flutter build apk --dart-define=ENVIRONMENT=staging --release
    ;;
  production)
    echo "Building production version..."
    flutter build apk --dart-define=ENVIRONMENT=production --release
    ;;
  *)
    echo "Invalid environment. Use: development, staging, or production"
    exit 1
    ;;
esac

echo "Build completed for $ENVIRONMENT environment"
