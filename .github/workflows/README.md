# GitHub Actions Workflows

Ce répertoire contient tous les workflows CI/CD pour le projet Sportify.

## 📋 Workflows disponibles

### 1. **Backend CI** (`backend-ci.yml`)
Exécute les vérifications de qualité de code pour le backend :
- ✅ Lint & Format Check
- ✅ TypeScript Type Check
- ✅ Tests unitaires avec coverage
- ✅ Build
- ✅ Security Audit

**Déclencheurs :**
- Push sur `main` ou `develop`
- Pull requests vers `main` ou `develop`
- Changements dans `backend/**`

### 2. **Frontend CI** (`frontend-ci.yml`)
Exécute les vérifications de qualité de code pour le frontend Flutter :
- ✅ Analyze & Lint
- ✅ Unit Tests avec coverage
- ✅ Build Android APK
- ✅ Build iOS

**Déclencheurs :**
- Push sur `main` ou `develop`
- Pull requests vers `main` ou `develop`
- Changements dans `lib/**`, `test/**`, ou `pubspec.yaml`

### 3. **E2E Tests** (`e2e-tests.yml`)
Exécute les tests end-to-end :
- ✅ Backend E2E Tests avec base de données PostgreSQL

**Déclencheurs :**
- Push sur `main` ou `develop`
- Pull requests vers `main` ou `develop`
- Déclenchement manuel (`workflow_dispatch`)

### 4. **Deploy** (`deploy.yml`)
Déploie l'application en staging ou production :
- ✅ Deploy Backend (Render, Heroku)
- ✅ Deploy Frontend (Firebase Hosting, Netlify)
- ✅ Run database migrations

**Déclencheurs :**
- Push sur `main` (production)
- Déclenchement manuel avec choix d'environnement

### 4.1. **Deploy Environments** (`deploy-environments.yml`) 🌳
Workflow de déploiement en arbre avec trois environnements :

#### Structure en arbre :
```
Review (PR)
    ├── Backend
    └── Frontend

Staging (develop)
    ├── Backend
    └── Frontend

Production (main)
    ├── Backend (dépend de Staging)
    └── Frontend (dépend de Staging)
```

#### Environnements :

1. **Review** - Environnement de prévisualisation pour les Pull Requests
   - Déploiement automatique sur chaque PR
   - Commentaire automatique avec l'URL de prévisualisation
   - Nettoyage automatique lors de la fermeture du PR

2. **Staging** - Environnement de développement
   - Déploiement automatique sur push vers `develop`
   - Permet de tester les fonctionnalités avant la production
   - Déclenchement manuel possible

3. **Production** - Environnement de production
   - Déploiement automatique sur push vers `main`
   - **Dépend de Staging** : ne se déploie que si Staging est réussi
   - Migration de base de données automatique
   - Redémarrage des services après déploiement

**Déclencheurs :**
- Pull requests → Review
- Push sur `develop` → Staging
- Push sur `main` → Production (via Staging)
- Déclenchement manuel avec choix d'environnement

**Fonctionnalités :**
- ✅ Déploiement parallèle Backend/Frontend
- ✅ Résumé de déploiement avec statut de chaque environnement
- ✅ URLs de déploiement dans les environnements GitHub
- ✅ Commentaires automatiques sur les PRs

### 5. **Code Quality** (`code-quality.yml`)
Vérifications de qualité de code avancées :
- ✅ SonarCloud Scan
- ✅ Vérification des dépendances obsolètes
- ✅ Security vulnerabilities check

**Déclencheurs :**
- Push sur `main` ou `develop`
- Pull requests vers `main` ou `develop`
- Planifié chaque lundi à 9h UTC

### 6. **Dependency Review** (`dependency-review.yml`)
Examine les dépendances dans les pull requests :
- ✅ Vérifie les nouvelles dépendances
- ✅ Détecte les vulnérabilités
- ✅ Vérifie les licences

**Déclencheurs :**
- Pull requests vers `main` ou `develop`

### 7. **PR Checks** (`pr-checks.yml`)
Validations spécifiques aux pull requests :
- ✅ Vérification du format du titre PR (Conventional Commits)
- ✅ Détection de fichiers volumineux
- ✅ Détection de secrets dans le code

**Déclencheurs :**
- Pull requests (ouvert, synchronisé, réouvert, prêt pour review)

## 🔐 Secrets requis

Configurez ces secrets dans les paramètres GitHub (Settings > Secrets and variables > Actions) :

### Backend
- `DATABASE_URL` - URL de la base de données de production
- `STAGING_DATABASE_URL` - URL de la base de données de staging (optionnel)
- `RENDER_DEPLOY_HOOK_URL` - URL du webhook de déploiement Render Production (optionnel)
- `RENDER_STAGING_DEPLOY_HOOK_URL` - URL du webhook de déploiement Render Staging (optionnel)
- `RENDER_PRODUCTION_DEPLOY_HOOK_URL` - URL du webhook de déploiement Render Production (optionnel)
- `HEROKU_API_KEY` - Clé API Heroku Production (optionnel)
- `HEROKU_STAGING_API_KEY` - Clé API Heroku Staging (optionnel)
- `HEROKU_APP_NAME` - Nom de l'application Heroku Production (optionnel)
- `HEROKU_STAGING_APP_NAME` - Nom de l'application Heroku Staging (optionnel)
- `HEROKU_EMAIL` - Email du compte Heroku (optionnel)

### Frontend
- `FIREBASE_SERVICE_ACCOUNT` - Compte de service Firebase Production (optionnel)
- `FIREBASE_STAGING_SERVICE_ACCOUNT` - Compte de service Firebase Staging (optionnel)
- `FIREBASE_PROJECT_ID` - ID du projet Firebase Production (optionnel)
- `FIREBASE_STAGING_PROJECT_ID` - ID du projet Firebase Staging (optionnel)
- `NETLIFY_AUTH_TOKEN` - Token d'authentification Netlify Production (optionnel)
- `NETLIFY_STAGING_AUTH_TOKEN` - Token d'authentification Netlify Staging (optionnel)
- `NETLIFY_SITE_ID` - ID du site Netlify Production (optionnel)
- `NETLIFY_STAGING_SITE_ID` - ID du site Netlify Staging (optionnel)

### Qualité de code
- `SONAR_TOKEN` - Token SonarCloud (optionnel)
- `SNYK_TOKEN` - Token Snyk pour la sécurité (optionnel)

## 🚀 Utilisation

### Déclencher un déploiement manuel

#### Workflow Deploy (classique)
1. Allez dans l'onglet **Actions** de votre repository GitHub
2. Sélectionnez le workflow **Deploy**
3. Cliquez sur **Run workflow**
4. Choisissez l'environnement (staging ou production)
5. Cliquez sur **Run workflow**

#### Workflow Deploy Environments (en arbre)
1. Allez dans l'onglet **Actions** de votre repository GitHub
2. Sélectionnez le workflow **Deploy Environments**
3. Cliquez sur **Run workflow**
4. Choisissez l'environnement (review, staging, ou production)
5. Cliquez sur **Run workflow**

**Note :** Le déploiement en Production nécessite que Staging soit réussi ou ignoré.

### Vérifier le statut des workflows

Tous les workflows s'exécutent automatiquement sur les push et pull requests. Vous pouvez voir leur statut :
- Dans l'onglet **Actions** de GitHub
- Dans les checks des pull requests
- Via les badges de statut (à ajouter dans le README principal)

## 📊 Badges de statut

Ajoutez ces badges dans votre README principal :

```markdown
![Backend CI](https://github.com/votre-username/sportify/workflows/Backend%20CI/badge.svg)
![Frontend CI](https://github.com/votre-username/sportify/workflows/Frontend%20CI/badge.svg)
![E2E Tests](https://github.com/votre-username/sportify/workflows/E2E%20Tests/badge.svg)
```

## 🔧 Configuration locale

Pour tester les workflows localement, utilisez [act](https://github.com/nektos/act) :

```bash
# Installer act
brew install act  # macOS
# ou
curl https://raw.githubusercontent.com/nektos/act/master/install.sh | sudo bash

# Exécuter un workflow
act -j lint
act -j test
```

## 📝 Notes

- Les workflows utilisent des caches pour accélérer les builds
- Les tests s'exécutent en parallèle quand possible
- Les déploiements ne se font que sur la branche `main` ou via déclenchement manuel
- Les secrets sont nécessaires uniquement pour les fonctionnalités optionnelles

