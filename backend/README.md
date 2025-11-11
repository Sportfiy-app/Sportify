# Sportify Backend (Express + Prisma)

Node.js + Express REST API powering Sportify (users, clubs, bookings, payments, notifications).

## Tech Stack

- Express 4
- PostgreSQL + Prisma ORM
- JWT auth (access + refresh tokens)
- Stripe Connect ready (payments)
- Zod validation, TypeScript, Jest

## Commands

```bash
npm install
npm run prisma:generate
npm run prisma:migrate:dev
npm run dev
```

## Project Structure

```
src/
  app.ts                # Express app configuration
  server.ts             # HTTP server bootstrap
  config/               # env configuration
  db/                   # Prisma client
  middleware/           # auth, error handling, validation
  modules/
    auth/               # register/login/refresh/logout
    users/              # profile endpoints
    clubs/              # club catalogue
    bookings/           # booking lifecycle
    payments/           # payment intents
    notifications/      # user notifications
    reviews/            # club reviews
  routes/               # aggregate routers
  types/                # express typings
```

## Environment Variables

| Key                     | Description                          |
| ----------------------- | ------------------------------------ |
| `DATABASE_URL`          | PostgreSQL connection string         |
| `JWT_ACCESS_SECRET`     | JWT secret for access tokens         |
| `JWT_REFRESH_SECRET`    | JWT secret for refresh tokens        |
| `JWT_ACCESS_TTL`        | Access token TTL (default `15m`)     |
| `JWT_REFRESH_TTL`       | Refresh token TTL (default `7d`)     |
| `PORT`                  | Server port (default `3333`)         |
| `STRIPE_SECRET_KEY`     | Stripe API key                       |
| `STRIPE_WEBHOOK_SECRET` | Stripe webhook signing secret        |

Create a `.env` file with the values above before running Prisma migrations.

## Docker

Build the backend image:

```bash
docker build -t sportify-backend ./backend
```

Local development stack (backend + Postgres):

```bash
docker compose -f docker-compose.dev.yml up --build
```

Production-like stack:

```bash
docker compose up --build -d
```

## GitHub Actions

Two workflows live under `.github/workflows/`:

- `backend-ci.yml` – runs on PRs/pushes, installs dependencies, generates the Prisma client, lints, and executes tests.
- `backend-deploy.yml` – builds the project and triggers Render or Heroku deployments. Provide secrets:
  - `RENDER_DEPLOY_HOOK_URL` (optional) to hit a Render deploy hook.
  - `HEROKU_APP_NAME` and `HEROKU_API_KEY` (optional) for Heroku container release.

## Secrets Management

- Local development uses `backend/.env` (not committed).
- Docker compose files load the same `.env` for container environment variables.
- CI/CD secrets are configured via GitHub repository secrets (Render deploy hook, Heroku credentials, Stripe keys, etc.).

