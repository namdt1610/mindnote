# MindNote - Monorepo with Next.js, NestJS & Docker

A modern monorepo setup with Next.js frontend, NestJS backend, shared UI components, and Docker containerization.

## 🚀 Quick Start

### With Docker (Recommended)

```bash
# Clone the repository
git clone <your-repo-url>
cd mindnote

# Start development environment
make docker-dev
# or
pnpm docker:dev

# Access the applications
# Web: http://localhost:3000
# API: http://localhost:3001
```

### Local Development

```bash
# Install dependencies
pnpm install

# Start development servers
pnpm dev

# Or use make
make dev
```

## 🐳 Docker Setup

This project includes a comprehensive Docker setup for both development and production environments.

### Development with Docker

```bash
# Start development environment (includes databases)
make docker-dev

# Build and start
make docker-dev-build

# View logs
make docker-logs

# Open shell in container
make docker-shell

# Stop containers
make docker-stop
```

### Production with Docker

```bash
# Build and start production environment
make docker-prod-build

# Start production environment
make docker-prod
```

For detailed Docker documentation, see [DOCKER.md](./DOCKER.md).

---

# Hướng dẫn Setup Monorepo Next.js với shadcn/ui và NestJS

## 1. Khởi tạo Project

```bash
# Tạo thư mục project
mkdir mindnote
cd mindnote

# Khởi tạo monorepo với pnpm
pnpm init

# Tạo file pnpm-workspace.yaml
echo "packages:
  - 'apps/*'
  - 'packages/*'" > pnpm-workspace.yaml
```

## 2. Cấu trúc Thư mục

```
mindnote/
├── apps/
│   ├── web/           # Next.js frontend application
│   └── api/           # NestJS backend application
├── packages/
│   ├── ui/           # Shared UI components
│   ├── eslint-config/ # Shared ESLint config
│   ├── typescript-config/ # Shared TypeScript config
│   └── shared/       # Shared types and utilities
├── package.json
├── pnpm-workspace.yaml
└── turbo.json
```

## 3. Setup Shared Packages

### 3.1. TypeScript Config
```bash
# Tạo package typescript-config
mkdir -p packages/typescript-config
cd packages/typescript-config
pnpm init

# Cài đặt dependencies
pnpm add -D typescript @types/node
```

### 3.2. ESLint Config
```bash
# Tạo package eslint-config
mkdir -p packages/eslint-config
cd packages/eslint-config
pnpm init

# Cài đặt dependencies
pnpm add -D eslint @typescript-eslint/parser @typescript-eslint/eslint-plugin
```

### 3.3. UI Package
```bash
# Tạo package ui
mkdir -p packages/ui
cd packages/ui
pnpm init

# Cài đặt dependencies
pnpm add @radix-ui/react-slot class-variance-authority clsx lucide-react next-themes react react-dom tailwind-merge tw-animate-css zod
pnpm add -D @tailwindcss/postcss @types/node @types/react @types/react-dom tailwindcss typescript
```

### 3.4. Shared Package
```bash
# Tạo package shared
mkdir -p packages/shared
cd packages/shared
pnpm init

# Cài đặt dependencies
pnpm add -D typescript @types/node
```

## 4. Setup Next.js Frontend

```bash
# Tạo Next.js app
cd apps
pnpm create next-app web --typescript --tailwind --eslint --app --src-dir --import-alias "@/*"

# Cài đặt dependencies
cd web
pnpm add @workspace/ui @workspace/eslint-config @workspace/typescript-config @workspace/shared
```

## 5. Setup NestJS Backend

```bash
# Tạo NestJS app
cd apps
pnpm dlx @nestjs/cli new api

# Cài đặt dependencies
cd api
pnpm add @workspace/shared @workspace/eslint-config @workspace/typescript-config
pnpm add -D @nestjs/cli @nestjs/schematics @nestjs/testing
```

### 5.1. Cấu hình NestJS

Tạo file `apps/api/nest-cli.json`:
```json
{
  "$schema": "https://json.schemastore.org/nest-cli",
  "collection": "@nestjs/schematics",
  "sourceRoot": "src",
  "compilerOptions": {
    "deleteOutDir": true,
    "webpack": true,
    "tsConfigPath": "tsconfig.json"
  }
}
```

### 5.2. Cấu hình TypeScript cho API

Tạo file `apps/api/tsconfig.json`:
```json
{
  "extends": "@workspace/typescript-config/base.json",
  "compilerOptions": {
    "module": "commonjs",
    "declaration": true,
    "removeComments": true,
    "emitDecoratorMetadata": true,
    "experimentalDecorators": true,
    "allowSyntheticDefaultImports": true,
    "target": "es2017",
    "sourceMap": true,
    "outDir": "./dist",
    "baseUrl": "./",
    "incremental": true,
    "skipLibCheck": true,
    "strictNullChecks": false,
    "noImplicitAny": false,
    "strictBindCallApply": false,
    "forceConsistentCasingInFileNames": false,
    "noFallthroughCasesInSwitch": false
  }
}
```

## 6. Cấu hình shadcn/ui

### 6.1. Khởi tạo shadcn
```bash
cd apps/web
pnpm dlx shadcn@latest init
```

Chọn các options sau:
- Style: new-york
- Base color: neutral
- CSS variables: Yes
- React Server Components: Yes
- Components directory: @/components
- Utils directory: @workspace/ui/lib/utils
- Include example components: No

### 6.2. Cài đặt tất cả components
```bash
pnpm dlx shadcn@latest add --all
```

## 7. Cấu hình Turborepo

Tạo file `turbo.json` ở root:
```json
{
  "$schema": "https://turbo.build/schema.json",
  "globalDependencies": ["**/.env.*local"],
  "pipeline": {
    "build": {
      "dependsOn": ["^build"],
      "outputs": [".next/**", "!.next/cache/**", "dist/**"]
    },
    "lint": {},
    "dev": {
      "cache": false,
      "persistent": true
    },
    "start": {
      "cache": false,
      "persistent": true
    }
  }
}
```

## 8. Cấu hình TypeScript

### 8.1. Root tsconfig.json
```json
{
  "compilerOptions": {
    "target": "es2017",
    "lib": ["dom", "dom.iterable", "esnext"],
    "allowJs": true,
    "skipLibCheck": true,
    "strict": true,
    "forceConsistentCasingInFileNames": true,
    "noEmit": true,
    "esModuleInterop": true,
    "module": "esnext",
    "moduleResolution": "node",
    "resolveJsonModule": true,
    "isolatedModules": true,
    "jsx": "preserve",
    "incremental": true,
    "plugins": [
      {
        "name": "next"
      }
    ],
    "paths": {
      "@/*": ["./src/*"]
    }
  },
  "include": ["next-env.d.ts", "**/*.ts", "**/*.tsx", ".next/types/**/*.ts"],
  "exclude": ["node_modules"]
}
```

## 9. Scripts

Thêm các scripts sau vào `package.json` ở root:
```json
{
  "scripts": {
    "build": "turbo run build",
    "dev": "turbo run dev",
    "lint": "turbo run lint",
    "format": "prettier --write \"**/*.{ts,tsx,md}\"",
    "start:web": "turbo run start --filter=web",
    "start:api": "turbo run start --filter=api"
  }
}
```

## 10. Chạy Project

```bash
# Cài đặt dependencies
pnpm install

# Chạy development servers
pnpm dev
```

## 11. Sử dụng Components

Trong Next.js app, import components từ UI package:
```typescript
import { Button } from '@workspace/ui/components/button'
import { Card } from '@workspace/ui/components/card'
```

## 12. API Endpoints

NestJS API sẽ chạy ở `http://localhost:3001` (mặc định). Bạn có thể thay đổi port trong `apps/api/src/main.ts`:

```typescript
async function bootstrap() {
  const app = await NestFactory.create(AppModule);
  await app.listen(3001);
}
```

## Lưu ý

1. Đảm bảo đã cài đặt pnpm globally:
```bash
npm install -g pnpm
```

2. Nếu gặp lỗi về workspace protocol, kiểm tra:
- File `pnpm-workspace.yaml` đã được tạo đúng
- Sử dụng pnpm thay vì npm
- Package.json của các workspace packages có đúng tên và version

3. Để thêm component mới:
```bash
pnpm dlx shadcn@latest add <component-name>
```

4. Để cập nhật tất cả components:
```bash
pnpm dlx shadcn@latest add --all
```

5. Để tạo module mới trong NestJS:
```bash
cd apps/api
pnpm dlx @nestjs/cli generate module <module-name>
```

6. Để tạo controller mới trong NestJS:
```bash
cd apps/api
pnpm dlx @nestjs/cli generate controller <controller-name>
```

7. Để tạo service mới trong NestJS:
```bash
cd apps/api
pnpm dlx @nestjs/cli generate service <service-name>
```

Bạn có thể:
Chạy cả frontend và backend cùng lúc với pnpm dev
Chạy riêng frontend với pnpm start:web
Chạy riêng backend với pnpm start:api
Chia sẻ code giữa frontend và backend thông qua package shared