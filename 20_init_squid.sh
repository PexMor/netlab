#!/bin/bash

set -e

N=netlab-squid
BD="$HOME/.docker-squid"

[ -d "$BD" ] || mkdir -p "$BD"
if [ ! -d "$BD/logs" ]; then
  mkdir -p "$BD/logs"
  chmod 0777 "$BD/logs"
fi
if [ ! -d "$BD/data" ]; then
  mkdir -p "$BD/data"
  chmod 0777 "$BD/data"
fi
[ -f "$BD/squid.conf" ] || cp squid.conf "$BD/squid.conf"

docker kill "$N" || true
docker run -it --rm \
  --network container:netlab \
  --name "$N" \
  -e TZ=UTC \
  -v "$BD/logs:/var/log/squid" \
  -v "$BD/data:/var/spool/squid" \
  -v "$BD/squid.conf:/etc/squid/squid.conf" \
  ubuntu/squid -z
