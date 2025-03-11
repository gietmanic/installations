# Bash-Skriptsammlung für Cloud Server🖥

Dieses Repository enthält mehrere Bash-Skripte zur Verwaltung und Automatisierung auf Cloudservern.

## Enthaltene Skripte 🔽

---

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

---

### 2. K3s Cluster Setup

Dieses Skript installiert und konfiguriert einen K3s Kubernetes-Cluster auf einem Hetzner Cloud Server und ermöglicht die einfache Integration in Rancher. 🌍📡⚙️

#### Installation

#### Voraussetzungen 

- Ein Hetzner Cloud Server mit Ubuntu 22.04
- Root-Zugriff oder ein Benutzer mit `sudo`-Rechten

#### Skript herunterladen und ausführen 

1. Lade das Skript direkt herunter:

   ```bash
   curl -o install_k3s.sh https://raw.githubusercontent.com/gietmanic/installations/refs/heads/main/server/k3s/install_k3s.sh
   ```

2. Mache das Skript ausführbar:

   ```bash
   chmod +x install_k3s.sh
   ```

3. Führe das Skript aus:

   ```bash
   sudo ./install_k3s.sh
   ```

#### Cluster Zugriff

Nach der Installation ist der K3s-Cluster betriebsbereit. Um den Kubernetes-Cluster zu verwalten, kannst du Folgendes ausführen:

```bash
export KUBECONFIG=/etc/rancher/k3s/k3s.yaml
kubectl get nodes
```

Falls du den Zugriff dauerhaft setzen möchtest, füge die folgende Zeile zu deiner `~/.bashrc` hinzu:

```bash
echo 'export KUBECONFIG=/etc/rancher/k3s/k3s.yaml' >> ~/.bashrc
source ~/.bashrc
```

#### Worker-Nodes hinzufügen

Falls du Worker-Nodes hinzufügen möchtest, kannst du den Token abrufen und auf den anderen Servern verwenden:

```bash
cat /var/lib/rancher/k3s/server/node-token
```

Diesen Token benötigst du, um zusätzliche Nodes mit folgendem Befehl in den Cluster einzubinden:

```bash
curl -sfL https://get.k3s.io | K3S_URL="https://<master-ip>:6443" K3S_TOKEN="<node-token>" sh -
```

#### Firewall-Konfiguration

Das Skript öffnet automatisch die benötigten Ports:

- **Port 6443** (Kubernetes API)
- **Port 10250** (Kubelet API)

Falls UFW nicht aktiv ist, kannst du es manuell aktivieren:

```bash
sudo ufw enable
```



## Lizenz 📜
Dieses Skript steht unter der MIT-Lizenz. Feel free to contribute! 🎉

