# ECOSYSTEM-DOCTOR — Auditoría automática del ecosistema

> Script: `scripts/ecosystem-doctor.sh` · Creado: 2026-10-19 · Feature: `odd/tasks/ecosystem-features.md` (fase 2)

## Qué hace

Audita en una sola corrida lo que antes se hacía a mano en `docs/AUDITORIA-SKILLS.md`:

1. **Skills instaladas por agente** — cuenta skills en `~/.claude/skills`, `~/.config/opencode/skills`, `~/.gemini/skills` y `~/.cursor/skills` (ignora `_shared`).
2. **Skills legacy `sdd-*`** — detecta restos del workflow SDD eliminado de gentle-ai v4; reporta cuáles y en qué agente.
3. **Cobertura del stack** — verifica que estén instaladas las skills del stack declarado en `docs/vision.md` (React 19, Next.js 15, TypeScript, Tailwind 4, AI SDK 5, Zod 4, Zustand 5, Playwright).
4. **gentle-pi** — reporta la versión instalada vía npm global.

## Uso

```bash
./scripts/ecosystem-doctor.sh            # reporte completo
./scripts/ecosystem-doctor.sh --quiet    # solo WARN + resumen; exit 1 si hay hallazgos
```

- **Exit 0** = sin hallazgos; **exit 1** = hay `WARN` (útil para CI o cron); **exit 2** = uso incorrecto.
- Los WARN van a stdout para que `--quiet` sea pipeable directo a logs.

## Cuándo correrlo

- Después de instalar o actualizar gentle-ai / gentle-pi.
- Antes de contribuir skills al ecosistema (verifica que el stack siga cubierto).
- En sesiones de limpieza (detecta exactamente las `sdd-*` a borrar).

## Resultado esperado con el ecosistema limpio

```
=== 2. Skills legacy sdd-* ===
  claude: limpio (0 sdd-*)
  ...
ecosystem-doctor: todo OK
```
