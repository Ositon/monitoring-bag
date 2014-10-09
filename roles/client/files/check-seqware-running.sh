#!/bin/sh
#
# It looks for jobs that have been running for too long

# First, get the jobID, status and run time
jobid=`sudo -u seqware_user -i /home/seqware/bin/seqware workflow report --accession 2 | grep -B1 -A18 running | egrep "Run SWID|Run Status|Run Time"`


Workflow Run Engine ID

if [ $out -gt 0 ]; then
  echo "Critical: $out seqware jobs have failed!!"
  exit 2
else
  echo "All seqware jobs are fine"
    exit 0
fi
