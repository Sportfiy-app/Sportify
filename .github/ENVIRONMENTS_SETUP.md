# 🌳 Configuration des Environnements de Déploiement

Ce guide explique comment configurer les environnements GitHub Actions pour le workflow de déploiement en arbre.

## 📋 Vue d'ensemble

Le workflow `deploy-environments.yml` utilise trois environnements GitHub :
- **Review** - Pour les Pull Requests
- **Staging** - Pour la branche `develop`
- **Production** - Pour la branche `main`

## 🔧 Configuration des Environnements GitHub

### Étape 1 : Accéder aux paramètres des environnements

1. Allez dans votre repository GitHub
2. Cliquez sur **Settings** (Paramètres)
3. Dans le menu de gauche, cliquez sur **Environments** (Environnements)
4. Vous verrez une liste des environnements utilisés dans vos workflows

### Étape 2 : Créer les environnements

Si les environnements n'existent pas encore, ils seront créés automatiquement lors du premier déploiement. Sinon, vous pouvez les créer manuellement :

1. Cliquez sur **New environment** (Nouvel environnement)
2. Entrez le nom de l'environnement (ex: `Review`, `Staging`, `Production`)
3. Cliquez sur **Configure environment** (Configurer l'environnement)

### Étape 3 : Configurer chaque environnement

#### 🌐 Review Environment

**Configuration recommandée :**
- **Deployment branches** : Toutes les branches (pour les PRs)
- **Required reviewers** : Aucun (déploiement automatique)
- **Wait timer** : 0 minutes
- **Prevent self-review** : Désactivé

**Secrets spécifiques (optionnel) :**
- `REVIEW_DEPLOY_URL` - URL de base pour les déploiements de review

#### 🧪 Staging Environment

**Configuration recommandée :**
- **Deployment branches** : `develop` uniquement
- **Required reviewers** : 0-1 reviewer (selon votre équipe)
- **Wait timer** : 0 minutes
- **Prevent self-review** : Activé (recommandé)

**Secrets spécifiques :**
- `STAGING_DATABASE_URL` - URL de la base de données de staging
- `RENDER_STAGING_DEPLOY_HOOK_URL` - Webhook Render pour staging
- `HEROKU_STAGING_API_KEY` - Clé API Heroku staging
- `HEROKU_STAGING_APP_NAME` - Nom de l'app Heroku staging
- `FIREBASE_STAGING_SERVICE_ACCOUNT` - Compte Firebase staging
- `FIREBASE_STAGING_PROJECT_ID` - ID du projet Firebase staging
- `NETLIFY_STAGING_AUTH_TOKEN` - Token Netlify staging
- `NETLIFY_STAGING_SITE_ID` - ID du site Netlify staging

#### 🚀 Production Environment

**Configuration recommandée :**
- **Deployment branches** : `main` uniquement
- **Required reviewers** : 1-2 reviewers (recommandé pour la production)
- **Wait timer** : 5-10 minutes (pour permettre l'annulation en cas d'erreur)
- **Prevent self-review** : Activé (obligatoire)

**Secrets spécifiques :**
- `DATABASE_URL` - URL de la base de données de production
- `RENDER_PRODUCTION_DEPLOY_HOOK_URL` - Webhook Render pour production
- `HEROKU_API_KEY` - Clé API Heroku production
- `HEROKU_APP_NAME` - Nom de l'app Heroku production
- `FIREBASE_SERVICE_ACCOUNT` - Compte Firebase production
- `FIREBASE_PROJECT_ID` - ID du projet Firebase production
- `NETLIFY_AUTH_TOKEN` - Token Netlify production
- `NETLIFY_SITE_ID` - ID du site Netlify production

## 🔐 Configuration des Secrets

### Secrets au niveau du Repository

Ces secrets sont partagés entre tous les environnements :

1. Allez dans **Settings > Secrets and variables > Actions**
2. Cliquez sur **New repository secret**
3. Ajoutez les secrets suivants :

```bash
# Heroku (partagé)
HEROKU_EMAIL=your-email@example.com

# GitHub (automatique)
GITHUB_TOKEN (créé automatiquement)
```

### Secrets au niveau des Environnements

Ces secrets sont spécifiques à chaque environnement :

1. Allez dans **Settings > Environments**
2. Cliquez sur l'environnement (ex: `Production`)
3. Dans la section **Environment secrets**, cliquez sur **Add secret**
4. Ajoutez les secrets spécifiques à cet environnement

**Exemple pour Production :**
```bash
DATABASE_URL=postgresql://user:pass@host:5432/db
HEROKU_API_KEY=your-production-heroku-key
HEROKU_APP_NAME=sportify-backend
RENDER_PRODUCTION_DEPLOY_HOOK_URL=https://api.render.com/...
```

**Exemple pour Staging :**
```bash
STAGING_DATABASE_URL=postgresql://user:pass@host:5432/db_staging
HEROKU_STAGING_API_KEY=your-staging-heroku-key
HEROKU_STAGING_APP_NAME=sportify-backend-staging
RENDER_STAGING_DEPLOY_HOOK_URL=https://api.render.com/...
```

## 🌳 Structure du Workflow en Arbre

```
┌─────────────────────────────────────────┐
│         Pull Request                    │
│         (Review Environment)            │
├─────────────────────────────────────────┤
│  ┌─────────────┐    ┌─────────────┐   │
│  │   Backend   │    │  Frontend    │   │
│  │   Review    │    │   Review     │   │
│  └─────────────┘    └─────────────┘   │
└─────────────────────────────────────────┘
              │
              ▼
┌─────────────────────────────────────────┐
│      Push to develop                     │
│      (Staging Environment)               │
├─────────────────────────────────────────┤
│  ┌─────────────┐    ┌─────────────┐   │
│  │   Backend   │    │  Frontend    │   │
│  │   Staging   │    │   Staging    │   │
│  └─────────────┘    └─────────────┘   │
└─────────────────────────────────────────┘
              │
              ▼ (dépendance)
┌─────────────────────────────────────────┐
│      Push to main                       │
│      (Production Environment)            │
├─────────────────────────────────────────┤
│  ┌─────────────┐    ┌─────────────┐   │
│  │   Backend   │    │  Frontend    │   │
│  │ Production  │    │  Production │   │
│  └─────────────┘    └─────────────┘   │
└─────────────────────────────────────────┘
```

## 📊 URLs des Environnements

Le workflow configure automatiquement les URLs dans les environnements GitHub :

- **Review** : `https://review-pr-{PR_NUMBER}.sportify.app`
- **Staging** : `https://staging.sportify.app` (frontend) / `https://staging-api.sportify.app` (backend)
- **Production** : `https://sportify.app` (frontend) / `https://api.sportify.app` (backend)

Ces URLs apparaissent dans :
- L'onglet **Environments** de GitHub
- Les commentaires automatiques sur les PRs
- Le résumé de déploiement dans GitHub Actions

## ✅ Vérification de la Configuration

### Test 1 : Vérifier les environnements

1. Allez dans **Settings > Environments**
2. Vérifiez que les trois environnements existent : `Review`, `Staging`, `Production`

### Test 2 : Vérifier les secrets

1. Pour chaque environnement, vérifiez que les secrets nécessaires sont configurés
2. Les secrets au niveau du repository sont accessibles à tous les environnements
3. Les secrets au niveau des environnements sont spécifiques à chaque environnement

### Test 3 : Tester le déploiement

1. Créez une Pull Request → Devrait déclencher le déploiement Review
2. Mergez vers `develop` → Devrait déclencher le déploiement Staging
3. Mergez vers `main` → Devrait déclencher le déploiement Production (après Staging)

## 🔍 Dépannage

### Problème : L'environnement n'apparaît pas

**Solution :** Les environnements sont créés automatiquement lors du premier déploiement. Si vous voulez les créer manuellement, allez dans **Settings > Environments** et créez-les.

### Problème : Les secrets ne sont pas trouvés

**Solution :** Vérifiez que :
1. Les secrets sont bien configurés dans **Settings > Secrets and variables > Actions**
2. Les secrets d'environnement sont configurés dans **Settings > Environments > [Environment Name]**
3. Les noms des secrets correspondent exactement à ceux utilisés dans le workflow

### Problème : Le déploiement Production ne se déclenche pas

**Solution :** Vérifiez que :
1. Le déploiement Staging a réussi (Production dépend de Staging)
2. Vous êtes sur la branche `main`
3. Les reviewers requis ont approuvé (si configuré)

### Problème : Les URLs ne s'affichent pas

**Solution :** Vérifiez que les steps de déploiement définissent correctement `outputs.url` dans le workflow.

## 📝 Notes Importantes

1. **Sécurité** : Les secrets d'environnement sont plus sécurisés que les secrets de repository car ils sont isolés par environnement
2. **Reviewers** : Configurez des reviewers pour Production pour éviter les déploiements accidentels
3. **Wait Timer** : Utilisez un timer pour Production pour permettre l'annulation en cas d'erreur
4. **Dépendances** : Production dépend de Staging, donc Staging doit être configuré même si vous ne l'utilisez pas activement

## 🚀 Prochaines Étapes

1. Configurez les environnements dans GitHub
2. Ajoutez les secrets nécessaires
3. Testez avec une Pull Request
4. Vérifiez les déploiements dans l'onglet **Environments** de GitHub

