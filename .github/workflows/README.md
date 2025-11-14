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
- `RENDER_DEPLOY_HOOK_URL` - URL du webhook de déploiement Render (optionnel)
- `HEROKU_API_KEY` - Clé API Heroku (optionnel)
- `HEROKU_APP_NAME` - Nom de l'application Heroku (optionnel)
- `HEROKU_EMAIL` - Email du compte Heroku (optionnel)

### Frontend
- `FIREBASE_SERVICE_ACCOUNT` - Compte de service Firebase (optionnel)
- `FIREBASE_PROJECT_ID` - ID du projet Firebase (optionnel)
- `NETLIFY_AUTH_TOKEN` - Token d'authentification Netlify (optionnel)
- `NETLIFY_SITE_ID` - ID du site Netlify (optionnel)

### Qualité de code
- `SONAR_TOKEN` - Token SonarCloud (optionnel)
- `SNYK_TOKEN` - Token Snyk pour la sécurité (optionnel)

## 🚀 Utilisation

### Déclencher un déploiement manuel

1. Allez dans l'onglet **Actions** de votre repository GitHub
2. Sélectionnez le workflow **Deploy**
3. Cliquez sur **Run workflow**
4. Choisissez l'environnement (staging ou production)
5. Cliquez sur **Run workflow**

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

