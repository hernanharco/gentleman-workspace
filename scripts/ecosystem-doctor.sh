#!/usr/bin/env bash
# ecosystem-doctor.sh — audita el ecosistema Gentleman en una máquina.
#
# Qué revisa:
#   1. Skills instaladas por agente (~/.claude, ~/.config/opencode, ~/.gemini, ~/.cursor)
#   2. Skills legacy sdd-* (eliminadas de gentle-ai v4, sobreviven en instalaciones viejas)
#   3. Cobertura del stack declarado en docs/vision.md (React 19, Next 15, TS, Tailwind 4, AI SDK 5, Zod 4, Zustand 5, Playwright)
#   4. Versión de gentle-pi instalada via npm
#
# Uso:
#   ./scripts/ecosystem-doctor.sh            # reporte completo
#   ./scripts/ecosystem-doctor.sh --quiet    # solo líneas de problema (exit != 0 si hay hallazgos)
set -euo pipefail

readonly SCRIPT_NAME="$(basename -- "$0")"

QUIET=0
[[ "${1-}" == "--quiet" ]] && QUIET=1
[[ "${1-}" == "-h" || "${1-}" == "--help" ]] && {
  cat >&2 <<EOF
Usage: ${SCRIPT_NAME} [--quiet]
  --quiet   Solo imprime problemas; exit 1 si hay hallazgos.
EOF
  exit 2
}

say()  { [[ "$QUIET" -eq 1 ]] || echo "$@"; }
warn() { echo "WARN: $*"; FOUND=1; }
info() { say "  $*"; }

FOUND=0

# --- 1. Skills por agente ---------------------------------------------------
declare -A AGENT_DIRS=(
  [claude]="$HOME/.claude/skills"
  [opencode]="$HOME/.config/opencode/skills"
  [gemini]="$HOME/.gemini/skills"
  [cursor]="$HOME/.cursor/skills"
)

say "=== 1. Skills instaladas por agente ==="
declare -A TOTALS
for agent in claude opencode gemini cursor; do
  dir="${AGENT_DIRS[$agent]}"
  if [[ ! -d "$dir" ]]; then
    info "$agent: (no instalado — $dir)"
    TOTALS[$agent]=0
    continue
  fi
  # _shared es soporte, no una skill.
  count="$(find "$dir" -mindepth 1 -maxdepth 1 -type d ! -name '_shared' | wc -l)"
  TOTALS[$agent]="$count"
  info "$agent: $count skills ($dir)"
done

# --- 2. Skills legacy sdd-* -------------------------------------------------
say ""
say "=== 2. Skills legacy sdd-* ==="
LEGACY_FOUND=0
for agent in claude opencode gemini cursor; do
  dir="${AGENT_DIRS[$agent]}"
  [[ -d "$dir" ]] || continue
  mapfile -t legacy < <(find "$dir" -mindepth 1 -maxdepth 1 -type d -name 'sdd-*' -exec basename {} \; | sort)
  if [[ ${#legacy[@]} -gt 0 ]]; then
    warn "$agent: ${#legacy[@]} skills sdd-* legacy: ${legacy[*]}"
    LEGACY_FOUND=1
  else
    info "$agent: limpio (0 sdd-*)"
  fi
done

# --- 3. Cobertura del stack (docs/vision.md) --------------------------------
# Busca en todos los directorios de skills instalados, no solo en el repo.
say ""
say "=== 3. Cobertura del stack declarado ==="
declare -a STACK_MISSING=()
check_stack() {
  local label="$1" pattern="$2"
  local hit=0 agent dir
  for agent in claude opencode gemini cursor; do
    dir="${AGENT_DIRS[$agent]}"
    [[ -d "$dir" ]] || continue
    if compgen -G "$dir/${pattern}" > /dev/null 2>&1; then
      info "$label: OK ($agent)"
      hit=1
      break
    fi
  done
  if [[ "$hit" -eq 0 ]]; then
    warn "$label: SIN SKILL instalada"
    STACK_MISSING+=("$label")
  fi
  return 0
}

check_stack "React 19"        "react-19*"
check_stack "Next.js 15"      "nextjs-15*"
check_stack "TypeScript"      "typescript*"
check_stack "Tailwind 4"      "tailwind-4*"
check_stack "AI SDK 5"        "ai-sdk-5*"
check_stack "Zod 4"           "zod-4*"
check_stack "Zustand 5"       "zustand-5*"
check_stack "Playwright"      "playwright*"

# --- 4. gentle-pi -----------------------------------------------------------
say ""
say "=== 4. gentle-pi ==="
if command -v npm >/dev/null 2>&1; then
  pi_version="$(npm ls -g @gentle-ai/pi 2>/dev/null | grep -o '[0-9]\+\.[0-9]\+\.[0-9]\+' | head -1 || true)"
  if [[ -n "$pi_version" ]]; then
    info "gentle-pi instalado: v$pi_version"
  else
    info "gentle-pi no detectado via npm global"
  fi
else
  info "npm no disponible — salto chequeo de gentle-pi"
fi

# --- Resumen ----------------------------------------------------------------
say ""
say "=== Resumen ==="
for agent in claude opencode gemini cursor; do
  info "$agent: ${TOTALS[$agent]} skills"
done

if [[ "$FOUND" -ne 0 ]]; then
  echo "ecosystem-doctor: hallazgos pendientes (ver WARN arriba)"
  exit 1
fi
say "ecosystem-doctor: todo OK"
