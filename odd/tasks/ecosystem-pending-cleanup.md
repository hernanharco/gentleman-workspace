# Feature: ecosystem-pending-cleanup

- **Creado**: 2026-10-03
- **Contexto**: post-upgrade stack Gentleman 4.0.0 — checklist de sesión nuevo OK; el usuario aprobó (cuestionario) atacar los 4 pendientes opcionales.
- **Mirror Engram**: `odd/ecosystem-pending-cleanup/tasks`
- **Alcance**: PR #23 (Gentleman-Skills), rescue de 9 sesiones Engram, remoción de 11 agents `sdd-*` de `~/.claude/agents`, diff de 8 review agents vs upstream v4.
- **Fuera de alcance**: PR #5091 (solo monitoreo), cloud Engram, settings de Pi (ya limpio).

## Tasks

| # | Task | Estado | Evidencia |
|---|------|--------|-----------|
| 1 | Fix PR #23: mover skills de `curated/` a `community/`, commit convencional, push, CI verde | done | commit `e3628c3` push a fork (hernanharco); CI verde: Security pass, Conventional Commits pass, Skill Format skipping; PR ahora tiene 2 commits |
| 2 | Rescue ownership de 9 sesiones `manual-save-*` (`engram projects rescue-ownership`) | done | 7 comandos OK (3+1+1+1+1+1+1=9 sesiones); doctor `unowned_session_project` → ok; warnings 3→2 |
| 3 | Borrar 11 `sdd-*` de `~/.claude/agents/` con backup tar | done | backup `~/.gentle-shell/backup-claude-agents-sdd-20261003.tar.gz` (11 archivos); quedan solo los 8 review/jd |
| 4 | Diff 8 review/jd agents locales vs upstream `internal/assets/claude/agents` (main) | done | main == v4.0.0 (0 diff); locales eran era 3.6.1 (+ bloque codegraph); merge adoptando v4.0.0: backup `backup-claude-agents-review-pre-v4-20261003.tar.gz`, 8/8 con diff 0 contra el tag |

## Notas

- Regla del repo (AGENTS.md): commits chicos y convencionales; documentar decisiones.
- El CI de Gentleman-Skills exige `community/<skill>/SKILL.md`; `curated/` está prohibido para contribuciones de la comunidad.
- `~/.claude/agents/` no trae `sdd-*` upstream desde v4 (verificado contra main con `gh api .../git/trees`).

## Evidencia de cierre (2026-10-03)

- Commits: `e3628c3` (Gentleman-Skills, push a fork hernanharco) + `89c859f` (feature doc, rama `feat/ecosystem-pending-cleanup`).
- Native review (RDD on): lineage `review-6b47289c78482f8b` → **approved** (lente review-reliability, 1 run) → acknowledge **burned** (`gentle-ai.review-acknowledged/v1`); advisory no bloqueante `R3-SubmodulePointerOnly` (WARNING, informational).
- Verificaciones: CI PR #23 verde; `engram doctor` unowned→ok (warnings 3→2, errors=0); 8/8 agents diff 0 vs v4.0.0; `gentle-ai doctor` 11/11 (inicio de sesión).
- Pendiente usuario: merge de la rama a master; monitoreo PR #5091 y review/merge de #23; relanzar OpenCode.
