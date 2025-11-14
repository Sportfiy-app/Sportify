# 🧪 Guide de Tests - Sportify

Ce guide explique comment exécuter et comprendre les tests de l'application Sportify.

## 📋 Vue d'ensemble des tests

### Backend Tests

#### Tests unitaires (Services)
- ✅ `auth.service.spec.ts` - Tests d'authentification
- ✅ `users.service.spec.ts` - Tests de gestion utilisateur
- ✅ `events.service.spec.ts` - Tests de gestion d'événements
- ✅ `posts.service.spec.ts` - Tests de gestion de posts
- ✅ `verification.service.spec.ts` - Tests de vérification SMS/Email
- ✅ `subscriptions.service.spec.ts` - Tests d'abonnements

#### Tests d'intégration (API)
- ✅ `api.spec.ts` - Tests des endpoints API complets

### Frontend Tests

#### Tests Flutter
- Tests unitaires des contrôleurs
- Tests des widgets
- Tests d'intégration des flows

## 🚀 Exécution des tests

### Backend

```bash
cd backend

# Tous les tests
npm test

# Tests avec coverage
npm run test:coverage

# Tests en mode watch
npm run test:watch

# Tests d'intégration uniquement
npm test -- --testPathPattern=integration

# Tests d'un fichier spécifique
npm test -- auth.service.spec.ts
```

### Frontend

```bash
# Tous les tests
flutter test

# Tests avec coverage
flutter test --coverage

# Tests d'un fichier spécifique
flutter test test/register_controller_test.dart
```

## 📊 Rapports de tests

### Dans GitHub Actions

Les workflows CI/CD génèrent automatiquement :
1. **Test Summary** - Résumé dans l'onglet Actions
2. **Coverage Reports** - Uploadés vers Codecov
3. **Functional Test Report** - Rapport détaillé des fonctionnalités testées

### Localement

```bash
# Backend - Coverage HTML
cd backend
npm run test:coverage
open coverage/lcov-report/index.html

# Frontend - Coverage HTML
flutter test --coverage
genhtml coverage/lcov.info -o coverage/html
open coverage/html/index.html
```

## ✅ Fonctionnalités testées

### Authentication & User Management
- [x] **User Registration** - Création de compte avec validation
- [x] **User Login** - Authentification avec email/password
- [x] **Token Refresh** - Renouvellement des tokens
- [x] **Get User Profile** - Récupération du profil utilisateur
- [x] **Update User Profile** - Mise à jour du profil
- [x] **Upload Avatar** - Upload d'image de profil

### Events Management
- [x] **Create Event** - Création d'événement avec tous les champs
- [x] **Get Events** - Liste des événements avec pagination
- [x] **Get Event by ID** - Détails d'un événement
- [x] **Join Event** - Rejoindre un événement
- [x] **Leave Event** - Quitter un événement
- [x] **Waiting List** - Gestion de la liste d'attente

### Posts Management
- [x] **Create Post** - Création de post (texte, image, événement)
- [x] **Get Posts** - Liste des posts avec filtres
- [x] **Get Post by ID** - Détails d'un post
- [x] **Like Post** - Liker/unliker un post
- [x] **Add Comment** - Ajouter un commentaire
- [x] **Get Comments** - Liste des commentaires

### Verification
- [x] **Send SMS Code** - Envoi de code SMS via Twilio
- [x] **Verify SMS Code** - Vérification du code SMS
- [x] **Send Email Verification** - Envoi d'email de vérification
- [x] **Verify Email** - Vérification du token email

### Subscriptions
- [x] **Create Subscription** - Création d'abonnement (monthly/annual)
- [x] **Get Subscription** - Récupération de l'abonnement
- [x] **Cancel Subscription** - Annulation d'abonnement
- [x] **Check Premium Status** - Vérification du statut premium

## 🔍 Comprendre les résultats

### Dans GitHub Actions

1. **Onglet Actions** - Voir le statut de tous les workflows
2. **Test Summary** - Résumé visuel des tests dans chaque workflow
3. **Artifacts** - Télécharger les rapports détaillés

### Statuts

- ✅ **Passed** - Tous les tests passent
- ❌ **Failed** - Certains tests échouent
- ⚠️ **Skipped** - Tests ignorés
- ⏱️ **Timeout** - Tests qui ont pris trop de temps

## 🐛 Dépannage

### Les tests échouent localement

1. **Vérifiez la base de données** :
   ```bash
   # Assurez-vous que PostgreSQL est démarré
   # Vérifiez DATABASE_URL dans .env
   ```

2. **Réinstallez les dépendances** :
   ```bash
   cd backend
   rm -rf node_modules package-lock.json
   npm install
   ```

3. **Générez Prisma client** :
   ```bash
   npx prisma generate
   ```

### Les tests échouent dans CI

1. **Vérifiez les logs** dans GitHub Actions
2. **Comparez avec les tests locaux**
3. **Vérifiez les variables d'environnement** dans les workflows

## 📈 Améliorer la couverture

### Ajouter de nouveaux tests

1. Créez un fichier `*.spec.ts` dans le même dossier que le service
2. Importez le service et les mocks nécessaires
3. Écrivez les tests avec `describe` et `it`
4. Exécutez les tests : `npm test`

### Exemple

```typescript
import { MyService } from './my.service';

describe('MyService', () => {
  it('should do something', async () => {
    const service = new MyService();
    const result = await service.doSomething();
    expect(result).toBeDefined();
  });
});
```

## 🎯 Bonnes pratiques

1. **Tests isolés** - Chaque test doit être indépendant
2. **Mocks appropriés** - Utilisez des mocks pour les dépendances externes
3. **Noms descriptifs** - Utilisez des noms clairs pour les tests
4. **Coverage** - Viser au moins 80% de couverture
5. **Tests rapides** - Les tests doivent s'exécuter rapidement

## 📚 Ressources

- [Jest Documentation](https://jestjs.io/docs/getting-started)
- [Flutter Testing](https://docs.flutter.dev/testing)
- [Supertest Documentation](https://github.com/visionmedia/supertest)

