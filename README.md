# LaravelAngularBase

A monorepo base for building applications with Laravel + Angular. Decoupled architecture: Laravel serves a REST API only, Angular is an independent SPA.

## Tech Stack

| Camada | Tecnologia |
|---|---|
| Backend | Laravel 12+ / PHP 8.4 (API only) |
| Frontend | Angular 21+ / TypeScript (SPA) |
| UI | Nebular UI |
| Banco de dados | MySQL 8.0 |
| Ambiente | Docker + Docker Compose |

## Estrutura do Projeto

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

## Pré-requisitos

- [Docker](https://docs.docker.com/get-docker/) 24+
- [Docker Compose](https://docs.docker.com/compose/) v2+

Não é necessário ter PHP, Node ou Composer instalados localmente.

## Subindo o projeto

### 1. Clone o repositório

```bash
git clone <url-do-repo> meu-projeto
cd meu-projeto
```

### 2. Build das imagens

```bash
docker compose build
```

### 3. Subir os containers

```bash
docker compose up
```

Na primeira execução o backend vai automaticamente:
- Copiar `.env.example` → `.env`
- Configurar a conexão MySQL
- Executar `composer install`
- Gerar o `APP_KEY`
- Executar as migrations

Aguarde até ver as mensagens abaixo nos logs antes de acessar:

```
laravel_angular_base_backend  | Starting Laravel development server: http://0.0.0.0:8000
laravel_angular_base_frontend | ✔ Compiled successfully.
```

### 4. Acessar

| Serviço | URL |
|---|---|
| Frontend (Angular) | http://localhost:4200 |
| Backend (Laravel API) | http://localhost:8000 |
| Banco de dados (MySQL) | localhost:3306 |

## Comandos úteis

### Containers

```bash
# Subir em background
docker compose up -d

# Ver logs em tempo real
docker compose logs -f

# Parar e remover containers
docker compose down

# Rebuild após mudanças no Dockerfile
docker compose build --no-cache
```

### Backend (Laravel)

```bash
# Executar um comando artisan
docker compose exec backend php artisan <comando>

# Criar uma migration
docker compose exec backend php artisan make:migration create_products_table

# Criar um model com migration e controller
docker compose exec backend php artisan make:model Product -mc

# Rodar migrations manualmente
docker compose exec backend php artisan migrate

# Abrir o Tinker (REPL)
docker compose exec backend php artisan tinker

# Instalar um pacote Composer
docker compose exec backend composer require <pacote>
```

### Frontend (Angular)

```bash
# Gerar um componente
docker compose exec frontend ng generate component nome-do-componente

# Gerar um serviço
docker compose exec frontend ng generate service nome-do-servico

# Rodar os testes
docker compose exec frontend ng test

# Instalar um pacote npm
docker compose exec frontend npm install <pacote>
```

## Variáveis de ambiente

As variáveis de ambiente do backend são definidas no `docker-compose.yml` e sobrescrevem automaticamente o `.env` na inicialização. Para customizar, edite a seção `environment` do serviço `backend`:

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

O arquivo `.env` gerado localmente em `backend/.env` pode ser editado diretamente para configurações adicionais (como mail, queue, cache).

## Renomeando o projeto

Este repositório usa `laravel-angular-base` / `LaravelAngularBase` / `laravel_angular_base` como nome genérico. Para renomear:

```bash
# Substituição global (Linux/macOS)
grep -rl "laravel-angular-base" . --include="*" | xargs sed -i 's/laravel-angular-base/meu-projeto/g'
grep -rl "LaravelAngularBase" . --include="*" | xargs sed -i 's/LaravelAngularBase/MeuProjeto/g'
grep -rl "laravel_angular_base" . --include="*" | xargs sed -i 's/laravel_angular_base/meu_projeto/g'
```

Arquivos a revisar após renomear:
- `docker-compose.yml` — nomes dos containers e banco de dados
- `frontend/package.json` e `angular.json` — nome do projeto Angular
- `frontend/src/index.html` — título da página
- `backend/.env` — `DB_DATABASE`
