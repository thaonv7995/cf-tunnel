#!/usr/bin/env bash
set -Eeuo pipefail

INSTALL_PATH="${CF_TUNNEL_INSTALL_PATH:-/usr/local/sbin/cf-tunnel}"
BASE_URL="${CF_TUNNEL_BASE_URL:-https://raw.githubusercontent.com/thaonv7995/cf-tunnel/main}"

if [ "$(id -u)" -ne 0 ]; then
    echo "Chạy bằng root: curl -fsSL .../install.sh | sudo bash" >&2
    exit 1
fi

command -v curl >/dev/null 2>&1 || { echo "Thiếu dependency: curl" >&2; exit 1; }
command -v bash >/dev/null 2>&1 || { echo "Thiếu dependency: bash" >&2; exit 1; }

tmp_dir=$(mktemp -d)
trap 'rm -rf "$tmp_dir"' EXIT

curl --fail --silent --show-error --location --retry 3 \
    --connect-timeout 10 --max-time 60 \
    "$BASE_URL/cf-tunnel" -o "$tmp_dir/cf-tunnel"
bash -n "$tmp_dir/cf-tunnel"
install -D -m 0755 "$tmp_dir/cf-tunnel" "$INSTALL_PATH"

echo "Đã cài cf-tunnel tại $INSTALL_PATH"
"$INSTALL_PATH" --version
