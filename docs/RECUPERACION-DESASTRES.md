# 💀 Plan de Recuperación ante Desastre

> **¿Se dañó tu PC? ¿La formateaste? ¿Te robaron la laptop?**
> **TL;DR: Solo necesitás llegar a `opencode .` funcionando. El AI hace el resto.**

---

## ⚡ Versión Exprés (si ya sabés lo que hacés)

```bash
# 1. Dependencias
sudo apt install -y curl git
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# 2. chezmoi + configs
brew install chezmoi
chezmoi init https://github.com/hernanharco/dotfiles.git
chezmoi apply

# 3. gentle-ai + OpenCode
brew tap Gentleman-Programming/tap
brew install gentle-ai
gentle-ai

# 4. Abrir OpenCode y PEDIRLE que restaure el resto
opencode .
```

> **A partir de acá, el AI con personalidad Gentleman sabe exactamente qué hacer.
> Solo decile: "restaurá mi entorno completo" y él se encarga.**

---

## 📦 Backup previo (IMPORTANTE — hace esto AHORA)

GitHub guarda las configs. Vos necesitás guardar SOLO esto:

### 1. Engram (memoria del AI) — ya se hace automático cada lunes

```bash
# Verificar que los backups automáticos existen
ls ~/Documentos/gentleman/backups/engram/
```

### 2. SSH keys (GitHub, servidores)

```bash
cp -r ~/.ssh ~/Documentos/gentleman/ssh-backup
```

### ESO ES TODO. El resto está en GitHub.

---

## 🚨 PASO ÚNICO (los demás los hace el AI)

En una PC **totalmente nueva** (sin nada instalado):

### 1. Ubuntu + curl + git

```bash
sudo apt update && sudo apt install -y curl git
```

### 2. Homebrew

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
```

### 3. chezmoi + restaurar configs

```bash
brew install chezmoi
chezmoi init https://github.com/hernanharco/dotfiles.git
chezmoi apply
```

✅ **Esto ya dejó:** Fish, Starship, LazyVim, Zellij, WezTerm, OpenCode config, GGA, git

### 4. gentle-ai + Engram + OpenCode

```bash
brew tap Gentleman-Programming/tap
brew install gentle-ai
gentle-ai
```

### 5. Abrir OpenCode y pedir el resto

```bash
opencode .
```

**Y LE DECÍS:**

> *"Restaurá mi entorno completo. Necesito Go, Node, pnpm, LazyVim plugins, y mis proyectos. Usá la info de mi persona gentleman y mi config."*

**El AI va a:**
- ✅ Instalar Go + Node + pnpm
- ✅ Instalar plugins de LazyVim que faltan
- ✅ Configurar Engram (si hay backup lo restaura)
- ✅ Recordarte lo que falta
- ✅ Preguntarte qué proyectos clonar

### 6. Si tenés backup de Engram

```bash
# Restaurar desde el backup automático
tar -xzf ~/Documentos/gentleman/backups/engram/engram-ULTIMO.tar.gz -C /tmp/
cp /tmp/engram-ULTIMO.db ~/.engram/engram.db
engram projects list  # Verificar
```

---

## 📋 Checklist (lo que hace el AI vs lo que hacés vos)

| Tarea | ¿Quién la hace? |
|-------|----------------|
| Instalar curl + git | **VOS** (2 comandos) |
| Instalar Homebrew | **VOS** (1 comando) |
| chezmoi + dotfiles | **VOS** (3 comandos) |
| gentle-ai + OpenCode | **VOS** (3 comandos) |
| **Abrir `opencode .`** | **VOS** → y pedís: *"restaurá mi entorno"* |
| Instalar Go, Node, pnpm | **🤖 AI** |
| Instalar plugins LazyVim | **🤖 AI** |
| Restaurar Engram (si hay backup) | **🤖 AI** (o lo hacés vos) |
| Clonar proyectos | **🤖 AI** (le decís cuáles) |
| Verificar que todo funcione | **🤖 AI** |

---

## ⚠️ Lo que NO se recupera automáticamente

| ¿Qué? | ¿Cómo evitarlo? |
|-------|----------------|
| **Engram DB** (memoria de sesiones) | ✅ **Automático**: cada lunes 10AM via cron |
| **Proyectos locales sin git** | Pushear a GitHub |
| **Tokens/API keys** | No estaban en dotfiles. Generar nuevas. |
| **History de la terminal** | Se pierde. No crítico. |

### 📦 Los backups de Engram están en:

```bash
ls ~/Documentos/gentleman/backups/engram/
```

Cada backup es un `.tar.gz` de aproximadamente 1 MB.

### 🔄 Para restaurar un backup:

```bash
# 1. Descomprimir
tar -xzf ~/Documentos/gentleman/backups/engram/engram-2026-XX-XX.tar.gz -C /tmp/

# 2. Reemplazar la DB actual
cp /tmp/engram-2026-XX-XX.db ~/.engram/engram.db

# 3. Verificar
engram projects list
```

---

## 🎯 Tiempo estimado: 30-45 minutos

> **"Más vale un backup hoy que un regret mañana."**
> Hacé una copia de Engram ahora y guardala en un lugar seguro (USB, nube, etc.)
