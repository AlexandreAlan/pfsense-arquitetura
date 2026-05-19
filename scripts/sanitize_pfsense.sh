#!/bin/bash
# Script para remover informações sensíveis de backups XML do pfSense

if [ -z "$1" ]; then
    echo "Uso: ./sanitize_pfsense.sh config.xml"
    exit 1
fi

FILE=$1
OUTPUT="sanitized_$FILE"

echo "Limpando $FILE..."

# Remove senhas, chaves privadas e PSKs
sed -e 's|<password>.*</password>|<password>REMOVED</password>|g' \
    -e 's|<prv>.*</prv>|<prv>REMOVED</prv>|g' \
    -e 's|<pre-shared-key>.*</pre-shared-key>|<pre-shared-key>REMOVED</pre-shared-key>|g' \
    -e 's|<shared-key>.*</shared-key>|<shared-key>REMOVED</shared-key>|g' \
    "$FILE" > "$OUTPUT"

echo "✅ Arquivo limpo criado: $OUTPUT"
echo "⚠️  Revise o arquivo antes de comitar!"
