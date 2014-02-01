unique template common/pacemaker/ha;

## nodes in HA cluster
variable HA_NODES ?= list(FULL_HOSTNAME);
"/software/components/pacemaker/ha/nodes" = HA_NODES;

## authkey
variable HA_AUTHKEY ?= "sha1 ***";
"/software/components/pacemaker/ha/authkey" = HA_AUTHKEY;

#   The use_logd directive specifies whether Heartbeat logs
#   its messages through logging daemon or not
"/software/components/pacemaker/ha/use_logd" = "on";

#   keepalive: how long between heartbeats?
"/software/components/pacemaker/ha/keepalive" = 2;

#   warntime: how long before issuing "late heartbeat" warning?
"/software/components/pacemaker/ha/warntime" = 10;

#   deadtime: how long-to-declare-host-dead?
"/software/components/pacemaker/ha/deadtime" = 30;

#   Very first dead time (initdead)
"/software/components/pacemaker/ha/initdead" = 120;

#   serial communication
variable HA_SERIAL ?= "/dev/ttyS0";
variable HA_BAUD ?= 115200;
"/software/components/pacemaker/ha/baud"= HA_BAUD;
"/software/components/pacemaker/ha/serial"= HA_SERIAL;

#   udp communication
"/software/components/pacemaker/ha/udpport" = 694;


## communication is a list of strings
## values can be list("bcast") and/or list("ucast","<interfacename>")
variable HA_COMMUNICATION ?= list("ucast","eth0");
"/software/components/pacemaker/ha/communication" = HA_COMMUNICATION;

#   The crm directive specifies whether Heartbeat should run 
#   the 1.x-style cluster manager or the 2.x-style cluster manager 
#   that supports more than 2 nodes
"/software/components/pacemaker/ha/crm" = "respawn";

## The auto_failback option determines whether a resource will automatically fail back 
## to its "primary" node, or remain on whatever node is serving it until that node fails,
## or an administrator intervenes. 
## Typically, you want to set auto_failback on for an ActiveActive cluster, 
## and commonly to off for an ActivePassive cluster.
## NOTE: auto_failback does not have any effect on a Release 2 CRM-style cluster (one configured with crm on). For CRM-style clusters, this has been replaced with the default_resource_stickiness attribute in the CIB. 
#"/software/components/pacemaker/ha/auto_failback" = "off";

