# 🚀 Déclenchement Automatique des Workflows CI/CD

## Comment ça fonctionne

Les workflows GitHub Actions se déclenchent **automatiquement** lorsque vous poussez (`git push`) vers GitHub. Vous n'avez **rien à faire de spécial** !

## 📋 Workflow de Déclenchement

```
git add .                    # Ajouter les fichiers
git commit -m "message"      # Créer un commit
git push origin main         # ← Les workflows se déclenchent ICI automatiquement
```

## 🔄 Workflows qui se déclenchent automatiquement

### Sur Push vers `main` ou `develop` :

1. **Backend CI** (si changements dans `backend/`)
   - Lint & Format Check
   - TypeScript Type Check
   - Tests unitaires avec coverage
   - Build
   - Security Audit

2. **Frontend CI** (si changements dans `lib/`, `test/`, ou `pubspec.yaml`)
   - Analyze & Lint
   - Unit Tests avec coverage
   - Build Android APK
   - Build iOS

3. **E2E Tests**
   - Tests end-to-end avec base de données PostgreSQL

4. **Code Quality**
   - SonarCloud Scan
   - Vérification des dépendances
   - Security vulnerabilities check

5. **Deploy Environments**
   - **Sur `develop`** → Déploiement Staging
   - **Sur `main`** → Déploiement Production (après Staging)

### Sur Pull Request :

1. **Review Environment** → Déploiement automatique pour prévisualisation
2. Tous les workflows CI (Backend, Frontend, E2E, Code Quality)
3. **Dependency Review** → Vérification des nouvelles dépendances
4. **PR Checks** → Validation du format, détection de secrets

## 🎯 Hooks Git Locaux

Des hooks Git ont été configurés pour vous rappeler :

### `pre-push` hook
- S'exécute **avant** chaque `git push`
- Affiche quels workflows seront déclenchés
- Montre les fichiers modifiés
- Donne un lien vers l'onglet Actions de GitHub

### `post-commit` hook
- S'exécute **après** chaque `git commit`
- Rappelle de faire `git push` pour déclencher les workflows

## 📊 Voir les Workflows en Action

Après un `git push`, vous pouvez voir les workflows :

1. **Dans GitHub** :
   - Onglet **Actions** : https://github.com/Sportfiy-app/Sportify/actions
   - Onglet **Environments** : https://github.com/Sportfiy-app/Sportify/settings/environments

2. **Dans votre terminal** :
   - Le hook `pre-push` affiche un résumé avant le push

3. **Notifications GitHub** :
   - Vous recevrez des notifications si un workflow échoue
   - Les PRs affichent le statut des checks

## ⚙️ Configuration des Déclencheurs

Les workflows sont configurés dans `.github/workflows/*.yml` avec :

```yaml
on:
  push:
    branches: [main, develop]
  pull_request:
    branches: [main, develop]
```

Cela signifie qu'ils se déclenchent automatiquement sur :
- ✅ Push vers `main` ou `develop`
- ✅ Pull requests vers `main` ou `develop`
- ✅ Déclenchement manuel (`workflow_dispatch`)

## 🔍 Vérifier si un Workflow sera Déclenché

Pour vérifier quels workflows seront déclenchés :

1. **Voir les fichiers modifiés** :
   ```bash
   git diff --name-only origin/main..HEAD
   ```

2. **Voir les workflows configurés** :
   ```bash
   ls -la .github/workflows/
   ```

3. **Tester localement** (optionnel) :
   ```bash
   # Installer act (GitHub Actions local runner)
   brew install act
   
   # Tester un workflow
   act -j lint
   ```

## 🚨 Dépannage

### Les workflows ne se déclenchent pas ?

1. **Vérifiez que vous avez bien fait `git push`** :
   - Les workflows se déclenchent uniquement sur GitHub, pas localement

2. **Vérifiez la branche** :
   - Les workflows ne se déclenchent que sur `main` et `develop` par défaut

3. **Vérifiez les chemins** :
   - Backend CI : uniquement si changements dans `backend/`
   - Frontend CI : uniquement si changements dans `lib/`, `test/`, ou `pubspec.yaml`

4. **Vérifiez les permissions** :
   - Settings > Actions > General
   - Assurez-vous que "Workflow permissions" est configuré correctement

### Le hook pre-push ne fonctionne pas ?

1. **Vérifiez les permissions** :
   ```bash
   chmod +x .git/hooks/pre-push
   ```

2. **Vérifiez que le hook existe** :
   ```bash
   ls -la .git/hooks/pre-push
   ```

## 💡 Astuces

- **Commit fréquemment** : Chaque push déclenche les workflows
- **Vérifiez les Actions** : Consultez l'onglet Actions après chaque push
- **Utilisez les badges** : Ajoutez des badges de statut dans votre README
- **Notifications** : Activez les notifications GitHub pour être alerté des échecs

## 📝 Exemple Complet

```bash
# 1. Modifier des fichiers
echo "test" >> backend/src/test.ts

# 2. Ajouter au staging
git add backend/src/test.ts

# 3. Créer un commit
git commit -m "Add test file"

# 4. Le hook post-commit rappelle de push
# ✅ Commit created successfully!
# 💡 Next steps:
#    1. git push origin <branch>
#    2. CI/CD workflows will automatically trigger on GitHub

# 5. Pousser vers GitHub
git push origin main

# 6. Le hook pre-push affiche les workflows qui seront déclenchés
# 🚀 Preparing to push to GitHub...
# 📦 Branch: main
# ✅ CI/CD Workflows that will be triggered:
#   ✓ Backend CI (lint, test, build)
#   ✓ Deploy Environments → Production
#   ✓ E2E Tests
#   ✓ Code Quality Checks

# 7. Les workflows s'exécutent automatiquement sur GitHub
# 8. Consultez https://github.com/Sportfiy-app/Sportify/actions
```

## 🎉 Résumé

**Vous n'avez qu'à faire `git push` !** Les workflows CI/CD se déclenchent automatiquement. Les hooks Git vous rappellent et vous informent, mais le déclenchement est entièrement automatique.

