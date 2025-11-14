# 🚀 CI/CD & Testing - Sportify

## 📋 Vue d'ensemble

Ce projet utilise GitHub Actions pour automatiser les tests, la validation du code, et le déploiement. Tous les workflows sont configurés pour afficher clairement ce qui fonctionne et ce qui ne fonctionne pas.

## 🧪 Tests disponibles

### Backend Tests (6 fichiers de tests)

1. **Authentication** (`auth.service.spec.ts`)
   - ✅ User Registration
   - ✅ User Login
   - ✅ Token Management

2. **User Management** (`users.service.spec.ts`)
   - ✅ Get User Profile
   - ✅ Update User Profile
   - ✅ Upload Avatar

3. **Events** (`events.service.spec.ts`)
   - ✅ Create Event
   - ✅ Get Events
   - ✅ Join/Leave Event
   - ✅ Waiting List Management

4. **Posts** (`posts.service.spec.ts`)
   - ✅ Create Post
   - ✅ Get Posts
   - ✅ Like/Unlike Post
   - ✅ Add Comments

5. **Verification** (`verification.service.spec.ts`)
   - ✅ SMS Verification
   - ✅ Email Verification

6. **Subscriptions** (`subscriptions.service.spec.ts`)
   - ✅ Create Subscription
   - ✅ Get Subscription
   - ✅ Cancel Subscription

### Integration Tests

- **API Tests** (`test/integration/api.spec.ts`)
  - Tests complets des endpoints API
  - Tests avec authentification
  - Tests de validation

## 📊 Workflows GitHub Actions (10 workflows)

1. **Backend CI** - Tests, lint, build backend
2. **Frontend CI** - Tests, analyze, build Flutter
3. **E2E Tests** - Tests end-to-end
4. **Functional Tests** - Tests fonctionnels complets
5. **Deploy** - Déploiement automatique
6. **Code Quality** - Analyse de qualité
7. **Dependency Review** - Revue des dépendances
8. **PR Checks** - Validation des PRs
9. **Test Report** - Génération de rapports
10. **Backend Deploy** - Déploiement backend (legacy)

## 🔍 Comment voir les résultats

### Dans GitHub

1. **Onglet Actions**
   - Voir tous les workflows
   - Voir le statut de chaque workflow
   - Voir les logs détaillés

2. **Test Summary**
   - Résumé visuel dans chaque workflow
   - Tableau des fonctionnalités testées
   - Statut de chaque feature

3. **Artifacts**
   - Télécharger les rapports de coverage
   - Télécharger les résultats de tests
   - Télécharger les builds

### Résumé visuel

Chaque workflow génère automatiquement un résumé avec :

```
## 🧪 Backend Test Results

### 📊 Test Coverage by Feature

| Feature | Status | Tests |
|---------|--------|-------|
| 🔐 Authentication | ✅ | auth.service.spec.ts |
| 👤 User Management | ✅ | users.service.spec.ts |
| 📅 Events | ✅ | events.service.spec.ts |
| 📝 Posts | ✅ | posts.service.spec.ts |
| 📧 Verification | ✅ | verification.service.spec.ts |
| 💳 Subscriptions | ✅ | subscriptions.service.spec.ts |

### 🔗 API Integration Tests
- ✅ Register User
- ✅ Login User
- ✅ Get User Profile
- ✅ Create Event
- ✅ Create Post
```

## 🚀 Exécution locale

### Backend

```bash
cd backend

# Tous les tests
npm test

# Tests avec coverage
npm run test:coverage

# Tests d'intégration
npm test -- --testPathPattern=integration

# Tests d'un service spécifique
npm test -- auth.service.spec.ts
```

### Frontend

```bash
# Tous les tests
flutter test

# Tests avec coverage
flutter test --coverage
```

## ✅ Fonctionnalités testées

Voir `FUNCTIONAL_STATUS.md` pour la liste complète des fonctionnalités testées et leur statut.

## 📈 Coverage

- **Backend Services** : > 80% coverage
- **API Endpoints** : Tous testés
- **Integration Tests** : 10+ tests

## 🔄 Mise à jour automatique

Les workflows s'exécutent automatiquement sur :
- Push vers `main` ou `develop`
- Pull requests vers `main` ou `develop`
- Déclenchement manuel (workflow_dispatch)

## 📚 Documentation

- `TESTING_GUIDE.md` - Guide complet des tests
- `FUNCTIONAL_STATUS.md` - Statut des fonctionnalités
- `CI_CD_SETUP.md` - Configuration CI/CD
- `.github/workflows/README.md` - Documentation des workflows

## 🆘 Support

Si les tests échouent :
1. Vérifiez les logs dans GitHub Actions
2. Testez localement avec les mêmes commandes
3. Consultez `TESTING_GUIDE.md` pour le dépannage

