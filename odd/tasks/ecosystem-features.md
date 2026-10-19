# Feature: ecosystem-features

- **Creado**: 2026-10-19
- **Contexto**: revisión del ecosistema gentleman para agregar features nuevas; el usuario aprobó atacar las 4 líneas propuestas, todas por fases.
- **Mirror Engram**: `odd/ecosystem-features/tasks`
- **Alcance**: 6 skills nuevas en `Gentleman-Skills/community/`, 1 script de auditoría automática, limpieza de `sdd-*` legacy en `~/.cursor/skills` y `~/.gemini/skills`.
- **Fuera de alcance**: contribuir/upstreamear las skills a los repos oficiales (queda a decisión del usuario al cerrar), cambios en gentle-pi ni gentle-ai, PRs nuevos.

## Specs

- **S1** — Petición original del usuario: "revisemos el ecosistema de gentleman a fiture nuevas".
- **S2** — Aprobación del plan completo por fases: "hagamos todas en fases". Las 4 fases aprobadas:
  1. Skills gaps 1–3 de `docs/AUDITORIA-SKILLS.md`: agentes/LLM (LangGraph, tools, memoria), SQL/Postgres, bash avanzado.
  2. `scripts/ecosystem-doctor.sh` — audita skills instaladas por agente (`~/.claude/skills`, `~/.config/opencode/skills`, `~/.gemini/skills`, `~/.cursor/skills`), detecta `sdd-*` legacy, reporta coverage vs stack de `docs/vision.md`.
  3. Skills gaps 4–6: GitHub Actions (CI/CD), API design (REST/OpenAPI), seguridad OWASP top 10.
  4. Limpieza de `sdd-*` legacy — alcance ampliado por hallazgo del doctor (L5): 31 skills en `~/.claude/skills` (11, incluye `sdd-research`), `~/.gemini/skills` (10) y `~/.cursor/skills` (10, directorios vacíos). Backup previo obligatorio (S6).
- **S3** — Formato de skills: frontmatter LLM-first igual que el resto de `community/` (ver `Gentleman-Skills/community/docker/SKILL.md`); contribution rule del repo: solo `community/<skill>/SKILL.md`, nunca `curated/`.
- **S4** — Convención del workspace (AGENTS.md): commits chicos con mensajes convencionales, decisiones documentadas, bash strict mode (`set -euo pipefail`) en scripts.
- **S5** — `immersive-3d-web` ya está trackeado en git (`community/immersive-3d-web/` limpio en `1d2a59d`): la task #15 del workspace anterior se da por cerrada aquí; la fase 4 solo limpia `sdd-*`.
- **S6** — La fase 4 toca archivos FUERA de la raíz del proyecto (`~/.cursor/skills`, `~/.gemini/skills`): requiere confirmación explícita del usuario antes de borrar, con rutas absolutas nombradas y backup verificado.

## Tasks

| # | Task | Fase | Ruta | Estado | Commit |
|---|------|------|------|--------|--------|
| 1 | Skill `llm-agents` (orquestación de agentes, tools, memoria, LangGraph) | 1 | `Gentleman-Skills/community/llm-agents/SKILL.md` | done | `6a4697a` |
| 2 | Skill `sql-postgres` (queries, esquemas, índices, planes) | 1 | `Gentleman-Skills/community/sql-postgres/SKILL.md` | done | `6a4697a` |
| 3 | Skill `bash-advanced` (strict mode, quoting, traps, portable) | 1 | `Gentleman-Skills/community/bash-advanced/SKILL.md` | done | `6a4697a` |
| 4 | Commit fase 1 (convencional, chico, en rama feature) | 1 | — | done | `6a4697a` (rama `feat/community-skills-gaps`) |
| 5 | `scripts/ecosystem-doctor.sh` con strict mode y salida report | 2 | `scripts/ecosystem-doctor.sh` | done | `8c7c4f0` |
| 6 | Docs: registrar doctor en `docs/` y commit fase 2 | 2 | `docs/ECOSYSTEM-DOCTOR.md` | done | `8c7c4f0` |
| 7 | Skill `github-actions` (jobs, caching, security, convención) | 3 | `Gentleman-Skills/community/github-actions/SKILL.md` | done | `561cb85` |
| 8 | Skill `api-design` (REST, OpenAPI, versionado) | 3 | `Gentleman-Skills/community/api-design/SKILL.md` | done | `561cb85` |
| 9 | Skill `owasp-top10` (seguridad básica) | 3 | `Gentleman-Skills/community/owasp-top10/SKILL.md` | done | `561cb85` |
| 10 | Commit fase 3 | 3 | — | done | `561cb85` (rama `feat/community-skills-gaps`) |
| 11 | Backup tar de `sdd-*` en claude/gemini/cursor + verificación | 4 | `~/.gentle-shell/backup-skills-sdd-20261019.tar.gz` | done | — |
| 12 | Borrar 31 skills `sdd-*` (11 claude + 10 gemini + 10 cursor) tras confirmación S6 | 4 | `~/.claude/skills`, `~/.gemini/skills`, `~/.cursor/skills` | done | — |
| 13 | Commit fase 4 (evidencia en doc) + cierre | 4 | `odd/tasks/ecosystem-features.md` | done | `d483233` |

## Log

- **L1** (2026-10-19) — Usuario: "revisemos el ecosistema de gentleman a fiture nuevas".
- **L2** (2026-10-19) — Usuario: "hagamos todas en fases" (aprueba las 4 líneas propuestas).
- **L3** (2026-10-19) — Evidencia: `immersive-3d-web` ya trackeado y limpio en Gentleman-Skills `1d2a59d`; fase 4 queda solo para `sdd-*`. Auditoría de referencia: `docs/AUDITORIA-SKILLS.md` (9 oct 2026).
- **L4** (2026-10-19) — Fase 1 completada: 3 skills escritas (406 líneas) y commiteadas como `6a4697a` en `feat/community-skills-gaps` (Gentleman-Skills).
- **L5** (2026-10-19) — Fase 2 completada: `scripts/ecosystem-doctor.sh` (verificado: exit 0 sin hallazgos / exit 1 con `--quiet` sobre los 31 `sdd-*` reales) + `docs/ECOSYSTEM-DOCTOR.md`, commit `8c7c4f0` en `feat/ecosystem-doctor` (workspace). Hallazgo: `~/.claude/skills` tiene 11 `sdd-*` legacy (incluye `sdd-research` que gemini/cursor no tienen) — candidatas a la fase 4.
- **L6** (2026-10-19) — Fase 3 completada: 3 skills (364 líneas) commiteadas como `561cb85` en `feat/community-skills-gaps`. Cobertura total de los 6 gaps de `docs/AUDITORIA-SKILLS.md`.
- **L7** (2026-10-19) — Fase 4 completada con autorización explícita del usuario (cuestionario: "Sí, los 3 agentes"). Backup: `~/.gentle-shell/backup-skills-sdd-20261019.tar.gz` (verificado `gzip -t`, 31 entradas: 21 SKILL.md reales + 10 dirs vacíos de cursor — cursor ya tenía solo cascarones). Borrado: 31/31, restantes 0. Verificación independiente: `ecosystem-doctor.sh --quiet` → `EXIT=0`. Nota: primer intento de backup con `tar -r` sobre gzip perdió cursor silenciosiomente; reconstruido con un solo `tar -czf` + `--transform`.
