#!/bin/sh
set -e

echo "🔍 Checking Docker installation..."
docker --version

echo "\n🔍 Checking container status..."
docker compose ps

echo "\n🔍 Testing service endpoints (via Caddy)..."
test_service() {
    response=$(curl -sk -o /dev/null -w "%{http_code}" "https://localhost:8443/$1")
    if [ "$response" = "200" ] || [ "$response" = "401" ] || [ "$response" = "302" ]; then
        echo "✅ $1: HTTP $response"
    else
        echo "❌ $1: HTTP $response"
    fi
}

test_service flowise
test_service n8n
test_service helicone
test_service ai/query
test_service docs
test_service text/v2/check

echo "\n💡 Access services at: https://<tailscale-ip>:8443/[service]"
echo "💡 Browsers will warn about self-signed cert - click 'Advanced' → 'Proceed'"
echo "💡 Use [ESCALATE] and [CONSENSUS] tags in prompts for advanced routing"
