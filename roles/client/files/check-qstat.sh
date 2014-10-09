#!/bin/sh
#
# Verifies "qstat -f" output for errors

out=`sudo -u seqware_user -i qstat -f | grep -i error| wc -l`

if [ $out -gt 0 ]; then
  echo "Critical: $out jobs in error status!!"
  exit 2
else
  echo "All jobs are fine"
    exit 0
fi
