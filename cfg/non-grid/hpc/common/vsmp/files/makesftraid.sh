#!/bin/bash

##
## dugtrio script
## - expects MegaRaid devices
## - to be run in rc.local
## - recreates the /tmp dir on reboot
## author Stijn De Weirdt (HPCUGent)
##

md=127
## 1 dev = 2 disks in raid0 per controller
nrd=`lspci |grep MegaRAID |wc -l`
offset=0
part=7



c=64
## each dev is 2 disks
multi=2

chr () {
    printf \\$(($1/64*100+$1%64/8*10+$1%8))
} 

allrd=""
for i in `seq 0 $(($nrd-1))`
do
  name=`chr $((97+$i+$offset))`
  dev=/dev/sd${name}${part}
  umount $dev
  allrd="$allrd $dev"
done

for mdstop in `cat /proc/mdstat |grep md |sed "s/ :.*//"`
do
  echo try umount
  umount /dev/$mdstop
  echo mdadm --stop /dev/$mdstop
  mdadm --stop /dev/$mdstop
done

echo mdadm --create /dev/md$md --run --level=0 --chunk=$c --raid-devices=$nrd $allrd
mdadm --create /dev/md$md --run --level=0 --chunk=$c --raid-devices=$nrd $allrd

xfsopt="-d sunit=$(($multi*$c)),swidth=$(($nrd*$multi*$c))"
xfsopt=""
echo mkfs.xfs -f $xfsopt /dev/md$md
mkfs.xfs -f $xfsopt /dev/md$md

echo mount /dev/md$md /tmp
mount /dev/md$md /tmp

echo chmod 1777 /tmp
chmod 1777 /tmp
