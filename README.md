# TalentLabs Assignment - Deploy Repository

This repository coordinates the deployment of both the frontend (Vue 3) and backend (Django) projects via Docker Compose.

## Project Structure
```text
.
├── .env # Environment variables for Docker Compose
├── .gitmodules # Git submodule declarations
├── docker-compose.yml # Main Compose file to spin up services
├── bin/ # Custom scripts (update sub module and nginx, etc.)
├── talentLabs_assignment_be/ # Backend submodule (Django)
├── talentLabs_assignment_fe/ # Frontend submodule (Vue 3 + Nginx)
```

## Requirements

- Docker
- Docker Compose
- Git (with submodule support)


## Getting Started

### 1. Clone this repository (with submodules)

```bash
git clone --recurse-submodules https://github.com/pili2026/talentlabs_assignment_deploy.git
cd talentlabs_assignment_deploy
```
If you forgot `--recurse-submodules`, run:
```bash
git submodule update --init --recursive
```

### 2. Set up environment variables
Create a .env file in the root directory:
```env
VITE_API_BASE=/api
POSTGRES_DB=talentlabs
POSTGRES_USER=admin
POSTGRES_PASSWORD=admin123
DB_HOST=timescaledb
DB_PORT=5432
```

### 3. Run with Docker Compose
```bash
docker compose up --build
```

* The backend will be available at: http://localhost:8000
* The frontend will be available at: http://localhost:5173

> The frontend communicates with the backend via Nginx reverse proxy (/api path).

## Services
| Name          | Description                 | Port |
| ------------- | --------------------------- | ---- |
| `frontend`    | Vue 3 app served by Nginx   | 5173 |
| `backend`     | Django backend (dev server) | 8000 |
| `timescaledb` | PostgreSQL with TimescaleDB | 5432 |


## Test Account
| Username | Password | Role      |
| -------- | -------- | --------- |
| admin    | admin123 | Superuser |

You can log in via the /api/auth/pair endpoint.

## Common Commands
Update submodules to latest commits:
```bash
./bin/update_submodules.sh
```

Stop all services:
```bash
docker compose down
```

## Note
* Django is served using the development server. Consider using gunicorn or uvicorn for production.
* Nginx handles static file delivery and proxying /api/ to the backend.
* The submodules must be maintained separately.

## License
```
MIT – for assignment evaluation only.
```