#!/bin/bash

# ==============================================================================
# pfSense Backup Sanitizer
# Author: Alexandre Basto
# Description: Removes sensitive data (hashes, keys, secrets) from pfSense XML backups.
# Usage: ./sanitize_pfsense.sh <input_file.xml> <output_file.xml>
# ==============================================================================

INPUT_FILE=$1
OUTPUT_FILE=$2

if [ -z "$INPUT_FILE" ] || [ -z "$OUTPUT_FILE" ]; then
    echo "Usage: $0 <input_file.xml> <output_file.xml>"
    exit 1
fi

echo "🛡️ Sanitizing pfSense backup: $INPUT_FILE..."

# Copy to output
cp "$INPUT_FILE" "$OUTPUT_FILE"

# 1. Remove password hashes for local users
sed -i 's|<password>.*</password>|<password><REDACTED_HASH></password>|g' "$OUTPUT_FILE"

# 2. Remove OpenVPN shared keys and private keys
sed -i 's|<shared_key>.*</shared_key>|<shared_key><REDACTED_KEY></shared_key>|g' "$OUTPUT_FILE"
sed -i 's|<prv>.*</prv>|<prv><REDACTED_PRIVATE_KEY></prv>|g' "$OUTPUT_FILE"

# 3. Remove IPsec PSKs
sed -i 's|<pre-shared-key>.*</pre-shared-key>|<pre-shared-key><REDACTED_PSK></pre-shared-key>|g' "$OUTPUT_FILE"

# 4. Remove WireGuard private keys
sed -i 's|<privatekey>.*</privatekey>|<privatekey><REDACTED_PRIVATE_KEY></privatekey>|g' "$OUTPUT_FILE"

# 5. Remove SNMP community strings
sed -i 's|<community>.*</community>|<community><REDACTED_COMMUNITY></community>|g' "$OUTPUT_FILE"

# 6. Remove dynamic DNS passwords
sed -i 's|<password>.*</password>|<password><REDACTED_PASSWORD></password>|g' "$OUTPUT_FILE"

echo "✅ Sanitization complete! Saved to: $OUTPUT_FILE"
echo "⚠️  Note: This file is now safe for documentation/versioning but CANNOT be used for a full restore without manual key re-entry."
