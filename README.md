# Valheim Dedicated Server (Docker)

[![Docker](https://img.shields.io/badge/docker-%230db7ed.svg?style=for-the-badge&logo=docker&logoColor=white)](https://www.docker.com/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg?style=for-the-badge)](https://opensource.org/licenses/MIT)

Easy-to-deploy Valheim dedicated server using Docker. Perfect for VPS deployment with minimal configuration.

## ✨ Features

- 🐳 Docker-based deployment
- ⚙️ Simple configuration via `.env` file
- 💾 Automatic world backups
- 🔄 Easy updates
- 📦 Persistent world data
- 🚀 One-command deployment

## 📋 Prerequisites

- VPS or dedicated server
- Docker and Docker Compose installed
- Open ports: 2456-2458/udp

## Minimum VPS Specifications
- 1 vCPU, 3GB RAM (max 6 players)
- 2 vCPU, 4GB RAM (recommended, 10 players)
- 40GB SSD storage

## 🚀 Quick Start

1. Clone repository and enter folder:
```bash
cd valheim-server
```

2. Edit configuration in `.env`:
```bash
nano .env
```

3. Start server:
```bash
docker-compose up -d
```

4. View logs:
```bash
docker-compose logs -f
```

5. Stop server:
```bash
docker-compose down
```

## 🎮 Connect to Server

**Method 1 - In Game:**
- Open "Join Game" tab
- Check "Community"
- Search for your server name

**Method 2 - Steam Server List:**
- Steam Client → View → Servers → FAVORITES
- Add Server: `<server_ip>:2457` (use port 2457 for Steam server list)
- Connect and enter password
- Note: Port 2456 for game connection, port 2457 for Steam query

## 🌍 Transfer World from Local

1. Windows world file location:
```
C:\Users\<Username>\AppData\LocalLow\IronGate\Valheim\worlds
```

2. Copy all files with your world name to `./worlds/` folder

3. Restart server

## 💾 Backup World

World files are stored in `./worlds/` folder
Backup files are stored in `./backups/` folder

## 🔄 Update Server

```bash
docker-compose pull
docker-compose down
docker-compose up -d --build
```

## 🛠️ Manual Deployment via Terminal (Without Docker Compose)

If deploying directly on VPS without docker-compose:

```bash
# Stop & remove old container (if exists)
docker stop valheim-server
docker rm valheim-server

# Run new container
docker run -d \
  --name valheim-server \
  --restart unless-stopped \
  -p 2456-2458:2456-2458/udp \
  -e SERVER_NAME="TestingIqbal" \
  -e SERVER_PORT=2456 \
  -e WORLD_NAME="Dedicated" \
  -e SERVER_PASSWORD="secret" \
  -e SERVER_PUBLIC=1 \
  -v /path/to/worlds:/home/steam/.config/unity3d/IronGate/Valheim/worlds \
  -v /path/to/server_data:/home/steam/valheim \
  -v /path/to/backups:/home/steam/backups \
  <image_name>:latest

# Check running container
docker ps | grep valheim

# View logs
docker logs -f valheim-server
```

## 🐳 Docker Swarm Deployment

If using Docker Swarm (Dokploy, Portainer, etc):

```bash
# Check service status
docker service ls | grep valheim

# Expose UDP ports (if not already exposed)
docker service update \
  --publish-add 2456-2458:2456-2458/udp \
  <service_name>

# Verify ports are published
docker service inspect <service_name> --pretty

# Check if ports are listening
netstat -tulpn | grep 2456

# View service logs
docker service logs -f <service_name>
```

## ❓ Troubleshooting

**Server not showing in server list:**
- Try using port `:2456` or `:2457` in Steam Server List
- Make sure VPS firewall opens port 2456-2458/udp
- Wait 10-15 minutes for first server startup

**How to enter container:**
```bash
docker exec -it valheim-server bash
```

## 📝 License

MIT License - feel free to use this project!

## 🤝 Contributing

Pull requests are welcome! For major changes, please open an issue first.

## ⭐ Support

If this project helps you, please give it a star! ⭐
