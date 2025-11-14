#!/bin/bash

# Script de déploiement Heroku pour Sportify Backend

set -e

echo "🚀 Déploiement sur Heroku..."

# Vérifier que Heroku CLI est installé
if ! command -v heroku &> /dev/null; then
    echo "❌ Heroku CLI n'est pas installé. Installez-le avec: brew install heroku"
    exit 1
fi

# Vérifier que nous sommes connectés
if ! heroku auth:whoami &> /dev/null; then
    echo "❌ Vous n'êtes pas connecté à Heroku. Exécutez: heroku login"
    exit 1
fi

# Nom de l'app (peut être modifié)
APP_NAME=${1:-sportify}

echo "📦 App: $APP_NAME"

# Vérifier si l'app existe
if ! heroku apps:info -a $APP_NAME &> /dev/null; then
    echo "⚠️  L'app $APP_NAME n'existe pas. Création..."
    heroku create $APP_NAME
    echo "✅ App créée: https://$APP_NAME.herokuapp.com"
fi

# Vérifier PostgreSQL
echo "🗄️  Vérification de PostgreSQL..."
if ! heroku addons:info -a $APP_NAME | grep -q "heroku-postgresql"; then
    echo "📦 Ajout de PostgreSQL..."
    heroku addons:create heroku-postgresql:essential-0 -a $APP_NAME
    echo "✅ PostgreSQL ajouté"
else
    echo "✅ PostgreSQL déjà configuré"
fi

# Build
echo "🔨 Build du projet..."
npm run build

# Déploiement
echo "📤 Déploiement..."
git add .
git commit -m "Deploy to Heroku" || true
git push heroku main || git push heroku master

# Migrations
echo "🔄 Exécution des migrations..."
heroku run npx prisma migrate deploy -a $APP_NAME

# Génération Prisma Client
echo "🔧 Génération du client Prisma..."
heroku run npx prisma generate -a $APP_NAME

# Redémarrage
echo "🔄 Redémarrage de l'app..."
heroku restart -a $APP_NAME

# Vérification
echo "✅ Vérification..."
sleep 5
curl -f https://$APP_NAME.herokuapp.com/health || echo "⚠️  L'endpoint /health ne répond pas encore"

echo ""
echo "🎉 Déploiement terminé!"
echo "📱 URL: https://$APP_NAME.herokuapp.com"
echo "📊 Logs: heroku logs --tail -a $APP_NAME"

