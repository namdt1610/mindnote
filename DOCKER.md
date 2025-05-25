# Docker Setup for MindNote

This document explains how to use Docker with the MindNote monorepo project.

## Overview

The Docker setup includes:
- **Multi-stage Dockerfile** for optimized production builds
- **Development environment** with hot reloading
- **Production environment** with optimized builds
- **Database services** (PostgreSQL, Redis) for development
- **Management script** for easy Docker operations

## Quick Start

### Development Environment

```bash
# Start development environment (includes database services)
pnpm docker:dev

# Or build and start
pnpm docker:dev:build

# View logs
pnpm docker:logs

# Stop containers
pnpm docker:stop
```

The development environment will be available at:
- **Web App**: http://localhost:3000
- **API**: http://localhost:3001
- **PostgreSQL**: localhost:5432
- **Redis**: localhost:6379

### Production Environment

```bash
# Start production environment
pnpm docker:prod

# Or build and start
pnpm docker:prod:build
```

## Docker Services

### Development Stack
- **app**: Main development container with hot reloading
- **postgres**: PostgreSQL database for development
- **redis**: Redis cache for development

### Production Stack
- **web**: Optimized Next.js application
- **api**: Optimized NestJS API server

## Management Script

The `docker.sh` script provides convenient commands:

```bash
./docker.sh dev          # Start development environment
./docker.sh dev:build    # Build and start development
./docker.sh prod         # Start production environment
./docker.sh prod:build   # Build and start production
./docker.sh stop         # Stop all containers
./docker.sh clean        # Stop containers and remove volumes
./docker.sh logs         # Show logs from all services
./docker.sh logs:api     # Show API logs only
./docker.sh logs:web     # Show web logs only
./docker.sh shell        # Open shell in development container
./docker.sh help         # Show help
```

## Docker Compose Files

- `docker-compose.yml`: Main compose file with production services
- `docker-compose.dev.yml`: Development environment with database services

## Dockerfile Targets

The multi-stage Dockerfile includes several targets:

1. **base**: Base Node.js Alpine image
2. **deps**: Dependencies installation
3. **builder**: Build stage for all applications
4. **api**: Production API image
5. **web**: Production web image
6. **dev**: Development image with source code mounting

## Volume Mounts (Development)

The development environment mounts your local code with selective node_modules exclusions:

```yaml
volumes:
  - .:/app
  - /app/node_modules
  - /app/apps/web/node_modules
  - /app/apps/api/node_modules
  - /app/packages/ui/node_modules
  - /app/packages/eslint-config/node_modules
  - /app/packages/typescript-config/node_modules
```

This ensures:
- Your code changes are reflected immediately
- node_modules from the container are preserved
- Hot reloading works correctly

## Environment Variables

### Development
- `NODE_ENV=development`

### Production
- `NODE_ENV=production`
- `PORT=3000` (web) / `PORT=3001` (api)
- `NEXT_TELEMETRY_DISABLED=1`

### Database (Development)
- `POSTGRES_DB=mindnote_dev`
- `POSTGRES_USER=postgres`
- `POSTGRES_PASSWORD=password`

## Ports

| Service    | Port | Description           |
|------------|------|-----------------------|
| Next.js    | 3000 | Web application       |
| NestJS API | 3001 | API server           |
| PostgreSQL | 5432 | Database             |
| Redis      | 6379 | Cache/Session store  |

## Troubleshooting

### Common Issues

1. **Port conflicts**: Make sure ports 3000, 3001, 5432, and 6379 are not in use
2. **Permission issues**: Run `chmod +x docker.sh` if the script isn't executable
3. **Docker not running**: Ensure Docker Desktop is running
4. **Build failures**: Try `./docker.sh clean` and rebuild

### Viewing Logs

```bash
# All services
pnpm docker:logs

# Specific service
docker-compose -f docker-compose.dev.yml logs -f app
docker-compose logs -f api
docker-compose logs -f web
```

### Debugging

Open a shell in the development container:

```bash
pnpm docker:shell
# or
./docker.sh shell
```

### Cleanup

Remove all containers and volumes:

```bash
pnpm docker:clean
# or
./docker.sh clean
```

## Production Deployment

For production deployment, you can build and push the images:

```bash
# Build production images
docker build --target api -t mindnote-api .
docker build --target web -t mindnote-web .

# Tag and push to registry (replace with your registry)
docker tag mindnote-api your-registry/mindnote-api:latest
docker tag mindnote-web your-registry/mindnote-web:latest
docker push your-registry/mindnote-api:latest
docker push your-registry/mindnote-web:latest
```

## Next Steps

1. **Configure environment variables** for your specific setup
2. **Set up CI/CD** to build and deploy Docker images
3. **Add health checks** to the services
4. **Configure reverse proxy** (nginx, Traefik) for production
5. **Set up monitoring** and logging for production containers
