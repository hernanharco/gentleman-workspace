# Session Improvements — 2026-09-13

## Resumen

Sesión de setup y configuración del eistema gentle + CodeGraph para el workspace `gentleman`.

---

## 1. Gentle Ecosystem — Actualización a Main

### gentle-ai
| Antes | Después |
|---|---|
| v2.7.0 (homebrew release) | v2.8.2 (compilado desde main) |

- Se compiló desde `github.com/Gentleman-Programming/gentle-ai` rama main
- Binario: `~/go/bin/gentle-ai`
- Se desinstaló homebrew `2.7.0` (ya no se usa)

### gentle-pi
| Antes | Después |
|---|---|
| v2.5.0 (npm release) | v2.6.1 (desde main) |

- Se instaló desde `github:Gentleman-Programming/gentle-pi#main`
- Package.json actualizado: `~/.pi/agent/npm/package.json`
- Backup creado: `~/.pi/agent/npm/package.json.bak`

### Dev Binary Override
- **Archivo:** `~/.pi/gentle-ai/dev-binary.json`
- **Contenido:** `{"schema":"gentle-pi.dev-binary/v1","path":"/home/harco/go/bin/gentle-ai"}`
- **Efecto:** gentle-pi resuelve el binario de main (2.8.2) en vez del pin de distribución

### RDD (Receipt-Driven Development)
- **Estado:** Ya activado globalmente (`global: on`)
- **Alcance:** Todos los proyectos en esta máquina

---

## 2. CodeGraph — Instalación y Configuración

### pi-code-graph
| Campo | Valor |
|---|---|
| Versión | 0.16.0 |
| Ubicación | `~/.pi/agent/npm/node_modules/pi-code-graph` |
| Config | `~/.cgs/config.toml` |
| Docker Compose | `~/.cgs/docker/docker-compose.yml` |

### Memgraph (Base de datos de grafos)
| Campo | Valor |
|---|---|
| Container | `cgr-memgraph` |
| Imagen | `memgraph/memgraph-mage` |
| Bolt port | 7687 |
| HTTP port | 27444 |
| Estado | ✅ Corriendo |

### Configuración
```toml
[llm]
source = "auto"          # Usa auth de Pi

[embedding]
source = "local"         # No necesita API key

[memgraph]
host = "localhost"
port = "7687"

[project]
allow_index = true
```

### Notas técnicas
- `memgraph/lab` image ya no existe → removida del compose (opcional)
- Requiere `--legacy-peer-deps` por conflicto con pi-coding-agent 0.85.1
- Extensión se carga via `pi.extensions` en package.json
- Proporciona comando `/cgs` y tools: `query_code_graph`, `semantic_code_search`, `analyze_code_dependencies`

---

## 3. Pendiente

- [ ] Reiniciar Pi para cargar extensión pi-code-graph
- [ ] Indexar repositorio con `/cgs index`
- [ ] Verificar tools de CodeGraph en sesión nueva

---

## Archivos modificados

| Archivo | Cambio |
|---|---|
| `~/.pi/agent/npm/package.json` | gentle-pi → main, pi-code-graph agregado |
| `~/.pi/agent/npm/package.json.bak` | Backup del original |
| `~/.pi/gentle-ai/dev-binary.json` | Nuevo — apunta a binario de main |
| `~/.cgs/config.toml` | Nuevo — config de pi-code-graph |
| `~/.cgs/docker/docker-compose.yml` | Nuevo — Memgraph container |

## Estado final del eistema

```
gentle-ai:    2.8.2  ~/go/bin/gentle-ai          (main, dev-binary)
gentle-pi:    2.6.1  ~/.pi/agent/npm/node_modules (main)
gentle-engram: 0.1.12                            (npm)
pi-code-graph: 0.16.0                            (npm)
Memgraph:     corriendo en localhost:7687         (Docker)
RDD:          activado globalmente
```
