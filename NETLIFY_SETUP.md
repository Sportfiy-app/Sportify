# 🚀 Guide de Configuration Netlify pour Sportify

Ce guide vous explique comment configurer Netlify pour déployer automatiquement votre application Flutter.

## 📋 Prérequis

1. Un compte Netlify (gratuit) : https://app.netlify.com
2. Votre repository GitHub connecté à Netlify
3. Flutter installé et configuré

## 🔧 Configuration Initiale

### Étape 1 : Connecter GitHub à Netlify

1. Allez sur https://app.netlify.com
2. Cliquez sur **"Add new site"** → **"Import an existing project"**
3. Sélectionnez **"Deploy with GitHub"**
4. Autorisez Netlify à accéder à votre repository `Sportfiy-app/Sportify`
5. Sélectionnez le repository **Sportify**

### Étape 2 : Configurer les Paramètres de Build

Dans la page de configuration Netlify, configurez :

#### Pour Staging (develop branch) :
- **Branch to deploy** : `develop`
- **Base directory** : (laisser vide)
- **Build command** : `flutter build web --release`
- **Publish directory** : `build/web`

#### Pour Production (main branch) :
- **Branch to deploy** : `main`
- **Base directory** : (laisser vide)
- **Build command** : `flutter build web --release`
- **Publish directory** : `build/web`

### Étape 3 : Variables d'Environnement

Ajoutez les variables d'environnement dans Netlify :

#### Variables pour Staging :
```
FLUTTER_VERSION=3.24.0
NODE_VERSION=20
API_URL=https://staging-api.sportify.app
ENVIRONMENT=staging
```

#### Variables pour Production :
```
FLUTTER_VERSION=3.24.0
NODE_VERSION=20
API_URL=https://api.sportify.app
ENVIRONMENT=production
```

## 📁 Configuration via Fichier `netlify.toml`

Créez un fichier `netlify.toml` à la racine du projet pour une configuration versionnée :

```toml
[build]
  command = "flutter build web --release"
  publish = "build/web"

[build.environment]
  FLUTTER_VERSION = "3.24.0"
  NODE_VERSION = "20"

# Configuration pour la branche develop (Staging)
[context.develop]
  command = "flutter build web --release --dart-define=ENVIRONMENT=staging --dart-define=API_URL=https://staging-api.sportify.app"
  publish = "build/web"

# Configuration pour la branche main (Production)
[context.production]
  command = "flutter build web --release --dart-define=ENVIRONMENT=production --dart-define=API_URL=https://api.sportify.app"
  publish = "build/web"

# Configuration pour les Pull Requests (Review)
[context.deploy-preview]
  command = "flutter build web --release --dart-define=ENVIRONMENT=review"
  publish = "build/web"

# Headers de sécurité
[[headers]]
  for = "/*"
  [headers.values]
    X-Frame-Options = "DENY"
    X-XSS-Protection = "1; mode=block"
    X-Content-Type-Options = "nosniff"
    Referrer-Policy = "strict-origin-when-cross-origin"
    Permissions-Policy = "geolocation=(), microphone=(), camera=()"

# Redirections pour SPA Flutter
[[redirects]]
  from = "/*"
  to = "/index.html"
  status = 200
```

## 🔐 Secrets GitHub pour Netlify

Ajoutez ces secrets dans GitHub (Settings > Secrets and variables > Actions) :

### Pour Staging :
```
NETLIFY_STAGING_AUTH_TOKEN=your-staging-netlify-token
NETLIFY_STAGING_SITE_ID=your-staging-site-id
```

### Pour Production :
```
NETLIFY_AUTH_TOKEN=your-production-netlify-token
NETLIFY_SITE_ID=your-production-site-id
```

## 🔑 Obtenir les Tokens Netlify

### 1. Obtenir le Site ID

1. Allez sur votre site Netlify
2. **Site settings** → **General**
3. Copiez le **Site ID** (ex: `abc123-def456-ghi789`)

### 2. Obtenir le Auth Token

1. Allez sur https://app.netlify.com/user/applications
2. Cliquez sur **"New access token"**
3. Donnez un nom (ex: "GitHub Actions - Sportify")
4. Copiez le token (il ne sera affiché qu'une seule fois !)

## 🌐 Configuration des Domaines

### Staging
1. Allez sur **Site settings** → **Domain management**
2. Ajoutez un domaine personnalisé : `staging.sportify.app`
3. Configurez les DNS selon les instructions Netlify

### Production
1. Allez sur **Site settings** → **Domain management**
2. Ajoutez un domaine personnalisé : `sportify.app`
3. Configurez les DNS selon les instructions Netlify

## 🔄 Intégration avec GitHub Actions

Le workflow `deploy-environments.yml` est déjà configuré pour déployer automatiquement sur Netlify :

- **Staging** : Déploiement automatique sur push vers `develop`
- **Production** : Déploiement automatique sur push vers `main` (après Staging)
- **Review** : Déploiement automatique pour chaque Pull Request

## 📊 Vérification du Déploiement

### Vérifier les déploiements

1. **Dans Netlify** :
   - Allez sur votre dashboard Netlify
   - Cliquez sur votre site
   - Onglet **"Deploys"** pour voir l'historique

2. **Dans GitHub Actions** :
   - Allez sur **Actions**
   - Vérifiez le workflow **"Deploy Environments"**
   - Le job `🌿 Staging → Frontend (Netlify)` ou `🚀 Production → Frontend (Firebase)` devrait être vert

### Vérifier les logs

1. Dans Netlify, cliquez sur un déploiement
2. Onglet **"Deploy log"** pour voir les détails du build

## 🐛 Dépannage

### Problème : Build échoue avec "Flutter not found"

**Solution** :
1. Ajoutez cette variable d'environnement dans Netlify :
   ```
   FLUTTER_VERSION=3.24.0
   ```
2. Ou utilisez un build image avec Flutter pré-installé

### Problème : Les assets ne se chargent pas

**Solution** :
1. Vérifiez que `publish = "build/web"` dans `netlify.toml`
2. Vérifiez les chemins des assets dans votre code Flutter
3. Utilisez des chemins relatifs : `/assets/` au lieu de `assets/`

### Problème : Les routes ne fonctionnent pas (404)

**Solution** :
1. Ajoutez la redirection SPA dans `netlify.toml` :
   ```toml
   [[redirects]]
     from = "/*"
     to = "/index.html"
     status = 200
   ```

### Problème : Les variables d'environnement ne sont pas disponibles

**Solution** :
1. Utilisez `--dart-define` dans la commande de build :
   ```bash
   flutter build web --release --dart-define=API_URL=https://api.sportify.app
   ```
2. Accédez aux variables dans Flutter avec :
   ```dart
   const apiUrl = String.fromEnvironment('API_URL', defaultValue: 'https://api.sportify.app');
   ```

## 📝 Configuration Recommandée

### Structure des Sites Netlify

Créez **deux sites séparés** dans Netlify :

1. **Sportify Staging**
   - Branch : `develop`
   - URL : `staging.sportify.app`
   - Site ID : `NETLIFY_STAGING_SITE_ID`

2. **Sportify Production**
   - Branch : `main`
   - URL : `sportify.app`
   - Site ID : `NETLIFY_SITE_ID`

### Workflow Recommandé

```
1. Développement → Push vers feature branch
2. Pull Request → Review Environment (Netlify Deploy Preview)
3. Merge vers develop → Staging Environment (Netlify)
4. Tests sur Staging
5. Merge vers main → Production Environment (Netlify)
```

## 🔗 Liens Utiles

- **Netlify Dashboard** : https://app.netlify.com
- **Documentation Flutter Web** : https://docs.flutter.dev/deployment/web
- **Netlify Build Settings** : https://docs.netlify.com/configure-builds/overview/
- **Netlify Environment Variables** : https://docs.netlify.com/environment-variables/overview/

## ✅ Checklist de Configuration

- [ ] Compte Netlify créé
- [ ] Repository GitHub connecté
- [ ] Site Staging créé (branch `develop`)
- [ ] Site Production créé (branch `main`)
- [ ] `netlify.toml` créé à la racine
- [ ] Variables d'environnement configurées
- [ ] Tokens Netlify ajoutés dans GitHub Secrets
- [ ] Domaines personnalisés configurés
- [ ] Premier déploiement réussi
- [ ] Workflow GitHub Actions fonctionnel

## 🎉 Prochaines Étapes

Une fois la configuration terminée :

1. **Testez le déploiement Staging** :
   ```bash
   git checkout develop
   git commit --allow-empty -m "Test Netlify deployment"
   git push origin develop
   ```

2. **Vérifiez dans Netlify** que le déploiement se lance automatiquement

3. **Vérifiez dans GitHub Actions** que le workflow se déclenche

4. **Testez le déploiement Production** :
   ```bash
   git checkout main
   git merge develop
   git push origin main
   ```

Votre application Flutter sera maintenant déployée automatiquement sur Netlify ! 🚀

