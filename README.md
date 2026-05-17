# LaravelAngularBase

A monorepo base for building applications with Laravel + Angular. Decoupled architecture: Laravel serves a REST API only, Angular is an independent SPA.

## Tech Stack

| Layer | Technology |
|---|---|
| Backend | Laravel 12+ / PHP 8.4 (API only) |
| Frontend | Angular 21+ / TypeScript (SPA) |
| Database | MySQL 8.0 |
| Environment | Docker + Docker Compose |

## Project Structure

```text
laravel-angular-base/
├── backend/               # Laravel API (PHP)
│   ├── app/
│   ├── routes/
│   ├── docker-entrypoint.sh
│   └── Dockerfile
├── frontend/              # Angular SPA
│   ├── src/
│   └── Dockerfile
├── docker-compose.yml
└── README.md
```

## Prerequisites

- [Docker](https://docs.docker.com/get-docker/) 24+
- [Docker Compose](https://docs.docker.com/compose/) v2+

No local PHP, Node, or Composer installation required.

## Getting Started

### 1. Clone the repository

```bash
git clone <repo-url> my-project
cd my-project
```

### 2. Build the images

```bash
docker compose build
```

### 3. Start the containers

```bash
docker compose up
```

On the first run, the backend will automatically:
- Copy `.env.example` to `.env`
- Configure the MySQL connection
- Run `composer install`
- Generate the `APP_KEY`
- Run database migrations

Wait until you see the following messages in the logs before accessing:

```
laravel_angular_base_backend  | Starting Laravel development server: http://0.0.0.0:8000
laravel_angular_base_frontend | ✔ Compiled successfully.
```

### 4. Access

| Service | URL |
|---|---|
| Frontend (Angular) | http://localhost:4200 |
| Backend (Laravel API) | http://localhost:8000 |
| Database (MySQL) | localhost:3306 |

## Useful Commands

### Containers

```bash
# Start in background
docker compose up -d

# Stream logs
docker compose logs -f

# Stop and remove containers
docker compose down

# Rebuild after Dockerfile changes
docker compose build --no-cache
```

### Backend (Laravel)

```bash
# Run an artisan command
docker compose exec backend php artisan <command>

# Create a migration
docker compose exec backend php artisan make:migration create_products_table

# Create a model with migration and controller
docker compose exec backend php artisan make:model Product -mc

# Run migrations manually
docker compose exec backend php artisan migrate

# Open Tinker (REPL)
docker compose exec backend php artisan tinker

# Install a Composer package
docker compose exec backend composer require <package>
```

### Frontend (Angular)

```bash
# Generate a component
docker compose exec frontend ng generate component component-name

# Generate a service
docker compose exec frontend ng generate service service-name

# Run unit tests
docker compose exec frontend ng test

# Install an npm package
docker compose exec frontend npm install <package>
```

## Environment Variables

Backend environment variables are defined in `docker-compose.yml` and are automatically written to `.env` on startup. To customize, edit the `environment` section of the `backend` service:

```yaml
environment:
  APP_ENV: local
  APP_DEBUG: "true"
  DB_CONNECTION: mysql
  DB_HOST: db
  DB_PORT: 3306
  DB_DATABASE: laravel_angular_base
  DB_USERNAME: app_user
  DB_PASSWORD: secret
```

The generated `backend/.env` file can be edited directly for additional settings (mail, queue, cache, etc.).

## Renaming the Project

This repository uses `laravel-angular-base` / `LaravelAngularBase` / `laravel_angular_base` as a generic placeholder. To rename:

```bash
# Global replacement (Linux/macOS)
grep -rl "laravel-angular-base" . --include="*" | xargs sed -i 's/laravel-angular-base/my-project/g'
grep -rl "LaravelAngularBase" . --include="*" | xargs sed -i 's/LaravelAngularBase/MyProject/g'
grep -rl "laravel_angular_base" . --include="*" | xargs sed -i 's/laravel_angular_base/my_project/g'
```

Files to review after renaming:
- `docker-compose.yml` — container names and database name
- `frontend/package.json` and `angular.json` — Angular project name
- `frontend/src/index.html` — page title
- `backend/.env` — `DB_DATABASE`
