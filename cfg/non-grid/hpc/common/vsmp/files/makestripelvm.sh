#!/bin/bash


okfn=/tmp/.ok_makestripelvm
if [ -f $okfn ]
then
  echo "Found ok file $okfn"
  exit 0
fi

set -x

mountpt=/tmp


## what dev holds/should hold this vg?
dev=`grep "$mountpt " /etc/fstab |cut -d ' ' -f 1`
lvname=`lvs --noheadings $dev  |sed "s/^[ ]\+//" |cut -d ' ' -f 1`
vgname=`lvs --noheadings $dev  |sed "s/^[ ]\+//" |cut -d ' ' -f 2`
bdevlong=`lvs --noheadings -o devices $dev  |sed "s/^[ ]\+//"`
bdev=${bdevlong%[0-9]*(*}

if [ -z "$bdev" ]
then
    echo "ERROR No device associated with mountpt $mountpt. Exiting"
    exit 1
fi

## look for boot device
rootpart=`mount |grep '/ ' | cut -f 1 -d ' '`
rootdev=${rootpart%[0-9]*}

if [ ! "$bdev" == "$rootdev" ]
then
    echo "ERROR: root dev $rootdev does not match bdev $bdev. Exiting."
    exit 2
fi

## umount dev
umount $dev


## from ncm-blockdevices
rereadpt () {
    [ -x /sbin/udevadm ] && udevadm settle
    # hdparm can still fail with EBUSY without the wait...
    sleep 2
    hdparm -q -z "$1"
    [ -x /sbin/udevadm ] && udevadm settle
    # Just in case...
    sleep 2
}

## remove unknown vgs
## blocks all access to disk
for vvgg in `vgs --noheadings  | grep -v $vgname | sed "s/^[ ]\+//" |cut -d ' ' -f 1`
do
  vgremove -f $vvgg
done
for vvgg in `vgs --noheadings  | grep -v $vgname | sed "s/^[ ]\+//" |cut -d ' ' -f 1`
do
  vgremove -f $vvgg
done

## for all but $bdev do
nrsds=1
for d in `ls -d /sys/block/sd* |grep -v ${bdev#/dev}`
do
  tmpdev=/dev/${d#/sys/block/}
  dd if=/dev/zero of=$tmpdev bs=512 count=1
  rereadpt $tmpdev
  pvcreate -ff -y $tmpdev
  vgreduce --removemissing $vgname
  vgextend $vgname $tmpdev
  nrsds=$(($nrsds+1))
done

vgreduce --removemissing $vgname

## remove lv
lvremove -f $vgname/$lvname

## recreate
## -I in kb, power of 2
## only 90%, must match possible lower size of remaining space on $bdev
lvcreate -i $nrsds -I 128 -n $lvname $vgname -l '90%FREE'

lvm vgscan --mknodes
lvm vgchange -ay


## recreate fs on dev and mount it
#mkfs.ext4 $dev
mkfs.xfs -f $dev
sed -i "s#$dev.*#$dev /tmp xfs defaults,noatime,nobarrier 1 2#" /etc/fstab

mount $dev

## all is fine
touch $okfn
chmod 700 $okfn
## set sticky bit
chmod 1777 $mountpt
