# 🖥️ Ecosistema Gentleman en Servidor Hetzner

> **Acceder al ecosistema desde cualquier dispositivo (PC, celular, tablet)**
> sin depender de Termux ni de recursos limitados.

---

## 🌐 Datos del Servidor

| Dato | Valor |
|------|-------|
| **Nombre** | hetzner-srv-elrincondeharco-01 |
| **Tailscale IP** | `100.111.99.61` |
| **Usuario** | hernan.harco@gmail.com |
| **OS** | Linux 6.8.0-generic (Ubuntu) |
| **Conexión** | vía Tailscale desde cualquier dispositivo |

---

## 🏗️ Arquitectura Propuesta

```
📱 CELULAR / TABLET / PC
   ├── VPN: Tailscale (siempre conectado)
   ├── Terminal: SSH a hetzner-srv (vía Termux, JuiceSSH, etc.)
   └── Web: Interfaz RinconAI (frontend Astro+Svelte)
                │
                ▼
🖥️ SERVIDOR HETZNER (100.111.99.61)
   ├── 🧠 gentle-ai (orquestador)
   ├── 🤖 OpenCode / Claude Code
   ├── 💾 Engram (memoria persistente)
   ├── 🐟 Fish + Starship + LazyVim
   ├── 😇 GGA (code review)
   └── 🌐 RinconAI (web frontend en Go)
```

---

## 🎯 Ventajas vs Termux en el Celular

| Aspecto | Termux (celular) | Servidor Hetzner |
|---------|-----------------|------------------|
| **RAM** | Limitada (Android mata procesos) | 8 GB+ |
| **Batería** | Se agota (5% = apagón) | 24/7 |
| **Arquitectura** | ARM64 (muchos bins no compilados) | x86_64 (todo funciona) |
| **Señal 9 (SIGKILL)** | 😤 Constante | ✅ Nunca |
| **Acceso** | Solo desde el celu | Desde cualquier dispositivo |
| **Disponibilidad** | Cuando el celu está encendido | 24/7 |

---

## 📋 Pendiente

- [ ] SSH al servidor
- [ ] Instalar gentle-ai + Engram + OpenCode
- [ ] Clonar dotfiles con chezmoi
- [ ] Configurar LazyVim
- [ ] Desplegar interfaz web RinconAI
- [ ] Probar acceso desde el celular

---

## 🔗 Conexión desde cualquier lado

```bash
# Desde la PC (ya funciona por Tailscale)
ssh 100.111.99.61

# Desde el celular (Termux)
pkg install openssh
ssh 100.111.99.61

# O usar JuiceSSH / Termius desde Play Store
```

---

> **Prioridad**: Tener el ecosistema corriendo en el servidor es más
> importante que hacerlo funcionar en Termux. El servidor es el caballo
> de batalla. El celu es solo el cliente.
