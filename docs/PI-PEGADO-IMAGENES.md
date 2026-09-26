# 🖼️ Pi: Pegado de Capturas + Detección de Estado en Herdr

## Fix 1: Pegado de Capturas (Ctrl+V)

### Problema
Al presionar Ctrl+V en Pi, no pegaba imágenes.

### Causa Raíz
Herdr corre como servicio systemd que arranca al boot **antes** de la sesión Wayland. Nunca recibe `WAYLAND_DISPLAY` ni `DISPLAY`.

### Solución
Agregar variables de display al servicio systemd:

**Archivo:** `~/.config/systemd/user/homebrew.herdr.service`

```ini
[Service]
Type=simple
Environment=WAYLAND_DISPLAY=wayland-0
Environment=DISPLAY=:0
Environment=XDG_SESSION_TYPE=wayland
ExecStart="/home/linuxbrew/.linuxbrew/opt/herdr/bin/herdr" "server"
```

```bash
systemctl --user daemon-reload
systemctl --user restart homebrew.herdr.service
```

---

## Fix 2: Detección de Estado en Herdr (círculo de color)

### Problema
El indicador de Pi en la sidebar de Herdr siempre quedaba verde (idle), nunca cambiaba a amarillo (working) ni necesidad de aprobación (blocked).

### Causa Raíz
El manifest remoto de Pi (`remote/pi.toml`) buscaba `"Working..."` pero Pi escribe `"Working"` sin puntos. Además, herdr sobreescribe el archivo local en cada restart.

### Solución
Local override en `~/.config/herdr/agent-detection/pi.toml`:

```toml
id = "pi"
version = "2026.06.10.1"
min_engine_version = 1
updated_at = "2026-09-10T00:00:00Z"
aliases = ["herdr:pi"]

# Match the border when working: ╭─ ❁ working ────╮
# visible_working = true: solo matchea cuando el indicador
# está visible en el viewport actual, NO en el scrollback
[[rules]]
id = "border_working"
state = "working"
priority = 130
region = "whole_recent"
visible_working = true
regex = ["❁ working"]
```

**Config adicional** en `~/.config/herdr/config.toml`:
```toml
[update]
manifest_check = false
```

### Comandos útiles
```bash
# Verificar estado de detección
herdr agent explain wS:p1

# Recargar overrides después de editar
herdr server reload-agent-manifests

# Ver todos los manifests activos
herdr server agent-manifests
```

### Notas importantes
- Los local overrides van en `~/.config/herdr/agent-detection/` (NO en `~/.local/state/`)
- `visible_working = true` es crucial: evita falsos positivos del scrollback
- El símbolo `❁` (U+2741) es del borde working; `✿` (U+273F) es del status bar
- Herdr 0.9.0 tiene soporte completo de local overrides
- OpenCode no tiene este problema porque sus indicadores scrollean
