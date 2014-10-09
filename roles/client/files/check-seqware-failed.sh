#!/bin/sh
#
# It looks for failed seqware jobs

out=`sudo -u seqware_user -i /home/seqware/bin/seqware workflow report --accession 2 | grep failed | wc -l`

if [ $out -gt 0 ]; then
  echo "Critical: $out seqware jobs have failed!!"
  exit 2
else
  echo "All seqware jobs are fine"
    exit 0
fi
