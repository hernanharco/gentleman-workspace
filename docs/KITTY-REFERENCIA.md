# 🐱 Kitty Terminal — Referencia Rápida

> Terminal GPU con soporte nativo de imágenes.
> Versión: 0.32.2

---

## 📂 Tabs y Splits

| Acción | Atajo |
|--------|-------|
| **Nueva pestaña** | `Ctrl + Shift + t` |
| Pestaña anterior | `Ctrl + Shift + {` |
| Pestaña siguiente | `Ctrl + Shift + }` |
| Cerrar pestaña | `Ctrl + Shift + q` |
| **Split vertical** (panel der) | `Ctrl + Shift + e` |
| **Split horizontal** (panel abajo) | `Ctrl + Shift + o` |
| Moverse entre paneles | `Ctrl + Shift + flechas` |
| Cerrar panel activo | `Ctrl + Shift + w` |
| Redimensionar paneles | `Ctrl + Shift + r` + flechas |
| Siguiente panel | `Ctrl + Shift + ]` |
| Panel anterior | `Ctrl + Shift + [` |

---

## 🖼️ Imágenes (icat)

### Ver una imagen en la terminal

```bash
# Siempre con comillas si la ruta tiene espacios
kitty +kitten icat "ruta/de/la/imagen.png"

# GIFs animados
kitty +kitten icat "animacion.gif"

# Desde internet
curl -s https://ejemplo.com/imagen.jpg | kitty +kitten icat --stdin yes
```

### Atajo en Fish (recomendado)

Para no escribir `kitty +kitten icat` cada vez:

```fish
function icat
    kitty +kitten icat $argv
end
funcsave icat
```

Después:

```bash
icat "mi-imagen.png"
```

### Redimensionar la imagen

```bash
kitty +kitten icat --place 80x40@10x5 imagen.png
#                  ancho×alto @ posX×posY
```

---

## 📝 markdown + imágenes en Neovim

Con `image.nvim` instalado, cuando abrís un archivo `.md`:

```markdown
# Documento con imágenes

El sistema funciona así:

![diagrama](ruta/del/diagrama.png)

Y la captura de pantalla muestra:

![captura](/home/harco/Imágenes/Capturas%20de%20pantalla/mi-captura.png)
```

Las imágenes aparecen **renderizadas directamente en el editor**.

> ⚠️ En la ruta, los espacios se escriben como `%20`
> O simplemente copiás la ruta con Tab completado y se escapa solo

### Atajos de markdown en LazyVim

| Acción | Atajo |
|--------|-------|
| Vista previa del markdown | automático con render-markdown.nvim |
| Insertar imagen | escribí `![](ruta)` |
| Cerrar imagen preview | automático al entrar en modo inserción |

---

## ⚙️ Configuración

Archivo de configuración:

```
~/.config/kitty/kitty.conf
```

### Personalizaciones comunes

```conf
# Fuente
font_family      Iosevka Term Nerd Font
font_size        14.0

# Opacidad (si te gusta ver el fondo)
background_opacity 0.95

# Atajos (si querés cambiarlos)
map ctrl+shift+t new_tab
map ctrl+shift+q close_tab

# Tema oscuro
background #1f1f28
foreground #dcd7ba
```

> ⚠️ `~/.config/kitty/kitty.conf` es el config principal. El layout con Yazi
> (`panel.conf`) se lanza aparte con el alias `panel` o `p` — son cosas distintas.

### 🔠 Tamaño de letra

| Acción | Atajo |
|--------|-------|
| **Agrandar letra** | `Ctrl + Shift + =` |
| **Achicar letra** | `Ctrl + Shift + -` |
| **Resetear tamaño** | `Ctrl + Shift + 0` |

Para que el tamaño quede fijo al abrir Kitty, editá `kitty.conf`:

```conf
font_size 14.0   # ajustá a tu gusto
```

---

## 🐘 Herdr — Multiplexor de Agentes (dentro de Kitty)

> Herdr es un runtime + multiplexor de terminal que vive DENTRO de Kitty.
> Mantiene workspaces, pestañas, paneles y agentes de IA corriendo en un
> servidor en segundo plano, aunque cierres la ventana o se caiga la conexión.
> Versión: 0.8.0

### Empezar

```bash
herdr
```

- Arranca o se re-conecta a la sesión por defecto. No hay que gestionar sockets.
- Si no hay workspaces, Herdr crea uno automático.
- **El prefijo por defecto es `Ctrl+B`** (estilo tmux), no `Ctrl+A`.

### Primeros 5 atajos (los que más se usan)

| Acción | Atajo |
|--------|-------|
| **Nueva pestaña** | `Ctrl+B` luego `C` |
| **Split a la derecha** | `Ctrl+B` luego `V` |
| **Split abajo** | `Ctrl+B` luego `-` |
| **Navegar entre paneles** | `Ctrl+B` luego `H/J/K/L` |
| **Navegar workspaces** | `Ctrl+B` luego `W` |

> "`Ctrl+B` luego `C`" significa: presionás `Ctrl+B`, soltás, y después presionás `C`.

### El resto, por tarea

**Paneles:**

| Acción | Atajo |
|--------|-------|
| Zoom al panel enfocado | `Ctrl+B` luego `Z` |
| Cerrar panel | `Ctrl+B` luego `X` |
| Intercambiar paneles | `Ctrl+B` luego `Shift+H/J/K/L` |
| Modo redimensionar | `Ctrl+B` luego `R` |
| Modo copiar | `Ctrl+B` luego `[` |

**Pestañas:**

| Acción | Atajo |
|--------|-------|
| Siguiente / anterior pestaña | `Ctrl+B` luego `N` / `P` |
| Saltar a pestaña 1–9 | `Ctrl+B` luego `1..9` |
| Renombrar pestaña | `Ctrl+B` luego `Shift+T` |
| Cerrar pestaña | `Ctrl+B` luego `Shift+X` |

**Workspaces y sesión:**

| Acción | Atajo |
|--------|-------|
| **Nuevo workspace** | `Ctrl+B` luego `Shift+N` |
| Renombrar workspace | `Ctrl+B` luego `Shift+W` |
| Cerrar workspace | `Ctrl+B` luego `Shift+D` |
| Selector de workspace | `Ctrl+B` luego `G` |
| **Mostrar/ocultar sidebar** | `Ctrl+B` luego `B` |
| **Despegarte (detach)** | `Ctrl+B` luego `Q` |

> `Ctrl+B` luego `?` muestra TODOS los atajos activos dentro de Herdr.
> En la ayuda de atajos, `/` filtra y `Ctrl+U` limpia el filtro.

### El mouse funciona (no hace falta teclado)

Herdr es mouse-native — podés trabajar sin aprender atajos:

- **Click** en paneles, pestañas, workspaces y agentes para enfocarlos
- **Arrastrar** los bordes de los splits para redimensionar
- **Click derecho** → menú contextual (splits, pestañas)
- **Seleccionar texto arrastrando** → copia directo al portapapeles (sin Ctrl+C)
- **Doble click** en una palabra → la copia
- **Ctrl+Click** en una URL → la abre en el navegador

### Agentes de IA

Ejecutá tu agente dentro de un panel (claude, codex, opencode, pi...):

```bash
claude
```

Herdr lo detecta solo y el **sidebar muestra su estado** en todos los workspaces:
`working`, `blocked`, `done`, `idle`. Así sabés qué proyecto necesita tu atención.

### Persistencia (la clave)

```bash
# Despegarte: todo sigue corriendo
Ctrl+B luego Q

# O directamente cerrá la ventana de Kitty
# El servidor y los agentes NO mueren

# Re-conectarte
herdr

# Detener TODO de verdad (mata los paneles)
herdr server stop
```

### Sesiones con nombre (servidores independientes)

```bash
herdr session list
herdr session attach work
herdr session stop work
herdr session delete work
```

### Kitty + Herdr: notas para que funcione bien

- **Sin conflicto de atajos**: los atajos de Kitty usan `Ctrl+Shift`; el prefijo de Herdr es `Ctrl+B`. No se pisan.
- **Atajos directos**: si querés atajos sin prefijo, la familia segura es `Ctrl+Alt` (Kitty la deja libre). Evitá `Ctrl+Alt+Flechas` (GNOME/KDE la toman) y `Ctrl+Alt+T` (lanzar terminal).
- **Gráficos Kitty**: `icat` y las imágenes de Neovim (image.nvim) funcionan dentro de los paneles de Herdr — Herdr preserva el protocolo gráfico de Kitty.
- **Copiar**: en Herdr no necesitás el Ctrl+Shift+C de Kitty; arrastrando el mouse ya copias.

---

## 🆘 Ayuda

```bash
# Ayuda general
kitty +kitten help

# Ayuda de Herdr
herdr --help

# Todos los atajos de Herdr (dentro de la TUI)
Ctrl+B luego ?

# Documentación de Herdr (en el navegador)
https://herdr.dev/docs/

# Documentación completa (en el navegador)
kitty +kitten docs

# Versión
kitty --version
```

---

> 🎩 Tips para acordarse:
> - `Ctrl + Shift + t` → **t** de tab/pestaña
> - `Ctrl + Shift + e` → **e** de enter (nuevo panel)
> - `Ctrl + Shift + o` → **o** de other (otro panel)
> - `icat` → **i** de image + **cat** de concatenar
> - `Ctrl+B` luego `C` → **c** de create tab (Herdr)
> - `Ctrl+B` luego `W` → **w** de workspaces (Herdr)
> - `Ctrl+B` luego `Q` → **q** de quit client, todo sigue corriendo (Herdr)

---

## 🔗 Fuentes de información

| Recurso | URL |
|---------|-----|
| Kitty docs oficiales | https://sw.kovidgoyal.net/kitty/ |
| Kitty configuración (fuente, atajos) | https://sw.kovidgoyal.net/kitty/conf.html |
| Herdr docs | https://herdr.dev/docs/ |
| Herdr keyboard (atajos) | https://herdr.dev/docs/keyboard/ |
| Herdr configuración | https://herdr.dev/docs/configuration/ |
| Herdr config reference (todas las claves) | https://herdr.dev/docs/config-reference/ |
| Guía completa Kitty + Herdr | `KITTY-HERDR.md` |
| Runbook de replicación en otra máquina | `RUNBOOK-SETUP-COMPLETO.md` |
