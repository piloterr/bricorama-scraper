#!/usr/bin/env bash
# Bricorama Product API – cURL example
# Usage: PILOTERR_API_KEY=your-key ./product.sh
set -euo pipefail

curl -sS -G "https://api.piloterr.com/v2/bricorama/product" \
  -H "x-api-key: ${PILOTERR_API_KEY}" \
  --data-urlencode query=https://www.bricorama.fr/p/perceuse-visseuse-sans-fil-18v/3999991691267
