#!/bin/bash
#
# usb device automation
#

# when running without terminal redirect output to log file
# redirect stdout(1) and stderr(2)
LOGDIR=/tmp
if [ ! -t 1 ] ; then
    [ -d "$LOGDIR" ] || mkdir -p "$LOGDIR"
    exec >$LOGDIR/addUsbNic.log 2>&1
fi

function test() {
  env
  echo "cli params: $*"
}

# test

# make sure that linux bridge brlab exists
brctl addbr brlab || true
brctl addif brlab $INTERFACE

