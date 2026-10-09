# 🔍 Auditoría de Skills — gentle-pi vs Gentleman-Skills

> **Fecha**: 9 de octubre de 2026 · **Cierre de tareas C1/C2** (`odd/gentleman-ecosystem-audit/tasks.md`)
> **Inventario**: gentle-pi 4.0.0 (12 skills + `_shared`) · Gentleman-Skills `90c34db` (16 curated + 9 community)

---

## 1. C1 — Cruce de inventarios

### gentle-pi (12) — proceso/harness, no tecnología

| Skill | Función |
|---|---|
| `gentle-ai` | Disciplina del harness ODD |
| `rdd-defect-workflow` | Receipt-driven development |
| `branch-pr` / `chained-pr` | PRs simples y encadenados (>400 líneas) |
| `issue-creation` | Issues desde evidencia del repo |
| `comment-writer` | Comentarios de colaboración |
| `work-unit-commits` | Commits como unidades revisables |
| `judgment-day` | Dual review adversarial |
| `cognitive-doc-design` | Docs de baja carga cognitiva |
| `skill-creator` / `skill-improver` / `skill-registry` | Ciclo de vida de skills |

### Gentleman-Skills (25) — tecnología/framework

- **curated (16)**: ai-sdk-5, angular, django-drf, github-pr, immersive-3d-web*, jira-epic, jira-task, nextjs-15, playwright, pytest, react-19, skill-creator, tailwind-4, typescript, zod-4, zustand-5
- **community (9)**: docker, electron, elixir-antipatterns, go-testing, hexagonal-architecture-layers-java, java-21, react-native, spring-boot-3, svelte-astro

\* `immersive-3d-web` está en el filesystem pero **sin trackear** en git (decisión pendiente, task #15 del workspace).

### Conclusión C1

**Complementarias, sin conflicto.** gentle-pi cubre *cómo* trabajar (proceso); Gentleman-Skills cubre *con qué* (stack). Única superposición:

| Superposición | gentle-pi | Gentleman-Skills | Veredicto |
|---|---|---|---|
| skill-creator | `skill-creator` (frontmatter LLM-first, sin `allowed-tools`, para Pi) | `curated/skill-creator` (spec Agent Skills con `allowed-tools`, multi-agente) | **Coexisten sanos** — nombres de frontmatter distintos (`gentle-ai-skill-creator` vs `skill-creator`), no colisionan al instalarse juntas |

No hay skills duplicadas ni contradictorias entre ambos repos.

---

## 2. Estado de instalación por agente

| Agente | Skills | Nota |
|---|---|---|
| `~/.claude/skills` | 26 | OK |
| `~/.config/opencode/skills` | 31 | El más completo |
| `~/.gemini/skills` | 22 | ⚠️ incluye skills `sdd-*` legacy |
| `~/.cursor/skills` | 12 | ⚠️ 8 de 12 son `sdd-*` legacy (mayoría huérfanos post-SDD) |
| Pi (gentle-pi) | 12 + `_shared` | vía npm, al día con 4.0.0 |

**Hallazgo**: `sdd-*` sobrevive en `~/.cursor/skills` y `~/.gemini/skills` — mismo problema detectado en `~/.claude/agents` (auditoría 2026-10-03). Limpieza opcional pendiente.

---

## 3. C2 — Cobertura vs. stack declarado (`docs/vision.md`)

Stack objetivo: **React 19 · Next.js 15 · TypeScript · Tailwind 4 · AI SDK 5 · Zod 4 · Zustand 5 · Node 20+** + rol de arquitecto.

| Necesidad del stack | Skill | Estado |
|---|---|---|
| React 19 | `curated/react-19` | ✅ |
| Next.js 15 | `curated/nextjs-15` | ✅ |
| TypeScript | `curated/typescript` | ✅ |
| Tailwind 4 | `curated/tailwind-4` | ✅ |
| AI SDK 5 | `curated/ai-sdk-5` | ✅ |
| Zod 4 / Zustand 5 | `curated/zod-4`, `zustand-5` | ✅ |
| Testing frontend | `curated/playwright` | ✅ |
| Python (scrapers, `pytest`) | `curated/pytest`, `django-drf` | ✅ |
| Java/Docker (proyectos heredados) | `community/java-21`, `spring-boot-3`, `docker` | ✅ |
| Proceso (PRs, commits, docs) | gentle-pi (12) | ✅ |

### Gaps reales (sin skill hoy)

Prioridad según tu trabajo actual (agentes LangGraph, servidores Hetzner, scrapers, webs de clientes):

1. **Agentes / LLM engineering** — trabajás con LangGraph (proyecto appointment) y no hay skill de patrones de agentes, tools, memoria. AI SDK 5 cubre el lado TS, no el de orquestación.
2. **SQL / Postgres** — queries, esquemas, índices; aparece en casi todo proyecto con persistencia.
3. **Bash / shell avanzado** — tu `AGENTS.md` ya tiene reglas de shell; formalizarlas como skill daría consistencia entre agentes.
4. **CI/CD — GitHub Actions** — PR #23 te comió tiempo con los jobs del repo; una skill con la convención del ecosistema evitaría repeats.
5. **API design / REST+OpenAPI** — contrato de interfaces, versionado; encaja con el rol de arquitecto.
6. **Seguridad básica (OWASP top 10)** — relevante por los advisories de npm audit y el trabajo con tokens/servers.

**No sugerido**: skills de Docker/Java adicionales (ya cubiertos), ni frameworks no usados (Elixir, Svelte, Go, React Native solo si entran al roadmap).

---

## 4. Recomendaciones

1. **No agregar skills nuevas al ecosistema todavía** — cerrar primero `curated/immersive-3d-web` (task #15) y alinear el inventario instalado por agente.
2. **Limpiar `sdd-*` legacy** de `~/.cursor/skills` y `~/.gemini/skills` (opcional, mismo criterio que la auditoría de `~/.claude/agents`).
3. **Crear skills locales** para los gaps 1–3 (agentes, SQL, bash) con `gentle-ai-skill-creator` — son candidates a contribuir upstream después.
4. `github-pr` (curated) y `branch-pr`/`issue-creation` (gentle-pi) cubren el mismo dominio GitHub con enfoques distintos: revisar en el próximo ciclo si merecen fusionarse o documentar cuándo usar cuál.

---

## Evidencia

- Inventario: `ls` sobre `gentle-pi/skills/`, `Gentleman-Skills/{curated,community}/` @ `90c34db`
- Instalación: `ls` sobre `~/.claude/skills` (26), `~/.config/opencode/skills` (31), `~/.gemini/skills` (22), `~/.cursor/skills` (12)
- Stack: `docs/vision.md` §Arquitectura del Stack Completo
- Superposición skill-creator: frontmatter comparado de ambos SKILL.md
