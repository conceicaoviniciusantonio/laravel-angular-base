# ConnectorManager - Roadmap

## [ ] Phase 1: Environment Setup
- [ ] 1.1 Create Laravel backend skeleton inside /backend
- [ ] 1.2 Create Angular frontend skeleton inside /frontend
- [ ] 1.3 Install and configure Nebular UI in the Angular project
- [ ] 1.4 Create root docker-compose.yml to run both + MySQL

## [ ] Phase 2: Core Features (Connectors CRUD)
- [ ] 2.1 Create connectors table migration and Model in Laravel
- [ ] 2.2 Create ConnectorController with basic API endpoints (index, store)
- [ ] 2.3 Create ConnectorService in Angular to consume the API
- [ ] 2.4 Create ConnectorListComponent in Angular using Nebular components (`<nb-card>`, `<nb-table>`)

## [ ] Phase 3: Authentication & Security
- [ ] 3.1 Configure Laravel Sanctum for API token generation
- [ ] 3.2 Create AuthController and Login route in Laravel
- [ ] 3.3 Create AuthService and Nebular-styled LoginComponent in Angular
- [ ] 3.4 Implement Angular HttpInterceptor and AuthGuard