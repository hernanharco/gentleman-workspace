# 🎩 Ecosistema Gentleman — Guía de Instalación Completa

> **Objetivo**: Tener EL MISMO entorno de desarrollo que Alan (Gentleman Programming).
> Stack completo: terminal + editor + AI + skills → para convertirte en arquitecto de software.

---

## 📋 Índice

1. [Mapa del Ecosistema](#1-mapa-del-ecosistema)
2. [Prerequisitos](#2-prerequisitos)
3. [Paso 1: Gentleman.Dots — Dev Environment](#3-paso-1-gentlemandots--dev-environment)
4. [Paso 2: gentle-ai — AI Layer](#4-paso-2-gentle-ai--ai-layer)
5. [Paso 3: Gentleman-Skills — Coding Patterns](#5-paso-3-gentleman-skills--coding-patterns)
6. [Paso 4: Configuración de Agentes AI](#6-paso-4-configuración-de-agentes-ai)
7. [Arquitectura del Stack Completo](#7-arquitectura-del-stack-completo)
8. [Ruta de Aprendizaje: De Dev a Arquitecto](#8-ruta-de-aprendizaje-de-dev-a-arquitecto)
9. [Referencias](#9-referencias)

---

## 1. Mapa del Ecosistema

```
┌──────────────────────────────────────────────────────────────────┐
│                    ECOSISTEMA GENTLEMAN                           │
├──────────────────────────────────────────────────────────────────┤
│                                                                   │
│   ┌──────────────────────────────────────────────────────────┐   │
│   │  CAPA 1: GENTLEMAN.DOTS (⭐ 1.8k)                        │   │
│   │  "Dev Environment"                                        │   │
│   │                                                           │   │
│   │  🖥️ Terminal: Ghostty / Kitty / WezTerm / Alacritty      │   │
│   │  🐚 Shell:     Fish / Zsh+Powerlevel10k / Nushell        │   │
│   │  📟 Multiplex: Tmux / Zellij                              │   │
│   │  ✍️ Editor:    Neovim + LazyVim                           │   │
│   │  🎨 Prompt:    Starship                                   │   │
│   │  🎮 Bonus:     Vim Mastery Trainer (RPG)                  │   │
│   └──────────────────────────────────────────────────────────┘   │
│                              │                                     │
│                              ▼                                     │
│   ┌──────────────────────────────────────────────────────────┐   │
│   │  CAPA 2: GENTLE-AI (⭐ 3.6k)                             │   │
│   │  "AI Development Layer"                                  │   │
│   │                                                           │   │
│   │  🧠 Engram     → Memoria persistente                      │   │
│   │  📋 SDD        → Workflow (Spec-Driven Development)       │   │
│   │  🛠️ Skills     → Patrones de coding                       │   │
│   │  📚 Context7   → Documentación on-demand                  │   │
│   │  😇 GGA        → Code review con AI                       │   │
│   │  🎭 Persona    → Estilo Gentleman                         │   │
│   └──────────────────────────────────────────────────────────┘   │
│                              │                                     │
│                              ▼                                     │
│   ┌──────────────────────────────────────────────────────────┐   │
│   │  CAPA 3: GENTLEMAN-SKILLS (⭐ 540)                        │   │
│   │  "Coding Patterns"                                        │   │
│   │                                                           │   │
│   │  React 19 │ Next.js 15 │ TypeScript │ Tailwind 4          │   │
│   │  Zod 4    │ Playwright │ Go Testing │ Angular             │   │
│   │  + más contribuciones de la comunidad                     │   │
│   └──────────────────────────────────────────────────────────┘   │
│                              │                                     │
│                              ▼                                     │
│   ┌──────────────────────────────────────────────────────────┐   │
│   │  CAPA 4: AGENTES AI                                       │   │
│   │                                                           │   │
│   │  Claude Code (principal)  │ OpenCode │ Cursor             │   │
│   │  Gemini CLI │ VS Code Copilot │ Codex │ Windsurf         │   │
│   │  Antigravity │ Kiro IDE                                   │   │
│   └──────────────────────────────────────────────────────────┘   │
│                                                                   │
└──────────────────────────────────────────────────────────────────┘
```

### Repositorios Oficiales

| Repo | URL | Propósito |
|------|-----|-----------|
| Gentleman.Dots | https://github.com/Gentleman-Programming/Gentleman.Dots | Dev environment |
| gentle-ai | https://github.com/Gentleman-Programming/gentle-ai | AI layer |
| engram | https://github.com/Gentleman-Programming/engram | Memoria persistente |
| Gentleman-Skills | https://github.com/Gentleman-Programming/Gentleman-Skills | Coding patterns |
| gga | https://github.com/Gentleman-Programming/gentleman-guardian-angel | Code review AI |

---

## 2. Prerequisitos

### Sistema

- **OS**: Linux (Ubuntu/Debian, Arch, Fedora), macOS, o Windows con WSL
- **Git**: `git --version` → 2.40+
- **Curl**: `curl --version`
- **Homebrew**: Instalado en Linux o macOS
- **Go 1.24+**: `go version`
- **Node.js 20+**: `node --version`

### Instalar Homebrew (Linux)

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
```

### Instalar Go (si no está)

```bash
brew install go
```

### Verificar todo

```bash
brew doctor
git --version
go version
node --version
```

---

## 3. Paso 1: Gentleman.Dots — Dev Environment

> **⚠️ IMPORTANTE**: Este paso se hace **PRIMERO**. La documentación oficial dice:
> *"Install Gentleman.Dots first for your dev environment, then AI Gentle Stack for the AI layer on top."*

### 3.1 Instalar Gentleman.Dots

**Opción A: Homebrew (recomendada)**

```bash
brew tap Gentleman-Programming/tap
brew install gentleman-dots
gentleman-dots
```

**Opción B: Binario directo (Linux)**

```bash
# Linux x86_64
curl -fsSL https://github.com/Gentleman-Programming/Gentleman.Dots/releases/latest/download/gentleman-installer-linux-amd64 -o gentleman-dots

# Linux ARM64
curl -fsSL https://github.com/Gentleman-Programming/Gentleman.Dots/releases/latest/download/gentleman-installer-linux-arm64 -o gentleman-dots

chmod +x gentleman-dots
./gentleman-dots
```

### 3.2 Qué instala Gentleman.Dots

El instalador TUI (interfaz interactiva) te guía para seleccionar:

#### Terminales
| App | Descripción | Instalar? |
|-----|-------------|-----------|
| **Ghostty** | Terminal nativa GPU (recomendada en macOS) | ✅ |
| **Kitty** | Terminal GPU multiplataforma | Opcional |
| **WezTerm** | Terminal GPU configurable en Lua | Opcional |
| **Alacritty** | Terminal minimalista GPU | Opcional |

#### Shells
| Shell | Descripción | Instalar? |
|-------|-------------|-----------|
| **Fish** | Shell moderno con autosugerencias out-of-the-box | ✅ RECOMENDADO |
| **Zsh + Powerlevel10k** | Zsh con tema bonito | Alternativa |
| **Nushell** | Shell tipo tabla (experimental) | Opcional |

#### Multiplexores
| App | Descripción | Instalar? |
|-----|-------------|-----------|
| **Tmux** | Multiplexor clásico | ✅ |
| **Zellij** | Multiplexor moderno (Rust) | Alternativa |

#### Editor
| App | Descripción | Instalar? |
|-----|-------------|-----------|
| **Neovim + LazyVim** | Editor con LSP, AI, completado | ✅ **OBLIGATORIO** |

#### Prompt
| App | Descripción | Instalar? |
|-----|-------------|-----------|
| **Starship** | Prompt customizable para cualquier shell | ✅ |

### 3.3 Post-instalación de Tmux

Si instalaste Tmux, abrí tmux y ejecutá:

```bash
# Dentro de tmux, presionar:
# prefix + I (mayúscula i) → instala los plugins de Tmux
```

### 3.4 Vim Mastery Trainer

Gentleman.Dots incluye un **RPG interactivo** para aprender Vim:

| Módulo | Teclas |
|--------|--------|
| 🔤 Movimiento Horizontal | `w` `e` `b` `f` `t` `0` `$` `^` |
| ↕️ Movimiento Vertical | `j` `k` `G` `gg` `{` `}` |
| 📦 Objetos de Texto | `iw` `aw` `i"` `a(` `it` `at` |
| ✂️ Cambio y Repetición | `d` `c` `dd` `cc` `D` `C` `x` |
| 🔄 Sustitución | `r` `R` `s` `S` `~` `gu` `gU` `J` |
| 🎬 Macros y Registros | `qa` `@a` `@@` `"ay` `"+p` |
| 🔍 Regex/Búsqueda | `/` `?` `n` `N` `*` `#` `\v` |

Lanzar desde el menú principal del instalador: **Vim Mastery Trainer**

### 3.5 Verificar instalación de Gentleman.Dots

```bash
# Deberías ver:
nvim --version            # Neovim instalado
fish --version            # o zsh --version
tmux -V                   # o zellij --version
starship --version        # Starship prompt
```

### 3.6 El Bigote 🧐

El logo de Gentleman (el bigote) aparece en:
- El **prompt de Starship** (cuando abrís la terminal)
- El **splash de Fish/Zsh** configurado
- Posiblemente como ASCII art al iniciar la terminal
- Es la identidad visual del ecosistema

---

## 4. Paso 2: gentle-ai — AI Layer

> **NOTA**: Si ya instalaste gentle-ai, verificá que esté actualizado:
> ```bash
> gentle-ai version  # Debería ser 1.34.0+
> gentle-ai update
> ```

### 4.1 Instalar gentle-ai

```bash
brew tap Gentleman-Programming/tap
brew install gentle-ai
gentle-ai
```

El TUI te guía para seleccionar:
- **Componentes**: Engram, SDD, Skills, Context7, GGA, Persona, Permisos, Theme
- **Agentes**: Claude Code, OpenCode, Gemini CLI, Cursor, VS Code Copilot, etc.
- **Preset**: `full-gentleman` (todo), `ecosystem-only`, `minimal`, o `custom`

### 4.2 Componentes que instala

| Componente | ID | Qué hace |
|-----------|-----|----------|
| **Engram** | `engram` | Memoria persistente entre sesiones (MCP) |
| **SDD** | `sdd` | Spec-Driven Development workflow (9 fases) |
| **Skills** | `skills` | Biblioteca de skills de coding |
| **Context7** | `context7` | Documentación on-demand via MCP |
| **Persona** | `persona` | Modo Gentleman, neutral o custom |
| **Permisos** | `permissions` | Seguridad: bloquea `.env`, git destructivo |
| **GGA** | `gga` | Gentleman Guardian Angel — code review multi-provider |
| **Theme** | `theme` | Tema Gentleman Kanagawa |

### 4.3 Habilidades (Skills) incluidas

**SDD (10 skills):**
- `sdd-init` → Bootstrap SDD en un proyecto
- `sdd-explore` → Investigar antes de codear
- `sdd-propose` → Propuesta de cambio
- `sdd-spec` → Especificaciones con escenarios
- `sdd-design` → Diseño técnico con decisiones de arquitectura
- `sdd-tasks` → Desglose en tareas
- `sdd-apply` → Implementar siguiendo specs
- `sdd-verify` → Validar contra specs
- `sdd-archive` → Archivar cambios completados
- `judgment-day` → Review adversarial con 2 jueces independientes

**Foundation (4 skills):**
- `go-testing` → Testing en Go + Bubbletea TUI
- `skill-creator` → Crear nuevas skills
- `branch-pr` → Workflow de PRs
- `issue-creation` → Issues en GitHub

### 4.4 Verificar instalación de gentle-ai

```bash
gentle-ai version
engram version
gga --version

# Verificar agentes configurados
ls ~/.claude/CLAUDE.md       # Claude Code
ls ~/.config/opencode/       # OpenCode
ls ~/.cursor/agents/         # Cursor (10 sub-agents SDD)
ls ~/.copilot/skills/        # VS Code Copilot
ls ~/.codex/                 # Codex
ls ~/.gemini/                # Gemini CLI
```

---

## 5. Paso 3: Gentleman-Skills — Coding Patterns

Skills de frameworks específicos. Se instalan manualmente.

### 5.1 Clonar el repositorio

```bash
git clone https://github.com/Gentleman-Programming/Gentleman-Skills.git
cd Gentleman-Skills
```

### 5.2 Estructura

```
Gentleman-Skills/
├── curated/          # Skills oficiales (curadas y revisadas)
│   ├── react-19/
│   ├── nextjs-15/
│   ├── typescript/
│   ├── tailwind-4/
│   ├── zod-4/
│   ├── playwright/
│   ├── go-testing/
│   └── angular/
├── community/        # Contribuciones de la comunidad
│   ├── ...
└── templates/        # Templates para crear nuevas skills
```

### 5.3 Instalar skills en tu agente

```bash
# Para Claude Code
cp -r curated/react-19 ~/.claude/skills/
cp -r curated/typescript ~/.claude/skills/

# Para Cursor
cp -r curated/react-19 ~/.cursor/skills/
cp -r curated/typescript ~/.cursor/skills/

# Para OpenCode
cp -r curated/react-19 ~/.config/opencode/skills/
cp -r curated/typescript ~/.config/opencode/skills/
```

### 5.4 Registrar skills en cada proyecto

Dentro de cada proyecto donde trabajes:

```
/skill-registry   ← comando slash en OpenCode
```

Esto escanea las skills instaladas y construye el registro en `.atl/skill-registry.md`.

---

## 6. Paso 4: Configuración de Agentes AI

### 6.1 Claude Code (Agente Principal)

```bash
npm install -g @anthropic-ai/claude-code
claude
```

Configuración gestionada por `gentle-ai`:
- `~/.claude/CLAUDE.md` → System prompt con persona Gentleman
- `~/.claude/mcp/` → Servidores MCP (Engram, Context7)
- `~/.claude/skills/` → Skills instaladas
- `~/.claude/output-styles/` → Estilos de output

### 6.2 OpenCode

```bash
brew install opencode
opencode
```

Característica exclusiva: **Multi-mode SDD Profiles**
- Asignar modelos diferentes a cada fase SDD
- Ej: Claude Opus para diseño, Gemini para implementación

```bash
# Crear perfil via CLI
gentle-ai sync --profile cheap:openrouter/qwen/qwen3-30b-a3b:free
gentle-ai sync --profile-phase cheap:sdd-design:anthropic/claude-sonnet-4-20250514

# En OpenCode, presionar Tab para cambiar entre perfiles
```

### 6.3 Cursor

Los 10 sub-agentes SDD se instalan automáticamente en:
```
~/.cursor/agents/sdd-{fase}.md
```

Skills en: `~/.cursor/skills/`
Reglas en: `~/.cursor/rules/gentle-ai.mdc`

### 6.4 VS Code Copilot

Skills en: `~/.copilot/skills/`
System prompt en: `Code/User/prompts/gentle-ai.instructions.md`

### 6.5 GGA — Gentleman Guardian Angel

```bash
gga init        # Inicializar en un proyecto
gga install     # Instalar hook de pre-commit
gga run         # Ejecutar code review
```

---

## 7. Arquitectura del Stack Completo

```
┌──────────────────────────────────────────────────────────────────┐
│                      TU FLUJO DE TRABAJO                          │
├──────────────────────────────────────────────────────────────────┤
│                                                                    │
│  ABRÍS LA TERMINAL                                                 │
│  └─ Starship te muestra el prompt con bigote 🧐                   │
│                                                                    │
│  ABRÍS UN ARCHIVO                                                  │
│  └─ LazyVim (Neovim) con LSP, autocompletado, tema Kanagawa       │
│                                                                    │
│  USÁS TMUX/ZELLIJ                                                  │
│  └─ Paneles: editor + terminal + AI                               │
│                                                                    │
│  PEDÍS AL AI QUE HAGA ALGO                                        │
│  └─ Claude Code / OpenCode / Cursor                               │
│     ├─ Si es chico → lo hace directo                              │
│     └─ Si es grande → activa SDD                                  │
│        ├─ sdd-explore → investiga el código                       │
│        ├─ sdd-propose → propone enfoque                           │
│        ├─ sdd-spec → escribe specs                                │
│        ├─ sdd-design → diseña arquitectura                        │
│        ├─ sdd-tasks → divide en tareas                            │
│        ├─ sdd-apply → implementa                                  │
│        ├─ sdd-verify → verifica contra specs                      │
│        ├─ judgment-day → 2 jueces revisan                         │
│        └─ sdd-archive → archiva el cambio                         │
│                                                                    │
│  ENGRAM GUARDA TODO                                                │
│  └─ Decisiones, bugs, patrones → persisten entre sesiones         │
│                                                                    │
│  GGA REVIEW                                                        │
│  └─ Code review automático antes de cada commit                   │
│                                                                    │
└──────────────────────────────────────────────────────────────────┘
```

---

## 8. Ruta de Aprendizaje: De Dev a Arquitecto

Esta es la progresión que Alan enseña en sus videos. Cada fase construye sobre la anterior.

### 🟢 Fase 1: Terminal Ninja (Semana 1-2)

| Objetivo | Herramienta | Recurso |
|----------|-------------|---------|
| Navegar terminal eficientemente | Fish/Zsh + Starship | Gentleman.Dots |
| Editor modal | LazyVim + Vim Mastery Trainer | Práctica diaria 15min |
| Multiplexor básico | Tmux o Zellij | Dividir pantallas, atajos |
| Git fluido | lazygit | TUI para git |

**Checkpoint**: Podés editar archivos en LazyVim sin tocar el mouse. Usás tmux con 3 paneles.

### 🔵 Fase 2: AI Consciente (Semana 3-4)

| Objetivo | Herramienta | Recurso |
|----------|-------------|---------|
| Usar Claude Code bien | Claude Code + Persona Gentleman | gentle-ai |
| Prompting estructurado | SDD workflow | Videos de Alan |
| Memory-driven dev | Engram | `/mem_save`, `/mem_search` |
| Code review automático | GGA | Pre-commit hooks |

**Checkpoint**: Dejás de pedir "haz esto" y empezás a pedir "explora esto y proponé un enfoque".

### 🟡 Fase 3: Arquitectura Práctica (Mes 2-3)

| Objetivo | Herramienta | Recurso |
|----------|-------------|---------|
| Clean Architecture | SDD design phase | Libros: Clean Architecture (Uncle Bob) |
| Hexagonal Architecture | SDD spec + design | Videos de Alan sobre arquitectura |
| Patrones de diseño | Gentleman-Skills | skills de cada patrón |
| Principios SOLID | SDD verify phase | Practice + AI review |

**Checkpoint**: Usás SDD naturalmente. Tus cambios vienen con specs, diseño y validación.

### 🟠 Fase 4: Maestría Técnica (Mes 3-6)

| Objetivo | Herramienta | Recurso |
|----------|-------------|---------|
| Testing disciplinado | go-testing skill + TDD | Strict TDD Mode de SDD |
| TypeScript avanzado | Typescript skill | Gentleman-Skills |
| Performance | SDD explore phase | Profiling + AI analysis |
| Refactoring seguro | judgment-day skill | Dual review |

**Checkpoint**: Podés liderar un proyecto completo desde 0 hasta producción aplicando SDD.

### 🔴 Fase 5: Arquitecto de Software (6+ meses)

| Objetivo | Herramienta | Recurso |
|----------|-------------|---------|
| Diseño de sistemas | SDD design (multimodelo) | Claude Opus para diseño |
| Toma de decisiones técnicas | Engram (historial de decisiones) | `engram search "decisión"` |
| Mentoría | Compartir skills propias | `skill-creator` |
| Contribución al ecosistema | PRs a Gentleman-Skills | GitHub |

**Checkpoint**: Otros devs te buscan para decisiones de arquitectura. Tenés tus propias skills publicadas.

---

## 9. Referencias

### Comunidad

| Recurso | Link |
|---------|------|
| Discord | https://discord.gg/gentleman-programming |
| YouTube | https://youtube.com/@GentlemanProgramming |
| Twitch | https://twitch.tv/GentlemanProgramming |
| GitHub | https://github.com/Gentleman-Programming |

### Comandos Rápidos

```bash
# Estado del ecosistema
gentle-ai version
engram version
gga --version

# Actualizar todo
gentle-ai update
gentle-ai upgrade

# Memoria
engram projects list
engram search "algo que hiciste"

# Code review
gga init && gga install    # En cada proyecto nuevo
gga run                     # Revisar cambios

# SDD en tu AI (dentro del chat)
usa sdd                     # Para features grandes
/sdd-init                   # Primera vez en un proyecto
/skill-registry             # Después de instalar skills nuevas
```

### Libros Recomendados por Alan

1. **Clean Architecture** — Robert C. Martin (Uncle Bob)
2. **Domain-Driven Design** — Eric Evans
3. **Design Patterns** — Gang of Four
4. **Working Effectively with Legacy Code** — Michael Feathers
5. **The Pragmatic Programmer** — Hunt & Thomas

---

## 🔧 Troubleshooting: Versiones duplicadas de opencode

### Problema
Al ejecutar `opencode .` desde WezTerm, mostraba la ayuda en vez del TUI interactivo con el error `Error: agent coder not found`.

### Causa
Dos versiones de opencode instaladas compitiendo en el PATH:

| Versión | Path |
|---------|------|
| 0.0.55 (obsoleta) | `/home/linuxbrew/.linuxbrew/bin/opencode` |
| 1.15.13 (moderna) | `/home/harco/.opencode/bin/opencode` |

La versión vieja (0.0.55) quedaba primera en el PATH de WezTerm, y buscaba un agente "coder" que ya no existe en la versión moderna.

### Solución
Agregar al `~/.config/fish/config.fish`:

```fish
set -gx PATH /home/harco/.opencode/bin $PATH
```

Esto asegura que la versión moderna esté siempre primero en el PATH.

### Uso correcto
```bash
opencode                     # Modo interactivo
opencode -c .                # En el directorio actual
```

---

## 🔄 Sincronización entre dispositivos (chezmoi)

Todas tus configs están versionadas en GitHub:
```
https://github.com/hernanharco/dotfiles
```

### ¿Qué se sincroniza?

| Config | Archivo |
|--------|---------|
| 🐟 Fish shell | `~/.config/fish/config.fish` |
| 🎨 Starship prompt | `~/.config/starship.toml` |
| 🖥️ WezTerm | `~/.config/wezterm/wezterm.lua` |
| ✍️ Neovim + LazyVim | `~/.config/nvim/` (completo) |
| 📟 Zellij | `~/.config/zellij/` |
| 🧠 OpenCode | `~/.config/opencode/` (sin node_modules) |
| 😇 GGA | `~/.config/gga/` |
| 📝 Git | `~/.gitconfig` |
| 📜 Bash | `~/.bashrc` |

### En una PC nueva

```bash
# 1. Instalar chezmoi
brew install chezmoi

# 2. Clonar las configs
chezmoi init https://github.com/hernanharco/dotfiles.git

# 3. Aplicar todas las configs
chezmoi apply
```

### En Termux (Android)

```bash
# 1. Instalar chezmoi
pkg install chezmoi

# 2. Clonar las configs
chezmoi init https://github.com/hernanharco/dotfiles.git

# 3. Aplicar todas las configs
chezmoi apply
```

### Para actualizar después de cambios

```bash
# En la PC donde hiciste cambios:
chezmoi add ~/ruta/al/archivo   # Agregar archivo nuevo
chezmoi reapply                   # Reaplicar todo

# En el otro dispositivo:
chezmoi update                    # Traer cambios de GitHub
chezmoi apply                     # Aplicarlos
```

### Ver qué cambió

```bash
chezmoi diff        # Ver diferencias
chezmoi status      # Ver estado
chezmoi revert      # Volver atrás
```

---

> **🎩 "El código es el medio, no el fin. La arquitectura es el arte de hacer que el código
>  cuente una historia clara. El AI acelera el proceso, pero el arquitecto es quien
>  decide qué historia contar."** — Gentleman Programming
