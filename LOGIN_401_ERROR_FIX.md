# 🔍 Diagnostic et Solution : Erreur 401 (Unauthorized) lors de la Connexion

## 📋 Problème

L'erreur `401 (Unauthorized)` se produit lors de la tentative de connexion depuis le frontend :
```
POST https://sportify-backend-f47b5a5fe209.herokuapp.com/api/auth/login 401 (Unauthorized)
```

## 🔎 Causes Possibles

### 1. **Email ou Mot de Passe Incorrect** ⚠️ (Cause la plus probable)

Le backend retourne `401 Invalid credentials` dans deux cas :
- L'email n'existe pas dans la base de données
- Le mot de passe ne correspond pas au hash stocké

**Solution :**
- Vérifiez que l'utilisateur existe dans la base de données
- Vérifiez que le mot de passe est correct
- Si vous venez de créer un compte, assurez-vous d'utiliser le même email et mot de passe

### 2. **Validation Zod Échoue**

Le schéma de validation exige :
- `email`: doit être un email valide
- `password`: minimum 8 caractères

**Vérification :**
```typescript
// backend/src/modules/auth/auth.schema.ts
export const loginSchema = z.object({
  email: z.string().email(),
  password: z.string().min(8),  // ⚠️ Minimum 8 caractères requis
});
```

**Solution :**
- Assurez-vous que le mot de passe fait au moins 8 caractères
- Vérifiez que l'email est au format valide (ex: `user@example.com`)

### 3. **Format des Données Envoyées**

Le frontend envoie les données ainsi :
```dart
// lib/app/data/auth/auth_repository.dart
final response = await _apiClient.post(
  '/auth/login',
  body: {
    'email': email,
    'password': password,
  },
);
```

Le backend attend exactement :
```json
{
  "email": "user@example.com",
  "password": "password123"
}
```

**Vérification :**
- Les données sont bien encodées en JSON (`jsonEncode(body)`)
- Le header `Content-Type: application/json` est présent
- L'URL est correcte : `/api/auth/login`

## 🧪 Tests de Diagnostic

### Test 1 : Vérifier que l'utilisateur existe

```bash
# Créer un utilisateur de test
curl -X POST https://sportify-backend-f47b5a5fe209.herokuapp.com/api/auth/register \
  -H "Content-Type: application/json" \
  -d '{
    "email": "testuser@example.com",
    "password": "Test123!",
    "firstName": "Test",
    "lastName": "User"
  }'
```

### Test 2 : Tester la connexion avec curl

```bash
# Connexion réussie (utilisateur existe)
curl -X POST https://sportify-backend-f47b5a5fe209.herokuapp.com/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{
    "email": "testuser@example.com",
    "password": "Test123!"
  }'

# Connexion échouée (email n'existe pas)
curl -X POST https://sportify-backend-f47b5a5fe209.herokuapp.com/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{
    "email": "nonexistent@example.com",
    "password": "Test123!"
  }'
# Réponse: {"status":401,"message":"Invalid credentials"}

# Connexion échouée (mot de passe incorrect)
curl -X POST https://sportify-backend-f47b5a5fe209.herokuapp.com/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{
    "email": "testuser@example.com",
    "password": "WrongPassword"
  }'
# Réponse: {"status":401,"message":"Invalid credentials"}
```

### Test 3 : Vérifier les logs Heroku

```bash
heroku logs --tail -a sportify-backend | grep -E "(login|401|Invalid|credentials)"
```

## ✅ Solutions

### Solution 1 : Créer un Compte d'Abord

Si vous essayez de vous connecter avec un compte qui n'existe pas :

1. **Créer le compte via l'interface d'inscription** ou via l'API :
```bash
curl -X POST https://sportify-backend-f47b5a5fe209.herokuapp.com/api/auth/register \
  -H "Content-Type: application/json" \
  -d '{
    "email": "votre-email@example.com",
    "password": "VotreMotDePasse123!",
    "firstName": "Prénom",
    "lastName": "Nom"
  }'
```

2. **Ensuite, connectez-vous** avec les mêmes identifiants

### Solution 2 : Vérifier le Mot de Passe

- Le mot de passe doit faire **minimum 8 caractères**
- Le mot de passe est **case-sensitive** (majuscules/minuscules importantes)
- Vérifiez qu'il n'y a pas d'espaces avant/après

### Solution 3 : Vérifier l'Email

- L'email doit être au format valide : `user@domain.com`
- L'email est **case-insensitive** mais vérifiez qu'il correspond exactement à celui utilisé lors de l'inscription

### Solution 4 : Activer le Mode Debug

Dans le frontend, activez les logs pour voir la requête exacte :

```dart
// Dans api_client.dart, vérifiez que kDebugMode affiche les erreurs
if (kDebugMode) {
  debugPrint('Request URL: $uri');
  debugPrint('Request Body: ${jsonEncode(body)}');
  debugPrint('Response Status: ${response.statusCode}');
  debugPrint('Response Body: ${response.body}');
}
```

## 🔍 Code Backend (Référence)

```typescript
// backend/src/modules/auth/auth.service.ts
async login(rawData: unknown) {
  const data = loginSchema.parse(rawData);  // Validation Zod
  const user = await prisma.user.findUnique({ where: { email: data.email } });
  
  if (!user) {
    throw createHttpError(401, 'Invalid credentials');  // ⚠️ Email n'existe pas
  }

  const isValid = await bcrypt.compare(data.password, user.passwordHash);
  if (!isValid) {
    throw createHttpError(401, 'Invalid credentials');  // ⚠️ Mot de passe incorrect
  }

  return this.generateTokens(user);
}
```

## 📝 Checklist de Dépannage

- [ ] L'utilisateur existe dans la base de données
- [ ] Le mot de passe fait au moins 8 caractères
- [ ] Le mot de passe est correct (vérifiez les majuscules/minuscules)
- [ ] L'email est au format valide
- [ ] L'email correspond exactement à celui utilisé lors de l'inscription
- [ ] Les headers HTTP sont corrects (`Content-Type: application/json`)
- [ ] L'URL de l'API est correcte (`/api/auth/login`)
- [ ] Le backend est accessible (testez `/health`)

## 🚨 Erreurs Communes

### Erreur : "Invalid credentials" (401)

**Cause :** Email ou mot de passe incorrect

**Solution :**
1. Vérifiez que vous avez créé un compte avec cet email
2. Vérifiez que le mot de passe est correct
3. Créez un nouveau compte si nécessaire

### Erreur : "Route not found" (404)

**Cause :** URL incorrecte

**Solution :**
- Vérifiez que l'URL est `/api/auth/login` (avec `/api` au début)
- Vérifiez que `baseUrl` dans `api_client.dart` se termine par `/api`

### Erreur : "Validation failed" (400)

**Cause :** Données invalides (email invalide ou password < 8 caractères)

**Solution :**
- Vérifiez le format de l'email
- Vérifiez que le mot de passe fait au moins 8 caractères

## 🎯 Prochaines Étapes

1. **Créer un compte de test** via l'interface d'inscription
2. **Tester la connexion** avec les identifiants créés
3. **Vérifier les logs** si l'erreur persiste
4. **Activer le mode debug** dans le frontend pour voir les requêtes exactes

## 📞 Support

Si le problème persiste après avoir vérifié tous les points ci-dessus :

1. Vérifiez les logs Heroku : `heroku logs --tail -a sportify-backend`
2. Testez avec curl pour isoler le problème frontend/backend
3. Vérifiez que la base de données contient bien l'utilisateur

