#!/bin/bash
#
# Tool to check the nic MAC
#
# assumptions:
#  - connected to USB
#
# e.g.: Bus 003 Device 007: ID 0bda:8152 Realtek Semiconductor Corp. RTL8152 Fast Ethernet Adapter
# lsusb -t
# lsusb
# lsusb -d 0bda:8152 -v
# lsusb -d 0bda:8152 -v | grep -i serial

NIC=$1

if [ "x$NIC" = "x" ]; then
  ip -c -br link
else
  echo "--=[ Lookup the name in /sys:"
  find /sys -name "$NIC" 2>/dev/null
  echo "---"
  MACFN="/sys/class/net/$NIC/address"
  if [ -f "$MACFN" ]; then
    MAC=`cat "$MACFN"`
    echo "MAC: $MAC"
    echo "--=[ use the command below to make the rules and append them to existing file (two lines wrapped)"
    echo "cat rules.d/10-persistent-network.rules | sed s/00:01:02:03:04:05/$MAC/g | \\"
    echo "   sudo tee -a /etc/udev/rules.d/10-persistent-network.rules"
    echo "--=[ to check the contents"
    echo "cat /etc/udev/rules.d/10-persistent-network.rules"
    echo "--=[ do not forget to reload ude rules w/o reboot"
    echo "udevadm control --reload-rules && udevadm trigger"
  else
    echo "No such nic registered"
  fi
fi
