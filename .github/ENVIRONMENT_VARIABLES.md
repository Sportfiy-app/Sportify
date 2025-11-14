# 🔐 Variables d'Environnement - Guide Complet

Ce document liste toutes les variables d'environnement nécessaires pour le déploiement de Sportify.

## 📋 Variables par Environnement

### 🌿 Review Environment (Pull Requests)

**Netlify (via GitHub Actions) :**
- `ENVIRONMENT=review`
- `API_URL=https://review-api.sportify.app`

**GitHub Secrets :**
- `NETLIFY_STAGING_AUTH_TOKEN` - Token Netlify pour les Deploy Previews
- `NETLIFY_STAGING_SITE_ID` - Site ID Netlify pour les Deploy Previews

### 🌿 Staging Environment (develop branch)

**Netlify :**
- `ENVIRONMENT=staging`
- `API_URL=https://staging-api.sportify.app`
- `FLUTTER_VERSION=3.24.0`
- `NODE_VERSION=20`

**GitHub Secrets :**
- `NETLIFY_STAGING_AUTH_TOKEN` - Token Netlify pour Staging
- `NETLIFY_STAGING_SITE_ID` - Site ID Netlify pour Staging
- `STAGING_DATABASE_URL` - URL de la base de données Staging (pour backend)
- `HEROKU_STAGING_API_KEY` - Clé API Heroku pour Staging
- `HEROKU_STAGING_APP_NAME` - Nom de l'app Heroku Staging
- `RENDER_STAGING_DEPLOY_HOOK_URL` - Webhook Render pour Staging
- `FIREBASE_STAGING_SERVICE_ACCOUNT` - Compte Firebase Staging (optionnel)
- `FIREBASE_STAGING_PROJECT_ID` - ID du projet Firebase Staging (optionnel)

**Netlify Environment Variables (dans Netlify Dashboard) :**
```
ENVIRONMENT=staging
API_URL=https://staging-api.sportify.app
FLUTTER_VERSION=3.24.0
NODE_VERSION=20
```

### 🚀 Production Environment (main branch)

**Netlify :**
- `ENVIRONMENT=production`
- `API_URL=https://api.sportify.app`
- `FLUTTER_VERSION=3.24.0`
- `NODE_VERSION=20`

**GitHub Secrets :**
- `NETLIFY_AUTH_TOKEN` - Token Netlify pour Production
- `NETLIFY_SITE_ID` - Site ID Netlify pour Production
- `DATABASE_URL` - URL de la base de données Production
- `HEROKU_API_KEY` - Clé API Heroku pour Production
- `HEROKU_APP_NAME` - Nom de l'app Heroku Production
- `HEROKU_EMAIL` - Email du compte Heroku
- `RENDER_PRODUCTION_DEPLOY_HOOK_URL` - Webhook Render pour Production
- `FIREBASE_SERVICE_ACCOUNT` - Compte Firebase Production (optionnel)
- `FIREBASE_PROJECT_ID` - ID du projet Firebase Production (optionnel)

**Netlify Environment Variables (dans Netlify Dashboard) :**
```
ENVIRONMENT=production
API_URL=https://api.sportify.app
FLUTTER_VERSION=3.24.0
NODE_VERSION=20
```

## 🔧 Configuration dans GitHub

### Repository Secrets

Allez dans **Settings > Secrets and variables > Actions** et ajoutez :

#### Backend
```bash
# Production
DATABASE_URL=postgresql://user:pass@host:5432/db
HEROKU_API_KEY=your-heroku-api-key
HEROKU_APP_NAME=sportify-backend
HEROKU_EMAIL=your-email@example.com
RENDER_PRODUCTION_DEPLOY_HOOK_URL=https://api.render.com/...

# Staging
STAGING_DATABASE_URL=postgresql://user:pass@host:5432/db_staging
HEROKU_STAGING_API_KEY=your-staging-heroku-key
HEROKU_STAGING_APP_NAME=sportify-backend-staging
RENDER_STAGING_DEPLOY_HOOK_URL=https://api.render.com/...
```

#### Frontend
```bash
# Production
NETLIFY_AUTH_TOKEN=your-netlify-token
NETLIFY_SITE_ID=your-netlify-site-id
FIREBASE_SERVICE_ACCOUNT={"type":"service_account",...}
FIREBASE_PROJECT_ID=your-firebase-project-id

# Staging
NETLIFY_STAGING_AUTH_TOKEN=your-staging-netlify-token
NETLIFY_STAGING_SITE_ID=your-staging-netlify-site-id
FIREBASE_STAGING_SERVICE_ACCOUNT={"type":"service_account",...}
FIREBASE_STAGING_PROJECT_ID=your-staging-firebase-project-id
```

## 🔧 Configuration dans Netlify

### Pour chaque site Netlify

1. Allez sur votre site dans Netlify
2. **Site settings** → **Environment variables**
3. Ajoutez les variables :

#### Site Staging
```
ENVIRONMENT=staging
API_URL=https://staging-api.sportify.app
FLUTTER_VERSION=3.24.0
NODE_VERSION=20
```

#### Site Production
```
ENVIRONMENT=production
API_URL=https://api.sportify.app
FLUTTER_VERSION=3.24.0
NODE_VERSION=20
```

## 🔧 Configuration dans Heroku

### Pour chaque app Heroku

1. Allez sur votre app dans Heroku
2. **Settings** → **Config Vars**
3. Ajoutez les variables nécessaires

#### App Staging
```
NODE_ENV=production
DATABASE_URL=postgresql://...
JWT_ACCESS_SECRET=...
JWT_REFRESH_SECRET=...
TWILIO_ACCOUNT_SID=...
TWILIO_AUTH_TOKEN=...
TWILIO_VERIFY_SERVICE_SID=...
SMTP_HOST=smtp.gmail.com
SMTP_PORT=587
SMTP_USER=...
SMTP_PASSWORD=...
SMTP_FROM=...
FRONTEND_URL=https://staging.sportify.app
```

#### App Production
```
NODE_ENV=production
DATABASE_URL=postgresql://...
JWT_ACCESS_SECRET=...
JWT_REFRESH_SECRET=...
TWILIO_ACCOUNT_SID=...
TWILIO_AUTH_TOKEN=...
TWILIO_VERIFY_SERVICE_SID=...
SMTP_HOST=smtp.gmail.com
SMTP_PORT=587
SMTP_USER=...
SMTP_PASSWORD=...
SMTP_FROM=...
FRONTEND_URL=https://sportify.app
```

## 📝 Utilisation dans Flutter

Dans votre code Flutter, accédez aux variables d'environnement :

```dart
// Dans main.dart ou config
const String environment = String.fromEnvironment(
  'ENVIRONMENT',
  defaultValue: 'development',
);

const String apiUrl = String.fromEnvironment(
  'API_URL',
  defaultValue: 'http://localhost:3333',
);

// Utilisation
final apiClient = ApiClient(baseUrl: apiUrl);
```

## 🔍 Vérification

### Vérifier les variables GitHub

```bash
# Les secrets GitHub ne peuvent pas être listés via CLI
# Vérifiez dans GitHub : Settings > Secrets and variables > Actions
```

### Vérifier les variables Netlify

```bash
# Via Netlify CLI
npm install -g netlify-cli
netlify login
netlify env:list --site YOUR_SITE_ID
```

### Vérifier les variables Heroku

```bash
heroku config -a sportify-backend
heroku config -a sportify-backend-staging
```

## 🚨 Sécurité

### ⚠️ Ne jamais commiter :

- Les tokens d'API
- Les clés secrètes
- Les mots de passe
- Les URLs de base de données avec credentials

### ✅ Utiliser toujours :

- GitHub Secrets pour les workflows
- Netlify Environment Variables pour les builds
- Heroku Config Vars pour les apps
- `.env` local (dans `.gitignore`)

## 📚 Références

- [GitHub Secrets](https://docs.github.com/en/actions/security-guides/encrypted-secrets)
- [Netlify Environment Variables](https://docs.netlify.com/environment-variables/overview/)
- [Heroku Config Vars](https://devcenter.heroku.com/articles/config-vars)
- [Flutter Environment Variables](https://docs.flutter.dev/deployment/environment-variables)

