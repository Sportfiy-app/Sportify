# 📧 Configuration de l'envoi d'email

Ce guide vous explique comment configurer l'envoi d'emails de vérification avec nodemailer.

## Options de configuration

### Option 1 : Gmail (Recommandé pour les tests)

Gmail permet d'utiliser un "Mot de passe d'application" pour l'authentification SMTP.

#### Étapes :

1. **Activez la validation en 2 étapes** sur votre compte Gmail
   - Allez dans [Paramètres Google](https://myaccount.google.com/)
   - Sécurité > Validation en deux étapes

2. **Générez un mot de passe d'application**
   - Allez dans [Mots de passe des applications](https://myaccount.google.com/apppasswords)
   - Sélectionnez "Autre (nom personnalisé)" et entrez "Sportify"
   - Copiez le mot de passe généré (16 caractères)

3. **Ajoutez ces variables dans votre `.env`** :
```env
SMTP_HOST=smtp.gmail.com
SMTP_PORT=587
SMTP_USER=votre-email@gmail.com
SMTP_PASSWORD=votre-mot-de-passe-d-application
SMTP_FROM=Sportify <votre-email@gmail.com>
FRONTEND_URL=http://localhost:3000
```

### Option 2 : SendGrid (Recommandé pour la production)

SendGrid est un service professionnel d'envoi d'emails.

#### Étapes :

1. **Créez un compte** sur [SendGrid](https://sendgrid.com/)

2. **Créez une clé API**
   - Allez dans Settings > API Keys
   - Créez une nouvelle clé avec les permissions "Mail Send"

3. **Ajoutez ces variables dans votre `.env`** :
```env
SMTP_HOST=smtp.sendgrid.net
SMTP_PORT=587
SMTP_USER=apikey
SMTP_PASSWORD=votre-clé-api-sendgrid
SMTP_FROM=Sportify <noreply@sportify.app>
FRONTEND_URL=https://votre-domaine.com
```

### Option 3 : Mailtrap (Recommandé pour le développement)

Mailtrap est un service de test qui capture les emails sans les envoyer réellement.

#### Étapes :

1. **Créez un compte** sur [Mailtrap](https://mailtrap.io/)

2. **Créez une boîte de test** et récupérez les identifiants SMTP

3. **Ajoutez ces variables dans votre `.env`** :
```env
SMTP_HOST=smtp.mailtrap.io
SMTP_PORT=2525
SMTP_USER=votre-username-mailtrap
SMTP_PASSWORD=votre-password-mailtrap
SMTP_FROM=Sportify <noreply@sportify.app>
FRONTEND_URL=http://localhost:3000
```

### Option 4 : Autre service SMTP

Vous pouvez utiliser n'importe quel service SMTP (Outlook, Yahoo, votre propre serveur, etc.).

#### Variables requises :
```env
SMTP_HOST=votre-serveur-smtp.com
SMTP_PORT=587  # ou 465 pour SSL
SMTP_USER=votre-email@exemple.com
SMTP_PASSWORD=votre-mot-de-passe
SMTP_FROM=Sportify <noreply@sportify.app>
FRONTEND_URL=https://votre-domaine.com
```

## Configuration du fichier `.env`

Ajoutez ces variables à votre fichier `.env` à la racine du dossier `backend` :

```env
# Email Configuration
SMTP_HOST=smtp.gmail.com
SMTP_PORT=587
SMTP_USER=votre-email@gmail.com
SMTP_PASSWORD=votre-mot-de-passe
SMTP_FROM=Sportify <noreply@sportify.app>
FRONTEND_URL=http://localhost:3000
```

## Vérification

Après avoir configuré les variables, redémarrez le serveur backend :

```bash
npm run dev
```

Vous devriez voir :
```
✅ Email service initialized
```

Si vous voyez `⚠️ Email credentials not found`, vérifiez que toutes les variables sont correctement définies dans votre `.env`.

## Mode développement

Si les variables d'email ne sont pas configurées, le système fonctionnera en mode développement :
- Les emails seront loggés dans la console
- Le token de vérification sera affiché pour faciliter les tests
- Aucun email réel ne sera envoyé

## Test de l'envoi d'email

1. **Lancez le serveur backend** avec les variables configurées
2. **Testez l'inscription** dans l'application Flutter
3. **Vérifiez votre boîte email** (ou Mailtrap si vous l'utilisez)
4. **Cliquez sur le lien de vérification** dans l'email

## Dépannage

### Erreur "Email service configuration error"
- Vérifiez que `SMTP_HOST`, `SMTP_PORT`, `SMTP_USER`, et `SMTP_PASSWORD` sont correctement définis
- Vérifiez que le port est correct (587 pour TLS, 465 pour SSL)
- Pour Gmail, assurez-vous d'utiliser un "Mot de passe d'application" et non votre mot de passe Gmail

### Les emails ne sont pas reçus
- Vérifiez votre dossier spam
- Vérifiez que `SMTP_FROM` est une adresse email valide
- Vérifiez les logs du serveur pour voir les erreurs éventuelles

### En mode développement
- Les emails sont loggés dans la console avec le token
- Le token est aussi retourné dans la réponse API pour faciliter les tests

## Production

Pour la production :
1. Utilisez un service professionnel (SendGrid, Mailgun, AWS SES, etc.)
2. Configurez `FRONTEND_URL` avec votre domaine de production
3. Assurez-vous que `SMTP_FROM` est une adresse email vérifiée
4. Testez l'envoi d'emails avant de déployer

