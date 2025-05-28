# TalentLabs Assignment – Deploy Repository

This repository serves as the unified deployment layer for the TalentLabs Full Stack Assignment.  
It integrates the **frontend (Vue 3)** and **backend (Django)** applications using Docker Compose, ensuring reproducible and portable development environments.

## Project Structure

```text
.
├── .env                    # Environment variables for Docker Compose (dev only)
├── .gitmodules             # Git submodule declarations
├── docker-compose.yml      # Main Compose file to spin up services
├── bin/                    # Custom scripts (update submodules, nginx, etc.)
├── talentLabs_assignment_be/  # Backend submodule (Django)
├── talentLabs_assignment_fe/  # Frontend submodule (Vue 3 + Nginx)
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

If you cloned without `--recurse-submodules`, you can run:

```bash
git submodule update --init --recursive
```

### 2. Set up environment variables

Create a `.env` file in the root directory:

```env
# .env – development only
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

This will:

- Start the TimescaleDB container
- Start the Django API container
- Run migrations and seed sample data
- Build and serve the frontend via Nginx

Access the application at:

- Frontend: [http://localhost:5173](http://localhost:5173)
- Backend: [http://localhost:8000](http://localhost:8000)

> The frontend communicates with the backend via Nginx reverse proxy (`/api` path).
> http://localhost is equivalent to http://127.0.0.1. You may access via either depending on your system.

### 4. View API Documentation

Once the backend is running, open:

[http://localhost:8000/api/docs](http://localhost:8000/api/docs)

This provides an interactive Swagger UI for exploring available API endpoints.

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

You can log in via the `/api/auth/pair` endpoint.

## Common Commands

Update submodules to latest commits:

```bash
./bin/update_submodules.sh
```

Stop all services:

```bash
docker compose down
```

## Notes

- Django is served using the development server. For production, consider using Gunicorn or Uvicorn.
- Nginx handles static file delivery and proxying `/api/` to the backend container.
- Each submodule is maintained as an independent repository and versioned separately.

## License

```
MIT – for assignment evaluation only.
```