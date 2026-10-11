# cf-tunnel

`cf-tunnel` là CLI Bash nhỏ để quản lý Cloudflare Tunnel trên server Linux.
Nó dùng Cloudflare API để cập nhật ingress và DNS CNAME, còn kết nối tunnel
được thực hiện bởi `cloudflared`.

## Cài đặt nhanh

```bash
curl -fsSL https://raw.githubusercontent.com/thaonv7995/cf-tunnel/main/install.sh | sudo bash
```

Cập nhật:

```bash
curl -fsSL https://raw.githubusercontent.com/thaonv7995/cf-tunnel/main/update.sh | sudo bash
```

Gỡ CLI (không xoá tunnel hoặc DNS):

```bash
curl -fsSL https://raw.githubusercontent.com/thaonv7995/cf-tunnel/main/uninstall.sh | sudo bash
```

Các script tải file vào thư mục tạm, kiểm tra Bash syntax rồi cài vào
`/usr/local/sbin/cf-tunnel`.

## Yêu cầu

- Linux với Bash 4+, `curl`, `jq`, `systemd`.
- `cloudflared` đã được cài trước khi chạy `cf-tunnel init`.
- Quyền `root`/`sudo`.
- Cloudflare API token có quyền đọc/ghi tunnel và DNS.

## Cấu hình

Tạo `/etc/cloudflared/cf-api.env` với permission `600`:

```bash
CF_API_TOKEN=...
CF_ACCOUNT_ID=...
CF_ZONE_ID=...
CF_DOMAIN=example.com
```

Không commit file này vào Git. Script đọc tunnel ID từ
`/etc/cloudflared/tunnel-id`.

## Sử dụng

```bash
sudo cf-tunnel init homelab
sudo cf-tunnel add app.example.com http://localhost:8080
sudo cf-tunnel ls
sudo cf-tunnel status
sudo cf-tunnel rm app.example.com
sudo cf-tunnel tunnels
sudo cf-tunnel --version
```

`init` tạo tunnel và cài/bật `cloudflared.service`. `add` cập nhật ingress
và tạo hoặc cập nhật CNAME proxied. `rm` chỉ xoá CNAME trỏ đúng vào tunnel
đang quản lý.

## Phát triển

```bash
bash -n cf-tunnel install.sh update.sh uninstall.sh
sudo env CF_TUNNEL_INSTALL_PATH=/tmp/cf-tunnel-test ./install.sh
```

Mọi thay đổi trên GitHub sẽ có hiệu lực cho lần cài/update tiếp theo.
