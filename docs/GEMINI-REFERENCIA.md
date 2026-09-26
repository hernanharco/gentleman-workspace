# Gemini: modelos disponibles, cuotas y roadmap de asistentes

> Referencia personal del ecosistema Gemini (Google AI Studio / Gemini API).
> Datos tomados del panel de límites de uso y verificación con la API en agosto 2026.
> Última actualización: 2026-08-20

## Glosario de cuotas (recordar)

- **RPM** = Requests Per Minute — llamadas permitidas por minuto (controla la velocidad).
- **RPD** = Requests Per Day — llamadas permitidas por día (se resetea cada 24h). Es el cuello de botella real para automatización.
- **TPM** = Tokens Per Minute — volumen de texto (entrada + salida) por minuto.

## Modelos aprovechables (los que tienen cuota real)

### Texto / contexto de respuesta — para asistentes
| Modelo | RPM | RPD | Uso |
|---|---|---|---|
| **Gemini 3.5 Flash Lite** | 15 | 500 | ⭐ El caballito de batalla: 500 req/día, GRATIS y amplio |
| **Gemini 3.1 Flash Lite** | 15 | 500 | Segunda opción por si se agota el 3.5 |
| Gemini 2.5 Flash | 5 | 20 | Cuota baja; quedó en 20 RPD, cuidado |
| Gemini 3.6 / 3.7 Flash | 5 | 20 | Probados, buena calidad pero cuota baja |

### Visión (leer imágenes) — RESUELTO
- En `~/.config/opencode/plugins/vision-assistant.ts` se migró **`gemini-2.5-flash` → `gemini-3.5-flash-lite`** (500 RPD).
- **Motivo**: 2.5 Flash tenía 20 RPD y se saturaba (25/20). Los Flash Lite tienen 25x más margen.
- **Verificado en vivo**: gemini-3.1-flash-lite, gemini-3.5-flash-lite y gemini-3.6-flash leen imágenes correctamente.

### Voz — modelos GRATIS (0 / Ilimitado)
| Modelo | Cuota | Para qué |
|---|---|---|
| **Gemini 2.5 Flash Native Audio** | ∞ RPM / 1M TPM / ∞ RPD | ⭐ Conversación de voz en vivo (reconocer + sintetizar). La mejor apuesta gratis para voz |
| **Gemini 3 Flash Live** | ∞ / 65K TPM / ∞ | Streaming de audio en tiempo real |
| **Gemini 3.5 Live Translate** | ∞ / 20K TPM / ∞ | Traducción de voz en vivo |
| TTS 2.5 / 3.1 Flash | 3 RPM / 10 RPD | Texto → voz de alta calidad (cuota justa pero usable) |

### Otros útiles
| Modelo | RPM | RPD | Uso |
|---|---|---|---|
| Gemini Embedding 1 / 2 | 100 | 1K | RAG / búsqueda semántica |
| Gemma 4 26B / 31B | 30 | 14.4K | Chat de bajo costo, volumen altísimo |
| Antigravity (agente) | 60 | 100 | Agentes autónomos de Google |

### Modelos con cuota 0/0 (sin acceso en este plan / no habilitados)
Deep Research Pro, Pro (2.5/3.1/3.5), Nano Banana (imagen), Veo (video), Lyria (música),
Computer Use, Robotics, Gemini Omni. Estos figuran como 0 — no confiar en ellos hoy.

## Roadmap de asistentes (intención del usuario)

**Meta**: asistentes con contexto de respuesta, que vean imágenes, identifiquen voz,
y a futuro puedan contestar/realizar llamadas telefónicas. Prioridad: GRATIS.

### Etapa 1 — Asistente con contexto (HECHO)
- Usar `gemini-3.5-flash-lite` para el contexto de respuesta. Activo.

### Etapa 2 — Voz conversacional (próximo paso)
- Usar **Gemini 2.5 Flash Native Audio** (gratis, ilimitado). Es lo que más conviene y ya hay acceso.

### Etapa 3 — Telefonía (futuro) — CLAVE DE ARQUITECTURA
- **Los modelos de audio de Gemini NO generan ni atienden llamadas telefónicas reales.**
  Son la "cabeza" (inteligencia) que va DENTRO de un sistema que sí maneje la telefonía.
- Para llamar/atender por teléfono hay que conectar una capa de telefonía aparte:
  - **Twilio** — pay-per-use (no gratis) → conecta llamadas a un asistente Gemini.
  - **Vapi / Retell AI** — plataformas hechas para esto.
  - **Self-hosted: Asterisk / FreeSWITCH + Gemini Native Audio** — software gratis, pero armado manual y requiere número.
- Google está integrando Gemini como asistente telefónico ("Interact with Gemini" / Gemini calling) — tenerlo en el radar.

## Notas técnicas aprendidas
- El `tsc --noEmit` standalone del proyecto opencode da errores FALSOS (falta `@types/node` y
  config de `moduleResolution`). NO indican problemas reales del plugin.
- Para validar sintaxis de un plugin: usar `ts.transpileModule` de typescript en node.
- Tener presente que `vision_describe`, `vision_analyze` y `analyze_video` usan la misma
  constante `GEMINI_MODEL` del plugin vision-assistant.
- Reiniciar opencode para recargar un plugin tras editar su modelo.
