#!/bin/bash

set -e

N=netlab-squid
BD="$HOME/.docker-squid"

docker kill "$N" || true
docker run -d --rm \
  --network container:netlab \
  --name "$N" \
  -e TZ=UTC \
  -v "$BD/logs:/var/log/squid" \
  -v "$BD/data:/var/spool/squid" \
  -v "$BD/squid.conf:/etc/squid/squid.conf" \
  ubuntu/squid
