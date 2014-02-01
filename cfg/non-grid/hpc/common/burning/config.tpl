unique template common/burning/config;

include {'components/filecopy/config'};

prefix "/software/packages";
"{memtester}" = nlist();
"{cpuburn}" = nlist();
"{iozone}" = nlist();

prefix "/software/components/filecopy/services/{/etc/rc.d/rc.local}";
"config" = { f = <<EOF;
#!/bin/sh

slt=86400

echo Memtester and burning CPU for 24 hours

memtester %dM >& /tmp/memtester.logs &

for i in {1..%d}
do
    taskset -c $(($i -1)) /usr/sbin/burnP6 &
done


sleep $slt
kill -9 %%1
pkill -9 burnP6
pkill -9 memtester


echo Burning disks for 24 hours
iozone -a &
sleep $slt
kill -9 %%1
EOF
    ncpus = value("/hardware/cpu/0/cores") * length(value("/hardware/cpu/"));
    totmem = 0;
    foreach (i;v;value("/hardware/ram")) {
        totmem = totmem + v["size"];
    };
    memfraction = to_long(totmem * 0.9);
    
    format(f, memfraction, ncpus);
};

"perms" = "0700";

include {'components/accounts/config'};

"/software/components/accounts/groups/justdontcomplain" = nlist("gid", 5001);
