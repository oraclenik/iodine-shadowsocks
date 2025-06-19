# DNS-SOCKS: Stealth DNS Tunnel + Shadowsocks in Docker

A lightweight, Docker-based DNS tunnel and Shadowsocks stack using `iodine` and `shadowsocks-libev` with `v2ray-plugin`.  
Built for use in restricted environments where only DNS is allowed, this setup exposes a local SOCKS5 proxy via an encrypted DNS tunnel.

---

## ✨ Features

- 🔐 Encrypted SOCKS5 proxy tunneled entirely through DNS
- 🧊 Alpine-based images for minimal footprint
- 🐳 Docker Compose deployment
- ⚙️ Environment-configurable client and server setup
- 🌐 Works behind restrictive firewalls (DNS-only egress)

---

## 📁 Structure

```
.
├── client/
│   ├── .env                  # Client environment (tunnel + proxy settings)
│   ├── docker-compose.yml    # Starts iodine + ss-local
│   ├── Dockerfile.iodine     # Builds iodine tunnel client
│   ├── start-iodine.sh       # Entrypoint for iodine client
│   └── start-ss-client.sh    # Entrypoint for Shadowsocks + v2ray-plugin
│
├── server/
│   ├── .env                  # Server configuration
│   ├── docker-compose.yml    # Starts iodined + ss-server
│   ├── Dockerfile            # Builds iodine server
│   └── iodined.sh            # Entrypoint for DNS tunnel server
│
└── README.md
```

---

## 🚀 Quick Start

### 🖥️ Server (run on DNS-accessible VPS)

```bash
cd server
cp .env.example .env   #  edit .env 
docker-compose up -d --build
```

Make sure to delegate a subdomain (e.g. `t1.example.com`) to the server IP via an NS record.

---

### 💻 Client

```bash
cd client
cp .env.example .env   #  edit .env 
docker-compose up -d --build
```

This will:
- Connect to the iodine tunnel
- Start a SOCKS5 proxy at `localhost:1080`

Test:

```bash
curl --socks5-hostname 127.0.0.1:1080 https://ifconfig.me
```

---

## 🔧 Environment Variables

Edit `.env` in both `client/` and `server/`:

### Shared

| Variable          | Example           | Purpose                             |
|------------------|-------------------|-------------------------------------|
| `TUNNEL_DOMAIN`   | `t1.example.com`  | Subdomain delegated to iodined      |
| `TUNNEL_GATEWAY`  | `10.0.0.1`        | Tunnel IP of the server             |

### Server-only

| Variable        | Example             |
|----------------|---------------------|
| `IODINED_PASS` | `SuperSecret123`     |

### Client-only

| Variable          | Example             |
|------------------|---------------------|
| `SS_REMOTE_PORT`  | `8388`              |
| `SS_PASSWORD`     | `MyProxyPass`       |
| `SS_METHOD`       | `chacha20-ietf-poly1305` |
| `SOCKS_PORT`      | `1080`              |

---

## 🧠 Notes

- You'll need to forward an NS record for the tunnel domain to your server.
- The TUN device must be available on the host (`/dev/net/tun`) and Docker must be run with `--cap-add=NET_ADMIN`.
- Shadowsocks traffic is obfuscated with `v2ray-plugin` (can add TLS/websocket if needed).

---

## 📜 License

MIT — Free to use, fork, and extend.

---

## 🙏 Credits

- [yarrick/iodine](https://github.com/yarrick/iodine)
- [teddysun/shadowsocks-libev](https://hub.docker.com/r/teddysun/shadowsocks-libev)
- [v2fly/v2ray-plugin](https://github.com/shadowsocks/v2ray-plugin)

---

Enjoy stealth networking 🕵️‍♂️ over DNS.
