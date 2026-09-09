#!/usr/bin/env bash
set -Eeuo pipefail

BACKUP_DIR=/opt/minecraft/backups
SERVER_DIR=/opt/minecraft/server
was_active=false

if systemctl is-active --quiet minecraft.service; then
  was_active=true
  systemctl stop minecraft.service
fi

restart_server() {
  if [ "$was_active" = true ]; then
    systemctl start minecraft.service
  fi
}
trap restart_server EXIT

timestamp=$(date +%F_%H-%M-%S)
archive="$BACKUP_DIR/minecraft-backup-$timestamp.tar.gz"
include=()

cd "$SERVER_DIR"
for item in world world_nether world_the_end server.properties bukkit.yml spigot.yml config plugins; do
  [ -e "$item" ] && include+=("$item")
done

if [ "${#include[@]}" -eq 0 ]; then
  echo "No server data available for backup." >&2
  exit 1
fi

tar -czf "$archive" -- "${include[@]}"

mapfile -t archives < <(find "$BACKUP_DIR" -maxdepth 1 -type f -name 'minecraft-backup-*.tar.gz' -printf '%T@ %p\n' | sort -nr | cut -d' ' -f2-)
if [ "${#archives[@]}" -gt 7 ]; then
  printf '%s\0' "${archives[@]:7}" | xargs -0r rm -f --
fi

echo "Backup created: $archive"
