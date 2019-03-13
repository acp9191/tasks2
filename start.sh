#!/bin/bash

export MIX_ENV=prod
export PORT=4795

echo "Stopping old copy of app, if any..."

_build/prod/rel/tasks2/bin/tasks2 stop || true

echo "Starting app..."

# Foreground for testing and for systemd
_build/prod/rel/tasks2/bin/tasks2 foreground

