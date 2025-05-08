#!/usr/bin/env bash
set -e

# Run any pending migrations 
echo "==> Running database migrations…"
bin/rails db:migrate

# Boot the app under Puma
echo "==> Starting Puma server…"
exec "$@"
