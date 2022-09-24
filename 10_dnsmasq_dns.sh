#!/bin/bash

set -e

N=netlab-dnsmasq
BD="$HOME/.docker-squid"

[ -f "$BD/dnsmasq.conf" ] || cp dnsmasq-dnsonly.conf "$BD/dnsmasq.conf"

docker kill "$N" || true
docker run -d --rm \
  --network container:netlab \
  --name "$N" \
  -e TZ=UTC \
  -v "$BD/dnsmasq.conf:/etc/dnsmasq.conf" \
  alvistack/dnsmasq-2.80
