#!/bin/bash
# Diagnostic script for Docker permissions and Pi-hole container

echo "=== Docker Permissions Diagnostic ==="
echo ""

# Check if docker is installed
if ! command -v docker >/dev/null 2>&1; then
  echo "[ERROR] Docker is not installed or not in PATH."
  exit 1
fi
echo "[OK] Docker is installed."

# Check if user can run docker without sudo
if docker ps >/dev/null 2>&1; then
  echo "[OK] You can run Docker commands without sudo."
  DOCKER_CMD="docker"
else
  echo "[WARNING] You need sudo to run Docker commands."
  echo "         Fix: sudo usermod -aG docker \$USER && newgrp docker"
  DOCKER_CMD="sudo docker"
fi

echo ""

# Check running containers
echo "Running containers:"
$DOCKER_CMD ps --format "table {{.Names}}\t{{.Image}}\t{{.Status}}"

echo ""

# Check for Pi-hole container
CONTAINER_NAME="${PIHOLE_CONTAINER:-pihole}"
if $DOCKER_CMD ps --format '{{.Names}}' | grep -q "^${CONTAINER_NAME}$"; then
  echo "[OK] Pi-hole container '$CONTAINER_NAME' is running."
else
  echo "[WARNING] No running container named '$CONTAINER_NAME'."
  echo "         Available containers:"
  $DOCKER_CMD ps --format '{{.Names}}'
  echo "         Set PIHOLE_CONTAINER=your_name if needed."
fi

echo ""

# Check mod directory
if [ -d "/opt/pihole-i18n" ]; then
  echo "[OK] Mod directory exists: /opt/pihole-i18n"
  ls -ld /opt/pihole-i18n
else
  echo "[INFO] Mod directory /opt/pihole-i18n does not exist yet (will be created on install)."
fi

echo ""
echo "=== Diagnostic complete ==="
