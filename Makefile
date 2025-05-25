.PHONY: help dev dev-build prod prod-build stop clean logs shell install test lint format

# Default target
help: ## Show this help message
	@echo "MindNote Development Commands"
	@echo ""
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

# Development commands
install: ## Install dependencies
	pnpm install

dev: ## Start development environment (local)
	pnpm dev

test: ## Run tests
	pnpm test

lint: ## Run linter
	pnpm lint

format: ## Format code
	pnpm format

build: ## Build the project
	pnpm build

# Docker commands
docker-dev: ## Start development environment with Docker
	./docker.sh dev

docker-dev-build: ## Build and start development environment with Docker
	./docker.sh dev:build

docker-prod: ## Start production environment with Docker
	./docker.sh prod

docker-prod-build: ## Build and start production environment with Docker
	./docker.sh prod:build

docker-stop: ## Stop all Docker containers
	./docker.sh stop

docker-clean: ## Clean up Docker containers and volumes
	./docker.sh clean

docker-logs: ## Show Docker logs
	./docker.sh logs

docker-shell: ## Open shell in development container
	./docker.sh shell

# Utility commands
typecheck: ## Run TypeScript type checking
	pnpm typecheck

clean: ## Clean node_modules and build artifacts
	rm -rf node_modules
	rm -rf apps/*/node_modules
	rm -rf packages/*/node_modules
	rm -rf apps/*/.next
	rm -rf apps/*/dist
	pnpm store prune

setup: ## Initial project setup
	cp .env.example .env
	pnpm install
	@echo "Setup complete! Run 'make dev' to start development."

# Database commands (when using Docker)
db-migrate: ## Run database migrations (example)
	@echo "Add your migration command here"

db-seed: ## Seed the database (example)
	@echo "Add your seed command here"

db-reset: ## Reset the database (example)
	@echo "Add your database reset command here"
