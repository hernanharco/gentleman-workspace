# 📡 Acceso Remoto al Portátil desde el Móvil

> **Objetivo**: Conectarse al portátil desde cualquier lugar (móvil, tablet, otra PC)
> como si estuvieras sentado frente a él, con todo el ecosistema Gentle-AI disponible.

---

## 📋 Índice

1. [Arquitectura](#1-arquitectura)
2. [Requisitos](#2-requisitos)
3. [Configuración del Portátil](#3-configuración-del-portátil)
4. [Configuración del Móvil](#4-configuración-del-móvil)
5. [Flujo de Trabajo Diario](#5-flujo-de-trabajo-diario)
6. [Setup actualizado (Moshi + Herdr)](#6-setup-actualizado-moshi--herdr)
7. [Preguntas Frecuentes](#7-preguntas-frecuentes)
8. [Referencias](#8-referencias)

---

## 1. Arquitectura

```
📱 CELU / TABLET / OTRA PC
   │
   ├── App: Tailscale (VPN mesh privada)
   │     └── Misma red que el portátil, sin IP pública
   │
   └── App: Termius / Termux (cliente SSH)
         │
         ▼
🖥️ PORTÁTIL (pc-harco - 100.122.199.125)
   ├── Tailscale (conectado 24/7)
   ├── OpenSSH (solo escucha en IP de Tailscale)
   ├── tmux / zellij (sesiones persistentes)
   └── opencode + Engram (ecosistema Gentle-AI)
```

### Componentes clave

| Componente | Rol |
|------------|-----|
| **Tailscale** | VPN mesh — conecta dispositivos sin exponer puertos |
| **OpenSSH** | Servidor SSH — permite conexión remota segura |
| **tmux** | Multiplexor de terminal — sesiones persistentes |
| **opencode** | AI asistente — conversación y código |

---

## 2. Requisitos

### Portátil

| Recurso | Detalle |
|---------|---------|
| Tailscale | Instalado y conectado (IP: `100.122.199.125`) |
| OpenSSH | Servidor activo escuchando en Tailscale |
| tmux | Instalado (`tmux 3.7b+`) |
| opencode | Instalado (`opencode 1.15.13+`) |

### Móvil

| App | Versión | Motivo |
|-----|---------|--------|
| **Tailscale** | Play Store | VPN mesh |
| **Termius** | Play Store | Cliente SSH con interfaz linda |

---

## 3. Configuración del Portátil

### 3.1 — Habilitar Tailscale SSH (opcional)

```bash
sudo tailscale up --ssh
```

> Alternativa: desde https://login.tailscale.com/admin/settings/ssh

### 3.2 — Configurar OpenSSH (solo Tailscale)

```bash
# El socket de systemd escucha en la IP de Tailscale
sudo sed -i 's/ListenStream=0.0.0.0:22/ListenStream=100.122.199.125:22/' /lib/systemd/system/ssh.socket
sudo sed -i 's/ListenStream=\[::\]:22/#ListenStream=[::]:22/' /lib/systemd/system/ssh.socket

# Recargar y arrancar
sudo systemctl daemon-reload
sudo systemctl restart ssh.socket
sudo systemctl restart ssh
```

### 3.3 — Agregar llave pública del móvil

```bash
# En el portátil, agregar la llave que genera Termius
echo "ssh-ed25519 <LLAVE_PUBLICA_DEL_MOVIL> termius-movil" >> ~/.ssh/authorized_keys
```

### 3.4 — Verificar conexión

```bash
# Verificar que SSH escucha en Tailscale
ss -tlnp | grep 22
# → LISTEN 0 4096 100.122.199.125:22

# Probar conexión local
ssh harco@100.122.199.125 "hostname && whoami"
# → PC-harco / harco
```

---

## 4. Configuración del Móvil

### 4.1 — Instalar apps

| App | Dónde | Qué hace |
|-----|-------|----------|
| **Tailscale** | Play Store | Conecta el móvil a la red del portátil |
| **Termius** | Play Store | Terminal SSH con interfaz gráfica |

### 4.2 — Configurar Tailscale

1. Abrir Tailscale en el móvil
2. Iniciar sesión con la misma cuenta de Google (`hernan.harco@gmail.com`)
3. Verificar que aparece `pc-harco` en la lista de dispositivos

### 4.3 — Configurar Termius

1. Abrir Termius en el móvil
2. **New Host** → Completar:

| Campo | Valor |
|-------|-------|
| **Alias** | `Mi Portátil` |
| **Hostname** | `100.122.199.125` |
| **Port** | `22` |
| **Username** | `harco` |

3. En **Authentication**:
   - **SSH Key** → **Generate Key** → **Ed25519**
   - Copiar la **llave pública** y agregarla al portátil (ver paso 3.3)
4. Guardar y conectar

Si pide confirmación de huella digital (fingerprint), aceptar.

---

## 5. Flujo de Trabajo Diario

### 🚀 Conectar desde el móvil

```bash
# 1. Abrir Termius
# 2. Tocar "Mi Portátil"
# 3. Una vez conectado:

tmux attach           # Retomar sesión donde la dejaste
# o
tmux new -s trabajo   # Crear sesión nueva
opencode .            # Abrir OpenCode en el directorio actual
```

### 🔒 Desconectar (sin cerrar sesión)

Solo cerrar Termius. **tmux sigue corriendo** en el portátil.
Cuando vuelvas a conectar, `tmux attach` te lleva exactamente donde estabas.

### 🔌 Si apagás el portátil

1. Prender el portátil (esperar a que arranque)
2. Tailscale se reconecta solo automáticamente
3. Abrir Termius → conectar
4. `tmux attach` → todo sigue igual

### 📝 Guardar ideas importantes

Dentro de OpenCode en el móvil:

```
/mem_save
  title: "Idea sobre [tema]"
  type: discovery
  content: "**What**: lo que pensé
           **Why**: por qué es importante"
```

---

## 6. Setup actualizado (Moshi + Herdr)

> Desde el 16 de agosto de 2026 el flujo diario usa **Herdr** en vez de tmux/zellij
> y **Moshi** (con moshi-hook) en vez de Termius para notificaciones. Termius sigue
> funcionando como cliente alternativo.

### 6.1 — Desde el móvil (Moshi)

1. Abrir **Moshi** (app del realme)
2. Tocar el host **harcomovil** (`harco@100.122.199.125:22`)
3. Aparecen los workspaces de Herdr (gentleman, tiendananata, glovo-seguimiento...)
4. Tocar el workspace y trabajar

### 6.2 — Notificaciones push

Con **moshi-hook** corriendo en el portátil, llegan notificaciones al móvil cuando
un agente: pide aprobación, termina una tarea, o arranca una sesión.

- Las notificaciones llegan **aunque Moshi esté cerrado** (push por servidor Moshi)
- Para **conectarte** a la sesión: Moshi abierto + **Tailscale activo** en el móvil

### 6.3 — Verificación del daemon

```bash
moshi-hook status                     # paired + herdr/tmux/zellij detectados
systemctl --user is-active moshi-hook # active
```

> Gotchas y replicación completa en `RUNBOOK-SETUP-COMPLETO.md`.

---

## 7. Preguntas Frecuentes

### ¿Puedo programar desde el móvil?

Sí. Tenés **todo** el ecosistema: opencode, neovim, lazygit, yazi, etc.
La experiencia es 100% terminal — exactamente igual que en el portátil.

### ¿Dónde quedan las conversaciones de OpenCode?

OpenCode no guarda historial de chat. Pero **Engram** guarda decisiones importants.
Usá `/mem_save` para preservar ideas clave.

### ¿Qué pasa si cambio de red WiFi?

No importa. **Tailscale funciona sobre cualquier red.** La IP `100.122.199.125` es siempre la misma.

### ¿Es seguro?

Sí:
- SSH solo escucha en la interfaz de Tailscale (`100.122.199.125`)
- Tailscale cifra todo el tráfico (WireGuard)
- Autenticación con llaves SSH (sin contraseñas)
- No hay puertos abiertos en el router

### ¿Y si no tengo Tailscale en el móvil?

No funciona. Tailscale es el **puente** entre el móvil y el portátil.
Sin Tailscale no hay conexión porque no tenés IP pública.

### ¿Puedo conectar desde otra PC en vez del móvil?

Sí. Mismo método:
- Instalar Tailscale en esa PC
- `ssh harco@100.122.199.125`
- `tmux attach`

---

## 8. Referencias

| Recurso | Link |
|---------|------|
| Tailscale | https://tailscale.com |
| Termius | https://termius.com |
| Moshi (terminal móvil) | https://getmoshi.app |
| Moshi hooks | https://getmoshi.app/docs/hooks |
| Herdr docs | https://herdr.dev/docs/ |
| tmux cheat sheet | `tmux list-keys` o https://tmuxcheatsheet.com |
| Engram docs | `engram help` |
| Ecosistema Gentleman | `ECOSISTEMA-GENTLEMAN.md` |
| Phone Manager (móvil) | `~/Documentos/Documentos-HERNAN/movilhernan/README.md` |
| Runbook de replicación | `RUNBOOK-SETUP-COMPLETO.md` |
| Guía Kitty + Herdr | `KITTY-HERDR.md` |

---

## 📌 Datos del Portátil

| Dato | Valor |
|------|-------|
| **Hostname** | PC-harco |
| **Tailscale IP** | `100.122.199.125` |
| **Usuario SSH** | `harco` |
| **Puerto SSH** | `22` |
| **OS** | Linux |
| **Última configuración** | 21 de julio de 2026 |

---

> 🎩 **"Tu portátil no necesita estar en la nube. Tu portátil ES la nube."**
