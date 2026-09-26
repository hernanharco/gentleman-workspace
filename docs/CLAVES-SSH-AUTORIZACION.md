# Claves SSH — Ubicación y Autorización

Referencia de dónde están las claves SSH y cómo se autoriza un dispositivo
(especialmente el móvil) para conectarse a PC-HARCO sin repetir configuraciones.

---

## 1. Claves del portátil (PC-HARCO)

| Archivo | Ruta | Permisos | Función |
|---------|------|----------|---------|
| **Clave privada** | `~/.ssh/id_ed25519` | `600` | La que usa PC-HARCO para conectarse a otras máquinas |
| **Clave pública** | `~/.ssh/id_ed25519.pub` | `644` | La que se copia a otros equipos para autorizar a PC-HARCO |
| **Clave de rescate (priv)** | `~/.ssh/id_rescue` | `600` | Backup de emergencia |
| **Clave de rescate (pub)** | `~/.ssh/id_rescue.pub` | `644` | Backup de emergencia |
| **Claves autorizadas** | `~/.ssh/authorized_keys` | `600` | Claves públicas de dispositivos que PUEDEN entrar a PC-HARCO |

> ⚠️ **Regla de oro:** la clave **privada** (`id_ed25519`, `id_rescue`) NUNCA
> sale de PC-HARCO ni se comparte. Solo se comparten las claves **públicas**.

---

## 2. Cómo se autoriza un dispositivo para entrar a PC-HARCO

Para que un dispositivo (por ejemplo el móvil con Termux) pueda conectarse por SSH
a PC-HARCO, su **clave pública** debe estar en:

```
/home/harco/.ssh/authorized_keys
```

**Procedimiento (lo hace el agente desde PC-HARCO):**

1. Recibir del móvil su clave pública (línea `ssh-ed25519 AAAA...`).
2. Añadirla al final de `~/.ssh/authorized_keys`:

   ```bash
   echo "<clave-publica-del-movil>" >> /home/harco/.ssh/authorized_keys
   chmod 600 /home/harco/.ssh/authorized_keys
   ```

3. Verificar que quedó:

   ```bash
   grep -c "ssh-ed25519" /home/harco/.ssh/authorized_keys
   ```

> El móvil (Termux) genera su par en `~/.ssh/` con:
> `ssh-keygen -t ed25519 -f ~/.ssh/id_ed25519 -N ""`

---

## 3. Nota importante: PC-HARCO no tiene contraseña de sistema

El usuario `harco` **no tiene contraseña de sistema** (solo entra por clave SSH).
Por eso es obligatorio autorizar la clave pública del móvil en `authorized_keys`
antes de poder conectarse. No se puede usar usuario+contraseña.

---

## 4. ¿Y si prefieres NO usar claves? → Tailscale SSH

PC-HARCO tiene **Tailscale SSH activo** (`RunSSH: true`). Esto permite conectarse
desde el móvil **sin clave SSH**, autenticando con la cuenta de Tailscale
(`hernan.harco@gmail.com`):

```bash
# Desde Termux (el móvil) — autentica por tu cuenta de Tailscale, sin clave:
ssh harco@100.122.199.125
```

Verificado OK: la conexión por Tailscale SSH como `harco` funciona y encuentra
`herdr`.

**Datos de red Tailscale (PC-HARCO):**

| Dato | Valor |
|------|-------|
| Hostname Tailscale | `pc-harco` |
| IP Tailscale | `100.122.199.125` |
| (Móvil realme-c75) | `100.105.18.71` |
| (IAN-PC) | `100.102.83.74` |
| (Hetzner) | `100.111.99.61` |

---

## 5. Contraseñas sudo (NO son claves SSH)

Las contraseñas sudo de cada máquina están en:

```
/home/harco/.env.passwords   (permisos 600, solo lectura para harco)
```

Variables definidas: `PC_HARCO_SUDO`, `IAN_PC_SUDO`.

Uso:

```bash
source ~/.env.passwords
echo "$PC_HARCO_SUDO" | sudo -S <comando>               # en PC-HARCO
ssh ian-pc "echo '$IAN_PC_SUDO' | sudo -S <comando>"    # en IAN-PC
```

> ⚠️ Este archivo contiene secretos en texto plano. Es una decisión del proyecto,
> pero conviene mantenerlo con permisos `600` y no compartirlo.

---

## 6. Herramientas de agente (Herdr)

| Dato | Valor |
|------|-------|
| Binario herdr | `/home/linuxbrew/.linuxbrew/bin/herdr` |
| Sesiones | `tiendananata`, `inventario-tiendas`, `glovo-seguimiento`, `gentleman`, `portatil` |

Para gestionar sesiones de Herdr desde el móvil:

```bash
# dentro de la sesión SSH (por Tailscale o por clave):
herdr
```

---

## 7. Resumen de conexiones rápidas desde el móvil (Termux)

```bash
# Opción A — Tailscale SSH (sin clave, con tu cuenta):
ssh harco@100.122.199.125

# Opción B — SSH por clave (tras autorizar la clave pública del móvil):
ssh -i ~/.ssh/id_ed25519 harco@100.122.199.125
```
