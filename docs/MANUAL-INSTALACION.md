# 🎩 Provisioning Specification — Ecosistema Gentleman

> **Archivo de especificación para aprovisionamiento automático.**
> La AI (OpenCode + gentle-ai) lee este archivo y ejecuta cada fase.
> El humano solo hace la **Fase 0** — bootstrap mínimo.

---

## 📋 Índice

1. [Fase 0: Bootstrap (Humano)](#fase-0-bootstrap-humano)
2. [Fase 1: Stack Base (AI)](#fase-1-stack-base-ai)
3. [Fase 2: Paquetes Adicionales (AI)](#fase-2-paquetes-adicionales-ai)
4. [Fase 3: Configuraciones (AI)](#fase-3-configuraciones-ai)
5. [Fase 4: Gentleman-Skills (AI)](#fase-4-gentleman-skills-ai)
6. [Fase 5: Verificación (AI)](#fase-5-verificación-ai)
7. [Apéndice A: Referencia de Herramientas](#apéndice-a-referencia-de-herramientas)
8. [Apéndice B: Solución de Problemas](#apéndice-b-solución-de-problemas)
9. [Apéndice C: Atajos](#apéndice-c-atajos)
10. [Apéndice D: Respaldo Manual](#apéndice-d-respaldo-manual)

---

## Fase 0: Bootstrap (Humano)

> ⏱️ ~15 minutos. Esto es lo ÚNICO que hace una persona. Después la AI se encarga.

### Requisitos de hardware

| Recurso | Mínimo | Recomendado |
|---------|--------|-------------|
| RAM | 8 GB | 16 GB |
| Disco | 10 GB libres | 50 GB+ |
| Internet | Necesario | Necesario |

### Sistemas operativos soportados

| SO | Estado |
|----|--------|
| **Linux Ubuntu/Debian** 24.04+ | ✅ Recomendado |
| **Linux Arch** | ✅ |
| **Linux Fedora/RHEL** | ✅ |
| **macOS** (Apple Silicon o Intel) | ✅ |
| **Windows** (vía WSL2) | ⚠️ Soporte parcial |
| **Termux** (Android) | ⚠️ Manual |

### 0.1 — Dependencias base del sistema

```bash
# Ubuntu/Debian
sudo apt update && sudo apt upgrade -y
sudo apt install -y curl git build-essential unzip fontconfig file procps

# Arch
sudo pacman -Syu
sudo pacman -S curl git base-devel unzip fontconfig file procps

# macOS
xcode-select --install
```

### 0.2 — Instalar Homebrew

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Después de instalar, agregar brew al PATH (seguir las instrucciones que muestra el instalador, típicamente):

```bash
# Linux
echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> ~/.bashrc
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# Verificar
brew doctor && brew --version
```

### 0.3 — Instalar gentle-ai

```bash
brew tap Gentleman-Programming/tap
brew install gentle-ai
gentle-ai
```

En el TUI de `gentle-ai`, seleccionar:
```
PRESET: Full Gentleman
  → Incluye: Engram + SDD + Skills + Context7 + GGA + Persona + Permisos + Theme

AGENTES:
☑ OpenCode (recomendado, principal)
☑ Claude Code (opcional)
```

### 0.4 — Configurar API key de Gemini

```bash
echo 'GOOGLE_API_KEY=tu_api_key_aqui' >> ~/.config/opencode/.env
```

> Obtener la API key gratis en: https://aistudio.google.com/apikey

### 0.5 — Iniciar provisioning automático

```bash
# Abrir OpenCode en el directorio del proyecto
cd ~/Documentos/gentleman
opencode . -a gentleman
```

Una vez en OpenCode, decile al modelo:
> **"Ejecutá la especificación de provisioning desde Fase 1 en adelante. El archivo es MANUAL-INSTALACION.md"**

---

## Fase 1: Stack Base (AI)

> La AI ejecuta `gentle-ai` para instalar el stack base completo.
> Esto instala: gentleman-dots, fish, neovim, lazyvim, zellij, starship, kitty, wezterm, iosevka nerd font, opencode, engram, gga, SDD workflow, skills base.

### Comandos

```bash
# gentle-ai ya está instalado (Fase 0). Ejecutar preset completo:
gentle-ai

# Si gentle-ai ya se configuró, verificar estado:
gentle-ai version          # → 1.48+
engram version              # → 1.16+
gga --version               # → 2.10+
```

### Verificar stack base

```bash
fish --version      # → 4.x
nvim --version      # → 0.12.x
zellij --version    # → 0.44.x
starship --version  # → 1.25.x
kitty --version     # → 0.32.x (opcional)
```

### PATH setup

Si Engram o herramientas no están en PATH, ejecutar:

```bash
fish -c "set -U fish_user_paths \$HOME/go/bin \$fish_user_paths"
fish -c "set -Ux PNPM_HOME \$HOME/.local/share/pnpm; set -U fish_user_paths \$PNPM_HOME \$fish_user_paths"
```

---

## Fase 2: Paquetes Adicionales (AI)

> Instalar paquetes extra que NO vienen con gentle-ai.

### 2.1 — Homebrew packages

```bash
brew install \
  atuin \
  bat \
  fd \
  fzf \
  ripgrep \
  lazygit \
  tmux \
  yazi \
  zoxide \
  carapace \
  mkcert \
  xclip \
  gh
```

### 2.2 — npm/pnpm global packages

```bash
npm install -g pnpm

# Globals:
npm install -g \
  @anthropic-ai/claude-code \
  @google/gemini-cli \
  vercel \
  md-to-pdf
```

### 2.3 — Spec: versión esperada post-instalación

| Package | Mínimo |
|---------|--------|
| go | 1.22+ |
| node | v20+ |
| pnpm | 9+ |
| atuin | 18.x |
| bat | 0.26.x |
| fzf | 0.73.x |
| ripgrep | 15.x |
| lazygit | 0.62.x |
| gh | 2.93.x |
| tmux | 3.7+ |
| yazi | 26.x |
| zoxide | 0.9.x |
| gemini-cli | 0.37.x |
| vercel | 54.x |

---

## Fase 3: Configuraciones (AI)

### 3.1 — Restaurar dotfiles con chezmoi

```bash
brew install chezmoi
chezmoi init https://github.com/hernanharco/dotfiles.git
chezmoi diff    # Mostrar diferencias (sin aplicar)
chezmoi apply   # Aplicar configs
```

Archivos que chezmoi restaura:

| Archivo | Contenido |
|---------|-----------|
| `~/.config/fish/config.fish` | Shell config, PATH, aliases |
| `~/.config/nvim/init.lua` | Neovim LazyVim |
| `~/.config/nvim/lua/plugins/*.lua` | Plugins Neovim |
| `~/.config/starship.toml` | Tema prompt |
| `~/.config/zellij/` | Config + plugins Zellij |
| `~/.config/wezterm/wezterm.lua` | Tema WezTerm Gentleman |
| `~/.config/opencode/opencode.json` | Config OpenCode (agentes, MCP, permisos) |
| `~/.bashrc` | Bash fallback |
| `~/.gitconfig` | Git user + defaults |

> **⚠️ chezmoi NO incluye:** plugins de OpenCode (`plugins/`) ni `.env`.
> Ver sección 3.2.

### 3.2 — Copiar plugins de OpenCode

OpenCode carga automáticamente todos los `.ts` de `~/.config/opencode/plugins/`.

```bash
# Copiar desde backup
mkdir -p ~/.config/opencode/plugins
cp /ruta/del/respaldo/plugins/*.ts ~/.config/opencode/plugins/

# También copiar documentación
cp ~/Documentos/gentleman/vision.md ~/.config/opencode/plugins/vision.md
```

Plugins requeridos:

| Archivo | Función |
|---------|---------|
| `vision-assistant.ts` | Análisis de imágenes y videos con Gemini |
| `background-agents.ts` | Delegación async de tareas en segundo plano |
| `engram.ts` | Adapter de memoria persistente Engram |

#### Verificar plugins

```bash
ls -la ~/.config/opencode/plugins/
# Debe mostrar:
#   vision-assistant.ts
#   background-agents.ts
#   engram.ts
#   vision.md (opcional)
```

### 3.3 — Configurar WezTerm (si aplica)

```lua
-- ~/.config/wezterm/wezterm.lua (restaurado por chezmoi)
config.hide_tab_bar_if_only_one_tab = false
```

### 3.4 — Configurar Kitty (si aplica)

```bash
sudo apt install -y kitty    # Linux
brew install --cask kitty    # macOS
```

### 3.5 — Registrar skills en proyectos

```bash
# En cada proyecto donde trabajes:
# Abrir OpenCode y ejecutar:
/skill-registry
```

---

## Fase 4: Gentleman-Skills (AI)

### 4.1 — Clonar repositorio

```bash
git clone https://github.com/Gentleman-Programming/Gentleman-Skills.git \
  ~/Documentos/gentleman/Gentleman-Skills
```

### 4.2 — Instalar skills en OpenCode

```bash
cp -r ~/Documentos/gentleman/Gentleman-Skills/curated/* ~/.config/opencode/skills/
```

### 4.3 — Skills instalados

```
ai-sdk-5/       → Vercel AI SDK
angular/        → Angular
django-drf/     → Django + DRF
github-pr/      → Pull Requests
jira-epic/      → Jira Epics
jira-task/      → Jira Tasks
nextjs-15/      → Next.js 15
playwright/     → Testing E2E
pytest/         → Testing Python
react-19/       → React 19
skill-creator/  → Crear skills nuevas
tailwind-4/     → Tailwind CSS v4
typescript/     → TypeScript
zod-4/          → Validación Zod
zustand-5/      → Estado global
```

---

## Fase 5: Verificación (AI)

> Ejecutar todos los checks para confirmar que el provisioning fue exitoso.

### 5.1 — Stack base

```bash
echo "=== STACK BASE ==="
fish --version
nvim --version | head -1
zellij --version
starship --version
kitty --version
echo "=== NERD FONT ==="
fc-list | grep -i "IosevkaTermNerd" | head -1
```

### 5.2 — AI Layer

```bash
echo "=== AI LAYER ==="
gentle-ai version
engram version
gga --version
opencode --version
claude --version
```

### 5.3 — Paquetes adicionales

```bash
echo "=== BREW PACKAGES ==="
atuin --version
bat --version | head -1
fd --version
fzf --version
rg --version | head -1
lazygit --version
tmux -V
yazi --version | head -1
zoxide --version
gh --version | head -1
```

### 5.4 — Configuraciones

```bash
echo "=== CONFIGS ==="
echo -n "plugins: " && ls ~/.config/opencode/plugins/*.ts 2>/dev/null | wc -l
echo -n "skills: " && ls ~/.config/opencode/skills/ 2>/dev/null | wc -l
echo -n "chezmoi: " && chezmoi diff 2>/dev/null | head -1
echo -n "vision.md: " && ls ~/.config/opencode/plugins/vision.md 2>/dev/null && echo "✓" || echo "✗"
echo -n ".env: " && ls ~/.config/opencode/.env 2>/dev/null && echo "✓" || echo "✗"
echo -n "Gentleman-Skills: " && ls ~/Documentos/gentleman/Gentleman-Skills/curated/ 2>/dev/null | wc -l
```

---

## Apéndice A: Referencia de Herramientas

### Stack base (vía gentle-ai)

| Herramienta | Versión | Comando |
|-------------|---------|---------|
| Fish | 4.7.1 | `fish` |
| Starship | 1.25.1 | Automático en Fish |
| Iosevka Nerd Font | — | Automático |
| Neovim | 0.12.2 | `nvim` |
| LazyVim | 16.0.0 | Automático en `nvim` |
| Zellij | 0.44.3 | `zellij` |
| Kitty | 0.32.2 | `kitty` (opcional) |
| WezTerm | — | `wezterm` (opcional) |
| gentle-ai | 1.48.0 | `gentle-ai` |
| OpenCode | 1.15.13 | `opencode .` |
| Engram | 1.16.1 | `engram search "..."` |
| GGA | 2.10.1 | `gga run` |
| Claude Code | — | `claude` |

### Paquetes adicionales (brew)

| Herramienta | Versión | Comando |
|-------------|---------|---------|
| gh | 2.93.0 | `gh` |
| tmux | 3.7b | `tmux` |
| atuin | 18.16.1 | `atuin search` |
| bat | 0.26.1 | `bat` |
| fd | — | `fd` |
| fzf | 0.73.1 | `fzf` |
| ripgrep | 15.1.0 | `rg` |
| lazygit | 0.62.1 | `lazygit` |
| yazi | 26.5.6 | `yazi` |
| zoxide | 0.9.9 | `z` |
| carapace | 1.7.0 | `carapace` |
| mkcert | 1.4.4 | `mkcert` |
| xclip | — | `xclip` |

### Plugins de OpenCode

| Plugin | Archivo | Función |
|--------|---------|---------|
| Vision Assistant | `vision-assistant.ts` | Analiza imágenes y videos con Gemini |
| background-agents | `background-agents.ts` | Delegación async de tareas |
| Engram | `engram.ts` | Memoria persistente |

### NPM globales

| Paquete | Versión | Comando |
|---------|---------|---------|
| gemini-cli | 0.37.2 | `gemini-cli` |
| vercel | 54.18.3 | `vercel` |
| md-to-pdf | 5.2.5 | `md-to-pdf` |
| claude-code | — | `claude` |

---

## Apéndice B: Solución de Problemas

### B.1 — "opencode . → Error: agent coder not found"

**Causa**: OpenCode espera un agente llamado "coder"
**Solución**: Ejecutar con el agente explícito:
```bash
opencode . -a gentleman
```
O verificar que `~/.config/opencode/opencode.json` tenga el agente "coder" definido.

### B.2 — "command not found: engram" (o cualquier herramienta)

**Causa**: El PATH de Fish no incluye Homebrew o Go.
**Solución**: Verificar `~/.config/fish/config.fish`:
```fish
eval (/home/linuxbrew/.linuxbrew/bin/brew shellenv)
set -x PATH $HOME/go/bin $PATH
set -x PATH $HOME/.opencode/bin $PATH
```

### B.3 — Fish da error de sintaxis

**Causa**: Config dañada o `end` fantasma.
**Solución**: Revisar `~/.config/fish/config.fish` y corregir bloques `if/end`. Si no hay backup, restaurar desde chezmoi:
```bash
chezmoi apply ~/.config/fish/config.fish
```

### B.4 — LazyVim no carga o tarda mucho

**Causa**: Primera vez — está descargando plugins.
**Solución**: Esperar a que termine. Si se corta, ejecutar `nvim .` de nuevo y continúa.

### B.5 — Las pestañas de WezTerm/Kitty no se ven

**Causa**: `hide_tab_bar_if_only_one_tab = true`
**Solución**: Cambiar a `false` en la config de WezTerm:
```lua
config.hide_tab_bar_if_only_one_tab = false
```

### B.6 — Vision Assistant no carga

**Causa**: Plugin faltante o API key sin configurar.
**Solución**:
```bash
# Verificar que el plugin existe
ls ~/.config/opencode/plugins/vision-assistant.ts

# Verificar API key
cat ~/.config/opencode/.env | grep GOOGLE_API_KEY

# Probar manualmente
opencode . -a gentleman-vision
```

---

## Apéndice C: Atajos

### Flujo de trabajo diario

```bash
cd ~/mi-proyecto
zellij                    # Abrir multiplexor
  → nvim .                # Editar código
  → Ctrl+p → p            # Abrir terminal al lado
  → opencode . -a coder   # Abrir AI asistente

# Consultar memoria
engram search "decisión sobre auth"

# Code review
gga run

# Actualizar
gentle-ai upgrade
```

### Comandos útiles de Fish

| Comando | Qué hace |
|---------|----------|
| `carpeta<Tab>` | Autocompleta |
| `git st<Tab>` | Sugiere `git status` |
| `hist` | Muestra historial |
| `cd -` | Vuelve al directorio anterior |
| `set -U` | Variable universal (persiste) |
| `exec fish` | Recargar Fish |

### Atajos de LazyVim

| Tecla | Qué hace |
|-------|----------|
| `<Space>` | Menú principal (leader) |
| `<Space> + f + f` | Buscar archivos |
| `<Space> + f + w` | Buscar palabras |
| `<Space> + e` | Explorador de archivos |

### Atajos de Zellij

| Tecla | Qué hace |
|-------|----------|
| `Ctrl + p → t` | Nueva terminal |
| `Ctrl + p → p` | Nuevo panel |
| `Ctrl + p → n` | Nueva pestaña |
| `Ctrl + p → x` | Cerrar panel |
| `Ctrl + p → q` | Salir |
| `Ctrl` + `flechas` | Moverse entre paneles |

---

## Apéndice D: Respaldo Manual

> Lo que **no** se recupera automáticamente con chezmoi o gentle-ai.
> Hay que copiarlo a mano cuando se migra de equipo.

### Archivos a respaldar

| Archivo | Por qué no está en chezmoi |
|---------|---------------------------|
| `~/.config/opencode/plugins/*.ts` | Son binarios/librerías, no configs |
| `~/.config/opencode/.env` | Contiene API keys (secreto) |
| `~/Documentos/gentleman/vision.md` | Documentación de respaldo |

### Comandos de backup

```bash
# En la PC origen
mkdir -p ~/backup-gentleman
cp -r ~/.config/opencode/plugins/ ~/backup-gentleman/plugins
cp ~/.config/opencode/.env ~/backup-gentleman/.env
cp ~/Documentos/gentleman/vision.md ~/backup-gentleman/vision.md

# Respaldo completo (opcional, comprimido)
tar -czf ~/backup-gentleman.tar.gz ~/backup-gentleman/
```

### Comandos de restauración

```bash
# En la PC nueva
tar -xzf ~/backup-gentleman.tar.gz -C ~/
cp ~/backup-gentleman/plugins/* ~/.config/opencode/plugins/
cp ~/backup-gentleman/.env ~/.config/opencode/.env
cp ~/backup-gentleman/vision.md ~/Documentos/gentleman/vision.md
```

---

> **🎩 "El código es el medio, no el fin. La arquitectura es el arte de hacer que el código
>  cuente una historia clara. El AI acelera el proceso, pero el arquitecto es quien
>  decide qué historia contar."** — Gentleman Programming
