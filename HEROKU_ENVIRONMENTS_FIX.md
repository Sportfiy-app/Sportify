# 🔧 Guide de Configuration Heroku et Environnements GitHub

## 📍 Où ajouter les environnements GitHub

### Étape 1 : Accéder aux paramètres des environnements

1. **Allez sur GitHub** : `https://github.com/Sportfiy-app/Sportify`
2. **Cliquez sur "Settings"** (en haut à droite du repository)
3. **Dans le menu de gauche**, cliquez sur **"Environments"** (sous "Code and automation")
4. **Vous verrez la liste** : Production, Staging, Review, sportify-backend

### Étape 2 : Configurer les secrets pour chaque environnement

#### 🌐 Review Environment
1. Cliquez sur **"Review"**
2. Dans **"Environment secrets"**, cliquez sur **"Add environment secret"**
3. Ajoutez (si nécessaire) :
   - `NETLIFY_STAGING_AUTH_TOKEN` (réutilisé pour Review)
   - `NETLIFY_STAGING_SITE_ID` (réutilisé pour Review)

#### 🧪 Staging Environment
1. Cliquez sur **"Staging"**
2. Dans **"Environment secrets"**, cliquez sur **"Add environment secret"**
3. Ajoutez :
   - `HEROKU_STAGING_API_KEY` - Votre clé API Heroku
   - `HEROKU_STAGING_APP_NAME` - Nom de l'app Heroku staging (ex: `sportify-backend-staging`)
   - `NETLIFY_STAGING_AUTH_TOKEN` - Token Netlify
   - `NETLIFY_STAGING_SITE_ID` - ID du site Netlify

#### 🚀 Production Environment
1. Cliquez sur **"Production"**
2. Dans **"Environment secrets"**, cliquez sur **"Add environment secret"**
3. Ajoutez :
   - `HEROKU_API_KEY` - Votre clé API Heroku (déjà dans Organization secrets)
   - `HEROKU_APP_NAME` - `sportify-backend` (déjà dans Organization secrets)
   - `DATABASE_URL` - URL de la base de données Heroku (sera automatiquement fournie par Heroku)
   - `NETLIFY_AUTH_TOKEN` - Token Netlify production
   - `NETLIFY_SITE_ID` - ID du site Netlify production

### Étape 3 : Vérifier les secrets au niveau du Repository

1. Allez dans **Settings > Secrets and variables > Actions**
2. Vérifiez que ces secrets existent au niveau **Repository** ou **Organization** :
   - `HEROKU_API_KEY` ✅ (déjà dans Organization)
   - `HEROKU_APP_NAME` ✅ (déjà dans Organization)
   - `HEROKU_EMAIL` ✅ (déjà dans Organization)
   - `NETLIFY_STAGING_AUTH_TOKEN` (si utilisé)
   - `NETLIFY_STAGING_SITE_ID` (si utilisé)

## 🔧 Fix Heroku Buildpack Detection

Le problème "No default language could be detected" vient du fait que Heroku ne détecte pas automatiquement Node.js dans un monorepo.

### Solution : Créer un package.json à la racine

Un fichier `package.json` a été créé à la racine avec un script `heroku-postbuild` qui aidera Heroku à détecter le buildpack Node.js.

### Vérification de la configuration Heroku

1. **Vérifiez que le Procfile est à la racine** : `web: cd backend && npm start`
2. **Vérifiez que package.json est à la racine** : Il contient le script `heroku-postbuild`
3. **Vérifiez les variables d'environnement Heroku** :
   - Allez sur https://dashboard.heroku.com/apps/sportify-backend/settings
   - Cliquez sur "Reveal Config Vars"
   - Vérifiez que `DATABASE_URL` est présent (ajouté automatiquement par Heroku Postgres)

### Configuration de la base de données

La base de données Heroku Postgres est déjà configurée (`postgresql-encircled-97672`). Les migrations sont exécutées automatiquement par le workflow GitHub Actions.

### Test du backend

Pour vérifier que le backend fonctionne :

1. **Vérifiez les logs Heroku** :
   ```bash
   heroku logs --tail -a sportify-backend
   ```

2. **Vérifiez que l'app démarre** :
   ```bash
   heroku ps -a sportify-backend
   ```

3. **Testez l'endpoint health** :
   ```bash
   curl https://sportify-backend-f47b5a5fe209.herokuapp.com/health
   ```

## 📝 Checklist de Configuration

### ✅ Environnements GitHub
- [ ] Review environment créé et configuré
- [ ] Staging environment créé avec secrets
- [ ] Production environment créé avec secrets

### ✅ Secrets GitHub
- [ ] `HEROKU_API_KEY` dans Organization secrets
- [ ] `HEROKU_APP_NAME` dans Organization secrets  
- [ ] `HEROKU_EMAIL` dans Organization secrets
- [ ] `HEROKU_STAGING_API_KEY` dans Staging environment (si utilisé)
- [ ] `HEROKU_STAGING_APP_NAME` dans Staging environment (si utilisé)
- [ ] `NETLIFY_STAGING_AUTH_TOKEN` dans Staging environment (si utilisé)
- [ ] `NETLIFY_STAGING_SITE_ID` dans Staging environment (si utilisé)

### ✅ Configuration Heroku
- [ ] Procfile à la racine : `web: cd backend && npm start`
- [ ] package.json à la racine avec script `heroku-postbuild`
- [ ] Heroku Postgres addon installé
- [ ] Variables d'environnement configurées dans Heroku
- [ ] Dyno web démarré

### ✅ Base de données
- [ ] Heroku Postgres addon installé
- [ ] `DATABASE_URL` configuré automatiquement par Heroku
- [ ] Migrations Prisma exécutées (automatique via GitHub Actions)

