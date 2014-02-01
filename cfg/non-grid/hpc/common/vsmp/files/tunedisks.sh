#!/bin/bash
##
## dugtrio script
## - expects MegaRaid devices
## - to be run in rc.local
## - adds some tuning to the local disk devices
## author Stijn De Weirdt (HPCUGent)
##

sched=cfq
nrreq=256
readah=256

for s in `ls -d /sys/block/sd*`
do
  echo $s
  echo $sched > $s/queue/scheduler
  echo $nrreq > $s/queue/nr_requests
  echo $readah > $s/queue/read_ahead_kb 
done


## 1 dev = 2 disks in raid0 per controller
nrd=`lspci |grep MegaRAID |wc -l`
readah=$((2*$readah*$nrd))
nrreq=$(($nrreq*$nrd))

for s in `ls -d /sys/block/md* /sys/block/dm-*`
do
  echo $s
  echo $readah > $s/queue/read_ahead_kb
  echo $sched > $s/queue/scheduler
  echo $nrreq > $s/queue/nr_requests
done




