# Flujos de Trabajo Prácticos — Ecosistema Gentleman

> Cómo uso el stack en el día a día.

---

## 1. Arranque diario

```bash
# Terminal
herdr                        # levanta sesión con workspaces anteriores

# En Pi (dentro de herdr)
pi                           # arranca gentle-shell
```

El workspace se restaura automáticamente. Los workspaces de herdr persisten entre sesiones.

---

## 2. Desarrollo con ODD (Organic Driven Development)

ODD es el workflow por defecto. Cada request entra en él sin preguntar.

### Flujo básico

1. **Autorizar** — Investigación, explicación, review → solo lectura.
2. **Explorar** — El agente explora código existente antes de cambiar nada.
3. **Resolver incertidumbre** — Pregunta solo si hay una decisión real pendiente.
4. **Clasificar** — Trabajo sustancial (2+ archivos, feature recoverable) vs trabajo chico.
5. **Trackear** — Si es sustancial: crear `odd/<feature>/tasks.md` antes del primer write.
6. **Implementar** — Tarea por tarea, con commit por cada una.
7. **Cerrar** — Reportar outcome, checks, y next step.

### Ejemplo práctico

```
User: "Agregá validación con Zod al form de login"

El agente:
1. Explora el form actual (archivos, estructura)
2. Clasifica: sustancial (2+ archivos)
3. Crea odd/login-validation/tasks.md
4. Implementa: schema Zod, integración, tests
5. Commit por cada tarea
6. Reporta: "3 commits, tests pasan, siguiente paso: ..."
```

---

## 3. SDD (Spec-Driven Development)

Solo se activa con petición explícita o propuesta aceptada.

```
User: "Usá SDD para esto"
# o
El agente propone: "¿Querés que use SDD para esto?"
User: "Sí"
```

### Fases SDD

1. **Research** — Investigar, mapear dependencias
2. **Proposal** — Propuesta con scope, no-goals, criterios
3. **Spec** — Especificación formal
4. **Design** — Arquitectura y decisiones
5. **Tasks** — Desglose en tareas
6. **Apply** — Implementación
7. **Verify** — Verificación contra spec
8. **Archive** — Cerrar y documentar

---

## 4. Skills

### Skills disponibles (gentle-pi package)

| Skill | Trigger |
|---|---|
| `branch-pr` | Crear PRs con checks de issues |
| `chained-pr` | PRs de 400+ líneas, stacked PRs |
| `cognitive-doc-design` | Escribir docs, READMEs, RFCs |
| `comment-writer` | Comentarios en PRs, issues, Slack |
| `gentle-ai` | Disciplina general de harness |
| `issue-creation` | Crear/triar issues de GitHub |
| `judgment-day` | Review adversarial dual |
| `rdd-defect-workflow` | Receipt-driven development |
| `skill-creator` | Crear nuevas skills |
| `skill-improver` | Auditar/mejorar skills existentes |
| `skill-registry` | Indexar skills disponibles |
| `work-unit-commits` | Planificar commits como units |

### Skills curated (Gentleman-Skills)

Frameworks: React 19, Next.js 15, Angular, TypeScript, Tailwind 4, Zod 4, Zustand 5, AI SDK 5, Django DRF, Playwright, Pytest.

Integraciones: GitHub PR, Jira Epic, Jira Task.

### Cómo se usan

Las skills se cargan automáticamente cuando el trigger coincide. No hay que invocarlas manualmente.

---

## 5. Subagents

### Delegación automática

El orquestador delega cuando se cumplen triggers:

- **4-file rule**: 4+ archivos para entender → delega scouting
- **Multi-file write**: 2+ archivos no triviales → delega writer
- **Incident rule**: Incidentes de cwd/worktree/git → separados
- **Long-session rule**: ~20 tool calls → pausa y delega
- **Verification rule**: Verificación → delega a gentle-ai-verify

### Delegación manual

```
User: "Mapeá todos los endpoints de esta API"
# El agente usa gentle-ai-explore como subagent
```

---

## 6. Review (opcional)

RDD (Receipt-Driven Development) es opt-in.

```bash
/gentle:review-mode enable    # activar
/gentle:review-mode disable   # desactivar
```

Cuando está activo, cada work-unit commit pasa por review nativo antes de considerarse completo.

---

## 7. Comandos útiles de gentle-shell

| Comando | Qué hace |
|---|---|
| `/gentle:status` | Estado del workspace |
| `/gentle:doctor` | Health check del sistema |
| `/gentle:changes` | Ver diffs capturados de la sesión |
| `/gentle:commands` | Paleta de comandos |
| `/gentle:profiles` | Routing de modelos |
| `/gentle:agents` | Ver subagents activos |

### Atajos

| Atajo | Acción |
|---|---|
| `alt+g` | Abrir Changes viewer |
| `alt+k` | Abrir command palette |
| `alt+a` | Abrir Agents view |

---

## 8. Memoria (Engram)

Engram persiste contexto entre sesiones. Se usa automáticamente.

- **mem_save**: Guardar decisiones, bugs, discoveries
- **mem_search**: Buscar en memoria guardada
- **mem_context**: Contexto del proyecto actual
- **mem_session_summary**: Resumen al cerrar sesión

---

## 9. Modelos y profiles

```bash
/gentle:profiles    # ver/crear profiles
```

Un profile define: modelo, effort, y routing de roles (orchestrator, reviewer, etc.).

Ejemplo:
```
Profile "fast": gpt-5.5 mini, low effort
Profile "thorough": claude-sonnet, high effort
```

---

> 🎩 **Regla de oro**: Si no sabés qué workflow usar, usá ODD. Si necesás formalidad explícita, pedí SDD.
