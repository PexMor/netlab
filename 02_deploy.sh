#!/bin/bash

set -e

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

NLD="/opt/netlab/bin"
[ -d "$NLD" ] || mkdir -p "$NLD"
cp addUsbNic.sh "$NLD/"
