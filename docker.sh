#!/bin/bash

# MindNote Docker Management Script

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Function to check if Docker is running
check_docker() {
    if ! docker info > /dev/null 2>&1; then
        print_error "Docker is not running. Please start Docker and try again."
        exit 1
    fi
}

# Function to show help
show_help() {
    echo "MindNote Docker Management Script"
    echo ""
    echo "Usage: ./docker.sh [COMMAND]"
    echo ""
    echo "Commands:"
    echo "  dev         Start development environment"
    echo "  dev:build   Build and start development environment"
    echo "  prod        Start production environment"
    echo "  prod:build  Build and start production environment"
    echo "  stop        Stop all containers"
    echo "  clean       Stop containers and remove volumes"
    echo "  logs        Show logs from all services"
    echo "  logs:api    Show logs from API service"
    echo "  logs:web    Show logs from web service"
    echo "  shell       Open shell in development container"
    echo "  help        Show this help message"
    echo ""
}

# Function to start development environment
start_dev() {
    print_status "Starting development environment..."
    docker-compose -f docker-compose.dev.yml up -d
    print_success "Development environment started!"
    echo ""
    print_status "Services available at:"
    echo "  - Web app: http://localhost:3000"
    echo "  - API: http://localhost:3001"
    echo "  - PostgreSQL: localhost:5432"
    echo "  - Redis: localhost:6379"
    echo ""
    print_status "To view logs: ./docker.sh logs"
    print_status "To stop: ./docker.sh stop"
}

# Function to build and start development environment
build_dev() {
    print_status "Building and starting development environment..."
    docker-compose -f docker-compose.dev.yml up --build -d
    print_success "Development environment built and started!"
}

# Function to start production environment
start_prod() {
    print_status "Starting production environment..."
    docker-compose up -d api web
    print_success "Production environment started!"
    echo ""
    print_status "Services available at:"
    echo "  - Web app: http://localhost:3000"
    echo "  - API: http://localhost:3001"
}

# Function to build and start production environment
build_prod() {
    print_status "Building and starting production environment..."
    docker-compose up --build -d api web
    print_success "Production environment built and started!"
}

# Function to stop all containers
stop_containers() {
    print_status "Stopping all containers..."
    docker-compose -f docker-compose.dev.yml down
    docker-compose down
    print_success "All containers stopped!"
}

# Function to clean up containers and volumes
clean_up() {
    print_warning "This will stop all containers and remove volumes. All data will be lost!"
    read -p "Are you sure? (y/N) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        print_status "Cleaning up containers and volumes..."
        docker-compose -f docker-compose.dev.yml down -v
        docker-compose down -v
        docker system prune -f
        print_success "Cleanup completed!"
    else
        print_status "Cleanup cancelled."
    fi
}

# Function to show logs
show_logs() {
    if [ "$1" = "api" ]; then
        docker-compose logs -f api
    elif [ "$1" = "web" ]; then
        docker-compose logs -f web
    else
        docker-compose -f docker-compose.dev.yml logs -f
    fi
}

# Function to open shell in development container
open_shell() {
    print_status "Opening shell in development container..."
    docker-compose -f docker-compose.dev.yml exec app sh
}

# Check if Docker is running
check_docker

# Main script logic
case "${1:-help}" in
    "dev")
        start_dev
        ;;
    "dev:build")
        build_dev
        ;;
    "prod")
        start_prod
        ;;
    "prod:build")
        build_prod
        ;;
    "stop")
        stop_containers
        ;;
    "clean")
        clean_up
        ;;
    "logs")
        show_logs
        ;;
    "logs:api")
        show_logs api
        ;;
    "logs:web")
        show_logs web
        ;;
    "shell")
        open_shell
        ;;
    "help"|*)
        show_help
        ;;
esac
