# Gentleman Ecosystem Audit — Tasks

> Feature: Auditar y organizar el ecosistema Gentleman
> Started: 2026-09-23
> Status: completed 2026-10-09 (todas las tareas cerradas; B3 obsoleto)

## Context

El workspace `gentleman/` tiene docs sueltos, Gentleman-Skills clonado de GitHub, gentle-pi 3.4.0 instalado como package de Pi, y Engram sin proyecto registrado. Hay que ordenar todo.

## Estado actual (reconciliado 2026-10-09)

- pi 1.1.0, gentle-ai 4.0.0 CLI, gentle-pi 4.0.0 package, engram 3.2.1, gentle-engram 0.3.0, herdr 0.9.3
- Engram: proyecto `gentleman` registrado (144 obs / 94 sessions / 680 prompts); 40 proyectos enrolados en cloud (local-first por decisión del usuario)
- `gentleman/` repo con remote `hernanharco/gentleman-workspace.git`, estructura docs/ odd/ scripts/ tests/ backups/
- `Gentleman-Skills/`: 16 skills curated + 9 community (fork local, PR #23 abierto upstream)
- gentle-pi tiene 13 skills de workflow (complementarias a las curated)

## Tasks

### A. Engram — Persistencia
- [x] **A1** Registrar proyecto `gentleman` en Engram
- [x] **A2** Sincronizar contexto del ecosistema en Engram

### B. Workspace — Organización
- [x] **B1** Estructurar `gentleman/` con directorios claros
- [x] **B2** Conectar `gentleman/` con repos GitHub (remote)
- [x] ~~**B3** Integrar/limpiar `gentleman/datos.md`~~ (obsoleto: `datos.md` nunca se creó; el contenido vive en `docs/`)

### C. Skills — Inventario
- [x] **C1** Auditar skills Gentleman-Skills vs gentle-pi → `docs/AUDITORIA-SKILLS.md` §1
- [x] **C2** Identificar skills faltantes para tech stack → `docs/AUDITORIA-SKILLS.md` §3

### D. Package — Contributions
- [x] **D1** Evaluar si hay updates de gentle-pi disponibles
- [x] **D2** Identificar bugs/mejoras para contribuir al package

### E. Documentación
- [x] **E1** Actualizar RUNBOOK-SETUP-COMPLETO.md (refresco de versiones 2026-10-09)
- [x] **E2** Documentar flujos de trabajo prácticos

## Completadas (reconciliación 2026-10-09)

- **A1/A2**: `engram projects list` → `gentleman` con 144 obs / 94 sessions / 680 prompts; memorias guardadas vía Engram en sesiones de ODD.
- **B1**: estructura `docs/ odd/ scripts/ tests/ backups/ Gentleman-Skills/` + `AGENTS.md` + `.codegraph`.
- **B2**: `origin = https://github.com/hernanharco/gentleman-workspace.git`.
- **B3**: obsoleto — `datos.md` no existe y nunca fue creado; la info quedó en `docs/`.
- **C1/C2**: `docs/AUDITORIA-SKILLS.md` (2026-10-09): inventarios cruzados (12 gentle-pi vs 16 curated + 9 community, complementarias sin conflicto) + 6 gaps priorizados (agentes/LLM, SQL, bash, CI/CD, API design, seguridad).
- **D1**: gentle-pi 4.0.0 = última release (upgradeado 2026-10-03, verificado 2026-10-09).
- **D2**: contribuciones materializadas: PR #23 Gentleman-Skills (go-testing, docker, svelte-astro) + issue gentle-shell#626 (herdr dot background, assignee decode2) + patch local herdr:busy.
- **E1**: RUNBOOK refrescado 2026-10-09 (Herdr 0.9.3 + fecha de verificación).
- **E2**: `docs/FLUJOS-DE-TRABAJO.md` (188 líneas).

**Estado: todas las tareas cerradas** (B3 obsoleto).
