#!/bin/ksh
exit 0
nodes=$(mdiag -n | grep -v '^WARNING:' | egrep 'Drained|Running|Idle|Busy' | grep -v Total | awk '{print $1}')

for fullnode in $nodes
do
  echo "Checking node $fullnode... \c"
  node=$(echo $fullnode | awk -F. '{print $1}')

  node_status=$(mdiag -n $fullnode | grep $fullnode | head -1 | awk '{print $2}')
  if [ "$node_status" != "Idle" ]
  then
    jobs=$(showq -r | grep $node | awk '{print $1}')
    job_count=$(echo $jobs | wc -w | awk '{print $1}')
  else
    job_count=0
  fi

  if [ $job_count -eq 0 ]
  then
    echo "$node_status (Free)"
  else
    echo "$node_status ($job_count jobs running)"
  fi
done
