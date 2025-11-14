# 🚀 Guide de configuration CI/CD

Ce guide explique comment configurer et utiliser les workflows CI/CD GitHub Actions pour Sportify.

## 📋 Vue d'ensemble

Le projet utilise GitHub Actions pour automatiser :
- ✅ Tests et validation du code
- ✅ Build et compilation
- ✅ Analyse de qualité de code
- ✅ Déploiement automatique
- ✅ Détection de vulnérabilités

## 🔧 Configuration initiale

### 1. Secrets GitHub

Allez dans **Settings > Secrets and variables > Actions** et ajoutez les secrets suivants :

#### Backend
```bash
DATABASE_URL=postgresql://user:password@host:port/database
RENDER_DEPLOY_HOOK_URL=https://api.render.com/deploy/srv-xxx
HEROKU_API_KEY=your-heroku-api-key
HEROKU_APP_NAME=your-app-name
HEROKU_EMAIL=your-email@example.com
```

#### Frontend
```bash
FIREBASE_SERVICE_ACCOUNT={"type":"service_account",...}
FIREBASE_PROJECT_ID=your-project-id
NETLIFY_AUTH_TOKEN=your-netlify-token
NETLIFY_SITE_ID=your-site-id
```

#### Qualité de code (optionnel)
```bash
SONAR_TOKEN=your-sonar-token
SNYK_TOKEN=your-snyk-token
```

### 2. Branches protégées

Configurez les branches protégées dans **Settings > Branches** :

- **main** : Require pull request reviews, Require status checks to pass
- **develop** : Require pull request reviews

## 📊 Workflows disponibles

### Backend CI
**Fichier :** `.github/workflows/backend-ci.yml`

Exécute automatiquement sur chaque push/PR :
- Lint & Format Check
- TypeScript Type Check
- Tests unitaires avec coverage
- Build
- Security Audit

**Commande locale :**
```bash
cd backend
npm run ci
```

### Frontend CI
**Fichier :** `.github/workflows/frontend-ci.yml`

Exécute automatiquement sur chaque push/PR :
- Analyze & Lint
- Unit Tests avec coverage
- Build Android APK
- Build iOS

**Commande locale :**
```bash
flutter analyze
flutter test --coverage
flutter build apk --release
```

### E2E Tests
**Fichier :** `.github/workflows/e2e-tests.yml`

Exécute les tests end-to-end avec une base de données PostgreSQL.

**Commande locale :**
```bash
cd backend
npm run test:e2e
```

### Deploy
**Fichier :** `.github/workflows/deploy.yml`

Déploie automatiquement sur `main` ou manuellement via GitHub Actions.

**Déclenchement manuel :**
1. Allez dans **Actions > Deploy**
2. Cliquez sur **Run workflow**
3. Choisissez l'environnement (staging/production)

### Code Quality
**Fichier :** `.github/workflows/code-quality.yml`

Exécute des vérifications de qualité avancées :
- SonarCloud Scan
- Vérification des dépendances obsolètes
- Security vulnerabilities check

### Dependency Review
**Fichier :** `.github/workflows/dependency-review.yml`

Examine automatiquement les dépendances dans les PRs.

### PR Checks
**Fichier :** `.github/workflows/pr-checks.yml`

Valide les pull requests :
- Format du titre (Conventional Commits)
- Détection de fichiers volumineux
- Détection de secrets

## 🧪 Tests locaux

### Backend

```bash
cd backend

# Lint
npm run lint:check

# Format check
npm run format:check

# Type check
npm run type-check

# Tests
npm test

# Tests avec coverage
npm run test:coverage

# Tests E2E
npm run test:e2e

# Tout en une commande
npm run ci
```

### Frontend

```bash
# Analyze
flutter analyze

# Format check
flutter format --set-exit-if-changed .

# Tests
flutter test

# Tests avec coverage
flutter test --coverage

# Build Android
flutter build apk --release

# Build iOS
flutter build ios --release --no-codesign
```

## 📈 Coverage

Les rapports de coverage sont automatiquement uploadés vers Codecov :
- Backend : `backend/coverage/lcov.info`
- Frontend : `coverage/lcov.info`

Voir les rapports sur [Codecov](https://codecov.io) (si configuré).

## 🔍 Dépannage

### Les workflows échouent

1. **Vérifiez les logs** dans l'onglet Actions
2. **Testez localement** avec les mêmes commandes
3. **Vérifiez les secrets** dans Settings > Secrets
4. **Vérifiez les dépendances** avec `npm ci` et `flutter pub get`

### Les tests échouent

1. **Vérifiez la base de données** : Les tests utilisent PostgreSQL
2. **Vérifiez les variables d'environnement** dans les workflows
3. **Exécutez les tests localement** pour reproduire l'erreur

### Les builds échouent

1. **Vérifiez les versions** : Node.js 20, Flutter 3.24.0
2. **Vérifiez les dépendances** : `npm ci` pour une installation propre
3. **Vérifiez les caches** : Les workflows utilisent des caches

## 🎯 Bonnes pratiques

### Commits

Utilisez [Conventional Commits](https://www.conventionalcommits.org/) :
```
feat: add user authentication
fix: resolve login bug
docs: update README
style: format code
refactor: improve code structure
test: add unit tests
chore: update dependencies
```

### Pull Requests

1. **Titre** : Utilisez le format Conventional Commits
2. **Description** : Décrivez clairement les changements
3. **Tests** : Assurez-vous que tous les tests passent
4. **Review** : Demandez une review avant de merger

### Déploiement

1. **Ne déployez jamais directement sur main** : Utilisez des PRs
2. **Testez en staging** avant la production
3. **Vérifiez les migrations** de base de données
4. **Surveillez les logs** après déploiement

## 📚 Ressources

- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [Flutter CI/CD](https://docs.flutter.dev/deployment/ci)
- [Node.js CI/CD](https://docs.github.com/en/actions/automating-builds-and-tests/building-and-testing-nodejs)
- [Conventional Commits](https://www.conventionalcommits.org/)

## 🆘 Support

Si vous rencontrez des problèmes :
1. Vérifiez les logs dans GitHub Actions
2. Testez localement avec les mêmes commandes
3. Consultez la documentation GitHub Actions
4. Créez une issue avec les détails du problème

