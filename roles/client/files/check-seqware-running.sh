#!/bin/sh
#
# It looks for jobs that have been running for too long

# First, get the jobID, status and run time
jobid=`sudo -u seqware_user -i /home/seqware/bin/seqware workflow report --accession 2 | grep -B1 -A18 running | egrep "Run SWID|Run Status|Run Time"`

# Still to do
# The running jobs should be investigated further to see if they have been running longer than a parameterized threshold
# If yes, then get the step number and exit with "Critical"
# If the job threshold has not been reached, get the working step and the time has it been working on it and compare it with a parameterized threshold
# If the job has been working on that job longer than the threshold, exit with "Critical" and JobID+StepID

# The threshold should be provided as a separate file, e.g.
# playbook_root/roles/client/vars/aws_threshold.yml
#  -- 
#   - include vars\aws_threshold.yml

# cat playbook_root/roles/client/vars/aws_threshold.yml
#---
# total_job_time:  4d
# step1_job_time:  4h
# step2_job_time:  4h
# step3_job_time:  8h
# step4_job_time:  12h
#....




#Workflow Run Engine ID


if [ $out -gt 0 ]; then
  echo "Critical: $out seqware jobs have failed!!"
  exit 2
else
  echo "All seqware jobs are fine"
    exit 0
fi
