#!/bin/sh
set -e

# 1. Verify prerequisites
if ! command -v docker >/dev/null; then
    echo "✅ Installing Docker..."
    curl -fsSL https://get.docker.com | sh
    sudo usermod -aG docker $USER
    echo "⚠️ Please log out and back in, then re-run this script"
    exit 1
fi

# 2. Create models directory
mkdir -p ./models

# 3. Start core infrastructure
echo "✅ Pulling and starting core services..."
docker compose pull --quiet
docker compose up -d

# 4. Start AI module
echo "✅ Setting up AI routing layer..."
docker compose -f docker-compose.yml -f modules/ai/cactus/docker-compose.yml up -d

# 5. Bootstrap Ollama
echo "✅ Setting up local AI models..."
docker run -d -p 11434:11434 -v ./models:/root/.ollama/models ollama/ollama
docker exec -it ollama ollama pull tinyllama:q2_K

# 6. Final status check
echo "\n✅ Installation complete! Run './scripts/status.sh' to verify services."
echo "💡 Access services at: https://<tailscale-ip>:8443/[service]"
echo "💡 Use [ESCALATE] and [CONSENSUS] tags in prompts for advanced routing"
