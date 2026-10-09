# Gentleman Ecosystem Audit — Tasks

> Feature: Auditar y organizar el ecosistema Gentleman
> Started: 2026-09-23
> Status: in_progress — reconciliado 2026-10-09 (varios items cerrados con evidencia)

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
- [ ] **C1** Auditar skills Gentleman-Skills vs gentle-pi (inventario tomado: 13 vs 16+9; cruzado pendiente)
- [ ] **C2** Identificar skills faltantes para tech stack

### D. Package — Contributions
- [x] **D1** Evaluar si hay updates de gentle-pi disponibles
- [x] **D2** Identificar bugs/mejoras para contribuir al package

### E. Documentación
- [ ] **E1** Actualizar RUNBOOK-SETUP-COMPLETO.md (refresco de versiones en curso 2026-10-09)
- [x] **E2** Documentar flujos de trabajo prácticos

## Completadas (reconciliación 2026-10-09)

- **A1/A2**: `engram projects list` → `gentleman` con 144 obs / 94 sessions / 680 prompts; memorias guardadas vía Engram en sesiones de ODD.
- **B1**: estructura `docs/ odd/ scripts/ tests/ backups/ Gentleman-Skills/` + `AGENTS.md` + `.codegraph`.
- **B2**: `origin = https://github.com/hernanharco/gentleman-workspace.git`.
- **B3**: obsoleto — `datos.md` no existe y nunca fue creado; la info quedó en `docs/`.
- **D1**: gentle-pi 4.0.0 = última release (upgradeado 2026-10-03, verificado 2026-10-09).
- **D2**: contribuciones materializadas: PR #23 Gentleman-Skills (go-testing, docker, svelte-astro) + issue gentle-shell#626 (herdr dot background, assignee decode2) + patch local herdr:busy.
- **E2**: `docs/FLUJOS-DE-TRABAJO.md` (188 líneas).

Pendientes restantes: **C1/C2** (cruce de inventario de skills) y **E1** (refresco del RUNBOOK, task #17 del todo activo).
