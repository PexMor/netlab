#!/bin/bash

sudo ip netns exec netlab dhclient -1 -v veth_lab_c
