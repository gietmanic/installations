# Bash-Skriptsammlung für Cloud Server🖥

Dieses Repository enthält mehrere Bash-Skripte zur Verwaltung und Automatisierung auf Cloudservern.

## Enthaltene Skripte 🔽

### 1. Rancher Installation

Das Skript `install_rancher.sh` ermöglicht die einfache Installation von Rancher auf einem Hetzner Cloud Server.

#### Voraussetzungen 
- Ein Cloudserver mit Ubuntu 22.04
- Root-Zugriff oder ein Benutzer mit `sudo`-Rechten
- Eine Domain (optional, für HTTPS-Zertifikat über Let's Encrypt)

#### Skript herunterladen und ausführen

1. Lade das Skript direkt herunter:
   ```bash
   curl -o install_rancher.sh https://raw.githubusercontent.com/gietmanic/installations/main/server/rancher/install_rancher.sh
   ```

2. Mache das Skript ausführbar:
   ```bash
   chmod +x install_rancher.sh
   ```

3. Führe das Skript aus:
   ```bash
   sudo ./install_rancher.sh
   ```

4. Während der Ausführung wirst du gefragt, ob du eine Domain verwenden möchtest:
   - Falls **ja**, gib deine Domain ein, und ein SSL-Zertifikat wird automatisch generiert. ✅🔐🌍
   - Falls **nein**, wird Rancher ohne HTTPS gestartet. ❌🔓

#### Rancher Zugriff

- Falls eine Domain genutzt wurde: `https://deine-domain`
- Falls keine Domain genutzt wurde: `https://<server-ip>`

Nach dem ersten Login kannst du ein Admin-Passwort festlegen und Rancher einrichten. 🔑👤⚙️

#### Ports & Firewall

Das Skript öffnet automatisch die benötigten Ports:
- **Port 80** (HTTP, für Let's Encrypt)
- **Port 443** (HTTPS, für Rancher UI)

Falls UFW nicht aktiv ist, kannst du es manuell aktivieren:
```bash
sudo ufw enable
```

#### Entfernen von Rancher 🗑️🚫🐳
Falls du Rancher entfernen möchtest, kannst du den folgenden Befehl ausführen:
```bash
docker rm -f rancher
```

### 2. Weitere Skripte


## Lizenz 📜
Dieses Skript steht unter der MIT-Lizenz. Feel free to contribute! 🎉

