#!/bin/sh

export PATH=/sbin:/usr/sbin:/bin:/usr/bin

pbsbin=/usr/sbin/pbs_server
pbssrv=pbs_server

service $pbssrv status > /dev/null 2>&1
if [ $? -ne 0 ]
then
  echo "`date` - PBS not running. Restarting..."
  service $pbssrv start
else
  # Check pbs is responding
  # If not, check again is pbs is there as mdiag command sometimes crashes pbs ...
  qmgr </dev/null > /dev/null 2>&1
  if [ $? -ne 0 ]
  then
    pbspid=`ps -e -opid="",cmd="" | awk "{if (\\$2==\"${pbsbin}\") print \\$1}"`
    if [ -z "$pbspid" ]
    then
      echo "`date` - PBS service looked ok but PBS not running. Restarting..."
    else
      echo "`date` - PBS running (pid=$pbspid) but not responding. Killing and restarting..."
      kill -KILL $pbspid
    fi
    echo `date` - System load statictics :
    uptime
    vmstat
    service $pbssrv start
  fi
fi
