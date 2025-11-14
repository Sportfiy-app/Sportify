#!/bin/bash

# Script de test pour vérifier que l'API backend fonctionne correctement
# Usage: ./scripts/test-api.sh [API_URL]
# Par défaut: http://localhost:3333

API_URL="${1:-http://localhost:3333}"
BASE_URL="${API_URL%/}"

echo "🧪 Test de l'API Sportify"
echo "📍 URL: $BASE_URL"
echo ""

# Couleurs pour l'affichage
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Compteur de tests
TESTS_PASSED=0
TESTS_FAILED=0

# Fonction pour tester un endpoint
test_endpoint() {
    local method=$1
    local path=$2
    local data=$3
    local expected_status=${4:-200}
    local description=$5
    
    local url="$BASE_URL$path"
    local response
    
    if [ "$method" = "GET" ]; then
        response=$(curl -s -w "\n%{http_code}" "$url")
    elif [ "$method" = "POST" ]; then
        response=$(curl -s -w "\n%{http_code}" -X POST "$url" \
            -H "Content-Type: application/json" \
            -d "$data")
    elif [ "$method" = "PATCH" ]; then
        response=$(curl -s -w "\n%{http_code}" -X PATCH "$url" \
            -H "Content-Type: application/json" \
            -d "$data")
    fi
    
    local body=$(echo "$response" | head -n -1)
    local status_code=$(echo "$response" | tail -n 1)
    
    if [ "$status_code" = "$expected_status" ]; then
        echo -e "${GREEN}✅${NC} $description (Status: $status_code)"
        ((TESTS_PASSED++))
        return 0
    else
        echo -e "${RED}❌${NC} $description (Expected: $expected_status, Got: $status_code)"
        echo "   Response: $body"
        ((TESTS_FAILED++))
        return 1
    fi
}

# Test 1: Health Check
echo "1️⃣  Test Health Check"
test_endpoint "GET" "/health" "" 200 "Health check endpoint"

# Test 2: Home Feed (public)
echo ""
echo "2️⃣  Test Home Feed"
test_endpoint "GET" "/api/home" "" 200 "Get home feed"

# Test 3: Register User
echo ""
echo "3️⃣  Test User Registration"
RANDOM_EMAIL="test$(date +%s)@example.com"
REGISTER_DATA="{\"email\":\"$RANDOM_EMAIL\",\"password\":\"Test123!\",\"firstName\":\"Test\",\"lastName\":\"User\"}"
test_endpoint "POST" "/api/auth/register" "$REGISTER_DATA" 201 "Register new user"

# Test 4: Login
echo ""
echo "4️⃣  Test User Login"
LOGIN_DATA="{\"email\":\"$RANDOM_EMAIL\",\"password\":\"Test123!\"}"
LOGIN_RESPONSE=$(curl -s -X POST "$BASE_URL/api/auth/login" \
    -H "Content-Type: application/json" \
    -d "$LOGIN_DATA" \
    -w "\n%{http_code}")

LOGIN_BODY=$(echo "$LOGIN_RESPONSE" | head -n -1)
LOGIN_STATUS=$(echo "$LOGIN_RESPONSE" | tail -n 1)

if [ "$LOGIN_STATUS" = "200" ]; then
    echo -e "${GREEN}✅${NC} User login (Status: $LOGIN_STATUS)"
    ((TESTS_PASSED++))
    # Extraire le token pour les tests suivants
    ACCESS_TOKEN=$(echo "$LOGIN_BODY" | grep -o '"accessToken":"[^"]*' | cut -d'"' -f4)
else
    echo -e "${RED}❌${NC} User login (Expected: 200, Got: $LOGIN_STATUS)"
    echo "   Response: $LOGIN_BODY"
    ((TESTS_FAILED++))
    ACCESS_TOKEN=""
fi

# Test 5: Get User Profile (authenticated)
if [ -n "$ACCESS_TOKEN" ]; then
    echo ""
    echo "5️⃣  Test Get User Profile (Authenticated)"
    test_endpoint "GET" "/api/users/me" "" 200 "Get current user profile" "$ACCESS_TOKEN"
fi

# Test 6: Get Events (public)
echo ""
echo "6️⃣  Test Get Events"
test_endpoint "GET" "/api/events" "" 200 "Get events list"

# Test 7: Get Posts (public)
echo ""
echo "7️⃣  Test Get Posts"
test_endpoint "GET" "/api/posts" "" 200 "Get posts list"

# Test 8: Get Clubs (public)
echo ""
echo "8️⃣  Test Get Clubs"
test_endpoint "GET" "/api/clubs" "" 200 "Get clubs list"

# Résumé
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "📊 Résumé des tests"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo -e "${GREEN}✅ Tests réussis: $TESTS_PASSED${NC}"
echo -e "${RED}❌ Tests échoués: $TESTS_FAILED${NC}"
echo ""

if [ $TESTS_FAILED -eq 0 ]; then
    echo -e "${GREEN}🎉 Tous les tests sont passés !${NC}"
    exit 0
else
    echo -e "${RED}⚠️  Certains tests ont échoué${NC}"
    exit 1
fi

