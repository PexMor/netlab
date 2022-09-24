#!/bin/bash

echo "--=[ current values"
sudo sysctl -a  | grep net.bridge.bridge-nf-call-

echo "--=[ to turn off the netfilter on bridge traffic run following commands:"

cat <<DATA
sudo sysctl net.bridge.bridge-nf-call-arptables=0
sudo sysctl net.bridge.bridge-nf-call-iptables=0
sudo sysctl net.bridge.bridge-nf-call-ip6tables=0
DATA

echo "--=[ you can add following lines to /etc/sysctl.d/99-nf-off4br.conf"
cat <<DATA
net.bridge.bridge-nf-call-arptables=0
net.bridge.bridge-nf-call-iptables=0
net.bridge.bridge-nf-call-ip6tables=0
DATA

echo "--=[ These rules will be loaded on system start"
echo "--=[ To load them instantly use sysctl -p /etc/sysctl.d/99-nf-off4br.conf"
