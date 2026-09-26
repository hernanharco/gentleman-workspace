# Vision Assistant — Plugin de OpenCode

Plugin que permite analizar imágenes y videos de YouTube usando **Gemini 2.5 Flash** directamente desde OpenCode, sin depender de servidores MCP externos.

## ¿Por qué existe?

Originalmente se usaba `opencode-vision` (paquete de PyPI) como servidor MCP para visión. Pero nunca funcionó bien — daba error `posix_spawn ENOTCONN` porque OpenCode no lograba inicializar la comunicación con el proceso MCP.

**Solución**: Reemplazar el MCP server por un plugin de OpenCode. Los plugins corren dentro del propio proceso de OpenCode, evitando por completo el problema de spawn.

## Requisitos

- Una **GOOGLE_API_KEY** (Gemini API). Se obtiene gratis en: https://aistudio.google.com/apikey
- La API key se configura en `~/.config/opencode/.env`:

```
GOOGLE_API_KEY=tu_api_key_aqui
```

## Archivos involucrados

| Archivo | Rol |
|---------|-----|
| `~/.config/opencode/plugins/vision-assistant.ts` | Plugin principal con tools + hook |
| `~/.config/opencode/plugins/vision.md` | Esta documentación |
| `~/.config/opencode/.env` | API key de Gemini |
| `~/.config/opencode/opencode.json` | Configuración donde se carga el plugin |

## Cómo funciona

El plugin se registra en OpenCode y expone dos cosas:

### 1. Tools (se invocan manualmente)

Estas herramientas aparecen como funciones que el modelo puede llamar:

| Tool | Descripción |
|------|-------------|
| `vision_describe` | Describe una imagen en detalle. Parámetros: `image_path` (ruta al archivo) o `image_data` (base64), y `prompt` opcional. |
| `vision_analyze` | Análisis estructurado completo: metadatos, descripción visual, transcripción de texto, contexto. |
| `analyze_video` | Analiza un video de YouTube. Parámetros: `url` del video y `prompt` opcional. Usa la API de Gemini Interactions. |

### 2. Hook automático (chat.message)

Cuando el usuario pega una imagen (Ctrl+Shift+V), el hook `chat.message` la intercepta automáticamente:

1. Detecta si el mensaje contiene un `FilePart` de tipo imagen
2. Extrae la ruta del archivo
3. Si la imagen no se encuentra (p.ej. clipboard), busca la captura de pantalla más reciente en `~/Imágenes/Capturas de pantalla/`
4. Envía la imagen a Gemini para describirla
5. Reemplaza el `FilePart` por un `TextPart` con la descripción

Esto permite que modelos de solo texto (como DeepSeek V4 Flash) puedan entender imágenes aunque no las vean directamente.

## Configuración del modelo Gemini

```typescript
modelo: gemini-2.5-flash
temperatura: 0.2
maxOutputTokens: 8192
timeout: 120s (imágenes), 180s (videos)
```

El modelo **gemini-2.5-flash** es gratuito (tier free):
- 1,500 requests/día
- 1,000,000 tokens/minuto

## Cómo instalar en un equipo nuevo

Si cambiás de equipo, esto es lo que necesitás:

1. **Copiar el plugin:**
   ```bash
   mkdir -p ~/.config/opencode/plugins
   # Copiar vision-assistant.ts y vision.md a ~/.config/opencode/plugins/
   ```

2. **Configurar la API key:**
   ```bash
   echo 'GOOGLE_API_KEY=tu_api_key' >> ~/.config/opencode/.env
   ```

3. **Registrar el plugin en opencode.json:**
   Si no está ya, agregar en `~/.config/opencode/opencode.json`:
   ```json
   {
     "plugins": [
       "~/.config/opencode/plugins/vision-assistant.ts"
     ]
   }
   ```

4. **Verificar que funciona:**
   Al iniciar OpenCode deberías ver en la terminal:
   ```
   [vision-assistant] Plugin loaded ✓
   ```

## Notas

- Las tools `vision_describe` y `vision_analyze` reemplazaron al MCP server `opencode-vision` que estaba configurado en `opencode.json`. Ya no es necesario tenerlo.
- La función `analyze_video` usa la API de Gemini Interactions (no la generateContent estándar), que permite pasar URLs de YouTube directamente.
- El plugin busca la API key primero en variables de entorno, luego en `~/.config/opencode/.env`, y por último en `~/.env`.
