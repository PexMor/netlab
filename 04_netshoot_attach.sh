#!/bin/bash

set -e
set -x

# b:inline: ensure_root.sh
# Make sure we are runing as root
echo "EUID=${EUID}"
if [ ${EUID} -ne 0 ]; then
  # inject USER as first parameter
  sudo $0 "$USER" "$@"
fi
# check and exit if not
[ ${EUID} -ne 0 ] && exit -1
# e:inline: ensure_root.sh

C_IMAGE=nicolaka/netshoot
C_NAME=netlab
BR_NAME=brlab
NIC_H=veth_lab_h
NIC_C=veth_lab_c

function rin() {
    ip netns exec ${C_NAME} "$@"
}

docker kill $C_NAME || true

# start container
docker run -d --rm \
    --network none \
    --name ${C_NAME} \
    --dns 127.0.0.1 \
    --dns-search demo.iot \
    --hostname ${C_NAME} \
    $C_IMAGE sleep infinity

brctl addbr $BR_NAME || true
ip li set dev $BR_NAME up

ip link add $NIC_H type veth peer name $NIC_C || true
ip link set $NIC_H up
brctl addif $BR_NAME $NIC_H || true

echo "Inspect .State.Running"
docker inspect -f {{.State.Running}} ${C_NAME}
echo "Inspect .State.Pid"
docker inspect -f {{.State.Pid}} ${C_NAME}

# make sure the container is running
until [ "x`docker inspect -f {{.State.Running}} ${C_NAME} || true`" == "xtrue" ]; do
    echo "wait for container/state.running"
    sleep 0.1
done
# wait for pid
until [ "x`docker inspect -f {{.State.Pid}} ${C_NAME} || true`" != "x" ]; do
    echo "wait for container/state.pid"
    sleep 0.1
done

# create namespace link
[ -d /var/run/netns ] || mkdir -p /var/run/netns
DPID=$(docker inspect --format '{{ .State.Pid }}' "${C_NAME}")
ln -sfT "/proc/$DPID/ns/net" "/var/run/netns/${C_NAME}"

ip link set netns ${C_NAME} dev $NIC_C

rin ip link set $NIC_C up

