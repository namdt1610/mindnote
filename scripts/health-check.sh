#!/bin/bash

# Health check script for Docker containers

set -e

# Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Default values
HOST="localhost"
WEB_PORT="3000"
API_PORT="3001"

# Parse command line arguments
while [[ $# -gt 0 ]]; do
  case $1 in
    --host)
      HOST="$2"
      shift 2
      ;;
    --web-port)
      WEB_PORT="$2"
      shift 2
      ;;
    --api-port)
      API_PORT="$2"
      shift 2
      ;;
    *)
      echo "Unknown option $1"
      exit 1
      ;;
  esac
done

echo "🔍 Checking Docker container health..."

# Check if Docker is running
if ! docker info > /dev/null 2>&1; then
    echo -e "${RED}❌ Docker is not running${NC}"
    exit 1
fi

# Check web application
echo -n "Checking web application ($HOST:$WEB_PORT)... "
if curl -f -s "http://$HOST:$WEB_PORT" > /dev/null; then
    echo -e "${GREEN}✅ OK${NC}"
else
    echo -e "${RED}❌ Failed${NC}"
    WEB_FAILED=1
fi

# Check API application
echo -n "Checking API application ($HOST:$API_PORT)... "
if curl -f -s "http://$HOST:$API_PORT/api/health" > /dev/null; then
    echo -e "${GREEN}✅ OK${NC}"
else
    echo -e "${RED}❌ Failed${NC}"
    API_FAILED=1
fi

# Check API root endpoint
echo -n "Checking API root endpoint ($HOST:$API_PORT/api)... "
if curl -f -s "http://$HOST:$API_PORT/api" > /dev/null; then
    echo -e "${GREEN}✅ OK${NC}"
else
    echo -e "${YELLOW}⚠️  Warning${NC}"
fi

# Summary
echo ""
if [[ $WEB_FAILED == 1 || $API_FAILED == 1 ]]; then
    echo -e "${RED}❌ Some services are not healthy${NC}"
    exit 1
else
    echo -e "${GREEN}✅ All services are healthy${NC}"
fi
