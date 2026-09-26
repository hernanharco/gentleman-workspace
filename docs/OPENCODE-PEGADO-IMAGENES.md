# 🖼️ OpenCode — Pegar capturas de pantalla en la conversación

> Cómo pegar imágenes (capturas) dentro del TUI de OpenCode.
> Probado con: Kitty, Ubuntu 24.04 (GNOME/Wayland), OpenCode 1.15.13.

---

## ✅ Lo que funciona (resumen)

| Acción | Atajo |
|--------|-------|
| Pegar imagen o texto en OpenCode | `Ctrl + V` (dentro de OpenCode) |
| Pegar texto desde el portapapeles (Kitty) | `Ctrl + Shift + V` |

**No hay que configurar NADA en Kitty** para pegar imágenes. OpenCode lee el
portapapeles del sistema directamente; la terminal solo tiene que dejar pasar la
tecla.

---

## 🔍 Cómo funciona por dentro

OpenCode tiene una acción `prompt.paste` (por defecto `Ctrl + V`) que lee el
portapapeles del SISTEMA, no el de la terminal:

```ts
// packages/tui/src/clipboard.ts (Linux)
const wayland = await command("wl-paste", ["-t", "image/png"])       // 1º intento
...
const x11 = await command("xclip", ["-selection", "clipboard", "-t", "image/png", "-o"]) // 2º intento
```

- Si el portapapeles tiene imagen (`mime image/png`) → la adjunta al prompt.
- Si tiene texto → lo inserta como texto.
- En WezTerm el `Ctrl + Alt + V` funcionaba porque era un paste **del terminal**
  (envía el texto del portapapeles) y OpenCode resolvía el archivo o disparaba
  `prompt.paste` ante un paste vacío. En Kitty el equivalente sería
  `paste_from_clipboard`, pero **NO sirve para imágenes** (solo envía texto).

---

## 🛠️ El problema real (Wayland + falta de wl-clipboard)

**Síntoma:** `Ctrl + V` en OpenCode no adjuntaba la captura, sin ningún error.

**Causa raíz:** sesión **Wayland** con solo `xclip` instalado.
1. `wl-paste` no existía → primer intento fallaba en silencio.
2. El fallback `xclip` habla con el servidor **X11**, pero la captura está en el
   portapapeles de **Wayland** → nunca ve la imagen.

**Fix (una línea):**

```bash
sudo apt install wl-clipboard
```

No hace falta reiniciar OpenCode (lanza la herramienta en cada pegado).

---

## 🧪 Verificación

Después de tomar una captura que copie al portapapeles:

```bash
wl-paste --list-types            # debe aparecer image/png
wl-paste -t image/png | wc -c    # número > 0 (0 = no hay imagen)
```

> Si `wl-paste` dice `Clipboard content is not available as requested type
> "image/png"` es normal cuando el portapapeles no tiene imagen en ese momento.

### Tomar captura directo al portapapeles

- **GNOME:** `Ctrl + PrtSc` (pantalla completa) o `PrtSc` → "Selección" → "Copiar al portapapeles"
- **CLI:** `gnome-screenshot -a -c` (región → portapapeles)
- **Archivo → portapapeles:** `wl-copy < ~/Pictures/captura.png`

---

## 🧯 Troubleshooting

| Problema | Causa probable | Solución |
|----------|----------------|----------|
| `Ctrl + V` no pega imagen | Falta `wl-clipboard` (Wayland) o `xclip` (X11) | `sudo apt install wl-clipboard` |
| El paste de Kitty solo pega texto | `Ctrl + Shift + V` es paste del terminal | Usar `Ctrl + V` dentro de OpenCode |
| `xclip` no devuelve nada | Sesión Wayland, portapapeles separado | Instalar `wl-clipboard` |
| Quiero `Ctrl + Alt + V` en Kitty | Músculo de WezTerm | NO mapearlo en kitty.conf (se traga la tecla y solo envía texto); configurarlo en `~/.config/opencode/tui.json`: `"keybinds": { "input_paste": "ctrl+v,ctrl+alt+v" }` |

---

## 🔗 Referencias

- Código fuente: `packages/tui/src/clipboard.ts` y `component/prompt/index.tsx` (repo anomalyco/opencode)
- Ver también: [KITTY-REFERENCIA.md](./KITTY-REFERENCIA.md)
