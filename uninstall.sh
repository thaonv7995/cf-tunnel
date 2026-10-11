#!/usr/bin/env bash
set -Eeuo pipefail

INSTALL_PATH="${CF_TUNNEL_INSTALL_PATH:-/usr/local/sbin/cf-tunnel}"

if [ "$(id -u)" -ne 0 ]; then
    echo "Chạy bằng root: curl -fsSL .../uninstall.sh | sudo bash" >&2
    exit 1
fi

if [ -e "$INSTALL_PATH" ]; then
    rm -f "$INSTALL_PATH"
    echo "Đã xoá $INSTALL_PATH"
else
    echo "Không tìm thấy $INSTALL_PATH"
fi

echo "Không xoá tunnel, DNS, token hoặc cloudflared.service."
