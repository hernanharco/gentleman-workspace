#!/bin/bash
# backup-engram.sh — Backup semanal de Engram
# Copia la base de memoria y la sube a un repo privado en GitHub
#
# Uso: ./backup-engram.sh
# Programar con cron: 0 10 * * 1 /home/harco/Documentos/gentleman/scripts/backup-engram.sh

set -e

# ═══════════════════════════════════════════════
# CONFIGURACIÓN
# ═══════════════════════════════════════════════

ENGRAM_DB="$HOME/.engram/engram.db"
BACKUP_DIR="$HOME/Documentos/gentleman/backups/engram"
DATE=$(date +%Y-%m-%d)
BACKUP_FILE="$BACKUP_DIR/engram-$DATE.db"
COMPRESSED_FILE="$BACKUP_DIR/engram-$DATE.tar.gz"

# ═══════════════════════════════════════════════
# 1. Verificar que la DB existe
# ═══════════════════════════════════════════════

if [ ! -f "$ENGRAM_DB" ]; then
    echo "❌ ERROR: No se encuentra $ENGRAM_DB"
    echo "   ¿Engram está instalado?"
    exit 1
fi

# ═══════════════════════════════════════════════
# 2. Crear directorio de backup
# ═══════════════════════════════════════════════

mkdir -p "$BACKUP_DIR"

# ═══════════════════════════════════════════════
# 3. Copiar y comprimir
# ═══════════════════════════════════════════════

echo "📦 Respaldando Engram ($DATE)..."
cp "$ENGRAM_DB" "$BACKUP_FILE"
tar -czf "$COMPRESSED_FILE" -C "$BACKUP_DIR" "engram-$DATE.db"
rm "$BACKUP_FILE"  # Solo dejamos el comprimido

echo "   ✅ Comprimido: $(du -h "$COMPRESSED_FILE" | cut -f1)"

# ═══════════════════════════════════════════════
# 4. Limpiar backups viejos (más de 30 días)
# ═══════════════════════════════════════════════

find "$BACKUP_DIR" -name "engram-*.tar.gz" -mtime +30 -delete

echo "   🧹 Backups antiguos eliminados"

# ═══════════════════════════════════════════════
# 5. Resumen
# ═══════════════════════════════════════════════

echo ""
echo "═══════════════════════════════════════"
echo "  ✅ BACKUP COMPLETADO"
echo "═══════════════════════════════════════"
echo "  📁 $COMPRESSED_FILE"
echo "  📦 Tamaño: $(du -h "$COMPRESSED_FILE" | cut -f1)"
echo "  📊 Proyectos en memoria:"
engram projects list 2>/dev/null | grep -c "obs" || echo "   (verificar con 'engram projects list')"
echo "═══════════════════════════════════════"
