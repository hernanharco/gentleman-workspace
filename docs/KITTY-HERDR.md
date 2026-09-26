# 🐘 Kitty + Herdr — Guía de Trabajo

> Combinación de terminal GPU (Kitty) + runtime/multiplexor de agentes (Herdr).
> Herdr vive DENTRO de Kitty: mantiene workspaces, pestañas, paneles y agentes de IA
> corriendo en un servidor en segundo plano, aunque cierres la ventana o se caiga la conexión.
>
> Kitty: 0.32.2 · Herdr: 0.8.0 · Instalado vía Homebrew (`brew install herdr`)

---

## ✅ Por qué esta combinación

| Criterio | Kitty + Herdr | WezTerm solo |
|----------|---------------|--------------|
| Disco | ~30 MB (6.8 + 23) | 24 MB |
| RAM en uso | ~172 MB (150 + 22) | ~190 MB |
| Sidebar de proyectos | ✅ Sí (workspaces) | ❌ No |
| Estado de agentes IA | ✅ Sí (working/blocked/done/idle) | ❌ No |
| Persistencia de sesión | ✅ Sí (servidor en segundo plano) | Parcial (mux integrado) |

**Conclusión**: más ligero en RAM, cumple el objetivo de accesos directos a proyectos
y es el único de los dos con conciencia de agentes de IA.

---

## 🚀 Empezar

```bash
herdr
```

- Arranca o se re-conecta a la sesión por defecto. No hay que gestionar sockets.
- Si no hay workspaces, Herdr crea uno automático.
- Cerrar la ventana de Kitty NO mata los procesos: el servidor sigue corriendo.

**Detener todo de verdad** (mata los paneles):

```bash
herdr server stop
```

---

## 🗂️ Workspaces = tus proyectos (accesos directos)

Cada workspace es un proyecto con su propio directorio. **Se crean una vez en la TUI
y Herdr los restaura automáticamente** en cada inicio desde el estado de sesión —
no se definen en el archivo de configuración.

1. `Ctrl+B` luego `Shift+N` → nuevo workspace
2. Escribís el nombre (p. ej. `gentleman`) y la ruta (p. ej. `/media/datos/Archivos_Personales/Documentos/gentleman`)
3. `Ctrl+B` luego `W` → navegar/volver a cualquiera de tus workspaces

Ejemplos de workspaces de este equipo:

- `gentleman` → `/media/datos/Archivos_Personales/Documentos/gentleman`
- `skills` → `/media/datos/Archivos_Personales/Documentos/gentleman/Gentleman-Skills`

---

## ⌨️ Atajos esenciales (prefijo por defecto: `Ctrl+B`)

> "`Ctrl+B` luego `C`" = presionás `Ctrl+B`, soltás, y después presionás `C`.

### Los 5 primeros

| Acción | Atajo |
|--------|-------|
| Nueva pestaña | `Ctrl+B` luego `C` |
| Split a la derecha | `Ctrl+B` luego `V` |
| Split abajo | `Ctrl+B` luego `-` |
| Navegar entre paneles | `Ctrl+B` luego `H/J/K/L` |
| Navegar workspaces | `Ctrl+B` luego `W` |

### Paneles

| Acción | Atajo |
|--------|-------|
| Zoom al panel enfocado | `Ctrl+B` luego `Z` |
| Cerrar panel | `Ctrl+B` luego `X` |
| Intercambiar paneles | `Ctrl+B` luego `Shift+H/J/K/L` |
| Modo redimensionar | `Ctrl+B` luego `R` |
| Modo copiar | `Ctrl+B` luego `[` |
| Ciclar panel siguiente/anterior | `Ctrl+B` luego `Tab` / `Shift+Tab` |

### Pestañas

| Acción | Atajo |
|--------|-------|
| Siguiente / anterior pestaña | `Ctrl+B` luego `N` / `P` |
| Saltar a pestaña 1–9 | `Ctrl+B` luego `1..9` |
| Renombrar pestaña | `Ctrl+B` luego `Shift+T` |
| Cerrar pestaña | `Ctrl+B` luego `Shift+X` |

### Workspaces y sesión

| Acción | Atajo |
|--------|-------|
| Nuevo workspace | `Ctrl+B` luego `Shift+N` |
| Renombrar workspace | `Ctrl+B` luego `Shift+W` |
| Cerrar workspace | `Ctrl+B` luego `Shift+D` |
| Selector de workspace | `Ctrl+B` luego `G` |
| Mostrar/ocultar sidebar | `Ctrl+B` luego `B` |
| Despegarte (detach) | `Ctrl+B` luego `Q` |
| Recargar config | `Ctrl+B` luego `Shift+R` |

> `Ctrl+B` luego `?` muestra TODOS los atajos activos. `/` filtra, `Ctrl+U` limpia el filtro.

---

## 🖱️ El mouse funciona (sin aprender teclado)

Herdr es mouse-native:

- **Click** en paneles, pestañas, workspaces y agentes para enfocar
- **Arrastrar** bordes de splits para redimensionar
- **Click derecho** → menú contextual
- **Seleccionar texto arrastrando** → copia al portapapeles (sin Ctrl+C)
- **Doble click** en una palabra → la copia
- **Ctrl+Click** en una URL → la abre en el navegador

---

## 🤖 Agentes de IA

Ejecutá tu agente dentro de un panel (claude, codex, opencode, pi...):

```bash
claude
```

Herdr lo detecta solo y el **sidebar muestra su estado** en todos los workspaces:
`working`, `blocked`, `done`, `idle`. Así sabés qué proyecto necesita tu atención.

---

## ⚙️ Configuración (`~/.config/herdr/config.toml`)

Herdr funciona sin config. Creá uno solo cuando quieras personalizar.

```bash
# Ver el config completo con comentarios
herdr --default-config

# Crear tu config desde los defaults
herdr --default-config > ~/.config/herdr/config.toml

# Recargar el config en caliente (sin reiniciar paneles)
herdr server reload-config
```

### Config recomendado

```toml
# Ocultar el onboarding en el primer arranque
onboarding = false

# Tema (por defecto: catppuccin)
[theme]
name = "catppuccin"

# Notificaciones cuando un agente termina o pide input
[ui.toast]
delivery = "system"       # herdr | terminal | system | off (el de esta máquina: system)
delay_seconds = 1

# Sonido al cambiar estado los agentes
[ui.sound]
enabled = true
```

### Notas de configuración

- **Prefijo**: `[keys] prefix = "ctrl+b"` (cambiable a `"ctrl+a"` si preferís el estilo del video de Alan)
- **Shell por defecto**: `[terminal] default_shell = "fish"` (si querés que los paneles nuevos usen fish)
- **Gráficos Kitty dentro de Herdr**: `[experimental] kitty_graphics = true` — experimental, desactivado por defecto
- **Restaurar conversaciones de agentes**: `[session] resume_agents_on_restore = true` (default)
- **Atajos sin prefijo**: la familia segura es `Ctrl+Alt` (Kitty la deja libre). Evitá `Ctrl+Alt+Flechas` (GNOME/KDE) y `Ctrl+Alt+T` (lanzar terminal).

---

## 🔌 Kitty + Herdr: compatibilidad

- **Sin conflicto de atajos**: los atajos de Kitty usan `Ctrl+Shift`; el prefijo de Herdr es `Ctrl+B`. No se pisan.
- **Gráficos Kitty**: `icat` y las imágenes de Neovim (image.nvim) funcionan dentro de los paneles de Herdr — Herdr preserva el protocolo gráfico de Kitty.
- **Copiar**: en Herdr no necesitás el `Ctrl+Shift+C` de Kitty; arrastrando el mouse ya copias.

---

## 📱 Notificaciones al móvil (Moshi + moshi-hook)

Combinación usada en esta máquina (setup del video de Gentle AI):

| Componente | Rol |
|------------|-----|
| **Moshi** (app móvil) | Terminal SSH en el teléfono; detecta Herdr y muestra los workspaces |
| **moshi-hook** (daemon en la máquina) | Envía eventos de agentes → notificaciones push al móvil |
| **Tailscale** (móvil) | Red privada — debe estar conectado para que Moshi llegue a la máquina |

Comandos útiles del daemon:

```bash
moshi-hook status                     # estado + multiplexers detectados
moshi-hook logs -f                    # logs en vivo
systemctl --user is-active moshi-hook # → active
```

> ⚠️ **Gotcha**: si `moshi-hook status` no detecta herdr/tmux/zellij, el servicio
> systemd no tiene el PATH de linuxbrew. Ver RUNBOOK-SETUP-COMPLETO.md (paso 3.5).
> Las notificaciones push llegan aunque Moshi esté en segundo plano; solo para
> conectarte y ver la sesión necesitás Moshi abierto + Tailscale activo.

---

## 🆘 Ayuda y troubleshooting

```bash
herdr --help            # Ayuda de CLI
Ctrl+B luego ?          # Todos los atajos activos (dentro de Herdr)
herdr server reload-config   # Recargar config sin reiniciar
herdr server stop       # Detener servidor y paneles

# Logs (rotación automática)
~/.config/herdr/herdr.log
~/.config/herdr/herdr-client.log
~/.config/herdr/herdr-server.log

# Documentación oficial
https://herdr.dev/docs/
```

---

## 🔗 Fuentes de información

| Recurso | URL |
|---------|-----|
| Herdr docs (índice) | https://herdr.dev/docs/ |
| Herdr quick start | https://herdr.dev/docs/quick-start/ |
| Herdr keyboard | https://herdr.dev/docs/keyboard/ |
| Herdr configuración | https://herdr.dev/docs/configuration/ |
| Herdr config reference | https://herdr.dev/docs/config-reference/ |
| Herdr persistencia y remoto | https://herdr.dev/docs/persistence-remote/ |
| Herdr agent automation | https://herdr.dev/docs/agent-automation/ |
| Moshi docs | https://getmoshi.app/docs |
| Moshi hooks (moshi-hook) | https://getmoshi.app/docs/hooks |
| Moshi + Herdr | https://getmoshi.app/docs/herdr |
| Moshi push notifications | https://getmoshi.app/docs/notifications |
| Kitty docs | https://sw.kovidgoyal.net/kitty/ |
| Runbook de replicación | `RUNBOOK-SETUP-COMPLETO.md` |
| Acceso remoto (guía local) | `ACCESO-REMOTO.md` |

---

> 🎩 Recordatorio:
> - `Ctrl+B` luego `C` → **c** de create tab
> - `Ctrl+B` luego `W` → **w** de workspaces
> - `Ctrl+B` luego `Q` → **q** de quit client, todo sigue corriendo
> - `Ctrl+B` luego `?` → ayuda de atajos siempre disponible
