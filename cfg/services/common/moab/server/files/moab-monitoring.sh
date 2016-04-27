#!/bin/sh

exit 0
if [ -z "$PATH" ]
then
 export PATH=/sbin:/usr/sbin:/bin:/usr/bin:/opt/moab/sbin:/opt/moab/bin
else
 export PATH=/sbin:/usr/sbin:/bin:/usr/bin:/opt/moab/sbin:/opt/moab/bin:$PATH
fi 

mauibin=`which moab`
if [ -z "$mauibin" ]
then
  mauibin=/opt/moab/sbin/moab
  if [ ! -f $mauibin ]
  then
    mauibin=/usr/sbin/moab
  fi
fi

mauisrv=moab
torquesrv=pbs_server

service $mauisrv status > /dev/null 2>&1
if [ $? -ne 0 ]
then
  echo "`date` - MOAB not running. Restarting..."
  service $mauisrv start
else
  restart_maui=0
  # Check maui is responding
  # If not, check again if maui is there as mdiag command sometimes crashes maui ...
  mdiag -S > /dev/null 2>&1
  if [ $? -ne 0 ]
  then
    mauipid=`ps -e -opid="",cmd="" | awk "{if (\\$2==\"${mauibin}\") print \\$1}"`
    if [ -z "$mauipid" ]
    then
      echo "`date` - MOAB service looked ok but MOAB not running. Restarting..."
      restart_maui=1
    else
      echo "`date` - MOAB running (pid=$mauipid) but not responding. Trying to restart Torque server..."
      service $torquesrv restart
      sleep 10

      mdiag -S > /dev/null 2>&1
      if [ $? -ne 0 ]
      then

        echo "`date` - MOAB running (pid=$mauipid) still not responding. Killing and restarting..."
        kill -KILL $mauipid
        restart_maui=1
      else
        echo "`date` - MOAB running properly after Torque restart."
      fi
    fi
    echo `date` - System load statictics :
    uptime
    vmstat
    if [ $restart_maui -eq 1 ]
    then
      service $mauisrv start
    fi
  fi
fi
