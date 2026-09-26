# 📡 RUNBOOK — Setup Completo: Kitty + Herdr + Tailscale + Moshi

> **Objetivo**: Replicar en otra máquina el ecosistema completo del video de Gentle AI:
> terminal GPU + multiplexor de agentes persistentes + acceso remoto seguro + notificaciones al móvil.
>
> **Última verificación**: 23 de septiembre de 2026 · **Máquina de origen**: PC-harco (Linux x86_64, Ubuntu)
> **Móvil**: realme-c75 (Android) con app Moshi

---

## 🏗️ Arquitectura final

```
📱 MÓVIL (Moshi / Termius)
   │  └── Tailscale (VPN mesh, sin IP pública)
   │        └── SSH con claves (NO contraseñas)
   ▼
🖥️ PC-HARCO (la máquina de trabajo)
   ├── Kitty 0.32.2          → terminal GPU (liviana)
   ├── Herdr 0.9.0           → multiplexor + runtime de agentes (workspaces, sidebar, persistencia)
   ├── moshi-hook 0.2.85     → daemon de notificaciones/eventos de agentes → push al móvil
   ├── Tailscale 1.102.4     → red privada (IP: 100.122.199.125)
   ├── OpenSSH               → SOLO escucha en IP de Tailscale
   ├── UFW                   → firewall: deny entrantes, allow solo tailscale0
   └── loginctl linger       → procesos sobreviven al cierre de sesión
```

**Comparativa de peso (medido en origen):**

| Componente | Disco | RAM en uso |
|------------|-------|------------|
| Kitty | 6.8 MB | ~150 MB |
| WezTerm (alternativa) | 24 MB | ~190 MB |
| Herdr | 23 MB | ~22 MB |
| **Kitty + Herdr** | **~30 MB** | **~172 MB** |

---

## ✅ FASE 1 — Terminal: Kitty + Herdr

### 1.1 Instalar Kitty

```bash
sudo apt install -y kitty   # Ubuntu/Debian
# o pacman -S kitty          # Arch
# Config: ~/.config/kitty/kitty.conf
```

### 1.2 Instalar Herdr

```bash
# Opción A: Homebrew/Linuxbrew
brew install herdr

# Opción B: instalador oficial
curl -fsSL https://herdr.dev/install.sh | sh
```

Verificar: `herdr --version` → 0.9.0

### 1.3 Config de Herdr (`~/.config/herdr/config.toml`)

```toml
onboarding = false

[theme]
name = "catppuccin"

# Notificaciones de escritorio cuando un agente termina/pide input
[ui.toast]
delivery = "system"     # off | herdr | terminal | system
delay_seconds = 1

[ui.sound]
enabled = true
```

> ⚠️ **Gotcha importante**: Herdr **NO tiene `[[workspaces]]` en el config**.
> Los workspaces se crean en la TUI (`Ctrl+B` → `Shift+N`) y se **restauran
> automáticamente** desde el estado de sesión. No hay que mantener rutas en un archivo.

### 1.4 Atajos esenciales (prefijo por defecto: `Ctrl+B`)

| Acción | Atajo |
|--------|-------|
| Nueva pestaña | `Ctrl+B` luego `C` |
| Split derecha / abajo | `Ctrl+B` luego `V` / `-` |
| Navegar paneles | `Ctrl+B` luego `H/J/K/L` |
| Navegar workspaces | `Ctrl+B` luego `W` |
| Nuevo workspace | `Ctrl+B` luego `Shift+N` |
| Mostrar/ocultar sidebar | `Ctrl+B` luego `B` |
| Detach (todo sigue) | `Ctrl+B` luego `Q` |
| Ayuda de atajos | `Ctrl+B` luego `?` |

Herdr es **mouse-native**: click para enfocar, arrastrar bordes, click derecho menú, arrastrar texto copia.

### 1.5 Persistencia

```bash
# Detach manual: Ctrl+B luego Q  (o cerrar la ventana de Kitty)
# Re-conectar:
herdr
# Matar todo de verdad:
herdr server stop
```

---

## 🔐 FASE 2 — Seguridad: Tailscale + SSH + UFW + linger

### 2.1 Tailscale

```bash
# Instalar
curl -fsSL https://tailscale.com/install.sh | sh

# Conectar (enlazar con cuenta)
sudo tailscale up
# Opcional: SSH gestionado por Tailscale
sudo tailscale up --ssh
```

Verificar: `tailscale status` → listar dispositivos (PC, móvil, etc.)

> El móvil debe tener la app Tailscale con la MISMA cuenta para estar en el tailnet.

### 2.2 OpenSSH — SOLO escuchar en Tailscale

```bash
sudo apt install -y openssh-server

# Configurar socket para escuchar solo en la IP de Tailscale
# (Reemplazar la IP por la de la máquina: tailscale ip -4)
sudo sed -i 's/ListenStream=0.0.0.0:22/ListenStream=<IP_TAILSCALE>:22/' /lib/systemd/system/ssh.socket
sudo sed -i 's/ListenStream=\[::\]:22/#ListenStream=[::]:22/' /lib/systemd/system/ssh.socket
sudo systemctl daemon-reload
sudo systemctl restart ssh.socket
```

> ⚠️ **Gotcha encontrado en origen**: existía un drop-in
> `/etc/systemd/system/ssh.socket.d/listen-all.conf` que SOBRESCRIBÍA la config
> y dejaba SSH en `0.0.0.0:22` (expuesto). **Verificar que no exista**:
> `ls /etc/systemd/system/ssh.socket.d/`. Si existe, moverlo a `.bak` y recargar:
> `sudo systemctl daemon-reload && sudo systemctl restart ssh.socket && sudo systemctl stop ssh.service`

### 2.3 SSH solo con claves

```bash
# Deshabilitar contraseñas
sudo sed -i 's/^#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config
sudo systemctl restart ssh

# Claves (si no existen)
ssh-keygen -t ed25519 -C "comentario"
# Agregar claves de dispositivos remotos (móvil, etc.)
# Copiar la clave pública del dispositivo a:
echo "ssh-ed25519 <CLAVE_PUBLICA> alias" >> ~/.ssh/authorized_keys
```

### 2.4 UFW — firewall cerrado, solo Tailscale

```bash
sudo ufw allow in on tailscale0 to any port 22 proto tcp
sudo ufw allow in on tailscale0 to any port 3000 proto tcp   # si usás dev servers
sudo ufw --force enable
```

Verificar: `sudo ufw status verbose`
→ Esperado: `22/tcp on tailscale0 ALLOW IN`, `3000/tcp on tailscale0 ALLOW IN`, default `deny (entrantes)`

### 2.5 Linger — procesos sobreviven al logout

```bash
sudo loginctl enable-linger <USUARIO>
loginctl show-user <USUARIO> | grep Linger   # → Linger=yes
```

### 2.6 Herdr como servicio de arranque

```bash
brew services start herdr   # (si se instaló con Homebrew)
```

> ⚠️ **Gotcha**: si el servidor de Herdr YA está corriendo (lo levantó `herdr`
> desde una terminal), el servicio falla con "server already running". Es normal
> y temporal: en el próximo reinicio (sin servidor corriendo) el servicio levanta
> sin conflicto. No hace falta hacer nada.

---

## 📱 FASE 3 — Notificaciones: Moshi + moshi-hook

### 3.1 App Moshi (en el móvil)

- **Android**: Google Play → "Moshi: SSH & MOSH Terminal"
- **iOS**: App Store
- Crear host: `100.122.199.125` (IP Tailscale de la máquina), user `harco`, port `22`
- Moshi genera una SSH key — agregarla a `~/.ssh/authorized_keys` (paso 2.3)
- Al conectar: aceptar fingerprint la primera vez
- Moshi detecta tmux/zellij/herdr automáticamente y muestra los workspaces

### 3.2 Instalar moshi-hook (en la máquina)

```bash
curl -fsSL https://getmoshi.app/install.sh | sh
# → instala moshi-hook y el alias moshi en ~/.local/bin/
```

### 3.3 Pairing

1. En Moshi (móvil): **Settings → Hooks** → copiar el pairing token
2. En la máquina:

```bash
moshi-hook pair --token <TOKEN>
# → "Paired as <nombre-host> (host_xxxx)"
```

> 🔒 Nunca guardar el token en archivos ni en memoria compartida.

### 3.4 Instalar hooks de agentes

```bash
moshi-hook install
# → instala en claude, codex, opencode, gemini, antigravity, cursor...
```

### 3.5 Daemon permanente (systemd user)

```bash
moshi-hook service install
# → Instala y arranca moshi-hook.service
```

> ⚠️ **Gotcha crítico (encontrado en origen)**: el servicio generado usa
> `PATH=/usr/local/bin:/usr/bin:/bin` y NO ve los binarios de Linuxbrew.
> Si el status dice `herdr: not found` / `tmux: not found` / `zellij: not found`,
> crear un drop-in con el PATH completo:

```bash
mkdir -p ~/.config/systemd/user/moshi-hook.service.d
cat > ~/.config/systemd/user/moshi-hook.service.d/path.conf <<'EOF'
[Service]
Environment=PATH=/home/linuxbrew/.linuxbrew/bin:/usr/local/bin:/usr/bin:/bin
EOF
systemctl --user daemon-reload
systemctl --user restart moshi-hook
```

### 3.6 Verificación

```bash
moshi-hook status
# Esperado:
#   status: paired
#   multiplexers: tmux / zellij / herdr (con rutas)
#   hooks: claude/codex/opencode/... "current"
systemctl --user is-active moshi-hook   # → active
```

### 3.7 Datos útiles

```bash
moshi-hook logs -f                      # logs en vivo
moshi-hook status --json                # status máquina-legible
moshi-hook set usage-collection off     # opt-out de colección de uso (opcional)
# Log: ~/.local/state/moshi/hook.log
# Socket: /run/user/<UID>/moshi-hook.sock
# Gateway local (Chat View/diff/browser preview): 127.0.0.1:24543
```

---

## 🧪 CHECKLIST FINAL DE VERIFICACIÓN

```bash
# 1. Red privada
tailscale status                     # PC + móvil online

# 2. SSH endurecido
ss -tlnp | grep 22                   # SOLO <IP_TAILSCALE>:22, NUNCA 0.0.0.0:22
sudo ufw status verbose              # deny entrantes + allow tailscale0:22/3000

# 3. Persistencia
loginctl show-user $USER | grep Linger   # Linger=yes
brew services list | grep herdr          # herdr arranca solo
herdr session list                       # sesión default running

# 4. Notificaciones móvil
systemctl --user is-active moshi-hook    # active
moshi-hook status                        # paired + multiplexers detectados
# PRUEBA REAL: lanzar un agente en Herdr → debe llegar push al móvil
```

---

## 🆘 Troubleshooting rápido

| Síntoma | Causa probable | Solución |
|---------|----------------|----------|
| `herdr server is already running` al arrancar servicio | Servidor ya levantado por CLI | Normal/temporal. Reiniciar máquina o `herdr server stop` |
| moshi-hook no ve herdr/tmux/zellij | PATH del servicio sin linuxbrew | Crear drop-in `path.conf` (paso 3.5) |
| Moshi "Permission denied" al conectar | Clave de Moshi no está en authorized_keys | Agregar la clave pública al host (paso 2.3) |
| No llegan notificaciones push | moshi-hook no corriendo / sin pair | `systemctl --user is-active moshi-hook` + `moshi-hook status` |
| SSH expuesto en 0.0.0.0:22 | Drop-in `listen-all.conf` presente | Moverlo a `.bak`, recargar socket (paso 2.2) |
| `herdr server stop` se cuelga | Agentes activos en paneles | Es esperado: espera a que terminen. Usar con paneles vacíos |

---

## 📚 Referencias

| Recurso | URL |
|---------|-----|
| **Video original (fuente de todo)** | https://www.youtube.com/watch?v=Yj51wXMwFwE |
| Herdr docs | https://herdr.dev/docs/ |
| Herdr install | https://herdr.dev/docs/install/ |
| Herdr keyboard | https://herdr.dev/docs/keyboard/ |
| Herdr configuration | https://herdr.dev/docs/configuration/ |
| Herdr config reference | https://herdr.dev/docs/config-reference/ |
| Herdr persistence & remote | https://herdr.dev/docs/persistence-remote/ |
| Moshi docs | https://getmoshi.app/docs |
| Moshi hooks | https://getmoshi.app/docs/hooks |
| Moshi hook settings | https://getmoshi.app/docs/hook-settings |
| Moshi push notifications | https://getmoshi.app/docs/notifications |
| Moshi Herdr integration | https://getmoshi.app/docs/herdr |
| Moshi Tailscale | https://getmoshi.app/docs/tailscale |
| Tailscale | https://tailscale.com |
| Kitty docs | https://sw.kovidgoyal.net/kitty/ |
| Guía local Kitty+Herdr | `KITTY-HERDR.md` |
| Guía local acceso remoto | `ACCESO-REMOTO.md` |

---

> 🎩 **"Tu portátil no necesita estar en la nube. Tu portátil ES la nube."**
