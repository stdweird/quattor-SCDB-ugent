unique template common/burning/config;
include 'components/filecopy/config';
prefix "/software/packages";
"{memtester}" = dict();
"{cpuburn}" = dict();
"{iozone}" = dict();

prefix "/software/components/filecopy/services/{/etc/rc.d/rc.local}";
"config" = { 
    f = <<EOF;
#!/bin/sh

day=86400

slt_burn=$((2*$day))
slt_io=$day

function run() {
    echo Memtester and burning CPU for $(($slt_burn/3600)) hours
    
    # use strings to filter out any control chars
    memtester %dM >& /tmp/memtester.logs.`date +%%s` &
    
    for i in {1..%d}
    do
        cpu=$(($i -1))
        taskset -c $cpu /usr/sbin/burnP6 >& /tmp/burnP6.$cpu.logs.`date +%%s` &
    done
    
    
    sleep $slt_burn
    kill -9 %%1
    pkill -9 burnP6
    pkill -9 memtester
    
    
    echo Burning disks for 24 hours
    iozone -a  >& /tmp/iozone.logs.`date +%%s` &
    sleep $slt_io
    kill -9 %%1
}

function stop() {
    pkill -9 burnP6
    pkill -9 memtester
    pkill -9 iozone
    pkill -9 /etc/rc.local
    pkill -9 /etc/rc.d/rc.local
}

RETVAL=0
case "$1" in
  start)
    echo "No doing anything, use run"
    ;;
  run)
    run
    ;;
  stop)
    stop
    ;;
  *)
    echo "Usage: $0 {run|stop}"
    RETVAL=1
esac

exit $RETVAL

EOF

    ncpus = value("/hardware/cpu/0/cores") * length(value("/hardware/cpu/"));
    totmem = 0;
    foreach (i;v;value("/hardware/ram")) {
        totmem = totmem + v["size"];
    };
    # 512GB ram gives 503GB total mem usable after kernel init
    basemem = totmem * 0.98;

    memfraction = totmem * 0.9;
    
    # 4GB free
    min_free = 4*1024; 
    if (basemem - memfraction > min_free) {
        memfraction = basemem - min_free;
    };
    
    format(f, to_long(memfraction), ncpus);
};

"perms" = "0700";
include 'components/accounts/config';
"/software/components/accounts/groups/justdontcomplain" = dict("gid", 5001);
