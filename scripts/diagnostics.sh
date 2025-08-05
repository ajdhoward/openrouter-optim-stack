#!/usr/bin/env bash
set -euo pipefail
LOG=diagnostics_$(date +%F-%H%M).log
{
  echo "=== FULL SYSTEM AUDIT $(date) ==="
  ss -tulpn
  free -h
  df -h /
  systemctl --type=service --state=running | grep -E "nginx|apache|plesk|caddy" || true
  docker ps --format '{{.Names}}\t{{.Ports}}' || true
  ufw status verbose 2>/dev/null || echo "UFW inactive"
} | tee "$LOG"
echo "Report saved to $LOG"
