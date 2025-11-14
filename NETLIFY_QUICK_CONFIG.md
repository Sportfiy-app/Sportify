# ⚡ Configuration Rapide Netlify - Sportify

## 🔧 Corrections à Apporter dans Netlify

### 1. Corriger le "Publish directory"

Dans Netlify → **Build & deploy settings** → **Build settings** :

**❌ Actuellement (incorrect) :**
- Publish directory: `flutter build web --release`

**✅ À corriger en :**
- Publish directory: `build/web`

### 2. Vérifier le "Build command"

**✅ Doit être :**
- Build command: `flutter build web --release`

### 3. Vérifier le "Base directory"

**✅ Doit être :**
- Base directory: (laisser vide)

## 🔐 Variables d'Environnement à Ajouter

Dans Netlify → **Environment variables** → Cliquez sur **"Add a variable"**

### Variables pour Staging (si vous créez un site séparé pour develop) :

```
ENVIRONMENT = staging
API_URL = https://staging-api.sportify.app
FLUTTER_VERSION = 3.24.0
NODE_VERSION = 20
```

### Variables pour Production (site actuel) :

```
ENVIRONMENT = production
API_URL = https://api.sportify.app
FLUTTER_VERSION = 3.24.0
NODE_VERSION = 20
```

## 📝 Configuration Actuelle de Votre Site

D'après les images, votre site Netlify :
- **Project name** : `gorgeous-pastelito-e03c7a`
- **Project ID** : `a814d4ba-063a-4f0f-b6a7-847d132f65e4`
- **Repository** : `github.com/Sportfiy-app/Sportify`
- **URL** : `gorgeous-pastelito-e03c7a.netlify.app`

## 🎯 Actions Immédiates

### Étape 1 : Corriger le Publish Directory

1. Allez dans **Build & deploy settings**
2. Dans **"Publish directory"**, remplacez `flutter build web --release` par `build/web`
3. Cliquez sur **"Save"**

### Étape 2 : Ajouter les Variables d'Environnement

1. Allez dans **Environment variables**
2. Cliquez sur **"Add a variable"**
3. Ajoutez chaque variable une par une :

**Variable 1 :**
- Key: `ENVIRONMENT`
- Value: `production`
- Scopes: Tous les scopes (All scopes)

**Variable 2 :**
- Key: `API_URL`
- Value: `https://api.sportify.app`
- Scopes: Tous les scopes

**Variable 3 :**
- Key: `FLUTTER_VERSION`
- Value: `3.24.0`
- Scopes: Tous les scopes

**Variable 4 :**
- Key: `NODE_VERSION`
- Value: `20`
- Scopes: Tous les scopes

### Étape 3 : Obtenir le Site ID pour GitHub Secrets

Le **Site ID** est le **Project ID** :
- **Site ID** : `a814d4ba-063a-4f0f-b6a7-847d132f65e4`

Ajoutez-le dans GitHub Secrets :
- `NETLIFY_SITE_ID=a814d4ba-063a-4f0f-b6a7-847d132f65e4`

### Étape 4 : Obtenir le Auth Token

1. Allez sur https://app.netlify.com/user/applications
2. Cliquez sur **"New access token"**
3. Nom : "GitHub Actions - Sportify Production"
4. Copiez le token
5. Ajoutez-le dans GitHub Secrets :
   - `NETLIFY_AUTH_TOKEN=votre-token-ici`

## 🔄 Test du Déploiement

Après avoir corrigé les paramètres :

1. **Déclencher un nouveau déploiement** :
   - Dans Netlify, allez dans **Deploys**
   - Cliquez sur **"Trigger deploy"** → **"Deploy site"**

2. **Ou pousser un commit** :
   ```bash
   git commit --allow-empty -m "Test Netlify deployment"
   git push origin main
   ```

3. **Vérifier les logs** :
   - Dans Netlify → **Deploys** → Cliquez sur le déploiement
   - Onglet **"Deploy log"** pour voir les détails

## ⚠️ Problèmes Courants

### Problème : "Publish directory" incorrect

**Symptôme** : Le build réussit mais le site affiche une erreur 404

**Solution** : Changez `flutter build web --release` en `build/web`

### Problème : Flutter non trouvé

**Symptôme** : Build échoue avec "flutter: command not found"

**Solution** : 
1. Ajoutez `FLUTTER_VERSION=3.24.0` dans Environment variables
2. Ou utilisez un build image avec Flutter pré-installé

### Problème : Les variables d'environnement ne sont pas disponibles

**Solution** : Utilisez `--dart-define` dans le build command :
```bash
flutter build web --release --dart-define=ENVIRONMENT=production --dart-define=API_URL=https://api.sportify.app
```

Mais avec `netlify.toml`, cela devrait être automatique.

## ✅ Checklist

- [ ] Publish directory corrigé : `build/web`
- [ ] Build command : `flutter build web --release`
- [ ] Base directory : (vide)
- [ ] Variables d'environnement ajoutées (4 variables)
- [ ] Site ID copié : `a814d4ba-063a-4f0f-b6a7-847d132f65e4`
- [ ] Auth Token créé et ajouté dans GitHub Secrets
- [ ] Premier déploiement testé
- [ ] Site accessible sur `gorgeous-pastelito-e03c7a.netlify.app`

## 🎉 Une fois Configuré

Votre site sera automatiquement déployé :
- Sur chaque push vers `main` → Production
- Sur chaque push vers `develop` → Staging (si vous créez un site séparé)
- Sur chaque Pull Request → Deploy Preview

Le workflow GitHub Actions `deploy-environments.yml` gérera automatiquement les déploiements Netlify !

